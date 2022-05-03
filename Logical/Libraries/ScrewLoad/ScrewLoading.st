
(* TODO: Add your comment here *)
FUNCTION_BLOCK ScrewLoading
		
	//---Spustenie
	IF EDGEPOS(Cmd.AutomatStart=1) THEN
		Internal.Step.Brzda:=1;
		Internal.Step.VibracnyHrniec:=1;
	ELSIF EDGEPOS (Cmd.ManualStartHrniec) THEN
		Internal.Step.VibracnyHrniec:=120;
	ELSIF EDGEPOS (Cmd.ManualPresunBrzdu) THEN
		Internal.Step.Brzda:=120;
	ELSIF EDGEPOS(Cmd.AutomatStart=0) OR EDGEPOS(Cmd.ManualStartHrniec=0) THEN
		Internal.Step.Brzda:=0;
		Internal.Step.VibracnyHrniec:=140;
	END_IF
	
	//Mapovanie ovladania
	IN.Brzda.VyziadanieSkrutky:=Cmd.PodajSkrutku;
	Status.SkrutkaPripravena:=OUT.Brzda.SktutkaPodana;

	//Run signal
	IF Internal.Step.VibracnyHrniec>120 AND Cmd.ManualStartHrniec=1 THEN
		Status.AutomatBezi:=0;
		Status.ManualBeziHrniec:=1;
	ELSIF Internal.Step.VibracnyHrniec>=100 AND Cmd.AutomatStart=1 THEN
		Status.AutomatBezi:=1;
		Status.ManualBeziHrniec:=0;
	ELSIF Internal.Step.VibracnyHrniec=0 THEN
		Status.AutomatBezi:=0;
		Status.ManualBeziHrniec:=0;
	END_IF
	
	
	//---Ovladanie brzdy--------------------------------------------------------------
	CASE Internal.Step.Brzda OF
		//---Vypnute-------------------
		0: Internal.Status.Brzda:="Vypnute";
			OUT.Brzda.NastrelenieSkrutky:=0;
			OUT.Brzda.OdsavanieNecistot:=0;
			OUT.Brzda.PodajSkrutku:=0;
			OUT.Brzda.ZakladnaPoloha:=0;
			OUT.Brzda.SktutkaPodana:=0;
			
			Internal.Brzda.T_CasCisteniaSkrutky.IN:=0;
			Internal.Brzda.T_PreletSkrutky.IN:=0;
			Internal.Brzda.T_PresunBrzdy.IN:=0;
		
			//---Inicializacia-------------
		1: Internal.Status.Brzda:="Inicializacia - Kontrolujem polohu brzdy";
			OUT.Brzda.ZakladnaPoloha:=1;
			OUT.Brzda.PodajSkrutku:=0;
			Internal.Brzda.T_PresunBrzdy.IN:=1;
		
			IF IN.Brzda.PodajSkrutku=0 AND IN.Brzda.ZakladnaPoloha=1 THEN
				Internal.Brzda.T_PresunBrzdy.IN:=0;
				Internal.Step.Brzda:=Internal.Step.Brzda+1;
			ELSIF Internal.Brzda.T_PresunBrzdy.Q=1 THEN
				OUT.Brzda.ZakladnaPoloha:=0;
				OUT.Brzda.PodajSkrutku:=0;
				Internal.Brzda.T_PresunBrzdy.IN:=0;
				Internal.Step.Brzda:=150; // brzda sa neda presunut
			END_IF
			
		2: Internal.Status.Brzda:="Inicializacia - Kontrolujem pritomnost skrutky";	
			IF IN.Brzda.ZakladnaPoloha=1 AND IN.Brzda.SkrutkaPritomnaVBrzde=0 THEN
				Internal.Step.Brzda:=100;
			ELSIF IN.Brzda.ZakladnaPoloha=1 AND IN.Brzda.SkrutkaPritomnaVBrzde=1 THEN
				Internal.Step.Brzda:=102;
			END_IF
		
			//---Automat-------------
		100: Internal.Status.Brzda:="Automat - Cakam na skrutku";
			IF IN.Brzda.ZakladnaPoloha=1 AND IN.Brzda.SkrutkaPritomnaVBrzde=1 THEN
				Internal.Step.Brzda:=Internal.Step.Brzda+1;
			END_IF
			
		101: Internal.Status.Brzda:="Automat - Cistim skrutku";
			OUT.Brzda.OdsavanieNecistot:=1;
			Internal.Brzda.T_CasCisteniaSkrutky.IN:=1;
			
			IF Internal.Brzda.T_CasCisteniaSkrutky.Q=1 THEN
				OUT.Brzda.OdsavanieNecistot:=0;
				Internal.Brzda.T_CasCisteniaSkrutky.IN:=0;
				Internal.Step.Brzda:=Internal.Step.Brzda+1;
			END_IF
		
		102: Internal.Status.Brzda:="Automat - Cakam na vyziadanie skrutky";
			IF IN.Brzda.VyziadanieSkrutky=1 THEN
				OUT.Brzda.ZakladnaPoloha:=0;
				OUT.Brzda.PodajSkrutku:=1;
				Internal.Brzda.T_PresunBrzdy.IN:=1;
			END_IF
		
			IF IN.Brzda.PodajSkrutku=1 AND IN.Brzda.ZakladnaPoloha=0 THEN
				Internal.Brzda.T_PresunBrzdy.IN:=0;
				Internal.Brzda.T_PreletSkrutky.IN:=1;
				OUT.Brzda.NastrelenieSkrutky:=1;
				Internal.Step.Brzda:=Internal.Step.Brzda+1;
			ELSIF Internal.Brzda.T_PresunBrzdy.Q=1 THEN
				OUT.Brzda.ZakladnaPoloha:=0;
				OUT.Brzda.PodajSkrutku:=0;
				Internal.Brzda.T_PresunBrzdy.IN:=0;
				Internal.Step.Brzda:=150; // Brzda sa neda presunut
			END_IF
		
		103: Internal.Status.Brzda:="Automat - Cakam na prelet skrutky";
			IF IN.Brzda.PreletSkrutky=1 THEN
				OUT.Brzda.NastrelenieSkrutky:=0;
				OUT.Brzda.ZakladnaPoloha:=1;
				OUT.Brzda.PodajSkrutku:=0;
				Internal.Brzda.T_PreletSkrutky.IN:=0;
			ELSIF Internal.Brzda.T_PreletSkrutky.Q=1 THEN
				OUT.Brzda.NastrelenieSkrutky:=0;
				OUT.Brzda.ZakladnaPoloha:=0;
				OUT.Brzda.PodajSkrutku:=0;
				Internal.Brzda.T_PreletSkrutky.IN:=0;
				Internal.Step.Brzda:=151; // Skrutka nepreletela snimacom
			END_IF
		
			IF IN.Brzda.PodajSkrutku=0 AND IN.Brzda.ZakladnaPoloha=1 THEN
				Internal.Step.Brzda:=Internal.Step.Brzda+1;
			END_IF
		
		104: Internal.Status.Brzda:="Automat - Skrutka podana";
			OUT.Brzda.SktutkaPodana:=1;
			
			IF IN.Brzda.VyziadanieSkrutky=0 THEN
				OUT.Brzda.SktutkaPodana:=0;
				Internal.Step.Brzda:=Internal.Step.Brzda+1;
			END_IF
			
		105: Internal.Status.Brzda:="Automat - Ukoncenie";
			Internal.Step.Brzda:=100;
		
		120: Internal.Status.Brzda:="Manual - Presuvam brzdu na vypustenie skrutky";
			
			OUT.Brzda.ZakladnaPoloha:=0;
			OUT.Brzda.PodajSkrutku:= 1;
		
			IF Cmd.ManualPresunBrzdu=0 THEN
				OUT.Brzda.PodajSkrutku:= 0;
				OUT.Brzda.ZakladnaPoloha:=1;
				IF IN.Brzda.ZakladnaPoloha THEN
					Internal.Step.Brzda:=0;
				END_IF	
			END_IF
				
					
			
			//---Error-----------------------
		150: Internal.Status.Brzda:="Error - Brzda sa neda presunut";
			Error.ErrorBit:=1;
			Error.ErrorNumber:=1;
			Error.ErrorMessage:=Internal.Status.Brzda;
		151: Internal.Status.Brzda:="Error - Skrutka nepresla preletovym snimacom";
			Error.ErrorBit:=1;
			Error.ErrorNumber:=2;
			Error.ErrorMessage:=Internal.Status.Brzda;
		
			//---Manual----------------------
		250: Internal.Status.Brzda:="Manual - Presuvam brzdu";
			OUT.Brzda.PodajSkrutku:=1;
			OUT.Brzda.ZakladnaPoloha:=0;
		
			IF Cmd.ManualPresunBrzdu=0 THEN
				OUT.Brzda.PodajSkrutku:=0;
				OUT.Brzda.ZakladnaPoloha:=1;
				Internal.Step.Brzda:=0;
			END_IF		
	END_CASE

	
	//---Ovladanie vibracneho hrnca-------------------------------------------------------------
	CASE Internal.Step.VibracnyHrniec OF
		//---Vypnute-------------------
		0: Internal.Status.VibracnyHrniec:="Vypnute";
			
			OUT.VibracnyHrniec.VzduchNastreleniaSkrutky:=0;
			OUT.VibracnyHrniec.OddelovacVysunut:=0;
			OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek:=0;
			OUT.VibracnyHrniec.TiedenieSkrutiek:=0;
			OUT.VibracnyHrniec.ZapniVibromotor:=0;
			
			Internal.VibracnyHrniec.T_PreletSkrutky.IN:=0;
			Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=0;
			Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
			Internal.VibracnyHrniec.T_PredOpatovnymPodanimSkrutky.IN:=0;
			
			Error.ErrorBit:=0;
			Error.ErrorNumber:=0;
			Error.ErrorMessage:="";
			
			//---Inicializacia-------------
		1: Internal.Status.VibracnyHrniec:="Inicializacia - Zapinam vibracny hrniec";
			OUT.VibracnyHrniec.TiedenieSkrutiek:=1;
			Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=1;
			
			IF Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.Q=1 THEN
				Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=0;
				OUT.VibracnyHrniec.ZapniVibromotor:=1;
				Internal.Step.VibracnyHrniec:=100;
			END_IF
		
			//---Automat-------------------
		100: Internal.Status.VibracnyHrniec:="Automat - Cakam na uvolnenie brzdy";
			IF IN.VibracnyHrniec.VibracnaListaZaplnena=1 THEN
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=1;
			ELSE
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
			END_IF
			
			IF IN.VibracnyHrniec.VibracnaListaZaplnena=1 AND Internal.VibracnyHrniec.T_Zaplnenie.Q=1 AND (Internal.Step.Brzda=102 OR Internal.Step.Brzda=104) THEN
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
				Internal.Step.VibracnyHrniec:=105;
			ELSIF Internal.Step.Brzda=100 AND OUT.VibracnyHrniec.ZapniVibromotor=0 THEN
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
				Internal.Step.VibracnyHrniec:=110;
			ELSIF Internal.Step.Brzda=100 AND OUT.VibracnyHrniec.ZapniVibromotor=1 THEN
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
				Internal.Step.VibracnyHrniec:=111;
			END_IF
			
			//---Vypnutie hrnca po èase z fázy 100
		105: Internal.Status.VibracnyHrniec:="Automat - Vypinam hrniec";
			OUT.VibracnyHrniec.ZapniVibromotor:=0;
			Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=1;
			
			IF Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.Q=1 THEN
				Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=0;
				OUT.VibracnyHrniec.TiedenieSkrutiek:=0;
				Internal.Step.VibracnyHrniec:=100;
			END_IF
			
			//---Zapnutie hrnca z fázy 100
		110: Internal.Status.VibracnyHrniec:="Automat - Zapinam hrniec";
			OUT.VibracnyHrniec.TiedenieSkrutiek:=1;
			Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=1;
			
			IF Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.Q=1 THEN
				Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=0;
				OUT.VibracnyHrniec.ZapniVibromotor:=1;
				Internal.Step.VibracnyHrniec:=Internal.Step.VibracnyHrniec+1;
			END_IF
			
		111: Internal.Status.VibracnyHrniec:="Automat - Podavam skrutku";
			IF IN.VibracnyHrniec.VibracnaListaZaplnena=1 THEN
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=1;
			ELSE
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
			END_IF
			
			IF Internal.VibracnyHrniec.T_Zaplnenie.Q=1 THEN
				OUT.VibracnyHrniec.OddelovacVysunut:=1;
				Internal.VibracnyHrniec.T_PreletSkrutky.IN:=1;
			END_IF	
			
			IF IN.VibracnyHrniec.PreletovySnimac=1 THEN
				Internal.VibracnyHrniec.T_PreletSkrutky.IN:=0;
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
				Internal.Step.VibracnyHrniec:=114;
			ELSIF Internal.VibracnyHrniec.T_PreletSkrutky.Q=1 THEN
				OUT.VibracnyHrniec.OddelovacVysunut:=0;
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
				Internal.VibracnyHrniec.T_PreletSkrutky.IN:=0;
				Internal.Step.VibracnyHrniec:=112;// Skrutka sa neda podat
			END_IF
		
		112: Internal.Status.VibracnyHrniec:="Automat - Cakam na opatovne podanie skrutky";
			
			Internal.VibracnyHrniec.T_PredOpatovnymPodanimSkrutky.IN:=1;
			
			IF Internal.VibracnyHrniec.T_PredOpatovnymPodanimSkrutky.Q THEN
				Internal.VibracnyHrniec.T_PredOpatovnymPodanimSkrutky.IN:=0;
				Internal.Step.VibracnyHrniec:=111;
			END_IF	
			
			
		114: Internal.Status.VibracnyHrniec:="Automat - Nastrelovanie";
			OUT.VibracnyHrniec.OddelovacVysunut:=0;
			OUT.VibracnyHrniec.VzduchNastreleniaSkrutky:=1;
			
			IF Internal.Step.Brzda>100 THEN
				OUT.VibracnyHrniec.VzduchNastreleniaSkrutky:=0;
				Internal.Step.VibracnyHrniec:=Internal.Step.VibracnyHrniec+1;
			END_IF
			
		115: Internal.Status.VibracnyHrniec:="Automat - Koniec cyklu";
			Internal.Step.VibracnyHrniec:=100;
			
			//---Manualne vibrovanie
		120: Internal.Status.VibracnyHrniec:="Manual - Zapinam vibracny hrniec";
			OUT.VibracnyHrniec.TiedenieSkrutiek:=1;
			Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=1;
			
			IF Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.Q=1 THEN
				Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=0;
				OUT.VibracnyHrniec.ZapniVibromotor:=1;
				Internal.Step.VibracnyHrniec:=121;
			END_IF
		
			//---Automat-------------------
		121: Internal.Status.VibracnyHrniec:="Manual - Prebieha vynasanie skrutiek";
			IF IN.VibracnyHrniec.VibracnaListaZaplnena=1 THEN
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=1;
			ELSE
				Internal.VibracnyHrniec.T_Zaplnenie.IN:=0;
			END_IF
			
			IF IN.VibracnyHrniec.VibracnaListaZaplnena=1 AND Internal.VibracnyHrniec.T_Zaplnenie.Q=1 AND OUT.VibracnyHrniec.ZapniVibromotor THEN
				OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek:=1;
			ELSE 
				OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek:=0;
			END_IF
			
			//---Ukoncenie vibrovania
		140: Internal.Status.VibracnyHrniec:="Ukoncenie - Vypinam vibracny hrniec";
			OUT.VibracnyHrniec.ZapniVibromotor:=0;
			Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=1;
			
			IF Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.Q=1 THEN
				Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.IN:=0;
				OUT.VibracnyHrniec.TiedenieSkrutiek:=0;
				Internal.Step.VibracnyHrniec:=0;
			END_IF
			
			//---Error-----------------------
		150: Internal.Status.VibracnyHrniec:="Error - Skrutka sa neda podat";
			Error.ErrorBit:=1;
			Error.ErrorNumber:=3;
			Error.ErrorMessage:=Internal.Status.VibracnyHrniec;
			OUT.VibracnyHrniec.TiedenieSkrutiek:=0;
			OUT.VibracnyHrniec.ZapniVibromotor:=0;
			
			//---Manual----------------------
		250: Internal.Status.VibracnyHrniec:="Manual";
	END_CASE
		
	IF IN.VibracnyHrniec.VibracnaListaZaplnena=1 AND Internal.Step.VibracnyHrniec>99 AND OUT.VibracnyHrniec.ZapniVibromotor THEN
		OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek:=1;
	ELSE 
		OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek:=0;
	END_IF
				
	//---Casovace-------------------------------------------------------------------------------
	Internal.Brzda.T_CasCisteniaSkrutky.PT:=T#1s;//REAL_TO_TIME(Visu.Premenne.);
	Internal.Brzda.T_CasCisteniaSkrutky();
	
	Internal.Brzda.T_PreletSkrutky.PT:=T#5s;//REAL_TO_TIME(Visu.Premenne.);
	Internal.Brzda.T_PreletSkrutky();
	
	Internal.Brzda.T_PresunBrzdy.PT:=T#2s;//REAL_TO_TIME(Visu.Premenne.);
	Internal.Brzda.T_PresunBrzdy();
	
	Internal.VibracnyHrniec.T_PreletSkrutky.PT:=T#5s;//REAL_TO_TIME(Visu.Premenne.);
	Internal.VibracnyHrniec.T_PreletSkrutky();
	
	Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu.PT:=T#0.5s;//REAL_TO_TIME(Visu.Premenne.);
	Internal.VibracnyHrniec.T_ZapnutieTriediacehoVzduchu();
	
	Internal.VibracnyHrniec.T_Zaplnenie.PT:=T#1s;//REAL_TO_TIME(Visu.Premenne.);
	Internal.VibracnyHrniec.T_Zaplnenie();
	
	Internal.VibracnyHrniec.T_PredOpatovnymPodanimSkrutky.PT:=T#2s;//REAL_TO_TIME(Visu.Premenne.);
	Internal.VibracnyHrniec.T_PredOpatovnymPodanimSkrutky();
	
	
	
END_FUNCTION_BLOCK
