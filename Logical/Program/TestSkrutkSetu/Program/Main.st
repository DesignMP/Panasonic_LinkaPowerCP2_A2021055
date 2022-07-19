
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

	//********************************Zrušenie príznaku skrutka pripravena**********************************************************//
	IF SkrutkSet_K30.STAV.SkrutkaPripravena AND NOT SkrutkSet_K30.IN.SkrutkovackaZASUNUTA THEN
		SkrutkSet_K30.STAV.SkrutkaPripravena:= FALSE;
	END_IF	
	
	
	
	//*******************************Ovládanie zhadzovacieho vzduchu pred lištou zásobníka******************************************//
	SkrutkSet_K30.Internal.CasZaplneniaZasobnika.IN:= SkrutkSet_K30.IN.ZaplnenieListyZasobnika AND SkrutkSet_K30.OUT.VibropohonZasobnika_RUN;
	
	IF SkrutkSet_K30.Internal.CasZaplneniaZasobnika.Q THEN
		SkrutkSet_K30.OUT.ZhadzovaciVzduch_RUN:= TRUE;
	ELSIF NOT SkrutkSet_K30.OUT.VibropohonZasobnika_RUN THEN
		SkrutkSet_K30.OUT.ZhadzovaciVzduch_RUN:= FALSE;
	ELSE
		SkrutkSet_K30.OUT.ZhadzovaciVzduch_RUN:= FALSE;
	END_IF	
	
	SkrutkSet_K30.Internal.CasZaplneniaZasobnika.PT:= T#3s;
	SkrutkSet_K30.Internal.CasZaplneniaZasobnika();
	
	
	//******************************Vypnutie triediaceho vzduchu nad lištou zásobníka************************************************//
	SkrutkSet_K30.Internal.CasVypnTriediacehoVzduchu.IN:= SkrutkSet_K30.OUT.TriediaciVzduch_RUN AND NOT SkrutkSet_K30.OUT.VibropohonZasobnika_RUN;
	IF SkrutkSet_K30.Internal.CasVypnTriediacehoVzduchu.Q THEN
		SkrutkSet_K30.OUT.TriediaciVzduch_RUN:= FALSE;
	END_IF	
	
	SkrutkSet_K30.Internal.CasVypnTriediacehoVzduchu.PT:= T#1s;
	SkrutkSet_K30.Internal.CasVypnTriediacehoVzduchu();
	
	
	
	//********************************Vypnutie zásobníka**************************************************************//
	SkrutkSet_K30.Internal.CasVypnZasobnika.IN:= SkrutkSet_K30.IN.ZaplnenieListyZasobnika AND SkrutkSet_K30.OUT.VibropohonZasobnika_RUN AND NOT SkrutkSet_K30.CMD.RR_ZapniZasobnik;
	
	IF SkrutkSet_K30.Internal.CasVypnZasobnika.Q THEN
		SkrutkSet_K30.OUT.VibropohonZasobnika_RUN:= FALSE;
	END_IF
	
	
	SkrutkSet_K30.Internal.CasVypnZasobnika.PT:= T#3s;
	SkrutkSet_K30.Internal.CasVypnZasobnika();
	
	
	
	//*******************************Zapnutie zásobníka keï je prázdna lišta zásobníka*****************//
	IF SkrutkSet_K30.CMD.ENABLE AND NOT SkrutkSet_K30.STAV.ERROR AND NOT SkrutkSet_K30.IN.ZaplnenieListyZasobnika AND NOT SkrutkSet_K30.OUT.VibropohonZasobnika_RUN AND NOT SkrutkSet_K30.OUT.OddelovacSkrutiek_VYSUN THEN
		SkrutkSet_K30.OUT.VibropohonZasobnika_RUN:= TRUE;
	END_IF	
	
	
	
	
	
	
	
	
	//***************************Ruèný režim**************************************************//
	//Ovládanie zásobníka//
	IF SkrutkSet_K30.CMD.Rezim_MANUAL AND NOT SkrutkSet_K30.STAV.PodanieSkrutky_BUSY THEN
		IF SkrutkSet_K30.Internal.CasPredSpustenimZasobnika.Q THEN
			SkrutkSet_K30.OUT.VibropohonZasobnika_RUN:= TRUE;
		ELSE
			SkrutkSet_K30.OUT.VibropohonZasobnika_RUN:= FALSE;
		END_IF
	END_IF	
	
	SkrutkSet_K30.Internal.CasPredSpustenimZasobnika.IN:= SkrutkSet_K30.CMD.Rezim_MANUAL AND SkrutkSet_K30.CMD.RR_ZapniZasobnik;
	SkrutkSet_K30.Internal.CasPredSpustenimZasobnika.PT:= T#1s;
	SkrutkSet_K30.Internal.CasPredSpustenimZasobnika();
	
	
	//Ovládanie brzdy//
	IF SkrutkSet_K30.CMD.Rezim_MANUAL AND NOT SkrutkSet_K30.STAV.PodanieSkrutky_BUSY THEN
		IF SkrutkSet_K30.CMD.RR_VysunBrzdu THEN
			SkrutkSet_K30.OUT.Brzdu_VYSUN:= TRUE;
			SkrutkSet_K30.OUT.Brzdu_ZASUN:= FALSE;
		ELSE
			SkrutkSet_K30.OUT.Brzdu_VYSUN:= FALSE;
			SkrutkSet_K30.OUT.Brzdu_ZASUN:= TRUE;
		END_IF
	END_IF	
	
	//Ovládanie oddelovaèa skrutiek//
	IF SkrutkSet_K30.CMD.Rezim_MANUAL AND NOT SkrutkSet_K30.STAV.PodanieSkrutky_BUSY THEN
		IF SkrutkSet_K30.CMD.RR_VysunOddelovacSkrutiek THEN
			SkrutkSet_K30.OUT.OddelovacSkrutiek_VYSUN:= TRUE;
		ELSE
			SkrutkSet_K30.OUT.OddelovacSkrutiek_VYSUN:= FALSE;
		END_IF
	END_IF	
	
	
	//***********************************Enable knižnice***************************************//
	IF NOT SkrutkSet_K30.CMD.ENABLE AND SkrutkSet_K30.Step <> 0 THEN
		SkrutkSet_K30.OUT.VibropohonZasobnika_RUN:= FALSE;
		SkrutkSet_K30.Step:= 0;
	END_IF	
	
	
	
	//**********************************Reset poruchy*****************************************//
	IF SkrutkSet_K30.CMD.ResetPoruchy OR NOT SkrutkSet_K30.CMD.ENABLE THEN
		SkrutkSet_K30.STAV.ERROR:= FALSE;
		SkrutkSet_K30.STAV.PopisPoruchy:= '';
		SkrutkSet_K30.CMD.ResetPoruchy:= FALSE;
	END_IF	
	
	
	
	
	
		
	CASE SkrutkSet_K30.Step OF
		
		0: //Nulovanie//
			SkrutkSet_K30.Internal.IdleTime_200ms.IN:= FALSE;
			SkrutkSet_K30.Internal.IdleTime_100ms.IN:= FALSE;
			SkrutkSet_K30.Internal.IdleTime_500ms.IN:= FALSE;
			SkrutkSet_K30.Internal.IdleTime_1s.IN:= FALSE;
			SkrutkSet_K30.Internal.IdleTime_2s.IN:= FALSE;
			SkrutkSet_K30.Internal.IdleTime_5s.IN:= FALSE;
			SkrutkSet_K30.Internal.IdleTime_1500ms.IN:= FALSE;
			SkrutkSet_K30.Internal.AlarmTime_5s.IN:= FALSE;
			SkrutkSet_K30.Internal.AlarmTime_10s.IN:= FALSE;
			SkrutkSet_K30.Internal.PocetPodaniSkrutky:= 0;
			SkrutkSet_K30.OUT.Brzdu_VYSUN:= FALSE;
			SkrutkSet_K30.OUT.Brzdu_ZASUN:= TRUE;
			SkrutkSet_K30.OUT.OddelovacSkrutiek_VYSUN:= FALSE;
			SkrutkSet_K30.OUT.NastrelSkrutkuDoBrzdy:= FALSE;
			SkrutkSet_K30.OUT.NastrelSkrutkuDoSkrutkovacky:= FALSE;
			SkrutkSet_K30.OUT.OdsavanieBrzdy_RUN:= FALSE;
			SkrutkSet_K30.CMD.Rezim_MANUAL:= FALSE;
			SkrutkSet_K30.CMD.PodajSkrutku:= FALSE;
			SkrutkSet_K30.CMD.VysunBrzdu:= FALSE;
			SkrutkSet_K30.CMD.RR_ZapniZasobnik:= FALSE;
			SkrutkSet_K30.CMD.RR_VysunBrzdu:= FALSE;
			SkrutkSet_K30.CMD.RR_VysunOddelovacSkrutiek:= FALSE;
			SkrutkSet_K30.STAV.PodanieSkrutky_BUSY:= FALSE;
			SkrutkSet_K30.STAV.SkrutkovaciSet_READY:= FALSE;
		
			IF SkrutkSet_K30.CMD.ENABLE AND NOT SkrutkSet_K30.STAV.ERROR THEN
				SkrutkSet_K30.Step:= 1;
			END_IF	
	
	
		1: //Èakam na spustenie//
			SkrutkSet_K30.STAV.SkrutkovaciSet_READY:= TRUE;
			IF SkrutkSet_K30.CMD.PodajSkrutku THEN
				SkrutkSet_K30.STAV.SkrutkovaciSet_READY:= FALSE;
				SkrutkSet_K30.STAV.PodanieSkrutky_BUSY:= TRUE;
				SkrutkSet_K30.Step:= 10;
			ELSIF SkrutkSet_K30.CMD.VysunBrzdu THEN	
				SkrutkSet_K30.STAV.SkrutkovaciSet_READY:= FALSE;
				SkrutkSet_K30.STAV.PodanieSkrutky_BUSY:= TRUE;
				SkrutkSet_K30.Step:= 30;
			END_IF	
		
		
		10: //Vysunutie brzdy pre kontrolu skrutky v brzde, kontrola preletu skrutky cez preletovy snimac pred skrutkovackou//
			SkrutkSet_K30.OUT.Brzdu_ZASUN:= FALSE;
			SkrutkSet_K30.OUT.Brzdu_VYSUN:= TRUE;
			SkrutkSet_K30.Internal.AlarmTime_5s.IN:= NOT SkrutkSet_K30.IN.BrzdaVYSUNUTA;
			
			IF SkrutkSet_K30.IN.BrzdaVYSUNUTA THEN
				SkrutkSet_K30.OUT.NastrelSkrutkuDoSkrutkovacky:= TRUE;
				SkrutkSet_K30.Internal.IdleTime_2s.IN:= TRUE;
			END_IF
			
			IF SkrutkSet_K30.IN.PreletSnimacPredSkrutkovackou THEN
				SkrutkSet_K30.Internal.AlarmTime_5s.IN:= FALSE;
				SkrutkSet_K30.Internal.IdleTime_2s.IN:= FALSE;
				SkrutkSet_K30.STAV.SkrutkaPripravena:= TRUE;
				SkrutkSet_K30.Step:= 13;
			ELSIF SkrutkSet_K30.Internal.IdleTime_2s.Q THEN
				SkrutkSet_K30.Internal.AlarmTime_5s.IN:= FALSE;
				SkrutkSet_K30.Internal.IdleTime_2s.IN:= FALSE;
				SkrutkSet_K30.Step:= 13;
			ELSIF SkrutkSet_K30.Internal.AlarmTime_5s.Q THEN
				SkrutkSet_K30.STAV.ERROR:= TRUE;
				SkrutkSet_K30.STAV.PopisPoruchy:= 'Porucha vysunutia brzdy';
				SkrutkSet_K30.Step:= 0;
			END_IF	
			
			
	
		13: //Vypnutie vzduchu nastrelenia skrutky do skrutkovacky a zasunutie brzdy//
			SkrutkSet_K30.OUT.NastrelSkrutkuDoSkrutkovacky:= FALSE;		
			SkrutkSet_K30.OUT.Brzdu_ZASUN:= TRUE;
			SkrutkSet_K30.OUT.Brzdu_VYSUN:= FALSE;
			SkrutkSet_K30.Internal.AlarmTime_5s.IN:= NOT SkrutkSet_K30.IN.BrzdaZASUNUTA;
			
			IF SkrutkSet_K30.IN.BrzdaZASUNUTA THEN
				SkrutkSet_K30.Internal.AlarmTime_5s.IN:= FALSE;
				SkrutkSet_K30.Step:= 15;
			ELSIF SkrutkSet_K30.Internal.AlarmTime_5s.Q THEN
				SkrutkSet_K30.STAV.ERROR:= TRUE;
				SkrutkSet_K30.STAV.PopisPoruchy:= 'Porucha zasunutia brzdy';
				SkrutkSet_K30.Step:= 0;
			END_IF		
				
				
				
			
		15: //Spustenie zasobnika a kontrola snimaca zaplnenia listy//
			SkrutkSet_K30.OUT.OddelovacSkrutiek_VYSUN:= FALSE;
			SkrutkSet_K30.OUT.TriediaciVzduch_RUN:= TRUE;
			SkrutkSet_K30.Internal.IdleTime_1s.IN:= SkrutkSet_K30.OUT.TriediaciVzduch_RUN;
			SkrutkSet_K30.Internal.IdleTime_1500ms.IN:= SkrutkSet_K30.IN.ZaplnenieListyZasobnika AND SkrutkSet_K30.OUT.VibropohonZasobnika_RUN;
			
			IF SkrutkSet_K30.Internal.IdleTime_1s.Q THEN
				SkrutkSet_K30.OUT.VibropohonZasobnika_RUN:= TRUE;
			END_IF 	
		
			IF SkrutkSet_K30.Internal.IdleTime_1500ms.Q THEN
				SkrutkSet_K30.Internal.IdleTime_1s.IN:= FALSE;
				SkrutkSet_K30.Internal.IdleTime_1500ms.IN:= FALSE;
				SkrutkSet_K30.Step:= 18;
			END_IF
		
				
		18: //Vysunutie oddelovaca skrutiek a zapnutie vzduchu nastrelenia skrutky do brzdy a zapnutie odsavania necistot		
			SkrutkSet_K30.OUT.OddelovacSkrutiek_VYSUN:= TRUE;
			SkrutkSet_K30.OUT.NastrelSkrutkuDoBrzdy:= TRUE;	
			SkrutkSet_K30.OUT.OdsavanieBrzdy_RUN:= TRUE;
			SkrutkSet_K30.Internal.IdleTime_2s.IN:= TRUE;
			
			IF SkrutkSet_K30.IN.PreletSnimacPredBrzdou THEN
				SkrutkSet_K30.Internal.IdleTime_2s.IN:= FALSE;
				SkrutkSet_K30.OUT.NastrelSkrutkuDoBrzdy:= FALSE;
				SkrutkSet_K30.OUT.OddelovacSkrutiek_VYSUN:= FALSE;
				SkrutkSet_K30.OUT.OdsavanieBrzdy_RUN:= FALSE;
				SkrutkSet_K30.Step:= 20;
			ELSIF SkrutkSet_K30.Internal.IdleTime_2s.Q THEN
				SkrutkSet_K30.Internal.IdleTime_2s.IN:= FALSE;
				SkrutkSet_K30.OUT.NastrelSkrutkuDoBrzdy:= FALSE;
				SkrutkSet_K30.OUT.OddelovacSkrutiek_VYSUN:= FALSE;
				SkrutkSet_K30.OUT.OdsavanieBrzdy_RUN:= FALSE;
				SkrutkSet_K30.Step:= 15;
			END_IF	
		
		
		20: //Kontrola stavu skrutka pripravena//
			IF SkrutkSet_K30.STAV.SkrutkaPripravena THEN
				SkrutkSet_K30.Step:= 0;
			ELSE
				SkrutkSet_K30.Internal.PocetPodaniSkrutky:= SkrutkSet_K30.Internal.PocetPodaniSkrutky + 1;
				IF SkrutkSet_K30.Internal.PocetPodaniSkrutky < 4 THEN
					SkrutkSet_K30.Step:= 10;
				ELSE
					SkrutkSet_K30.STAV.ERROR:= TRUE;
					SkrutkSet_K30.STAV.PopisPoruchy:= 'Porucha nastrelenia skrutky do brzdy';
					SkrutkSet_K30.Step:= 0;
				END_IF	
			END_IF	
			
		30: //Vysunutie brzdy//
			SkrutkSet_K30.OUT.Brzdu_ZASUN:= FALSE;
			SkrutkSet_K30.OUT.Brzdu_VYSUN:= TRUE;	
			SkrutkSet_K30.Internal.AlarmTime_5s.IN:= NOT SkrutkSet_K30.IN.BrzdaVYSUNUTA;
			
			IF NOT SkrutkSet_K30.CMD.VysunBrzdu THEN
				SkrutkSet_K30.Step:= 0;
			ELSIF SkrutkSet_K30.Internal.AlarmTime_5s.Q THEN
				SkrutkSet_K30.STAV.ERROR:= TRUE;
				SkrutkSet_K30.STAV.PopisPoruchy:= 'Porucha vysunutia brzdy';
				SkrutkSet_K30.Step:= 0;	
			END_IF	
		
	END_CASE
	
				
				
				
				
				
	//*********************************Èasovaèe**************************************//
	SkrutkSet_K30.Internal.IdleTime_200ms.PT:= T#200ms;
	SkrutkSet_K30.Internal.IdleTime_200ms();
	SkrutkSet_K30.Internal.IdleTime_100ms.PT:= T#100ms;
	SkrutkSet_K30.Internal.IdleTime_100ms();
	SkrutkSet_K30.Internal.IdleTime_1500ms.PT:= T#1s500ms;
	SkrutkSet_K30.Internal.IdleTime_1500ms();
	SkrutkSet_K30.Internal.IdleTime_500ms.PT:= T#500ms;
	SkrutkSet_K30.Internal.IdleTime_500ms();
	SkrutkSet_K30.Internal.IdleTime_1s.PT:= T#1s;
	SkrutkSet_K30.Internal.IdleTime_1s();
	SkrutkSet_K30.Internal.IdleTime_2s.PT:= T#2s;
	SkrutkSet_K30.Internal.IdleTime_2s();
	SkrutkSet_K30.Internal.IdleTime_5s.PT:= T#5s;
	SkrutkSet_K30.Internal.IdleTime_5s();
	SkrutkSet_K30.Internal.AlarmTime_5s.PT:= T#5s;
	SkrutkSet_K30.Internal.AlarmTime_5s();
	SkrutkSet_K30.Internal.AlarmTime_10s.PT:= T#10s;
	SkrutkSet_K30.Internal.AlarmTime_10s();
				
				
				
				
				
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

