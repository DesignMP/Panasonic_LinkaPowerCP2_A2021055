
(* Skrutkovac� set Pick and Place *)
FUNCTION_BLOCK PickAndPlace
	
		
		
	//Pr�znak skrutka pripravena//
	STAV.SkrutkaPripravena:= IN.Podavac_SkrutkaNaVystupe;
	
	
	//*******************************Zapnutie z�sobn�ka ke� je pr�zdna li�ta z�sobn�ka*****************//
	IF EDGEPOS(CMD.ENABLE = TRUE) THEN
		OUT.TriediaciVzduch_RUN:= TRUE;
		OUT.VibropohonZasobnika_RUN:= TRUE;
		OUT.VibropohonListy_RUN:= TRUE;
	END_IF	
		
	
	//*******************************Ovl�danie zhadzovacieho vzduchu pred li�tou z�sobn�ka******************************************//
	Internal.CasZaplneniaZasobnika.IN:= IN.ZaplnenieListyZasobnika AND OUT.VibropohonZasobnika_RUN AND IN.ZaplnenieVibrolisty_MIN AND IN.ZaplnenieVibrolisty_MAX;
	
	IF Internal.CasZaplneniaZasobnika.Q THEN
		OUT.ZhadzovaciVzduch_RUN:= TRUE;
	ELSE
		OUT.ZhadzovaciVzduch_RUN:= FALSE;
	END_IF	
	
	Internal.CasZaplneniaZasobnika.PT:= T#3s;
	Internal.CasZaplneniaZasobnika();
	
	
	//******************************Vypnutie triediaceho vzduchu nad li�tou z�sobn�ka************************************************//
	Internal.CasVypnTriediacehoVzduchu.IN:= OUT.TriediaciVzduch_RUN AND NOT OUT.VibropohonZasobnika_RUN;
	IF Internal.CasVypnTriediacehoVzduchu.Q THEN
		OUT.TriediaciVzduch_RUN:= FALSE;
	END_IF	
	
	Internal.CasVypnTriediacehoVzduchu.PT:= T#1s;
	Internal.CasVypnTriediacehoVzduchu();
	
	//*****************************************Vypnutie vibroli�ty a z�sobn�ka********************************************************//
	IF (OUT.VibropohonListy_RUN OR OUT.VibropohonZasobnika_RUN) AND
		IN.ZaplnenieVibrolisty_MIN AND
		IN.ZaplnenieVibrolisty_MAX AND
		IN.ZaplnenieListyZasobnika AND
		IN.PodavacOtoceny_VYSTUP AND
		NOT CMD.RR_ZapniVibrolistu AND
		NOT CMD.RR_ZapniZasobnik THEN
		Internal.CasZaplneniaVibrolisty.IN:= TRUE;
	ELSE	
		Internal.CasZaplneniaVibrolisty.IN:= FALSE;
	END_IF
	
	IF (OUT.VibropohonListy_RUN OR OUT.VibropohonZasobnika_RUN) AND Internal.CasZaplneniaVibrolisty.Q THEN
		OUT.VibropohonListy_RUN:= FALSE;
		OUT.VibropohonZasobnika_RUN:= FALSE;
	END_IF	
	
	Internal.CasZaplneniaVibrolisty.PT:= T#2s;
	Internal.CasZaplneniaVibrolisty();
	
	//***********************************Enable kni�nice***************************************//
	IF NOT CMD.ENABLE AND Step <> 0 THEN
		OUT.VibropohonListy_RUN:= FALSE;
		OUT.VibropohonZasobnika_RUN:= FALSE;
		OUT.ZhadzovaciVzduch_RUN:= FALSE;
		Step:= 0;
	END_IF	
	
	
	//**********************************Reset poruchy*****************************************//
	//1 - porucha oto�enia podava�a smerom k zasobniku
	//2 - porucha oto�enia podava�a smerom k skrutkova�ke
	//3 - porucha sn�ma�a skrutky na vystupe podava�a
	
	IF CMD.ResetPoruchy OR NOT CMD.ENABLE THEN
		STAV.ERROR:= FALSE;
		STAV.CisloPoruchy:= 0;
		STAV.PopisPoruchy:= '';
	END_IF	
	
	
	
	CASE Step OF
		
		0: //Nulovanie//
			Internal.IdleTime_200ms.IN:= FALSE;
			Internal.IdleTime_100ms.IN:= FALSE;
			Internal.IdleTime_500ms.IN:= FALSE;
			Internal.IdleTime_1s.IN:= FALSE;
			Internal.AlarmTime_10s.IN:= FALSE;
			CMD.PodajSkrutku:= FALSE;
			CMD.RR_ZapniVibrolistu:= FALSE;
			CMD.RR_ZapniZasobnik:= FALSE;
			CMD.RR_OtocPodavac_Vstup:= FALSE;
			CMD.RR_OtocPodavac_Vystup:= FALSE;
			CMD.RucnyRezim:= FALSE;
			IF NOT CMD.PodajSkrutku AND CMD.ENABLE AND NOT STAV.ERROR THEN
				Step:= 1;
			END_IF	
	
	
		1: //�akam na spustenie//
			Internal.IdleTime_1s.IN:= NOT IN.Podavac_SkrutkaNaVystupe;
			
			IF Internal.IdleTime_1s.Q THEN
				CMD.PodajSkrutku:= TRUE;
			END_IF	
			
			
			IF CMD.RucnyRezim THEN
				Step:= 70;	
			ELSIF CMD.PodajSkrutku THEN
				Internal.IdleTime_1s.IN:= FALSE;
				Step:= 10;
			END_IF	
	
			
		10: //Kontrola skrutky na vystupe podavaca//
			IF IN.Podavac_SkrutkaNaVystupe THEN
				Step:= 0;
			ELSE
				Step:= 11;
			END_IF
		
		11: //Otocenie podavaca na vstup smerom k zasobniku//
			OUT.OtocPodavac_NaVystup:= FALSE;
			OUT.OtocPodavac_NaVstup:= TRUE;
			Internal.AlarmTime_10s.IN:= TRUE;
			
			Internal.IdleTime_1s.IN:= IN.PodavacOtoceny_VSTUP;
			
			IF Internal.IdleTime_1s.Q THEN
				Internal.AlarmTime_10s.IN:= FALSE;
				Internal.IdleTime_1s.IN:= FALSE;
				Step:= 15;
			ELSIF Internal.AlarmTime_10s.Q THEN
				STAV.ERROR:= TRUE;
				STAV.CisloPoruchy:= 1;
				STAV.PopisPoruchy:= 'Porucha snimaca otocenia podavaca na vstup';
				Step:= 0;
			END_IF	
		
		15: //Kontrola zaplnenie vibrolisty//
			IF IN.ZaplnenieVibrolisty_MAX AND IN.ZaplnenieVibrolisty_MIN AND IN.ZaplnenieListyZasobnika THEN
				Internal.IdleTime_500ms.IN:= FALSE;
				Step:= 20;
			ELSE
				Internal.IdleTime_1s.IN:= FALSE;
				Internal.IdleTime_200ms.IN:= FALSE;
				Step:= 30;
			END_IF
		
		20: //Spustenie vibrolisty//
			OUT.VibropohonListy_RUN:= TRUE;
			Internal.IdleTime_500ms.IN:= IN.Podavac_SkrutkaNaVstupe;
			
			
			IF Internal.IdleTime_500ms.Q THEN
				Internal.IdleTime_500ms.IN:= FALSE;
				Step:= 21;
			END_IF
		
		21: //Otocenie podavaca na vystup smerom k skrutkovacke//
			OUT.OtocPodavac_NaVstup:= FALSE;
			OUT.OtocPodavac_NaVystup:= TRUE;
			
			Internal.AlarmTime_10s.IN:= NOT IN.PodavacOtoceny_VYSTUP;
			
			Internal.IdleTime_1s.IN:= IN.PodavacOtoceny_VYSTUP;
			
			IF Internal.IdleTime_1s.Q AND IN.Podavac_SkrutkaNaVystupe THEN
				OUT.VibropohonListy_RUN:= FALSE;
				Step:= 0;
			ELSIF Internal.IdleTime_1s.Q AND NOT IN.Podavac_SkrutkaNaVystupe THEN
				Internal.IdleTime_1s.IN:= FALSE;
				Internal.AlarmTime_10s.IN:= FALSE;
				Step:= 11;
			ELSIF Internal.AlarmTime_10s.Q THEN
				STAV.ERROR:= TRUE;
				STAV.CisloPoruchy:= 2;
				STAV.PopisPoruchy:= 'Porucha snimaca otocenia podavaca na vystup';
				Step:= 0;	
			END_IF	
		
			
		
			
		30: //Spustenie vibrolisty a zasobnika//
			OUT.TriediaciVzduch_RUN:= TRUE;
			OUT.VibropohonListy_RUN:= TRUE;
					
			Internal.IdleTime_1s.IN:= OUT.TriediaciVzduch_RUN;
			Internal.IdleTime_200ms.IN:= IN.Podavac_SkrutkaNaVstupe AND OUT.VibropohonZasobnika_RUN;
			
			
			IF Internal.IdleTime_1s.Q THEN
				OUT.VibropohonZasobnika_RUN:= TRUE;
			END_IF	
		
			
			IF Internal.IdleTime_200ms.Q THEN
				Internal.IdleTime_1s.IN:= FALSE;
				Internal.IdleTime_200ms.IN:= FALSE;
				Step:= 31;
			END_IF
			
		31: //Otocenie podavaca na vystup smerom k skrutkovacke//
			OUT.OtocPodavac_NaVstup:= FALSE;
			OUT.OtocPodavac_NaVystup:= TRUE;
			
			Internal.AlarmTime_10s.IN:= NOT IN.PodavacOtoceny_VYSTUP;
			
			Internal.IdleTime_1s.IN:= IN.PodavacOtoceny_VYSTUP;
			
			IF Internal.IdleTime_1s.Q AND IN.Podavac_SkrutkaNaVystupe THEN
				Internal.IdleTime_1s.IN:= FALSE;
				Step:= 0;
			ELSIF Internal.IdleTime_1s.Q AND NOT IN.Podavac_SkrutkaNaVystupe THEN
				Internal.IdleTime_1s.IN:= FALSE;
				Internal.AlarmTime_10s.IN:= FALSE;
				Step:= 11;	
			ELSIF Internal.AlarmTime_10s.Q THEN
				STAV.ERROR:= TRUE;
				STAV.CisloPoruchy:= 2;
				STAV.PopisPoruchy:= 'Porucha snimaca otocenia podavaca na vystup';
				Step:= 0;	
			END_IF	
			
			
		
			
			
			
		
		70: //Rucny rezim//
			OUT.VibropohonListy_RUN:= CMD.RR_ZapniVibrolistu;
			
			IF CMD.RR_ZapniZasobnik THEN
				OUT.TriediaciVzduch_RUN:= TRUE;
				Internal.IdleTime_1s.IN:= TRUE;
			ELSE
				Internal.IdleTime_1s.IN:= FALSE;
			END_IF	
			
			OUT.VibropohonZasobnika_RUN:= Internal.IdleTime_1s.Q;
		
			IF NOT CMD.RucnyRezim THEN
				OUT.VibropohonListy_RUN:= FALSE;
				OUT.VibropohonZasobnika_RUN:= FALSE;
				Step:= 0;
			ELSIF CMD.PodajSkrutku THEN
				Step:= 10;
			END_IF	
		
			
			IF CMD.RR_OtocPodavac_Vstup THEN
				OUT.OtocPodavac_NaVystup:= FALSE;
				OUT.OtocPodavac_NaVstup:= TRUE;
				CMD.RR_OtocPodavac_Vstup:= FALSE;
			ELSIF CMD.RR_OtocPodavac_Vystup THEN	
				OUT.OtocPodavac_NaVstup:= FALSE;
				OUT.OtocPodavac_NaVystup:= TRUE;
				CMD.RR_OtocPodavac_Vystup:= FALSE;
			END_IF	
		
	END_CASE		
	
	
	//*****************�asova�e************************//
	Internal.IdleTime_100ms.PT:= T#200ms;
	Internal.IdleTime_100ms();	
	Internal.IdleTime_200ms.PT:= T#200ms;
	Internal.IdleTime_200ms();
	Internal.IdleTime_500ms.PT:= T#200ms;
	Internal.IdleTime_500ms();
	Internal.IdleTime_1s.PT:= T#1s;
	Internal.IdleTime_1s();
	Internal.AlarmTime_10s.PT:= T#10s;
	Internal.AlarmTime_10s();
	Internal.CasPredSpustenimZasobnika.PT:= T#1s;
	Internal.CasPredSpustenimZasobnika();
	
	
END_FUNCTION_BLOCK
