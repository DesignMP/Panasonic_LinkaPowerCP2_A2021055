
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_StoperSrobovania);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	IOLinkKomunikacia;
	
	
	//Reset sekcie //
	IF P2_StoperSrobovania.Reset THEN
		SC_P2_StoperSrobovania.Step:= 0;
		P2_StoperSrobovania.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P2_StoperSrobovania.Step:= 0;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		SC_P2_StoperSrobovania.Step:= 0;
	END_IF	
	
	
	CASE SC_P2_StoperSrobovania.Step OF 
	
		0:
			SC_P2_StoperSrobovania.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			P2_StoperSrobovania.Automat:= FALSE;
			P2_StoperSrobovania.KoniecCyklu:= FALSE;
			P2_StoperSrobovania.Manual:= FALSE;
			P2_StoperSrobovania.STAV.PoINIT:= FALSE;
			P2_StoperSrobovania.OUT.ZasunStoper:= FALSE;
			P2_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
			P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM4:= FALSE;
			P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM4:= FALSE;
			P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM6:= FALSE;
			P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM6:= FALSE;
			P2_Srobovanie.COM_IN.Model5H_ZaskrutkujLavuM5:= FALSE;
			P2_Srobovanie.COM_IN.Model5H_ZaskrutkujPravuM5:= FALSE;
			P2_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednuM4:= FALSE;
			P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
			P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
			P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
			P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
			P2_Robot.COM_OUT.Odober_Busbary4F:= FALSE;
			P2_Robot.COM_OUT.Odober_Busbary5F:= FALSE;
			P2_Robot.COM_OUT.Odober_Busbary5H:= FALSE;
			P2_Robot.COM_OUT.Poloz_Busbary4F:= FALSE;
			P2_Robot.COM_OUT.Poloz_Busbary5F:= FALSE;
			P2_Robot.COM_OUT.Poloz_Busbary5H:= FALSE;
			P2_Robot.COM_OUT.Dotlac_Filter5H:= FALSE;
			P2_Robot.COM_OUT.Odparkovanie:= FALSE;
			P2_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
			P2_Robot.COM_OUT.UvolniBusbary:= FALSE;
			P2_Robot.COM_OUT.Dotlac_Filter5H:= FALSE;
			P2_Robot.COM_OUT.ZmenaGripra_Cistenie:= FALSE;
			CAM10.CMD.Triger:= FALSE;
			CAM10.STAV.Results_READY:= FALSE;
			FTP_CAM10.CMD.OdosliFotku:= FALSE;
			FTP_CAM10.CMD.VymazFotku:= FALSE;
			TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P2_Srobovanie_ST5.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P2_Srobovanie_ST5.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
			P2_Srobov_KAM_Result_OK:= FALSE;
			P2_Srobov_KAM_Result_NG:= FALSE;
			P2_Vizu.ZobrazHL1_ST5:= FALSE;
			P2_Vizu.ZobrazHL2_ST5:= FALSE;
			P2_Vizu.ZobrazHL3_ST5:= FALSE;
			P2_Vizu.ZobrazHL4_ST5:= FALSE;
			TRCB_P2_Srobov_OpatovnyDopyt:= FALSE;
			TRCB_P2_Srobov_PaletkaNG:= FALSE;
			VysunutieSkrutkovacky_OK:= FALSE;
			P2_StoperSrobovania.PAR.IndexFotky:= 0;
			PocetTrigrovKamery:= 0;
			PocetDopytovNaServer:= 0;
			CisloFotky:= 0;
			TestovaciKus:= FALSE;
			P2_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_Robot.STAV.Srobovanie_PrebiehaManipulacia:= FALSE;
			DoskrutkovaniePriPoruche:= FALSE;
			
				
			
			
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND 
				Safety.STAV.P2_ZonaBunky_AKTIVNA AND 
				P2_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P2_Pracovisko.STAV.Porucha_ST2 AND
				NOT P2_Pracovisko.STAV.Porucha_ST3 AND
				NOT P2_Pracovisko.STAV.Porucha_ST4 AND
				NOT P2_Pracovisko.STAV.Porucha_ST5 THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 1;
			END_IF
	
		1:
			SC_P2_StoperSrobovania.StepName:='1 - Cakam na spustenie vyroby';
			P2_StoperSrobovania.KoniecCyklu:= FALSE;
			IF P2_StoperSrobovania.Automat THEN
				SC_P2_StoperSrobovania.Step:= 2;
			ELSIF P2_StoperSrobovania.Manual THEN
				SC_P2_StoperSrobovania.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P2_StoperSrobovania.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			
									
			IF P2_Srobovanie.STAV.PoINIT AND P2_Dopravniky.STAV.PoINIT AND P2_Pracovisko.STAV.SkrutkovackyZasunute AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 3;
			END_IF
		
			
		3:
			SC_P2_StoperSrobovania.StepName:='3 - Inicializacia - vymazanie adresara kamery';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 10;
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 THEN
				FTP_CAM10.CMD.VymazFotku:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
				
			IF FTP_CAM10.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM10.CMD.VymazFotku:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 10;
			ELSIF FTP_CAM10.STATUS.KomunikaciaError THEN
				P2_Alarmy[232]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF	
			
	
			
		
			
		10:
			SC_P2_StoperSrobovania.StepName:='10 - Inicializacia - zasunutie centrovacky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperSrobovania.IN.Centrovanie_ZASUNUTE AND P2_Dopravniky.STAV.PoINIT THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 13;
			END_IF		
			
			
		
		13:
			SC_P2_StoperSrobovania.StepName:='13 - Inicializacia - hladanie paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
	
			IF P2_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 20;		
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q THEN
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 100;
			END_IF
		
		
		20:
			SC_P2_StoperSrobovania.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
		
			SC_P2_StoperSrobovania.IdleTime.IN:= P2_StoperSrobovania.RFID_hlava.PritomnostPaletky;
									
			IF SC_P2_StoperSrobovania.IdleTime.Q THEN
				P2_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
			END_IF
			
			IF P2_StoperSrobovania.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P2_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P2_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 23;
			END_IF	
			
		23:
			SC_P2_StoperSrobovania.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P2_StoperSrobovania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 30;
			ELSE
				P2_Alarmy[214]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF
		
				
	
			
		30:
			SC_P2_StoperSrobovania.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_5' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_5' THEN  
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_5' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_5' THEN
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			END_IF	
            
                      
            
            
		33:
			SC_P2_StoperSrobovania.StepName:='33 - Inicializacia - kontrola uzavretia komunikacie s Panatrace'; 
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			ELSE
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 38;
			END_IF	
					
		
			
		38:
			SC_P2_StoperSrobovania.StepName:='38 - Inicializacia - kontrola odoslania fotiek';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;   
            
			IF Paletka[i].STAV.OdoslanieFotiek_DONE THEN
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 550;
			ELSE
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 40;
			END_IF
            
            
		40:
			SC_P2_StoperSrobovania.StepName:='40 - Inicializacia - zacentrovanie paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 43;
			END_IF	   
            
            
		43:
			SC_P2_StoperSrobovania.StepName:='43 - Inicializacia - presun manipulatora vzad';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 45;
			END_IF   
         
		45:
			SC_P2_StoperSrobovania.StepName:='45 - Inicializacia - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				CAM10.STAV.Results_READY:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 46;
			END_IF		
			
			
            
		46:
			SC_P2_StoperSrobovania.StepName:='45 - Inicializacia - kamerova kontrola paletky CAM10'; //CAM 10//
			SC_P2_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;   
            
           			
			IF Linka.P2_Kamery_OFF THEN
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 138;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 138;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 358; 
				END_IF	
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 AND CAM10.STAV.Command_READY THEN
				CAM10.CMD.Triger:= TRUE;
				SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF CAM10.STAV.Results_READY AND CAM10.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM10.STAV.Results_READY:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 50;
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM10.STAV.Results_READY:= FALSE;
				CAM10.CMD.Triger:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 48;
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[295]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF
		
                     
            
            
		48:
			SC_P2_StoperSrobovania.StepName:='48 - Inicializacia - cakam na opatovny triger kamery CAM10';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P2_StoperSrobovania.IdleTime.Q THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 46;
			END_IF	
			
			
			   
		50:
			SC_P2_StoperSrobovania.StepName:='50 - Inicializacia - kontrola vysledku kamery podla typu modelu';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			
			IF NOT CAM10.STAV.BUSY THEN
				CAM10.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF CAM10.RESULT.Paletka.Pritomn_Busbarov_4F AND
						NOT CAM10.RESULT.PowerCP.Pritomn_LavejM4_4F5F AND
						NOT CAM10.RESULT.PowerCP.Pritomn_LavejSkrutkyM6_4F5F AND
						NOT CAM10.RESULT.PowerCP.Pritomn_PravejM4_4F5F AND
						NOT CAM10.RESULT.PowerCP.Pritomn_PravejSkrutkyM6_4F5F THEN
						CAM10.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 53;
					ELSE
						CAM10.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 53;
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF CAM10.RESULT.Paletka.Pritomn_Busbarov_5F AND
						NOT CAM10.RESULT.PowerCP.Pritomn_LavejM4_4F5F AND
						NOT CAM10.RESULT.PowerCP.Pritomn_LavejSkrutkyM6_4F5F AND
						NOT CAM10.RESULT.PowerCP.Pritomn_PravejM4_4F5F AND
						NOT CAM10.RESULT.PowerCP.Pritomn_PravejSkrutkyM6_4F5F THEN
						CAM10.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 53;
					ELSE
						CAM10.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 53;
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					IF CAM10.RESULT.Paletka.Pritomn_Busbarov_5H AND
						NOT CAM10.RESULT.PowerCP.Pritomn_LavejSkrutkyM5_5H AND
						NOT CAM10.RESULT.PowerCP.Pritomn_PravejSkrutkyM5_5H AND
						NOT CAM10.RESULT.PowerCP.Pritomn_SkrutkyM4_Filtra_5H THEN
						CAM10.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 53;
					ELSE
						CAM10.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 53;
					END_IF  
				END_IF   
			END_IF
			
			
		53:
			SC_P2_StoperSrobovania.StepName:='53 - Inicializacia - vymazanie adresara kamery';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 55;		
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 THEN
				FTP_CAM10.CMD.VymazFotku:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
				
			IF FTP_CAM10.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM10.CMD.VymazFotku:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 55;
			ELSIF FTP_CAM10.STATUS.KomunikaciaError THEN
				P2_Alarmy[232]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF	
            
            
		55:
			SC_P2_StoperSrobovania.StepName:='55 - Inicializacia - rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
            	
				
			IF CAM10.PAR.ResultFotky = 'PASS' THEN
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 138;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 138;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 358;  
				END_IF    
			ELSIF CAM10.PAR.ResultFotky = 'FAIL' THEN
				P2_StoperSrobovania.STAV.PoINIT:= TRUE;
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 545;
			END_IF
            
               
            
			
					
			//********************************************************Automatický režim****************************************************************************//
	
		100:  
			SC_P2_StoperSrobovania.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			              
			SC_P2_StoperSrobovania.IdleTime.IN:= P2_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			
			IF P2_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				P2_Robot.STAV.Srobovanie_PrebiehaManipulacia:= TRUE;
				P2_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			           
			IF P2_StoperSrobovania.KoniecCyklu THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 0;
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 101;
			END_IF
		
		101:
			SC_P2_StoperSrobovania.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#500ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				i:= 0;
				P2_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
					
			IF P2_StoperSrobovania.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P2_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P2_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 102;
			END_IF	
           
			
		
		
		
		
		102:
			SC_P2_StoperSrobovania.StepName:='102 - Automaticky Rezim - kontrola a priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
		
			IF i<> 0 THEN
				P2_StoperSrobovania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 103;
			ELSE
				P2_Alarmy[214]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF	
			
				
		
			
		103:
			SC_P2_StoperSrobovania.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_5' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_5' THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_5' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_5' THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;  
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			END_IF		
			
		
			
		105:
			SC_P2_StoperSrobovania.StepName:='105 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 120;
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 THEN
				TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 106;
			ELSIF TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaError THEN	
				TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 115;
			END_IF	
			
		106:
			SC_P2_StoperSrobovania.StepName:='106 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 106;	
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 106;
				END_IF   
			END_IF
				
			
			
		108:
			SC_P2_StoperSrobovania.StepName:='108 - Automaticky Rezim - vyziadanie stavu paletky zo servera, zacentrovanie paletky'; 
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#10s;	
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
            
            
			IF NOT SC_P2_StoperSrobovania.Switch1  THEN
				TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				Centrovacku_VYSUN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 110;
			ELSIF TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaError THEN	
				TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 115;
			END_IF	
			
			
			
		
			
			
		110:
			SC_P2_StoperSrobovania.StepName:='110 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaUkoncena AND P2_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				IF TRCB_P2_Srobovanie_ST5.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST5' THEN
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 120;
					END_IF   
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 115;
				END_IF	
			END_IF
		
            
		115:
			SC_P2_StoperSrobovania.StepName:='115 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
            
       
			P2_Vizu.ZobrazHL4_ST5:= TRUE;
            
			IF TRCB_P2_Srobov_OpatovnyDopyt THEN
				TRCB_P2_Srobov_OpatovnyDopyt:= FALSE; 
				P2_Vizu.ZobrazHL4_ST5:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 105;
			ELSIF TRCB_P2_Srobov_PaletkaNG THEN
				TRCB_P2_Srobov_PaletkaNG:= FALSE;
				P2_Vizu.ZobrazHL4_ST5:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 116;
			END_IF   
            
            
            
            
            
		116:
			SC_P2_StoperSrobovania.StepName:='116 - Automaticky Rezim - odcentrovanie paletky po odpovedi servera NG';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			END_IF	    
            
			
		
		120:
			SC_P2_StoperSrobovania.StepName:='118 - Automaticky Rezim - zacentrovanie paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 125;
			END_IF	
		
       
            
            
		125:
			SC_P2_StoperSrobovania.StepName:='125 - Automaticky Rezim - rozhodnutie podla typu modelu';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 138;
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 138;	
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 358; 
			END_IF
            
		            
		
			
			//******************************************Model 45F*************************************************//			
		
		138:
			SC_P2_StoperSrobovania.StepName:='138 - Automaticky Rezim - model 45F presun manipulatora vpred';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 139;
			END_IF	
		
		139:
			SC_P2_StoperSrobovania.StepName:='139 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND NOT P2_Robot.COM_IN.Stav_Busbary4F_Odobrate AND NOT P2_Robot.COM_IN.Stav_Busbary5F_Odobrate THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 140;
			END_IF	
			
				
			
		140:
			SC_P2_StoperSrobovania.StepName:='140 - Automaticky Rezim - modwel 45F odober vrchne busbary';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P2_StoperSrobovania.Switch1 AND NOT P2_Robot.STAV.Zvaranie_PrebiehaManipulacia THEN
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P2_Robot.COM_OUT.Odober_Busbary4F:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P2_Robot.COM_OUT.Odober_Busbary5F:= TRUE;
				END_IF	
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF    
            
			
			IF (P2_Robot.COM_IN.Stav_Busbary4F_Odobrate OR P2_Robot.COM_IN.Stav_Busbary5F_Odobrate) AND NOT P2_Robot.COM_IN.Stav_Busbary4F_Polozene AND NOT P2_Robot.COM_IN.Stav_Busbary5F_Polozene THEN
				P2_Robot.COM_OUT.Odober_Busbary4F:= FALSE;
				P2_Robot.COM_OUT.Odober_Busbary5F:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 143;
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Alarmy[271]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;     
			END_IF
			
			
		143:
			SC_P2_StoperSrobovania.StepName:='143 - Automaticky Rezim - modwel 45F poloz vrchne busbary';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P2_Robot.COM_OUT.Poloz_Busbary4F:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P2_Robot.COM_OUT.Poloz_Busbary5F:= TRUE;
				END_IF	
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF (P2_Robot.COM_IN.Stav_Busbary4F_Polozene OR P2_Robot.COM_IN.Stav_Busbary5F_Polozene) THEN
				P2_Robot.COM_OUT.Poloz_Busbary4F:= FALSE;
				P2_Robot.COM_OUT.Poloz_Busbary5F:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 145;
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Alarmy[271]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;         
			END_IF
			
			
		145:
			SC_P2_StoperSrobovania.StepName:='145 - Automaticky Rezim - modwel 45F zaskrutkuj lavu skrutku M6';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
						
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM6:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM6:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 146;
			END_IF	
		
		
		146:
			SC_P2_StoperSrobovania.StepName:='146 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P2_SkrutkovanieResult_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 150;
				ELSE	
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 148;
				END_IF	
			END_IF	
		
		
		148:
			SC_P2_StoperSrobovania.StepName:='148 - Automaticky Rezim - modwel 4F kontrola vysledku zaskrutkovania lavej skrutky M6';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_LavaSkrutkaM6:= REAL_TO_STRING(P2_Srobovanie.STAV.M6_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_LavaSkrutkaM6:= REAL_TO_STRING(P2_Srobovanie.STAV.M6_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P2_LavaSkrutkaM6:= REAL_TO_STRING(P2_Srobovanie.STAV.M6_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_LavaSkrutkaM6:= UDINT_TO_STRING(P2_Srobovanie.STAV.M6_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_LavaSkrutkaM6:= UDINT_TO_STRING(P2_Srobovanie.STAV.M6_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_LavaSkrutkaM6:= UDINT_TO_STRING(P2_Srobovanie.STAV.M6_DosiahnutyUhol);
            
            
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Skrutk_45F_LavaM6_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM6);
				IF (P2_Skrutk_45F_LavaM6_Vysunutie <= P2_RemPremenne.P2_Srob45F_LavaM6_Vysunutie_HI) AND (P2_Skrutk_45F_LavaM6_Vysunutie >= P2_RemPremenne.P2_Srob45F_LavaM6_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF  
            
            
			IF P2_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM6:= 'PASS';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 150;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM6:= 'FAIL';
					IF P2_Srobov_M6_Result_OFF THEN
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 150;
					ELSE 	
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 500;
					END_IF    
				END_IF 
			ELSIF P2_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN    
				Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM6:= 'FAIL';
				IF P2_Srobov_M6_Result_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 150;
				ELSE 	
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 500;
				END_IF    
			END_IF
		
		
		150:
			SC_P2_StoperSrobovania.StepName:='150 - Automaticky Rezim - modwel 45F zaskrutkuj pravu skrutku M6';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
				
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM6:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM6:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 151;
			END_IF		
					
		151:
			SC_P2_StoperSrobovania.StepName:='151 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P2_SkrutkovanieResult_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 155;
				ELSE	
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 153;
				END_IF	
			END_IF	
						
			
		153:
			SC_P2_StoperSrobovania.StepName:='151 - Automaticky Rezim - modwel 45F kontrola vysledku zaskrutkovania pravej skrutky M6';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                        
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_PravaSkrutkaM6:= REAL_TO_STRING(P2_Srobovanie.STAV.M6_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_PravaSkrutkaM6:= REAL_TO_STRING(P2_Srobovanie.STAV.M6_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P2_PravaSkrutkaM6:= REAL_TO_STRING(P2_Srobovanie.STAV.M6_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_PravaSkrutkaM6:= UDINT_TO_STRING(P2_Srobovanie.STAV.M6_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_PravaSkrutkaM6:= UDINT_TO_STRING(P2_Srobovanie.STAV.M6_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_PravaSkrutkaM6:= UDINT_TO_STRING(P2_Srobovanie.STAV.M6_DosiahnutyUhol);
            
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Skrutk_45F_PravaM6_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM6);
				IF (P2_Skrutk_45F_PravaM6_Vysunutie <= P2_RemPremenne.P2_Srob45F_PravaM6_Vysunutie_HI) AND (P2_Skrutk_45F_PravaM6_Vysunutie >= P2_RemPremenne.P2_Srob45F_PravaM6_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
            
			IF P2_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM6:= 'PASS';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 155;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM6:= 'FAIL';
					IF P2_Srobov_M6_Result_OFF THEN
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 155;
					ELSE 
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 500;
					END_IF    
				END_IF 
			ELSIF P2_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM6:= 'FAIL';
				IF P2_Srobov_M6_Result_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 155;
				ELSE 
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 500;
				END_IF    
			END_IF	
		
		155:
			SC_P2_StoperSrobovania.StepName:='155 - Automaticky Rezim - modwel 45F presun manipulatora vpred';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 156;
			END_IF	
		
			
		156:
			SC_P2_StoperSrobovania.StepName:='156 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND NOT P2_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 158;
			END_IF	
			
			
			
					
		158:
			SC_P2_StoperSrobovania.StepName:='158 - Automaticky Rezim - model 45F vystavenie signalu pre robota chod do cakacej pozicie';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Robot.COM_OUT.Presun_CakaciaPozicia:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P2_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				P2_Robot.STAV.Srobovanie_PrebiehaManipulacia:= FALSE;
				P2_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 160;
			END_IF
			
		
		160:
			SC_P2_StoperSrobovania.StepName:='160 - Automaticky Rezim - modwel 45F zaskrutkuj lavu skrutku M4';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
						
			IF NOT SC_P2_StoperSrobovania.Switch1 AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM4:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM4:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 161;
			END_IF
			
		161:
			SC_P2_StoperSrobovania.StepName:='161 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P2_SkrutkovanieResult_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 165;
				ELSE	
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 163;
				END_IF	
			END_IF		
			
			
			
		163:
			SC_P2_StoperSrobovania.StepName:='163 - Automaticky Rezim - modwel 45F kontrola vysledku zaskrutkovania lavej skrutky M4';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_LavaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_LavaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P2_LavaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_LavaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_LavaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_LavaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_DosiahnutyUhol);
            
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Skrutk_45F_LavaM4_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM4);
				IF (P2_Skrutk_45F_LavaM4_Vysunutie <= P2_RemPremenne.P2_Srob45F_LavaM4_Vysunutie_HI) AND (P2_Skrutk_45F_LavaM4_Vysunutie >= P2_RemPremenne.P2_Srob45F_LavaM4_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF         
            
            
            
			IF P2_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM4:= 'PASS';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 165;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM4:= 'FAIL';
					IF P2_Srobov_M4_Result_OFF THEN
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 165;
					ELSE 
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 500;
					END_IF    
				END_IF 
			ELSIF P2_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM4:= 'FAIL';
				IF P2_Srobov_M4_Result_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 165;
				ELSE 
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 500;
				END_IF    
			END_IF
			
			
		165:
			SC_P2_StoperSrobovania.StepName:='165 - Automaticky Rezim - modwel 45F zaskrutkuj pravu skrutku M4';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
						
			IF NOT SC_P2_StoperSrobovania.Switch1 AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM4:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM4:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 166;
			END_IF	

			
			
		166:
			SC_P2_StoperSrobovania.StepName:='166 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P2_SkrutkovanieResult_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 170;
				ELSE	
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 168;
				END_IF	
			END_IF			
			
			
			
		168:
			SC_P2_StoperSrobovania.StepName:='168 - Automaticky Rezim - modwel 4F kontrola vysledku zaskrutkovania pravej skrutky M4';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_PravaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_PravaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P2_PravaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_PravaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_PravaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_PravaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_DosiahnutyUhol);
            
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Skrutk_45F_PravaM4_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM4);
				IF (P2_Skrutk_45F_PravaM4_Vysunutie <= P2_RemPremenne.P2_Srob45F_PravaM4_Vysunutie_HI) AND (P2_Skrutk_45F_PravaM4_Vysunutie >= P2_RemPremenne.P2_Srob45F_PravaM4_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF  
            
           
            
            
            
			IF P2_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM4:= 'PASS';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 170;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM4:= 'FAIL';
					IF P2_Srobov_M4_Result_OFF THEN
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 170;
					ELSE  
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 500;
					END_IF
				END_IF 
			ELSIF P2_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM4:= 'FAIL';
				IF P2_Srobov_M4_Result_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 170;
				ELSE  
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 500;
				END_IF
			END_IF
		
			
			
		170:
			SC_P2_StoperSrobovania.StepName:='170 - Automaticky Rezim - modwel 45F presun manipulatora vzad';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 171;
			END_IF	
		
		
		171:	
			SC_P2_StoperSrobovania.StepName:='171 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				CAM10.STAV.Results_READY:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 173;
			END_IF		
		
		
		173:
			SC_P2_StoperSrobovania.StepName:='173 - Automaticky Rezim - modwel 45F kamerova kontrola paletky CAM10';//CAM 10//
			SC_P2_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.P2_Kamery_OFF THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 540;
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 AND CAM10.STAV.Command_READY THEN
				CAM10.CMD.Triger:= TRUE;
				SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF CAM10.STAV.Results_READY AND CAM10.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM10.STAV.Results_READY:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 175;
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM10.STAV.Results_READY:= FALSE;
				CAM10.CMD.Triger:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 174;    
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[295]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;    
			END_IF	
		
            
                  
            
            
            
		174:
			SC_P2_StoperSrobovania.StepName:='174 - Automaticky Rezim - modwel 45F cakam na opatovny triger kamery CAM10';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P2_StoperSrobovania.IdleTime.Q THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 173;
			END_IF	
            
		175:
			SC_P2_StoperSrobovania.StepName:='175 - Automaticky Rezim - model 45F kontrola vysledku kamery';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF NOT CAM10.STAV.BUSY THEN
				CAM10.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF NOT CAM10.RESULT.Paletka.Pritomn_Busbarov_4F	THEN
						CAM10.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 180;
					ELSE
						CAM10.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 180;
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF NOT CAM10.RESULT.Paletka.Pritomn_Busbarov_5F	THEN
						CAM10.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 180;
					ELSE
						CAM10.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 180;
					END_IF	
				END_IF
			END_IF
			
				
	
	
		180:
			SC_P2_StoperSrobovania.StepName:='135 - Automaticky Rezim - model 45F rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
							
			IF CAM10.PAR.ResultFotky = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 540;
			ELSIF CAM10.PAR.ResultFotky = 'FAIL' THEN
				P2_Vizu.ZobrazHL1_ST5:= TRUE;
				IF P2_Srobov_KAM_Result_OK THEN
					P2_Srobov_KAM_Result_OK:= FALSE;
					P2_Vizu.ZobrazHL1_ST5:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					CAM10.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 540;
				ELSIF P2_Srobov_KAM_Result_NG THEN
					P2_Srobov_KAM_Result_NG:= FALSE;    
					P2_Vizu.ZobrazHL1_ST5:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 540;
				END_IF
			END_IF				
					
					
	
			
			//********************************************Model 5H**************************************************************//	
		
		358:
			SC_P2_StoperSrobovania.StepName:='358 - Automaticky Rezim - model 5H presun manipulatora vpred a odobratie vrchnych busbarov';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
            
            
			IF P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie AND NOT P2_Robot.COM_IN.Stav_Busbary5H_Odobrate AND NOT P2_Robot.STAV.Zvaranie_PrebiehaManipulacia AND SC_P2_Srobovanie.Step = 100  THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= TRUE;
				P2_Robot.COM_OUT.Odober_Busbary5H:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 360;
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Alarmy[271]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;     
			END_IF
		
			
		
				
		360:
			SC_P2_StoperSrobovania.StepName:='360 - Automaticky Rezim - modwel 5H cakam na polozenie vrchnych busbarov';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND P2_Robot.COM_IN.Stav_Busbary5H_Odobrate THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
				P2_Robot.COM_OUT.Odober_Busbary5H:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 361;
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Alarmy[271]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;   
			END_IF
        
			
		361:
			SC_P2_StoperSrobovania.StepName:='361 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND NOT P2_Robot.COM_IN.Stav_Busbary5H_Polozene THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 363;
			END_IF		
			
			
                 
			
		363:
			SC_P2_StoperSrobovania.StepName:='363 - Automaticky Rezim - modwel 5H poloz vrchne busbary';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P2_StoperSrobovania.Switch1 AND NOT P2_Robot.COM_IN.Stav_Busbary5H_Odobrate THEN
				P2_Robot.COM_OUT.Poloz_Busbary5H:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P2_Robot.COM_IN.Stav_Busbary5H_Polozene THEN
				P2_Robot.COM_OUT.Poloz_Busbary5H:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 365;
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Alarmy[271]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;   
			END_IF
		
			
			
		365:
			SC_P2_StoperSrobovania.StepName:='365 - Automaticky Rezim - modwel 5H zaskrutkuj skrutku M4';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
						
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P2_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednuM4:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene  THEN
				P2_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednuM4:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 366;
			END_IF	
	
			
		366:
			SC_P2_StoperSrobovania.StepName:='366 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene AND NOT P2_Robot.COM_IN.Stav_Filter5H_Dotlaceny THEN
				IF Linka.P2_SkrutkovanieResult_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 370;
				ELSE	
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 368;
				END_IF	
			END_IF		
			
					
			
		368:
			SC_P2_StoperSrobovania.StepName:='368 - Automaticky Rezim - modwel 5H kontrola vysledku zaskrutkovania skrutky M4';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                       
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_StrednaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_StrednaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P2_StrednaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.STAV.M4_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_StrednaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_StrednaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_StrednaSkrutkaM4:= UDINT_TO_STRING(P2_Srobovanie.STAV.M4_DosiahnutyUhol);
            
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Skrutk_5H_StrednaM4_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P2_StrednaSkrutkaM4);
				IF (P2_Skrutk_5H_StrednaM4_Vysunutie <= P2_RemPremenne.P2_Srob5H_StrednaM4_Vysunutie_HI) AND (P2_Skrutk_5H_StrednaM4_Vysunutie >= P2_RemPremenne.P2_Srob5H_StrednaM4_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF        
            
            
			IF P2_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P2_StrednaSkrutkaM4:= 'PASS';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 370;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P2_StrednaSkrutkaM4:= 'FAIL';
					IF P2_Srobov_M4_Result_OFF THEN
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 370;
					ELSE
						DoskrutkovaniePriPoruche:= TRUE;
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 370;//500
					END_IF
				END_IF	
			ELSIF P2_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P2_StrednaSkrutkaM4:= 'FAIL';
				IF P2_Srobov_M4_Result_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 370;
				ELSE
					DoskrutkovaniePriPoruche:= TRUE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 370;//500
				END_IF
			END_IF	
		
		370:
			SC_P2_StoperSrobovania.StepName:='370 - Automaticky Rezim - modwel 5H dotlac filter';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Robot.COM_OUT.Dotlac_Filter5H:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P2_Robot.COM_IN.Stav_Filter5H_Dotlaceny THEN
				P2_Robot.COM_OUT.Dotlac_Filter5H:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 375;
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Alarmy[271]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF
			
			
		375:
			SC_P2_StoperSrobovania.StepName:='375 - Automaticky Rezim - modwel 5H zaskrutkuj lavu skrutku M5';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
						
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P2_Srobovanie.COM_IN.Model5H_ZaskrutkujLavuM5:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P2_Srobovanie.COM_IN.Model5H_ZaskrutkujLavuM5:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 376;
			END_IF	
		
		376:
			SC_P2_StoperSrobovania.StepName:='376 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P2_SkrutkovanieResult_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 380;
				ELSE	
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 378;
				END_IF	
			END_IF	
		
		
		378:
			SC_P2_StoperSrobovania.StepName:='378 - Automaticky Rezim - modwel 5H kontrola vysledku zaskrutkovania lavej skrutky M5';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                  
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_LavaSkrutkaM5:= REAL_TO_STRING(P2_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_LavaSkrutkaM5:= REAL_TO_STRING(P2_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P2_LavaSkrutkaM5:= REAL_TO_STRING(P2_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_LavaSkrutkaM5:= UDINT_TO_STRING(P2_Srobovanie.STAV.M5_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_LavaSkrutkaM5:= UDINT_TO_STRING(P2_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_LavaSkrutkaM5:= UDINT_TO_STRING(P2_Srobovanie.STAV.M5_DosiahnutyUhol);
            
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Skrutk_5H_LavaM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM5);
				IF (P2_Skrutk_5H_LavaM5_Vysunutie <= P2_RemPremenne.P2_Srob5H_LavaM5_Vysunutie_HI) AND (P2_Skrutk_5H_LavaM5_Vysunutie >= P2_RemPremenne.P2_Srob5H_LavaM5_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF         
            
            
			IF P2_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					IF NOT DoskrutkovaniePriPoruche THEN
						Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM5:= 'PASS';
					ELSE
						Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM5:= 'FAIL';
					END_IF    
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 380;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM5:= 'FAIL';
					IF P2_Srobov_M5_Result_OFF THEN
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 380;
					ELSE
						DoskrutkovaniePriPoruche:= TRUE;
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 380;//500
					END_IF
				END_IF
			ELSIF P2_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN   
				Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM5:= 'FAIL';
				IF P2_Srobov_M5_Result_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 380;
				ELSE
					DoskrutkovaniePriPoruche:= TRUE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 380;//500
				END_IF
			END_IF
		
		
		380:
			SC_P2_StoperSrobovania.StepName:='380 - Automaticky Rezim - modwel 5H zaskrutkuj pravu skrutku M5';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
						
			IF NOT SC_P2_StoperSrobovania.Switch1  THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P2_Srobovanie.COM_IN.Model5H_ZaskrutkujPravuM5:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P2_Srobovanie.COM_IN.Model5H_ZaskrutkujPravuM5:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 381;
			END_IF
		
		
		381:
			SC_P2_StoperSrobovania.StepName:='381 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P2_SkrutkovanieResult_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 385;
				ELSE	
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 383;
				END_IF	
			END_IF	
		
		
		383:
			SC_P2_StoperSrobovania.StepName:='383 - Automaticky Rezim - modwel 5H kontrola vysledku zaskrutkovania pravej skrutky M5';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                       
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_PravaSkrutkaM5:= REAL_TO_STRING(P2_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_PravaSkrutkaM5:= REAL_TO_STRING(P2_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P2_PravaSkrutkaM5:= REAL_TO_STRING(P2_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_PravaSkrutkaM5:= UDINT_TO_STRING(P2_Srobovanie.STAV.M5_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_PravaSkrutkaM5:= UDINT_TO_STRING(P2_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_PravaSkrutkaM5:= UDINT_TO_STRING(P2_Srobovanie.STAV.M5_DosiahnutyUhol);
            
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Skrutk_5H_PravaM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM5);
				IF (P2_Skrutk_5H_PravaM5_Vysunutie <= P2_RemPremenne.P2_Srob5H_PravaM5_Vysunutie_HI) AND (P2_Skrutk_5H_PravaM5_Vysunutie >= P2_RemPremenne.P2_Srob5H_PravaM5_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
			IF P2_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					IF NOT DoskrutkovaniePriPoruche THEN
						Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM5:= 'PASS';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 385;
					ELSE
						Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM5:= 'FAIL';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 500;
					END_IF    
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM5:= 'FAIL';
					IF P2_Srobov_M5_Result_OFF THEN
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 385;
					ELSE
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperSrobovania.ResetStep:= TRUE;
						SC_P2_StoperSrobovania.Step:= 500;
					END_IF
				END_IF
			ELSIF P2_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM5:= 'FAIL';
				IF P2_Srobov_M5_Result_OFF THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 385;
				ELSE
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 500;
				END_IF
			END_IF
		
		
		385:
			SC_P2_StoperSrobovania.StepName:='385 - Automaticky Rezim - modwel 5H presun manipulatora vpred, vystavenie signalu pre robota chod do cakacej pozicie ';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
            
			IF NOT P2_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= TRUE;
				P2_Robot.COM_OUT.Presun_CakaciaPozicia:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 388;
			END_IF
			
            
		
					
		388:
			SC_P2_StoperSrobovania.StepName:='388 - Automaticky Rezim - model 5H cakam na presunutie robota do cakacej pozicie';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			       
					
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND P2_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				P2_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
				P2_Robot.STAV.Srobovanie_PrebiehaManipulacia:= FALSE;
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 389;
			END_IF	
		
		
		389:
			SC_P2_StoperSrobovania.StepName:='389 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 390;
			END_IF	
		
		
		390:
			SC_P2_StoperSrobovania.StepName:='390 - Automaticky Rezim - modwel 5H presun manipulatora vzad';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie AND SC_P2_Srobovanie.Step = 100 THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 393;
			END_IF	
		
		
		391:
			SC_P2_StoperSrobovania.StepName:='391 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				CAM10.STAV.Results_READY:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 393;
			END_IF	
		
		
		393:
			SC_P2_StoperSrobovania.StepName:='393 - Automaticky Rezim - modwel 5H kamerova kontrola paletky CAM10';//CAM 10//
			SC_P2_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.P2_Kamery_OFF THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 540;
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 AND CAM10.STAV.Command_READY THEN
				CAM10.CMD.Triger:= TRUE;
				SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF CAM10.STAV.Results_READY AND CAM10.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM10.STAV.Results_READY:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 395;
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM10.STAV.Results_READY:= FALSE;
				CAM10.CMD.Triger:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 394;
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[295]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;         
			END_IF	
		
            
                     
            
            
            
		394:
			SC_P2_StoperSrobovania.StepName:='394 - Automaticky Rezim - modwel 5H cakam na opatovny triger kamery CAM10';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P2_StoperSrobovania.IdleTime.Q THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 393;
			END_IF	
            
            
		395:
			SC_P2_StoperSrobovania.StepName:='395 - Automaticky Rezim - model 5H kontrola vysledku kamery';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF NOT CAM10.STAV.BUSY  THEN
				CAM10.CMD.Triger:= FALSE;
				IF NOT CAM10.RESULT.Paletka.Pritomn_Busbarov_5H THEN
					CAM10.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 400;
				ELSE
					CAM10.PAR.ResultFotky:= 'FAIL';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 400;
				END_IF
			END_IF
			
				
					
        	
	
		400:
			SC_P2_StoperSrobovania.StepName:='400 - Automaticky Rezim - model 5H rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF CAM10.PAR.ResultFotky = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 540;
			ELSIF CAM10.PAR.ResultFotky = 'FAIL' THEN
				P2_Vizu.ZobrazHL3_ST5:= TRUE;
				IF P2_Srobov_KAM_Result_OK THEN
					P2_Srobov_KAM_Result_OK:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					CAM10.PAR.ResultFotky:= 'PASS';
					P2_Vizu.ZobrazHL3_ST5:= FALSE;
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 540;
				ELSIF P2_Srobov_KAM_Result_NG THEN
					P2_Srobov_KAM_Result_NG:= FALSE;    
					P2_Vizu.ZobrazHL3_ST5:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 540;    
				END_IF
			END_IF	
			
		         
            
            
            
            
			
		
	
			
			//****************************************Uvolnenie robota a vyfotenie paletky po zlom skrutkovaní************************************************//
		
		500:
			SC_P2_StoperSrobovania.StepName:='500 - Automaticky Rezim - presun manipulatora vpred';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
						
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 501;
			END_IF
		
		
		501:
			SC_P2_StoperSrobovania.StepName:='501 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 503;
			END_IF	
		
		
		503:
			SC_P2_StoperSrobovania.StepName:='503 - Automaticky Rezim - vystavenie signalu pre robota chod do cakacej pozicie';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Robot.COM_OUT.Presun_CakaciaPozicia:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P2_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 505;
			END_IF
			
		
		505:
			SC_P2_StoperSrobovania.StepName:='505 - Automaticky Rezim - presun manipulatora vzad';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P2_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 506;
			END_IF
		
		506:
			SC_P2_StoperSrobovania.StepName:='506 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				CAM10.STAV.Results_READY:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 508;
			END_IF	
			
		508:
			SC_P2_StoperSrobovania.StepName:='508 - Automaticky Rezim - kamerova kontrola paletky CAM10';//CAM 10//
			SC_P2_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF Linka.P2_Kamery_OFF THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 540;
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 AND CAM10.STAV.Command_READY THEN
				CAM10.CMD.Triger:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
						
			IF CAM10.STAV.Results_READY AND CAM10.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM10.STAV.Results_READY:= FALSE;
				CAM10.PAR.ResultFotky:= 'FAIL';
				CAM10.CMD.Triger:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 540;
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM10.STAV.Results_READY:= FALSE;
				CAM10.CMD.Triger:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 510;
			ELSIF SC_P2_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[295]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;   
			END_IF    
           
	      
			
		
		510:
			SC_P2_StoperSrobovania.StepName:='510 - Automaticky Rezim - cakam na opatovny triger kamery CAM10';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P2_StoperSrobovania.IdleTime.Q THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 508;
			END_IF	   
            
            
            
            
			
			
			//*************************************Odoslanie fotiek na server*********************************//	
		540:
			SC_P2_StoperSrobovania.StepName:='540 - Automaticky Rezim - odoslanie fotiek na server';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 545;
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 THEN
				FTP_CAM10.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM10.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM10.INPUTS.Result:= CAM6.PAR.ResultFotky;
				Reports.Kamery.P2_CAM10_KontrolaPaletky:= CAM10.PAR.ResultFotky;
				FTP_CAM10.CMD.OdosliFotku:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
            	
			
			IF FTP_CAM10.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM10.CMD.OdosliFotku:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 545;
			ELSIF FTP_CAM10.STATUS.KomunikaciaError THEN
				P2_Alarmy[232]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF	
		
			
       		
			
			//************************Odcentrovanie paletky***********************************//	
		
		545:
			SC_P2_StoperSrobovania.StepName:='545 - Automaticky Rezim - odcentrovanie paletky';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 550;
			END_IF	
		
				
			//**********************Odoslanie dát na server************************************//		
		
		550:
			SC_P2_StoperSrobovania.StepName:='550 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 560;
			ELSIF NOT SC_P2_StoperSrobovania.Switch1 THEN
				TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Srobovanie_ST5.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 552;
			ELSIF TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaError THEN	
				P2_Alarmy[233]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF
		
			
		552:
			SC_P2_StoperSrobovania.StepName:='552 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 552;	
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 552;
				END_IF   
			END_IF
		
		
		555:
			SC_P2_StoperSrobovania.StepName:='555 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#10s;
			
			
			IF NOT SC_P2_StoperSrobovania.Switch1 THEN
				TRCB_P2_Srobovanie_ST5.CMD.OdosliStavPaletky_TYP2:= TRUE;
				SC_P2_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			
			IF TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Srobovanie_ST5.CMD.OdosliStavPaletky_TYP2:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 556;
			ELSIF TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaError THEN
				P2_Alarmy[233]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF
			
			
		
		556:
			SC_P2_StoperSrobovania.StepName:='553 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#10s;
			
			IF NOT TRCB_P2_Srobovanie_ST5.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Srobovanie_ST5.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 560;
				ELSIF TRCB_P2_Srobovanie_ST5.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperSrobovania.ResetStep:= TRUE;
					SC_P2_StoperSrobovania.Step:= 560;
				END_IF	
			END_IF
			
		
			//***************************Vyvezenie paletky**********************************************//	
		
		560:
			SC_P2_StoperSrobovania.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na stoper zvarania';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			P2_Robot.STAV.Srobovanie_PrebiehaManipulacia:= FALSE;
            
                        
			IF P2_StoperSrobovania.KoniecCyklu THEN
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 0;
			ELSIF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 0;
			ELSIF ((NOT P2_StoperZvarania.RFID_hlava.PritomnostPaletky AND SC_P2_StoperZvarania.Step = 100) OR (P2_StoperZvarania.OUT.ZasunStoper AND SC_P2_StoperZvarania.Step = 561)) AND NOT P2_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky THEN
				P2_StoperSrobovania.OUT.ZasunStoper:= TRUE;
				P2_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 561;
			END_IF	
		
		
		561:
			SC_P2_StoperSrobovania.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na stoper zvarania';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#1300ms;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#10s;
		
			SC_P2_StoperSrobovania.AlarmTime.IN:= P2_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			SC_P2_StoperSrobovania.IdleTime.IN:= NOT P2_StoperSrobovania.RFID_hlava.PritomnostPaletky;
            
			IF NOT P2_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				DoskrutkovaniePriPoruche:= FALSE;
				CisloFotky:= 0;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM6:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM6:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyslednyReport.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyslednyReport.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_StrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_StrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P2_StrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyslednyReport.P2_StrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_StrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_StrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_StrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P2_StrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_StrednaSkrutkaM4:= '';
				Reports.Kamery.P2_CAM10_KontrolaPaletky:= '';
				P2_StoperSrobovania.OUT.ZasunStoper:= FALSE;
				SC_P2_StoperSrobovania.ResetStep:= TRUE;
				SC_P2_StoperSrobovania.Step:= 100;
			ELSIF SC_P2_StoperSrobovania.AlarmTime.Q THEN
				P2_Alarmy[288]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;	
			END_IF
            
			
	
            
                     
            
			
			
			//*******************************************************Manuálny režim*******************************************************************************//	
			
		700:
			SC_P2_StoperSrobovania.StepName:='700 - Manualny Rezim';
			SC_P2_StoperSrobovania.IdleTime.PT:= T#8s;
			SC_P2_StoperSrobovania.AlarmTime.PT:= T#5s;
		
		
		
		
		
		
		
		
		
		
	END_CASE		
			
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

