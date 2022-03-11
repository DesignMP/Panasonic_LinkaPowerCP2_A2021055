
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
		
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_StoperSrobovania);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	IOLinkKomunikacia;
	
	
	//Reset sekcie //
	IF P3_StoperSrobovania.Reset THEN
		SC_P3_StoperSrobovania.Step:= 0;
		P3_StoperSrobovania.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_StoperSrobovania.Step:= 0;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		SC_P3_StoperSrobovania.Step:= 0;	
	END_IF	
	
	
	CASE SC_P3_StoperSrobovania.Step OF 
	
		0:
			SC_P3_StoperSrobovania.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			P3_StoperSrobovania.Automat:= FALSE;
			P3_StoperSrobovania.KoniecCyklu:= FALSE;
			P3_StoperSrobovania.Manual:= FALSE;
			P3_StoperSrobovania.STAV.PoINIT:= FALSE;
			P3_StoperSrobovania.OUT.ZasunStoper:= FALSE;
			P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
		
			P3_Srobovanie.COM_IN.Model5H_ZaskrutkujSkrutky:= FALSE;
			P3_Srobovanie.COM_IN.Model45F_ZaskrutkujSkrutky:= FALSE;
			P3_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
			P3_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
			P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
			P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
			
			CAM13.CMD.Triger:= FALSE;
			CAM13.STAV.Results_READY:= FALSE;
			FTP_CAM13.CMD.OdosliFotku:= FALSE;
			FTP_CAM13.CMD.VymazFotku:= FALSE;
		
			TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P3_Srobovanie_ST7.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P3_Srobovanie_ST7.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
		
			P3_Srobov_KAM_Result_OK:= FALSE;
			P3_Srobov_KAM_Result_NG:= FALSE;
			P3_Srobov_KAM_Result_Ignoruj:= FALSE;
			P3_Srobov_K40_Result_OFF:= FALSE;
			P3_Srobov_M5_Result_OFF:= FALSE;
			P34_Vizu.ZobrazHL1_ST7:= FALSE;
			TRCB_P3_Srobov_OpatovnyDopyt:= FALSE;
			TRCB_P3_Srobov_PaletkaNG:= FALSE;
			VysunutieSkrutkovacky_OK:= FALSE;
			P3_StoperSrobovania.PAR.IndexFotky:= 0;
			PocetTrigrovKamery:= 0;
			PocetDopytovNaServer:= 0;
			CisloFotky:= 0;
			TestovaciKus:= FALSE;
			P3_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_StoperZvarania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			SkrutkaM5_Zahodena:= FALSE;
		
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P3_ZonaBunky_AKTIVNA AND
				P3_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P3_Pracovisko.STAV.Porucha_ST1 AND
				NOT P3_Pracovisko.STAV.Porucha_ST2 AND
				NOT P3_Pracovisko.STAV.Porucha_ST3 AND
				NOT P3_Pracovisko.STAV.Porucha_ST4 AND
				NOT P3_Pracovisko.STAV.Porucha_ST5 AND
				NOT P3_Pracovisko.STAV.Porucha_ST6 AND
				NOT P3_Pracovisko.STAV.Porucha_ST7 AND
				NOT P3_Pracovisko.STAV.Porucha_ST8 THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 1;
			END_IF
	
		1:
			SC_P3_StoperSrobovania.StepName:='1 - Cakam na spustenie vyroby';
			P3_StoperSrobovania.KoniecCyklu:= FALSE;
			IF P3_StoperSrobovania.Automat THEN
				SC_P3_StoperSrobovania.Step:= 2;
			ELSIF P3_StoperSrobovania.Manual THEN
				SC_P3_StoperSrobovania.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P3_StoperSrobovania.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			
									
			IF P3_Srobovanie.STAV.PoINIT AND P3_Dopravniky.STAV.PoINIT AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 3;
			END_IF	
		
		
		3:
			SC_P3_StoperSrobovania.StepName:='3 - Inicializacia - vymazanie adresara kamery';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 5;
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 THEN
				FTP_CAM13.CMD.VymazFotku:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
				
			IF FTP_CAM13.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM13.CMD.VymazFotku:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 5;
			ELSIF FTP_CAM13.STATUS.KomunikaciaError THEN
				P34_Alarmy[320]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
		
		
		5:
			SC_P3_StoperSrobovania.StepName:='5 - Inicializacia - zasunutie centrovacky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P3_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 13;
			END_IF		
		
		
		13:
			SC_P3_StoperSrobovania.StepName:='13 - Inicializacia - hladanie paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
	
			IF P3_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 20;		
			ELSIF SC_P3_StoperSrobovania.IdleTime.Q THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 100;
			END_IF
		
		
		20:
			SC_P3_StoperSrobovania.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
		
			SC_P3_StoperSrobovania.IdleTime.IN:= P3_StoperSrobovania.RFID_hlava.PritomnostPaletky;
									
			IF SC_P3_StoperSrobovania.IdleTime.Q THEN
				P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
			END_IF
			
			IF P3_StoperSrobovania.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P3_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 23;
			END_IF	
			
		23:
			SC_P3_StoperSrobovania.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P3_StoperSrobovania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 30;
			ELSE
				P34_Alarmy[321]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
		30:
			SC_P3_StoperSrobovania.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' THEN  
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_7' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_7' THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			END_IF	
            
                      
            
            
		33:
			SC_P3_StoperSrobovania.StepName:='33 - Inicializacia - kontrola uzavretia komunikacie s Panatrace'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSE
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 38;
			END_IF	
					
		
			
		38:
			SC_P3_StoperSrobovania.StepName:='38 - Inicializacia - kontrola odoslania fotiek';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;   
            
			IF Paletka[i].STAV.OdoslanieFotiek_DONE THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 550;
			ELSE
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 40;
			END_IF
            
            
		40:
			SC_P3_StoperSrobovania.StepName:='40 - Inicializacia - zacentrovanie paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P3_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 43;
			END_IF	   
            
		
		43:
			SC_P3_StoperSrobovania.StepName:='43 - Inicializacia - presun manipulatora vzad';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P3_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				CAM13.STAV.Results_READY:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 48;
			END_IF   
		
		
		48:
			SC_P3_StoperSrobovania.StepName:='48 - Inicializacia - kamerova kontrola paletky CAM13'; //CAM 13//
			SC_P3_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;   
            
			IF Linka.P3_Kamery_OFF THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 130;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 130;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 350;  
				END_IF   
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 AND CAM13.STAV.Command_READY THEN
				CAM13.CMD.Triger:= TRUE;
				SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF CAM13.STAV.Results_READY AND CAM13.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM13.STAV.Results_READY:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 53;
			ELSIF SC_P3_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM13.STAV.Results_READY:= FALSE;
				CAM13.CMD.Triger:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 50;
			ELSIF SC_P3_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P34_Alarmy[359]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
                       
            
            
            
		50:
			SC_P3_StoperSrobovania.StepName:='50 - Inicializacia - cakam na opatovny triger kamery CAM13';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P3_StoperSrobovania.IdleTime.Q THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 48;
			END_IF	
			
			
			   
		53:
			SC_P3_StoperSrobovania.StepName:='53 - Inicializacia - kontrola vysledku kamery podla typu modelu';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			
			IF NOT CAM13.STAV.BUSY THEN
				CAM13.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF NOT CAM13.RESULT.Pritomn_SkrutkyK40_TopCover_4F5F AND
						NOT CAM13.RESULT.Pritomn_SkrutkyM5_TopCover THEN
						CAM13.PAR.ResultFotky:= 'PASS';
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 55;
					ELSE
						CAM13.PAR.ResultFotky:= 'FAIL';
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 55;
					END_IF 
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF NOT CAM13.RESULT.Pritomn_SkrutkyK40_TopCover_4F5F AND
						NOT CAM13.RESULT.Pritomn_SkrutkyM5_TopCover THEN
						CAM13.PAR.ResultFotky:= 'PASS';
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 55;
					ELSE
						CAM13.PAR.ResultFotky:= 'FAIL';
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 55;
					END_IF	
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					IF NOT CAM13.RESULT.Pritomn_SkrutkyM5_TopCover THEN
						CAM13.PAR.ResultFotky:= 'PASS';
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 55;
					ELSE
						CAM13.PAR.ResultFotky:= 'FAIL';
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 55;
					END_IF	
				END_IF
			END_IF   
            
		55:
			SC_P3_StoperSrobovania.StepName:='55 - Inicializacia - vymazanie adresara kamery';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 58;
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 THEN
				FTP_CAM13.CMD.VymazFotku:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
				
			IF FTP_CAM13.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM13.CMD.VymazFotku:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 58;
			ELSIF FTP_CAM13.STATUS.KomunikaciaError THEN
				P34_Alarmy[320]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
            
		
		58:
			SC_P3_StoperSrobovania.StepName:='58 - Inicializacia - rozhodnutie podla kamerovej kontroly paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
            	
				
			IF CAM13.PAR.ResultFotky = 'PASS' THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 130;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 130;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 350;  
				END_IF    
			ELSIF CAM13.PAR.ResultFotky = 'FAIL' THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 545;
			END_IF
		
		
			//********************************************************Automatický režim****************************************************************************//
		
		100:  
			SC_P3_StoperSrobovania.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			              
			SC_P3_StoperSrobovania.IdleTime.IN:= P3_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			
			IF P3_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				P2_StoperZvarania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			           
			IF P3_StoperSrobovania.KoniecCyklu THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 0;
			ELSIF SC_P3_StoperSrobovania.IdleTime.Q THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;//102
			END_IF
		
			
			
			
		102:
			SC_P3_StoperSrobovania.StepName:='102 - Automaticky Rezim - precitanie cisla paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#500ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				i:= 0;
				P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
					
			IF P3_StoperSrobovania.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P3_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 103;
			END_IF	
           
			
		
		
		
		
		103:
			SC_P3_StoperSrobovania.StepName:='103 - Automaticky Rezim - kontrola a priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
		
			IF i<> 0 THEN
				P3_StoperSrobovania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 104;
			ELSE
				P34_Alarmy[321]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
			
		
		104:
			SC_P3_StoperSrobovania.StepName:='104 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_7' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_7' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;  
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			END_IF		
		
		
		
		105:
			SC_P3_StoperSrobovania.StepName:='105 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 118;
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 106;
			ELSIF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaError THEN	
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 115;
			END_IF	
			
		106:
			SC_P3_StoperSrobovania.StepName:='106 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 106;	
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 106;
				END_IF   
			END_IF
				
			
			
		108:
			SC_P3_StoperSrobovania.StepName:='108 - Automaticky Rezim - vyziadanie stavu paletky zo servera, zacentrovanie paletky'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#10s;	
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
            
            
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				Centrovacku_VYSUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 110;
			ELSIF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaError THEN	
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 115;
			END_IF	
		
		110:
			SC_P3_StoperSrobovania.StepName:='110 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;		
				
			IF NOT TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena AND P3_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				IF TRCB_P3_Srobovanie_ST7.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST7' THEN
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 118;
					END_IF    
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 115;
				END_IF	
			END_IF
		
		
		
		115:
			SC_P3_StoperSrobovania.StepName:='115 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
             
            
			P34_Vizu.ZobrazHL1_ST7:= TRUE;
            
			IF TRCB_P3_Srobov_OpatovnyDopyt THEN
				TRCB_P3_Srobov_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL1_ST7:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 105;
			ELSIF TRCB_P3_Srobov_PaletkaNG THEN
				TRCB_P3_Srobov_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL1_ST7:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 116;
			END_IF   
            
            
            
            
            
	
		116:
			SC_P3_StoperSrobovania.StepName:='118 - Automaticky Rezim - odcentrovanie paletky po odpovedi servera NG';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#10s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
				
			IF P3_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			END_IF    
		
		
		118:
			SC_P3_StoperSrobovania.StepName:='118 - Automaticky Rezim - zacentrovanie paletky ';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#10s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
				
			IF P3_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 125;
			END_IF    
		         
            
            
			
			
		125:
			SC_P3_StoperSrobovania.StepName:='125 - Automaticky Rezim - rozhodnutie podla typu modelu';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			             
			
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 130;
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 130;
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 350; 
			END_IF
		
           
		
		
			//********************************************Model 45F**************************************************************//
		
		130:
			SC_P3_StoperSrobovania.StepName:='130 - Automaticky Rezim - model 45F vystavenie signalu zaskrutkuj skrutky K40 A M5';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
						
			
			
			IF NOT SC_P3_StoperSrobovania.Switch1  THEN
				P3_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P3_Srobovanie.COM_IN.Model45F_ZaskrutkujSkrutky:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P3_Srobovanie.COM_IN.Model45F_ZaskrutkujSkrutky:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 135;
			END_IF	
	
			
		135:
			SC_P3_StoperSrobovania.StepName:='135 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P3_SkrutkovanieResult_OFF THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 545;
				ELSE	
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 140;
				END_IF	
			END_IF	
			
			
			
		140:
			SC_P3_StoperSrobovania.StepName:='140 - Automaticky Rezim - model 45F kontrola stavu zaskrutkovania skrutiek K40 a M5';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                      
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaK40:= REAL_TO_STRING(P3_Srobovanie.STAV.K40_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaK40:= REAL_TO_STRING(P3_Srobovanie.STAV.K40_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaK40:= REAL_TO_STRING(P3_Srobovanie.STAV.K40_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaK40:= UDINT_TO_STRING(P3_Srobovanie.STAV.K40_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaK40:= UDINT_TO_STRING(P3_Srobovanie.STAV.K40_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaK40:= UDINT_TO_STRING(P3_Srobovanie.STAV.K40_DosiahnutyUhol);
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_DosiahnutyUhol);
            
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Skrutk_45F_StredK40_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaK40);
				P3_Skrutk_45F_StredM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5);
				IF (P3_Skrutk_45F_StredK40_Vysunutie <= P34_RemPremenne.P3_Srob45F_K40_Vysunutie_HI) AND
					(P3_Skrutk_45F_StredK40_Vysunutie >= P34_RemPremenne.P3_Srob45F_K40_Vysunutie_LO) AND
					(P3_Skrutk_45F_StredM5_Vysunutie <= P34_RemPremenne.P3_Srob45F_M5_Vysunutie_HI) AND
					(P3_Skrutk_45F_StredM5_Vysunutie >= P34_RemPremenne.P3_Srob45F_M5_Vysunutie_LO) THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF 
              
            
            
            
			IF P3_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaK40:= 'PASS';
					Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'PASS';
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 545;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaK40:= 'FAIL';
					Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'FAIL';
					IF P3_Srobov_K40_Result_OFF THEN
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 545;	
					ELSE 	
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 500;
					END_IF    
				END_IF 
			ELSIF P3_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN  
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaK40:= 'FAIL';
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'FAIL';
				IF P3_Srobov_K40_Result_OFF THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 545;	
				ELSE 
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 500;
				END_IF    
			END_IF
		
		
			
		
			
		
			//********************************************Model 5H**************************************************************//
				
        		
		350:	
			SC_P3_StoperSrobovania.StepName:='350 - Automaticky Rezim - model 5H vystavenie signalu zaskrutkuj skrutku M5';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
						
						
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P3_Srobovanie.COM_IN.Model5H_ZaskrutkujSkrutky:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P3_Srobovanie.COM_IN.Model5H_ZaskrutkujSkrutky:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 355;
			END_IF	
		
			
		355:
			SC_P3_StoperSrobovania.StepName:='355 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P3_SkrutkovanieResult_OFF THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 545;
				ELSE
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 360;
				END_IF	
			END_IF	
			
	           
            
		360:
			SC_P3_StoperSrobovania.StepName:='360 - Automaticky Rezim - model 5H kontrola stavu zaskrutkovania skrutky M5';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
                      
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_DosiahnutyUhol);
            
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Skrutk_5H_StredM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5);
				IF (P3_Skrutk_5H_StredM5_Vysunutie <= P34_RemPremenne.P3_Srob5H_M5_Vysunutie_HI) AND
					(P3_Skrutk_5H_StredM5_Vysunutie >= P34_RemPremenne.P3_Srob5H_M5_Vysunutie_LO) THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF  
            
            
			IF P3_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'PASS';
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 545;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'FAIL';
					IF P3_Srobov_M5_Result_OFF THEN
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 545;	
					ELSE	
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 500;
					END_IF
				END_IF
			ELSIF P3_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'FAIL';
				IF P3_Srobov_M5_Result_OFF THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 545;	
				ELSE	
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 500;
				END_IF
			END_IF	
		
		
	
			
			
			
			
		
			//********************************Vyfotenie paletky po zlom skrutkovaní**********************************//			
			
			
			
		500:
			SC_P3_StoperSrobovania.StepName:='500 - Automaticky Rezim - presun manipulatora vzad';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			
			
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny) THEN
				P3_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 501;
			END_IF
		
			
		501:
			SC_P3_StoperSrobovania.StepName:='501 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				CAM13.STAV.Results_READY:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 505;
			END_IF	
			
			
			
		505:
			SC_P3_StoperSrobovania.StepName:='505 - Automaticky Rezim - kamerova kontrola paletky CAM13';//CAM 13//
			SC_P3_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF Linka.P3_Kamery_OFF THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 540;
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 AND CAM13.STAV.Command_READY THEN
				CAM13.CMD.Triger:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			
			IF CAM13.STAV.Results_READY AND CAM13.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM13.STAV.Results_READY:= FALSE;
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				CAM13.PAR.ResultFotky:= 'FAIL';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 540;
			ELSIF SC_P3_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM13.STAV.Results_READY:= FALSE;
				CAM13.CMD.Triger:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 508;
			ELSIF SC_P3_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P34_Alarmy[359]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF    
           
		508:
			SC_P3_StoperSrobovania.StepName:='508 - Automaticky Rezim - cakam na opatovny triger kamery CAM13';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P3_StoperSrobovania.IdleTime.Q THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 505;
			END_IF	   
            
            
            
            
			
					
			//******************************************Odoslanie fotiek na server**********************************************//			
		
		540:
			SC_P3_StoperSrobovania.StepName:='540 - Automaticky Rezim - odoslanie fotiek na server';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 545;
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 THEN		
				FTP_CAM13.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM13.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM13.INPUTS.Result:= CAM13.PAR.ResultFotky;
				Reports.Kamery.P3_CAM13_KontrolaPaletky:= CAM13.PAR.ResultFotky;				
				FTP_CAM13.CMD.OdosliFotku:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
            
			
			IF FTP_CAM13.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM13.CMD.OdosliFotku:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 545;
			ELSIF FTP_CAM13.STATUS.KomunikaciaError THEN
				P34_Alarmy[320]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
			
		
		
			
        			
			
			
			//**********************************Odcentrovanie paletky***************************************//	
		545:
			SC_P3_StoperSrobovania.StepName:='545 - Automaticky Rezim - odcentrovanie paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P3_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 550;
			END_IF	
		
				
			//**********************Odoslanie dát na server************************************//	
		
		550:
			SC_P3_StoperSrobovania.StepName:='550 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 552;
			ELSIF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaError THEN	
				P34_Alarmy[325]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
			
		552:
			SC_P3_StoperSrobovania.StepName:='552 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 552;	
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 552;
				END_IF   
			END_IF
		
		
		555:
			SC_P3_StoperSrobovania.StepName:='555 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				TRCB_P3_Srobovanie_ST7.CMD.OdosliStavPaletky_TYP2:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF   
						
			
			IF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_Srobovanie_ST7.CMD.OdosliStavPaletky_TYP2:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 556;
			ELSIF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaError THEN
				P34_Alarmy[325]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
			
		
		556:
			SC_P3_StoperSrobovania.StepName:='556 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF NOT TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_Srobovanie_ST7.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 560;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 560;
				END_IF	
			END_IF
	
            
            
			
			

			//********************************Vyvezenie paletky**************************************//	
		560:
			SC_P3_StoperSrobovania.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na stoper HV testu';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
            
			IF P3_StoperSrobovania.KoniecCyklu THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 0;
			ELSIF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 0;	
			ELSIF ((NOT P3_HV_Test.RFID_hlava.PritomnostPaletky AND SC_P3_HV_Test.Step = 100) OR (P3_HV_Test.OUT.ZasunStoper AND SC_P3_HV_Test.Step = 561)) AND NOT P3_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky THEN
				P3_StoperSrobovania.OUT.ZasunStoper:= TRUE;
				P3_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 561;
			END_IF	
		
		
		561:
			SC_P3_StoperSrobovania.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na stoper HV testu';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#10s;
		
			SC_P3_StoperSrobovania.IdleTime.IN:= NOT P3_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			SC_P3_StoperSrobovania.AlarmTime.IN:= P3_StoperSrobovania.RFID_hlava.PritomnostPaletky;
            
			IF NOT P3_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				CisloFotky:= 0;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5:= '';
				Reports.Kamery.P3_CAM13_KontrolaPaletky:= '';
				SkrutkaM5_Zahodena:= FALSE;
				P3_StoperSrobovania.OUT.ZasunStoper:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 100;
			ELSIF SC_P3_StoperSrobovania.AlarmTime.Q THEN
				P34_Alarmy[355]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF
            
		            
		        
            
					
		
				
			//*******************************************************Manuálny režim*******************************************************************************//	
			
		700:
			SC_P3_StoperSrobovania.StepName:='700 - Manualny Rezim';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#8s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
		
		
		
		
		
		
		
		
	
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

