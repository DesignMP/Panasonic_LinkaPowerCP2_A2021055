
(* Skrutkovací set maticovaèky *)
FUNCTION_BLOCK MaticaSet
	
	
	//Príznak matica pripravena//
	STAV.MaticaPripravena:= IN.PritomnostMaticeNaVystupe AND IN.PodavacMatice_ZASUNUTY;
	
	//*******************************Ovládanie zhadzovacieho vzduchu pred lištou zásobníka******************************************//
	Internal.CasZaplneniaZasobnika.IN:= IN.ZaplnenieListyZasobnika AND OUT.VibropohonZasobnika_RUN;
	
	IF Internal.CasZaplneniaZasobnika.Q THEN
		OUT.ZhadzovaciVzduch_RUN:= TRUE;
	ELSE
		OUT.ZhadzovaciVzduch_RUN:= FALSE;
	END_IF	
	
	Internal.CasZaplneniaZasobnika.PT:= T#1s;
	Internal.CasZaplneniaZasobnika();
	
	
	//******************************Vypnutie triediaceho vzduchu nad lištou zásobníka************************************************//
	Internal.CasVypnTriediacehoVzduchu.IN:= OUT.TriediaciVzduch_RUN AND NOT OUT.VibropohonZasobnika_RUN;
	IF Internal.CasVypnTriediacehoVzduchu.Q THEN
		OUT.TriediaciVzduch_RUN:= FALSE;
	END_IF	
	
	Internal.CasVypnTriediacehoVzduchu.PT:= T#1s;
	Internal.CasVypnTriediacehoVzduchu();
	
	
	//*******************************Vypnutie zásobníka***************************************//
	Internal.CasVypnZasobnika.IN:= IN.ZaplnenieListyZasobnika AND OUT.VibropohonZasobnika_RUN;
	
	IF Internal.CasVypnZasobnika.Q THEN
		OUT.VibropohonZasobnika_RUN:= FALSE;
	END_IF
	
	Internal.CasVypnZasobnika.PT:= T#3s;
	Internal.CasVypnZasobnika();
	
	
	//*******************************Zapnutie zásobníka keï je prázdna lišta zásobníka*****************//
	IF CMD.ENABLE AND NOT STAV.ERROR AND NOT IN.ZaplnenieListyZasobnika AND NOT OUT.VibropohonZasobnika_RUN AND IN.PodavacMatice_ZASUNUTY THEN
		OUT.VibropohonZasobnika_RUN:= TRUE;
	END_IF	
	
	
	
	//***********************************Enable knižnice***************************************//
	IF NOT CMD.ENABLE AND Step <> 0 THEN
		OUT.VibropohonZasobnika_RUN:= FALSE;
		OUT.ZhadzovaciVzduch_RUN:= FALSE;
		OUT.NastrelenieMatice_RUN:= FALSE;
		Internal.PoInit:= FALSE;
		STAV.ERROR:= FALSE;
		STAV.PodanieMatice_BUSY:= FALSE;
		STAV.CisloPoruchy:= 0;
		STAV.PopisPoruchy:= '';
		Step:= 0;
	END_IF
	
	
	//**********************************Reset poruchy*****************************************//
	//1 - porucha preletu matice cez snímaè za oddelovaèom
	//2 - porucha preletu matice cez snimaè pred podavaèom
	//3 - porucha otoèenia oddelovaèa smerom k zásobníku
	//4 - porucha otoèenia oddelovaèa smerom k maticovaèke
	//5 - porucha vysunutia podavaèa vpred
	//6 - porucha zasunutia podavaèa vzad
	//7 - porucha snimaèa prítomnosti matice v skrutkovaèke
	
	IF CMD.ResetPoruchy THEN
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
			Internal.IdleTime_1500ms.IN:= FALSE;
			Internal.AlarmTime_3s.IN:= FALSE;
			OUT.PodavacMatice_Vysun:= FALSE;
			OUT.OtocOddelovacMatice_NaVystup:= FALSE;
			OUT.NastrelenieMatice_RUN:= FALSE;
			CMD.RR_OtocPodavac_Vstup:= FALSE;
			CMD.RR_OtocPodavac_Vystup:= FALSE;
			CMD.RR_VysunPodavacMatic:= FALSE;
			CMD.RR_ZapniZasobnik:= FALSE;
			CMD.RucnyRezim:= FALSE;
			CMD.PodajMaticu:=FALSE;
			STAV.PodanieMatice_BUSY:= FALSE;
			IF NOT CMD.PodajMaticu AND CMD.ENABLE AND NOT STAV.ERROR THEN
				Step:= 1;
			END_IF	
		
		
		1: //Èakam na spustenie//
			IF CMD.RucnyRezim THEN
				Step:= 70;	
			ELSIF CMD.PodajMaticu THEN
				Step:= 10;
			END_IF	
		
		10: //Kontrola matice na vystupe//
			STAV.PodanieMatice_BUSY:= TRUE;
			IF IN.PritomnostMaticeNaVystupe THEN
				Step:= 0;
			ELSE	
				IF NOT Internal.PoInit THEN	
					Step:= 11;
				ELSE
					Step:= 13;
				END_IF
			END_IF
		
			
		11: //Hladanie matice pri prvom spusteni//	
			OUT.PodavacMatice_Vysun:= FALSE;
			Internal.IdleTime_1500ms.IN:= OUT.NastrelenieMatice_RUN;
			
			IF IN.PodavacMatice_ZASUNUTY THEN
				OUT.NastrelenieMatice_RUN:= TRUE;
			END_IF	
			
			IF Internal.IdleTime_1500ms.Q THEN
				OUT.NastrelenieMatice_RUN:= FALSE;
				Internal.IdleTime_1500ms.IN:= FALSE;
				Step:= 12;
			END_IF
		
	
		12: //Vysunutie podavaèa//	
			OUT.PodavacMatice_Vysun:= TRUE;
			Internal.AlarmTime_3s.IN:= TRUE;
			Internal.IdleTime_500ms.IN:= IN.PodavacMatice_VYSUNUTY;
			
			IF Internal.IdleTime_500ms.Q THEN
				Internal.PoInit:= TRUE;
				Internal.IdleTime_500ms.IN:= FALSE;
				OUT.PodavacMatice_Vysun:= FALSE;
				Internal.AlarmTime_3s.IN:= FALSE;
				Step:= 10;
			ELSIF Internal.AlarmTime_3s.Q THEN
				STAV.ERROR:= TRUE;
				STAV.CisloPoruchy:= 5;
				STAV.PopisPoruchy:= 'Porucha vysunutia podavaèa vpred';
				Step:= 0;
			END_IF	
			
			
		13: //Zasunutie podavaca matice a otocenie oddelovaca k zasobniku//
			OUT.PodavacMatice_Vysun:= FALSE;
			OUT.OtocOddelovacMatice_NaVystup:= FALSE;
			Internal.AlarmTime_3s.IN:= TRUE;
			
			IF IN.PodavacMatice_ZASUNUTY AND IN.OddelovacOtoceny_VSTUP THEN
				Internal.AlarmTime_3s.IN:= FALSE;
				Step:= 15;
			ELSIF Internal.AlarmTime_3s.Q THEN
				STAV.ERROR:= TRUE;
				IF NOT IN.PodavacMatice_ZASUNUTY THEN
					STAV.CisloPoruchy:= 6;
					STAV.PopisPoruchy:= 'Porucha zasunutia podavaèa vzad';
				ELSIF NOT IN.OddelovacOtoceny_VSTUP THEN
					STAV.CisloPoruchy:= 3;
					STAV.PopisPoruchy:= 'Porucha otocenia oddelovaca smerom k zasobníku';
				END_IF
				Step:= 0;
			END_IF
		
		
		15: //Spustenie zasobnika//
			OUT.TriediaciVzduch_RUN:= TRUE;
			Internal.IdleTime_1s.IN:= OUT.TriediaciVzduch_RUN;
			Internal.IdleTime_1500ms.IN:= IN.ZaplnenieListyZasobnika AND OUT.VibropohonZasobnika_RUN;
			
			IF Internal.IdleTime_1s.Q THEN
				OUT.VibropohonZasobnika_RUN:= TRUE;
			END_IF
		
			IF Internal.IdleTime_1500ms.Q THEN
				Internal.IdleTime_1s.IN:= FALSE;
				Internal.IdleTime_1500ms.IN:= FALSE;
				Step:= 18;
			END_IF
		
		
		18: //Otoèenie oddelovaèa matic na vystup smerom k maticovaèke a èakanie na prechod matice cez prvy snimac//
			OUT.OtocOddelovacMatice_NaVystup:= TRUE;
			Internal.AlarmTime_3s.IN:= TRUE;
			
			IF IN.Oddelovac_SnimPrechoduMatice THEN
				Internal.AlarmTime_3s.IN:= FALSE;
				Step:= 20;
			ELSIF Internal.AlarmTime_3s.Q THEN
				STAV.ERROR:= TRUE;
				STAV.CisloPoruchy:= 1;
				STAV.PopisPoruchy:= 'Porucha preletu matice cez snimac za oddelovacom';
				Step:= 0;
			END_IF
				
		20: //Zapnutie nastrelovacieho vzduchu a èakanie na prechod matice cez druhý snímaè//		
			OUT.NastrelenieMatice_RUN:= TRUE;
			Internal.AlarmTime_3s.IN:= TRUE;
			
			IF IN.Podavac_SnimPrechoduMatice THEN
				Internal.AlarmTime_3s.IN:= FALSE;
				Step:= 23;
			ELSIF Internal.AlarmTime_3s.Q THEN
				STAV.ERROR:= TRUE;
				STAV.CisloPoruchy:= 2;
				STAV.PopisPoruchy:= 'Porucha preletu matice cez snimac pred podavacom';
				Step:= 0;
			END_IF	
		
		23: //Cakam na vysunutie podavaca//		
			Internal.IdleTime_500ms.IN:= TRUE;
				
			IF Internal.IdleTime_500ms.Q THEN
				OUT.PodavacMatice_Vysun:= TRUE;
				Internal.AlarmTime_3s.IN:= TRUE;
			END_IF
			
			IF IN.PodavacMatice_VYSUNUTY AND IN.PritomnostMaticeNaVystupe THEN
				Internal.IdleTime_500ms.IN:= FALSE;
				Internal.AlarmTime_3s.IN:= FALSE;
				Step:= 25;
			ELSIF Internal.AlarmTime_3s.Q THEN
				STAV.ERROR:= TRUE;
				IF NOT IN.PodavacMatice_VYSUNUTY THEN
					STAV.CisloPoruchy:= 5;
					STAV.PopisPoruchy:= 'Porucha vysunutia podavaca vpred';
				ELSIF NOT IN.PritomnostMaticeNaVystupe THEN
					STAV.CisloPoruchy:= 7;
					STAV.PopisPoruchy:= 'Porucha snimaca pritomnosti matice v skrutkovacke';
				END_IF	
				Step:= 0;
			END_IF
				
				
		25: //Èakam na zasunutie podavaèa//		
			Internal.IdleTime_200ms.IN:= TRUE;
		
			IF Internal.IdleTime_200ms.Q THEN
				OUT.PodavacMatice_Vysun:= FALSE;
				Internal.AlarmTime_3s.IN:= TRUE;
			END_IF
				
			IF IN.PodavacMatice_ZASUNUTY THEN
				Internal.IdleTime_200ms.IN:= FALSE;
				Internal.AlarmTime_3s.IN:= FALSE;
				Step:= 0;
			ELSIF Internal.AlarmTime_3s.Q THEN
				STAV.ERROR:= TRUE;
				STAV.CisloPoruchy:= 6;
				STAV.PopisPoruchy:= 'Porucha zasunutia podavaca vzad';
				Step:= 0;
			END_IF	
		
		
		
		70: //Rucny rezim//
			IF CMD.RR_ZapniZasobnik THEN
				OUT.TriediaciVzduch_RUN:= TRUE;
				Internal.IdleTime_1s.IN:= TRUE;
			ELSE
				Internal.IdleTime_1s.IN:= FALSE;
			END_IF	
			
			OUT.VibropohonZasobnika_RUN:= Internal.IdleTime_1s.Q;
		
			IF NOT CMD.RucnyRezim THEN
				OUT.VibropohonZasobnika_RUN:= FALSE;
				Step:= 0;
			ELSIF CMD.PodajMaticu THEN
				OUT.PodavacMatice_Vysun:= FALSE;
				Step:= 10;
			END_IF	
		
			IF CMD.RR_OtocPodavac_Vstup THEN
				OUT.OtocOddelovacMatice_NaVystup:= FALSE;
				CMD.RR_OtocPodavac_Vstup:= FALSE;
			ELSIF CMD.RR_OtocPodavac_Vystup THEN	
				OUT.OtocOddelovacMatice_NaVystup:= TRUE;
				CMD.RR_OtocPodavac_Vystup:= FALSE;
			END_IF	
			
			OUT.PodavacMatice_Vysun:= CMD.RR_VysunPodavacMatic;
		
		
		
		
				
	END_CASE
	
	
	//*****************Èasovaèe************************//
	Internal.IdleTime_100ms.PT:= T#200ms;
	Internal.IdleTime_100ms();	
	Internal.IdleTime_200ms.PT:= T#200ms;
	Internal.IdleTime_200ms();
	Internal.IdleTime_500ms.PT:= T#200ms;
	Internal.IdleTime_500ms();
	Internal.IdleTime_1s.PT:= T#1s;
	Internal.IdleTime_1s();
	Internal.IdleTime_1500ms.PT:= T#1s500ms;
	Internal.IdleTime_1500ms();
	Internal.AlarmTime_3s.PT:= T#40s;
	Internal.AlarmTime_3s();
						
	
	
	
END_FUNCTION_BLOCK
