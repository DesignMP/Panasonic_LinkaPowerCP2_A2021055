
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
		
	
			
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P1_StoperSrobovania);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	IOLinkKomunikacia;
	
    
    
    	
	
		
	//Reset sekcie //
	IF P1_StoperSrobovania.Reset THEN
		SC_P1_StoperSrobovania.Step:= 0;
		P1_StoperSrobovania.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P1_StoperSrobovania.Step:= 0;
	ELSIF NOT Safety.STAV.P1_ZonaBunky_AKTIVNA THEN
		SC_P1_StoperSrobovania.Step:= 0;
	END_IF	
	
        
    
    
	CASE SC_P1_StoperSrobovania.Step OF 
	
		0:
			SC_P1_StoperSrobovania.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			P1_StoperSrobovania.Automat:= FALSE;
			P1_StoperSrobovania.KoniecCyklu:= FALSE;
			P1_StoperSrobovania.Manual:= FALSE;
			P1_StoperSrobovania.STAV.PoINIT:= FALSE;
			P1_StoperSrobovania.OUT.ZasunStoper:= FALSE;
			P1_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
			P1_Srobovanie.COM_IN.Model45F_ZaskrutkujLavu_K30:= FALSE;
			P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPravu_K30:= FALSE;
			P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPrednu_M4:= FALSE;
			P1_Srobovanie.COM_IN.Model45F_ZaskrutkujZadnu_M4:= FALSE;
			P1_Srobovanie.COM_IN.Model45F_ZaskrutkujDPS_M4:= FALSE;
			P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_K30:= FALSE;
			P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_K30:= FALSE;
			P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_M5:= FALSE;
			P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_M5:= FALSE;
			P1_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednu_M5:= FALSE;
			P1_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
			P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
			P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
			P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
			P1_Robot.COM_OUT.OdoberDPS_4F_z_Paletky:= FALSE;
			P1_Robot.COM_OUT.OdoberDPS_5F_z_Paletky:= FALSE;
			P1_Robot.COM_OUT.OdoberFoam4F_z_Paletky:= FALSE;
			P1_Robot.COM_OUT.OdoberFoam5F_z_Paletky:= FALSE;
			P1_Robot.COM_OUT.OdoberSpodnyBusbar4F_z_Paletky:= FALSE;
			P1_Robot.COM_OUT.OdoberSpodnyBusbar5F_z_Paletky:= FALSE;
			P1_Robot.COM_OUT.OdoberSpodnyBusbar5H_z_Paletky:= FALSE;
			P1_Robot.COM_OUT.PolozDPS_4F_na_PowerCP:= FALSE;
			P1_Robot.COM_OUT.PolozDPS_5F_na_PowerCP:= FALSE;
			P1_Robot.COM_OUT.PolozFoam4F_na_PowerCP:= FALSE;
			P1_Robot.COM_OUT.PolozFoam5F_na_PowerCP:= FALSE;
			P1_Robot.COM_OUT.PolozSpodnyBusbar4F_na_PowerCP:= FALSE;
			P1_Robot.COM_OUT.PolozSpodnyBusbar5F_na_PowerCP:= FALSE;
			P1_Robot.COM_OUT.PolozSpodnyBusbar5H_na_PowerCP:= FALSE;
			P1_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
			P1_Robot.COM_OUT.ZopakujOdoberanie:= FALSE;
			P1_Robot.COM_OUT.Odparkovanie:= FALSE;
			CAM6.CMD.Triger:= FALSE;
			CAM6.STAV.Results_READY:= FALSE;
			FTP_CAM6.CMD.OdosliFotku:= FALSE;
			FTP_CAM6.CMD.VymazFotku:= FALSE;
			P1_Srobov_KAM_Result_Ignoruj:= FALSE;
			TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P1_Srobovanie_ST2.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P1_Srobovanie_ST2.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
			P1_Srobov_KAM_Result_OK:= FALSE;
			P1_Srobov_KAM_Result_NG:= FALSE;
			P1_Robot.STAV.DrziBusbar_45F:= FALSE;
			P1_Robot.STAV.DrziBusbar_5H:= FALSE;
			P1_Robot.STAV.DrziDPS_45F:= FALSE;
			P1_Robot.STAV.DrziFoamy_45F:= FALSE;
			P1_Vizu.ZobrazHL1_ST2:= FALSE;
			P1_Vizu.ZobrazHL2_ST2:= FALSE;
			P1_Vizu.ZobrazHL3_ST2:= FALSE;
			P1_Vizu.ZobrazHL4_ST2:= FALSE;
			P1_Vizu.ZobrazHL5_ST2:= FALSE;
			P1_Vizu.ZobrazHL6_ST2:= FALSE;
			P1_Vizu.ZobrazHL7_ST2:= FALSE;
			P1_Vizu.ZobrazHL8_ST2:= FALSE;
			P1_Vizu.ZobrazHL9_ST2:= FALSE;
			TRCB_P1_Srobov_OpatovnyDopyt:= FALSE;
			TRCB_P1_Srobov_PaletkaNG:= FALSE;
			VysunutieSkrutkovacky_OK:= FALSE;
			P1_StoperSrobovania.PAR.IndexFotky:= 0;
			PocetTrigrovKamery:= 0;
			PocetZopakovaniOdobratia:= 0;
			PocetDopytovNaServer:= 0;
			CisloFotky:= 0;
			TestovaciKus:= FALSE;
			P1_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P1_Vytah.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			            
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND Safety.STAV.P1_ZonaBunky_AKTIVNA AND NOT P1_Pracovisko.STAV.Porucha_ST2 AND NOT P1_Pracovisko.STAV.Porucha_ST3 THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 1;
			END_IF
	
		1:
			SC_P1_StoperSrobovania.StepName:='1 - Cakam na spustenie vyroby';
			P1_StoperSrobovania.KoniecCyklu:= FALSE;
			IF P1_StoperSrobovania.Automat THEN
				SC_P1_StoperSrobovania.Step:= 2;
			ELSIF P1_StoperSrobovania.Manual THEN
				SC_P1_StoperSrobovania.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P1_StoperSrobovania.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
									
			IF P1_Srobovanie.STAV.PoINIT AND P1_Dopravniky.STAV.PoINIT AND P1_Pracovisko.STAV.SkrutkovackyZasunute AND P1_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 3;
			END_IF
		
			
		3:
			SC_P1_StoperSrobovania.StepName:='3 - Inicializacia - vymazanie adresara kamery CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 10;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 THEN
				FTP_CAM6.CMD.VymazFotku:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
				
			IF FTP_CAM6.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM6.CMD.VymazFotku:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 10;
			ELSIF FTP_CAM6.STATUS.KomunikaciaError THEN
				P1_Alarmy[116]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
			
	
    		
			
		10:
			SC_P1_StoperSrobovania.StepName:='10 - Inicializacia - zasunutie centrovacky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P1_StoperSrobovania.IN.Centrovanie_ZASUNUTE AND P1_Dopravniky.STAV.PoINIT THEN
				IF Linka.Kamery_OFF THEN
					P1_StoperSrobovania.STAV.PoINIT:= TRUE;
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 100;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 13;
				END_IF	
			END_IF		
		
		13:	
			SC_P1_StoperSrobovania.StepName:='13 - Inicializacia - hladanie paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
	
			IF P1_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 20;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q THEN
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 100;
			END_IF
		
		
		20:
			SC_P1_StoperSrobovania.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			SC_P1_StoperSrobovania.IdleTime.IN:= P1_StoperSrobovania.RFID_hlava.PritomnostPaletky;
									
			IF SC_P1_StoperSrobovania.IdleTime.Q THEN
				P1_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
			END_IF
			
			IF P1_StoperSrobovania.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P1_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P1_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 23;
			END_IF	
			
		23:
			SC_P1_StoperSrobovania.StepName:='23 - Inicializacia - kontrola a priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P1_StoperSrobovania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 30;
			ELSE
				P1_Alarmy[113]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
		
		
		30:
			SC_P1_StoperSrobovania.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_2' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_2' THEN
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_2' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_2' THEN
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			END_IF	
            
       				
		33:
			SC_P1_StoperSrobovania.StepName:='33 - Inicializacia - kontrola uzavretia komunikacie s Panatrace';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			ELSE
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 38;
			END_IF	
			
			
			
            
		38:
			SC_P1_StoperSrobovania.StepName:='38 - Inicializacia - kontrola odoslania fotiek';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;   
            
			IF Paletka[i].STAV.OdoslanieFotiek_DONE THEN
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 550;
			ELSE
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 40;
			END_IF
            
       
		40:
			SC_P1_StoperSrobovania.StepName:='40 - Inicializacia - zacentrovanie paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P1_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 43;
			END_IF	
            
		43:
			SC_P1_StoperSrobovania.StepName:='43 - Inicializacia - presun manipulatora vzad';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1 AND P1_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 45;
			END_IF
            
         
		45:
			SC_P1_StoperSrobovania.StepName:='45 - Inicializacia - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 46;
			END_IF	
			
			
            
            
		46:
			SC_P1_StoperSrobovania.StepName:='46 - Inicializacia - kamerova kontrola paletky CAM6'; //CAM 6//
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;   
            
           			
							
			IF NOT SC_P1_StoperSrobovania.Switch1 AND CAM6.STAV.Command_READY THEN
				CAM6.CMD.Triger:= TRUE;
				SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF CAM6.STAV.Results_READY AND CAM6.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 50;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM6.STAV.Results_READY:= FALSE;
				CAM6.CMD.Triger:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 48;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P1_Alarmy[168]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
            
            
            
            
            
            
            
            
		48:
			SC_P1_StoperSrobovania.StepName:='48 - Inicializacia - cakam na opatovny triger kamery CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P1_StoperSrobovania.IdleTime.Q THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 46;
			END_IF	
			
			
			
		50:
			SC_P1_StoperSrobovania.StepName:='50 - Inicializacia - kontrola vysledku kamery podla typu modelu';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
            
		
			IF NOT CAM6.STAV.BUSY THEN
				CAM6.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF CAM6.RESULT.Paletka.Pritom_LavyFoam_4F5F AND
						CAM6.RESULT.Paletka.Pritom_PravyFoam_4F5F AND
						CAM6.RESULT.Paletka.Pritom_SpodnyBusbar_4F AND
						NOT CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30 AND
						NOT CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30 THEN
						CAM6.PAR.ResultFotky:= 'PASS';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 53;
					ELSE
						CAM6.PAR.ResultFotky:= 'FAIL';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 53;
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF CAM6.RESULT.Paletka.Pritom_LavyFoam_4F5F AND
						CAM6.RESULT.Paletka.Pritom_PravyFoam_4F5F AND
						CAM6.RESULT.Paletka.Pritom_SpodnyBusbar_5F AND
						NOT CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30 AND
						NOT CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30 THEN
						CAM6.PAR.ResultFotky:= 'PASS';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 53;
					ELSE 
						CAM6.PAR.ResultFotky:= 'FAIL';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 53;
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					IF CAM6.RESULT.Paletka.Pritom_KrytuBusbarov_5H AND
						CAM6.RESULT.Paletka.Pritom_SpodnychBusbarov_5H AND
						NOT CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyM5_5H AND
						NOT CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyM5_5H AND
						NOT CAM6.RESULT.PowerCP.Pritom_StrednejSkrutkyM5_5H AND
						NOT CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30 AND
						NOT CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30 THEN
						CAM6.PAR.ResultFotky:= 'PASS';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 53;
					ELSE 
						CAM6.PAR.ResultFotky:= 'FAIL';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 53;
					END_IF
				END_IF
			END_IF
            
                 
            
		53:			
			SC_P1_StoperSrobovania.StepName:='53 - Inicializacia - vymazanie adresara kamery';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 55;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 THEN
				FTP_CAM6.CMD.VymazFotku:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM6.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM6.CMD.VymazFotku:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 55;
			ELSIF FTP_CAM6.STATUS.KomunikaciaError THEN
				P1_Alarmy[116]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF		
        
       	
             
            
            
            
            
		55:
			SC_P1_StoperSrobovania.StepName:='55 - Inicializacia - rozhodnutie podla kamerovej kontroly paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
            	
				
			IF CAM6.PAR.ResultFotky = 'PASS' THEN
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 138;   
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 138;  
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 360; 
				END_IF    
			ELSIF CAM6.PAR.ResultFotky = 'FAIL' THEN
				P1_StoperSrobovania.STAV.PoINIT:= TRUE;
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 545;
			END_IF
                 
                 
            
					
			//********************************************************Automatický režim****************************************************************************//
	
		100:  
			SC_P1_StoperSrobovania.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			SC_P1_StoperSrobovania.IdleTime.IN:= P1_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			
			IF P1_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				P1_Vytah.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			            
			IF P1_StoperSrobovania.KoniecCyklu THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 0;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 101;
			END_IF
		
		101:
			SC_P1_StoperSrobovania.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#500ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				i:= 0;
				P1_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
					
			IF P1_StoperSrobovania.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P1_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P1_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 102;
			END_IF	
			
						
			
			
		102:
			SC_P1_StoperSrobovania.StepName:='102 - Automaticky Rezim - kontrola a priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
						
			IF i<> 0 THEN
				P1_StoperSrobovania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 103;
			ELSE
				P1_Alarmy[113]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
			
			
		
		103:
			SC_P1_StoperSrobovania.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_2' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_2' THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_2' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_2' THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;         
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			END_IF		
		
         
		105:
			SC_P1_StoperSrobovania.StepName:='105 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 120;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 THEN
				TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaUkoncena THEN
				TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 106;
			ELSIF TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaError THEN	
				TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 115;
			END_IF
		
			
		106:
			SC_P1_StoperSrobovania.StepName:='106 - Automaticky Rezim - kontrola odpovede servera';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 106;	
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 106;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 106;
				END_IF   
			END_IF
			
			
		
		108:
			SC_P1_StoperSrobovania.StepName:='108 - Automaticky Rezim - vyziadanie stavu paletky zo servera'; 
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#10s;	
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF   
            
			
			IF TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaUkoncena THEN
				TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 110;
			ELSIF TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaError THEN	
				TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 115;
			END_IF	
			
		
			
			
		110:
			SC_P1_StoperSrobovania.StepName:='110 - Automaticky Rezim - kontrola odpovede servera';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Srobovanie_ST2.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST2' THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 120;
					END_IF   
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 115;
				END_IF	
			END_IF
			
		
		115:
			SC_P1_StoperSrobovania.StepName:='115 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
		
			P1_Vizu.ZobrazHL9_ST2:= TRUE;
            
			IF TRCB_P1_Srobov_OpatovnyDopyt THEN
				TRCB_P1_Srobov_OpatovnyDopyt:= FALSE; 
				P1_Vizu.ZobrazHL9_ST2:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 105;
			ELSIF TRCB_P1_Srobov_PaletkaNG THEN
				TRCB_P1_Srobov_PaletkaNG:= FALSE;
				P1_Vizu.ZobrazHL9_ST2:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			END_IF    
            
            
            
		
		120:
			SC_P1_StoperSrobovania.StepName:='120 - Automaticky Rezim - zacentrovanie paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P1_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 121;
			END_IF	
		
		121:
			SC_P1_StoperSrobovania.StepName:='121 - Automaticky Rezim - presun manipulatora vzad';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1 AND P1_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 122;
			END_IF
		
		122:
			SC_P1_StoperSrobovania.StepName:='122 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 123;
			END_IF	
			
	
		123:
			SC_P1_StoperSrobovania.StepName:='123 - Automaticky Rezim - kamerova kontrola paletky CAM6';//CAM 6//
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.Kamery_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 125;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 AND CAM6.STAV.Command_READY THEN
				CAM6.CMD.Triger:= TRUE;
				SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF CAM6.STAV.Results_READY AND CAM6.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 125;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM6.STAV.Results_READY:= FALSE;
				CAM6.CMD.Triger:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 124;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P1_Alarmy[168]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;    
			END_IF
		       
                 
            
            
            
		124:
			SC_P1_StoperSrobovania.StepName:='123 - Automaticky Rezim - cakam na opatovny triger kamery CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P1_StoperSrobovania.IdleTime.Q THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 123;
			END_IF	
			
			
			
		125:
			SC_P1_StoperSrobovania.StepName:='125 - Automaticky Rezim - rozhodnutie podla typu modelu';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
		
			IF NOT CAM6.STAV.BUSY THEN
				CAM6.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF Linka.Kamery_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 138;
					ELSE	
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 130;
					END_IF	
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF Linka.Kamery_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 138;
					ELSE	
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 130;
					END_IF	 	
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					IF Linka.Kamery_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 360;
					ELSE	
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 350;
					END_IF	
				END_IF
			END_IF
			
            
            
            
            
            
            
            
			//********************************************Model 4F a 5F**************************************************************//
		130:
			SC_P1_StoperSrobovania.StepName:='130 - Automaticky Rezim - model 45F kontrola vysledku kamery';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
            
            		
			IF NOT CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30 AND
				NOT CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30 THEN
				CAM6.PAR.ResultFotky:= 'PASS';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 132;
			ELSE 
				CAM6.PAR.ResultFotky:= 'FAIL';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 132;
			END_IF
			
       
		132:
			SC_P1_StoperSrobovania.StepName:='132 - Automaticky Rezim - model 45F rozhodnutie podla kamerovej kontroly paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
				
			IF CAM6.PAR.ResultFotky = 'PASS' THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 135;
			ELSIF CAM6.PAR.ResultFotky = 'FAIL' THEN
				P1_Vizu.ZobrazHL1_ST2:= TRUE;
				IF P1_Srobov_KAM_Result_OK THEN
					P1_Srobov_KAM_Result_OK:= FALSE;
					P1_Vizu.ZobrazHL1_ST2:= FALSE;
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 135;
				ELSIF P1_Srobov_KAM_Result_NG THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P1_Srobov_KAM_Result_NG:= FALSE;
					P1_Vizu.ZobrazHL1_ST2:= FALSE;
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 540;    
				END_IF 
			END_IF
			
			
		135:			
			SC_P1_StoperSrobovania.StepName:='135 - Automaticky Rezim - model 45F vymazanie fotky CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 138;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 THEN
				FTP_CAM6.CMD.VymazFotku:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM6.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM6.CMD.VymazFotku:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 138;
			ELSIF FTP_CAM6.STATUS.KomunikaciaError THEN
				P1_Alarmy[116]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF				
					
			
		138:
			SC_P1_StoperSrobovania.StepName:='138 - Automaticky Rezim - model 45F vystavenie signalu zaskrutkuj lavú skrutku K30, odober foamy';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#7s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#10s;
			
			SC_P1_StoperSrobovania.IdleTime.IN:= P1_Robot.COM_IN.Stav_RobotOdoberaFoamy;
						
			IF NOT SC_P1_StoperSrobovania.Switch1 AND P1_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujLavu_K30:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P1_Robot.COM_OUT.OdoberFoam4F_z_Paletky:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P1_Robot.COM_OUT.OdoberFoam5F_z_Paletky:= TRUE;
				END_IF	
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(SC_P1_StoperSrobovania.IdleTime.Q)THEN
				IF PocetZopakovaniOdobratia <= 3 THEN
					P1_Robot.COM_OUT.ZopakujOdoberanie:= TRUE;
				END_IF    
				PocetZopakovaniOdobratia:= PocetZopakovaniOdobratia + 1;
			END_IF
            
			IF NOT P1_Robot.COM_IN.Stav_RobotOdoberaFoamy THEN
				P1_Robot.COM_OUT.ZopakujOdoberanie:= FALSE;
			END_IF    
            
            
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene AND (P1_Robot.COM_IN.Stav_Foam4F_Odobraty OR P1_Robot.COM_IN.Stav_Foam5F_Odobraty) THEN
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujLavu_K30:= FALSE;
				P1_Robot.COM_OUT.OdoberFoam4F_z_Paletky:= FALSE;
				P1_Robot.COM_OUT.OdoberFoam5F_z_Paletky:= FALSE;
				P1_Robot.STAV.DrziFoamy_45F:= TRUE;
				P1_Robot.COM_OUT.ZopakujOdoberanie:= FALSE;
				PocetZopakovaniOdobratia:= 0;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 139;
			ELSIF PocetZopakovaniOdobratia > 3 THEN
				P1_Alarmy[159]:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 500;
			ELSIF NOT P1_Robot.COM_IN.Stav_ProgramRUN THEN
				P1_Alarmy[145]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;       
			END_IF	
			
			
		139:
			SC_P1_StoperSrobovania.StepName:='139 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 143;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 140;
				END_IF	
			END_IF	
			
			
		140:
			SC_P1_StoperSrobovania.StepName:='140 - Automaticky Rezim - model 45F kontrola stavu zaskrutkovania lavej skrutky K30';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                        
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_LavaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_LavaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_LavaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_DosiahnutyUhol);
            
			
			
				
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_45F_LavaK30_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaK30);
				IF (P1_Skrutk_45F_LavaK30_Vysunutie <= P1_RemPremenne.P1_Srob45F_LavaK30_Vysunutie_HI) AND (P1_Skrutk_45F_LavaK30_Vysunutie >= P1_RemPremenne.P1_Srob45F_LavaK30_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF  
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF    
                        
			
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaK30:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 143;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaK30:= 'FAIL';
					IF P1_Srobov_K30_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 143;
					ELSE	
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500; 
					END_IF
				END_IF   
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaK30:= 'FAIL';
				IF P1_Srobov_K30_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 143;
				ELSE	
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500; 
				END_IF
			END_IF
			
			
		143:
			SC_P1_StoperSrobovania.StepName:='143 - Automaticky Rezim - model 45F vystavenie signalu zaskrutkuj pravu skrutku K30, odober spodny busbar';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
			
						
			IF NOT SC_P1_StoperSrobovania.Switch1 AND P1_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPravu_K30:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P1_Robot.COM_OUT.OdoberSpodnyBusbar4F_z_Paletky:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P1_Robot.COM_OUT.OdoberSpodnyBusbar5F_z_Paletky:= TRUE;	
				END_IF	
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene AND (P1_Robot.COM_IN.Stav_SpodnyBusbar4F_Odobraty OR P1_Robot.COM_IN.Stav_SpodnyBusbar5F_Odobraty) THEN
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPravu_K30:= FALSE;
				P1_Robot.COM_OUT.OdoberSpodnyBusbar4F_z_Paletky:= FALSE;
				P1_Robot.COM_OUT.OdoberSpodnyBusbar5F_z_Paletky:= FALSE;
				P1_Robot.STAV.DrziBusbar_45F:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 144;
			ELSIF NOT P1_Robot.COM_IN.Stav_ProgramRUN THEN
				P1_Alarmy[145]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE; 
			END_IF	
					
	
		144:
			SC_P1_StoperSrobovania.StepName:='144 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 148;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 145;
				END_IF	
			END_IF	
			
		145:
			SC_P1_StoperSrobovania.StepName:='145 - Automaticky Rezim - model 45F kontrola stavu zaskrutkovania pravej skrutky K30';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
                       
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_PravaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_PravaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_PravaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_DosiahnutyUhol);
            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_45F_PravaK30_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaK30);
				IF (P1_Skrutk_45F_PravaK30_Vysunutie <= P1_RemPremenne.P1_Srob45F_PravaK30_Vysunutie_HI) AND (P1_Skrutk_45F_PravaK30_Vysunutie >= P1_RemPremenne.P1_Srob45F_PravaK30_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF   
            
           		
			
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaK30:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 148;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaK30:= 'FAIL';
					IF P1_Srobov_K30_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 148;
					ELSE	
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF
				END_IF    
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaK30:= 'FAIL';
				IF P1_Srobov_K30_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 148;
				ELSE	
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF
			END_IF	
			
		
			
		148:
			SC_P1_StoperSrobovania.StepName:='148 - Automaticky Rezim - model 45F presun manipulatora vzad';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1 AND P1_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie  THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 149;
			END_IF
			
		149:
			SC_P1_StoperSrobovania.StepName:='149 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND NOT P1_Robot.COM_IN.Stav_Foam4F_Polozeny AND NOT P1_Robot.COM_IN.Stav_Foam5F_Polozeny THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 153;
			END_IF	
			
			
			
		153:
			SC_P1_StoperSrobovania.StepName:='153 - Automaticky Rezim - model 45F vystavenie signalu pre robota poloz foam na PowerCP';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P1_Robot.COM_OUT.PolozFoam4F_na_PowerCP:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P1_Robot.COM_OUT.PolozFoam5F_na_PowerCP:= TRUE;
				END_IF	
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF (P1_Robot.COM_IN.Stav_Foam4F_Polozeny OR P1_Robot.COM_IN.Stav_Foam5F_Polozeny) AND NOT P1_Robot.COM_IN.Stav_SpodnyBusbar4F_Polozeny AND NOT P1_Robot.COM_IN.Stav_SpodnyBusbar5F_Polozeny THEN
				P1_Robot.STAV.DrziFoamy_45F:= FALSE;
				P1_Robot.COM_OUT.PolozFoam4F_na_PowerCP:= FALSE;
				P1_Robot.COM_OUT.PolozFoam5F_na_PowerCP:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 158;
			ELSIF NOT P1_Robot.COM_IN.Stav_ProgramRUN THEN
				P1_Alarmy[145]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;    
			END_IF
			
		
            
            
		158:
			SC_P1_StoperSrobovania.StepName:='158 - Automaticky Rezim - model 45F vystavenie signalu pre robota poloz spodny busbar na PowerCP';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P1_Robot.COM_OUT.PolozSpodnyBusbar4F_na_PowerCP:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P1_Robot.COM_OUT.PolozSpodnyBusbar5F_na_PowerCP:= TRUE;
				END_IF	
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF (P1_Robot.COM_IN.Stav_SpodnyBusbar4F_Polozeny OR P1_Robot.COM_IN.Stav_SpodnyBusbar5F_Polozeny) THEN
				P1_Robot.STAV.DrziBusbar_45F:= FALSE;
				P1_Robot.COM_OUT.PolozSpodnyBusbar4F_na_PowerCP:= FALSE;
				P1_Robot.COM_OUT.PolozSpodnyBusbar5F_na_PowerCP:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 160;
			ELSIF NOT P1_Robot.COM_IN.Stav_ProgramRUN THEN
				P1_Alarmy[145]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
			
		160:
			SC_P1_StoperSrobovania.StepName:='160 - Automaticky Rezim - model 45F vystavenie signalu zaskrutkuj prednu skrutku M4';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
			
			
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPrednu_M4:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPrednu_M4:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 161;
			END_IF
				
			
		
				
		
	
		161:
			SC_P1_StoperSrobovania.StepName:='161 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 165;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 163;
				END_IF	
			END_IF			
				
				
		163:
			SC_P1_StoperSrobovania.StepName:='163 - Automaticky Rezim - model 45F kontrola stavu zaskrutkovania prednej skrutky M4';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
                        
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_PrednaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_PrednaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_PrednaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_PrednaSkrutkaM4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_Uhol_ToleranciaMIN);
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_PrednaSkrutkaM4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_PrednaSkrutkaM4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_DosiahnutyUhol);
            
          
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_45F_PrednaM4_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_PrednaSkrutkaM4);
				IF (P1_Skrutk_45F_PrednaM4_Vysunutie <= P1_RemPremenne.P1_Srob45F_PrednaM4_Vysunutie_HI) AND (P1_Skrutk_45F_PrednaM4_Vysunutie >= P1_RemPremenne.P1_Srob45F_PrednaM4_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF   
            
                       
			
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_PrednaSkrutkaM4:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 165;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_PrednaSkrutkaM4:= 'FAIL';
					IF P1_Srobov_M4_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 165;
					ELSE
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF
				END_IF    
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_PrednaSkrutkaM4:= 'FAIL';
				IF P1_Srobov_M4_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 165;
				ELSE
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF
			END_IF     
            		
		165:
			SC_P1_StoperSrobovania.StepName:='165 - Automaticky Rezim - model 45F vystavenie signalu zaskrutkuj zadnu skrutku M4';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
						
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujZadnu_M4:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujZadnu_M4:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 166;
			END_IF		
				
		166:
			SC_P1_StoperSrobovania.StepName:='166 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 170;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 168;
				END_IF	
			END_IF			
		
			
			
		168:
			SC_P1_StoperSrobovania.StepName:='168 - Automaticky Rezim - model 45F kontrola stavu zaskrutkovania zadnej skrutky M4';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
           
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_ZadnaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_ZadnaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_ZadnaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_ZadnaSkrutkaM4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_Uhol_ToleranciaMIN);
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_ZadnaSkrutkaM4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_ZadnaSkrutkaM4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_DosiahnutyUhol);
            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_45F_ZadnaM4_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_ZadnaSkrutkaM4);
				IF (P1_Skrutk_45F_ZadnaM4_Vysunutie <= P1_RemPremenne.P1_Srob45F_ZadnaM4_Vysunutie_HI) AND (P1_Skrutk_45F_ZadnaM4_Vysunutie >= P1_RemPremenne.P1_Srob45F_ZadnaM4_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF  
            
            
			
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_ZadnaSkrutkaM4:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 170;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_ZadnaSkrutkaM4:= 'FAIL';
					IF P1_Srobov_M4_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 170;
					ELSE
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF 
				END_IF   
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_ZadnaSkrutkaM4:= 'FAIL';
				IF P1_Srobov_M4_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 170;
				ELSE
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF 
			END_IF	
			
		
		170:
			SC_P1_StoperSrobovania.StepName:='170 - Automaticky Rezim - model 45F presun manipulatora vzad';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND NOT P1_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 171;
			END_IF	
			
		171:	
			SC_P1_StoperSrobovania.StepName:='171 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND NOT P1_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 173;
			END_IF		
			
			
		173:
			SC_P1_StoperSrobovania.StepName:='173 - Automaticky Rezim - model 45F vystavenie signalu pre robota chod do cakacej pozicie';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Robot.COM_OUT.Presun_CakaciaPozicia:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P1_Robot.COM_IN.Stav_RobotPoziciaCakania AND (NOT P1_Robot.COM_IN.Stav_DPS_4F_Odobraty AND NOT P1_Robot.COM_IN.Stav_DPS_4F_Odobraty) THEN
				P1_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 175;
			END_IF	
			
		175:
			SC_P1_StoperSrobovania.StepName:='175 - Automaticky Rezim - model 45F kamerova kontrola polozenia foamov CAM6';//CAM 6//
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.Kamery_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 185;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 AND CAM6.STAV.Command_READY THEN
				CAM6.CMD.Triger:= TRUE;
				SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF CAM6.STAV.Results_READY AND CAM6.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 178;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM6.STAV.Results_READY:= FALSE;
				CAM6.CMD.Triger:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 176;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P1_Alarmy[168]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;      
			END_IF
            
                      
            
		
		176:
			SC_P1_StoperSrobovania.StepName:='176 - Automaticky Rezim - cakam na opatovny triger kamery CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P1_StoperSrobovania.IdleTime.Q THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 175;
			END_IF		
			
		
		178:
			SC_P1_StoperSrobovania.StepName:='178 - Automaticky Rezim - model 45F kontrola vysledku kamery';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			IF NOT CAM6.STAV.BUSY THEN
				CAM6.CMD.Triger:= FALSE;
				IF NOT CAM6.RESULT.PowerCP.Nepritom_LavyFoam_4F5F AND
					NOT CAM6.RESULT.PowerCP.Nepritom_PravyFoam_4F5F THEN
					CAM6.PAR.ResultFotky:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 180;
				ELSE 
					CAM6.PAR.ResultFotky:= 'FAIL';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 180;
				END_IF
			END_IF
       
		180:
			SC_P1_StoperSrobovania.StepName:='180 - Automaticky Rezim - model 45F rozhodnutie podla kamerovej kontroly foamov';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
				
			IF CAM6.PAR.ResultFotky = 'PASS' THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 183;
			ELSIF CAM6.PAR.ResultFotky = 'FAIL' THEN
				P1_Vizu.ZobrazHL2_ST2:= TRUE;
				IF P1_Srobov_KAM_Result_OK THEN
					CAM6.PAR.ResultFotky:= 'PASS';
					P1_Srobov_KAM_Result_OK:= FALSE;
					P1_Vizu.ZobrazHL2_ST2:= FALSE;
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 183;
				ELSIF P1_Srobov_KAM_Result_NG THEN
					CAM6.PAR.ResultFotky:= 'FAIL';
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P1_Vizu.ZobrazHL2_ST2:= FALSE;
					P1_Srobov_KAM_Result_NG:= FALSE;
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 540;    
				END_IF 
			END_IF
            
                     
		183:
			SC_P1_StoperSrobovania.StepName:='183 - Automaticky Rezim - model 45F odoslanie fotky na server Panasonic';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
                       
			IF Linka.KOM_FTP_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 185;	
			ELSE	
				FTP_CAM6.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM6.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM6.INPUTS.Result:= CAM6.PAR.ResultFotky;
				Reports.Kamery.P1_CAM6_KontrolaPaletky:= CAM6.PAR.ResultFotky;
            	FTP_CAM6.CMD.OdosliFotku:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 185;	
			END_IF	
			
			
		185:
			SC_P1_StoperSrobovania.StepName:='185 - Automaticky Rezim - model 45F vystavenie signalu pre robota odober DPS z paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P1_Robot.COM_OUT.OdoberDPS_4F_z_Paletky:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P1_Robot.COM_OUT.OdoberDPS_5F_z_Paletky:= TRUE;
				END_IF	
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF (P1_Robot.COM_IN.Stav_DPS_4F_Odobraty OR P1_Robot.COM_IN.Stav_DPS_5F_Odobraty) AND NOT P1_Robot.COM_IN.Stav_DPS_4F_Polozeny AND NOT P1_Robot.COM_IN.Stav_DPS_5F_Polozeny THEN
				P1_Robot.STAV.DrziDPS_45F:= TRUE;
				P1_Robot.COM_OUT.OdoberDPS_4F_z_Paletky:= FALSE;
				P1_Robot.COM_OUT.OdoberDPS_5F_z_Paletky:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 188;
			ELSIF NOT P1_Robot.COM_IN.Stav_ProgramRUN THEN
				P1_Alarmy[145]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
			
			
		188:
			SC_P1_StoperSrobovania.StepName:='188 - Automaticky Rezim - model 45F vystavenie signalu pre robota poloz DPS na PowerCP';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P1_Robot.COM_OUT.PolozDPS_4F_na_PowerCP:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P1_Robot.COM_OUT.PolozDPS_5F_na_PowerCP:= TRUE;
				END_IF	
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF (P1_Robot.COM_IN.Stav_DPS_4F_Polozeny OR P1_Robot.COM_IN.Stav_DPS_5F_Polozeny) AND (FTP_CAM6.STATUS.KomunikaciaUkoncena OR Linka.KOM_FTP_OFF) THEN
				FTP_CAM6.CMD.OdosliFotku:= FALSE;
				P1_Robot.STAV.DrziDPS_45F:= FALSE;
				P1_Robot.COM_OUT.PolozDPS_4F_na_PowerCP:= FALSE;
				P1_Robot.COM_OUT.PolozDPS_5F_na_PowerCP:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 190;
			ELSIF NOT P1_Robot.COM_IN.Stav_ProgramRUN THEN
				P1_Alarmy[145]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF FTP_CAM6.STATUS.KomunikaciaError THEN
				P1_Alarmy[116]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;   
			END_IF
				
		
			
		190:
			SC_P1_StoperSrobovania.StepName:='190 - Automaticky Rezim - model 45F vystavenie signalu zaskrutkuj skrutku M4 pre DPS';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
			
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujDPS_M4:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P1_Srobovanie.COM_IN.Model45F_ZaskrutkujDPS_M4:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 191;
			END_IF	
				
				
			
		191:	
			SC_P1_StoperSrobovania.StepName:='191 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 195;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 193;
				END_IF	
			END_IF	
			
			
			
		193:
			SC_P1_StoperSrobovania.StepName:='193 - Automaticky Rezim - model 45F kontrola stavu zaskrutkovania skrutky M4 pre DPS';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_SkrutkaDPS_M4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_SkrutkaDPS_M4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_SkrutkaDPS_M4:= REAL_TO_STRING(P1_Srobovanie.STAV.M4_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_SkrutkaDPS_M4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_Uhol_ToleranciaMIN);
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_SkrutkaDPS_M4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_SkrutkaDPS_M4:= UDINT_TO_STRING(P1_Srobovanie.STAV.M4_DosiahnutyUhol);
            
                   
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_45F_DPS_M4_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_SkrutkaDPS_M4);
				IF (P1_Skrutk_45F_DPS_M4_Vysunutie <= P1_RemPremenne.P1_Srob45F_DPS_M4_Vysunutie_HI) AND (P1_Skrutk_45F_DPS_M4_Vysunutie >= P1_RemPremenne.P1_Srob45F_DPS_M4_Vysunutie_LO) THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF          
            
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_SkrutkaDPS_M4:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 195;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_SkrutkaDPS_M4:= 'FAIL';
					IF P1_Srobov_M4_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 195;
					ELSE
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF
				END_IF
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_SkrutkaDPS_M4:= 'FAIL';
				IF P1_Srobov_M4_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 195;
				ELSE
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF
			END_IF
			
			
		195:
			SC_P1_StoperSrobovania.StepName:='195 - Automaticky Rezim - model 45F presun manipulatora vzad';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 196;
			END_IF	
			
		196:
			SC_P1_StoperSrobovania.StepName:='196 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND NOT P1_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 198;
			END_IF	
			
		
		198:
			SC_P1_StoperSrobovania.StepName:='198 - Automaticky Rezim - model 45F vystavenie signalu pre robota chod do cakacej pozicie';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Robot.COM_OUT.Presun_CakaciaPozicia:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P1_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				P1_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 200;
			END_IF
			
		200:
			SC_P1_StoperSrobovania.StepName:='200 - Inicializacia - model 45F kamerova kontrola paletky CAM6';//CAM 6//
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.Kamery_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 545;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 AND CAM6.STAV.Command_READY THEN
				CAM6.CMD.Triger:= TRUE;
				SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF CAM6.STAV.Results_READY AND CAM6.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 205;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM6.STAV.Results_READY:= FALSE;
				CAM6.CMD.Triger:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 203;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P1_Alarmy[168]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;     
			END_IF	
		
            
                   
            
            
            
		203:
			SC_P1_StoperSrobovania.StepName:='203 - Automaticky Rezim - model 45F cakam na opatovny triger kamery CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P1_StoperSrobovania.IdleTime.Q THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 200;
			END_IF		
			
		205:
			SC_P1_StoperSrobovania.StepName:='205 - Automaticky Rezim - model 45F kontrola vysledku kamery';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
            
				
			IF NOT CAM6.STAV.BUSY THEN
				CAM6.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF NOT CAM6.RESULT.Paletka.Pritom_SpodnyBusbar_4F AND
						CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30 AND
						CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30 THEN
						CAM6.PAR.ResultFotky:= 'PASS';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 208;
					ELSE 
						CAM6.PAR.ResultFotky:= 'FAIL';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 208;
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF NOT CAM6.RESULT.Paletka.Pritom_SpodnyBusbar_5F AND
						CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30 AND
						CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30 THEN
						CAM6.PAR.ResultFotky:= 'PASS';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 208;
					ELSE 
						CAM6.PAR.ResultFotky:= 'FAIL';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 208;
					END_IF
				END_IF	
			END_IF
			
       	
		
			
		208:
			SC_P1_StoperSrobovania.StepName:='208 - Automaticky Rezim - model 45F rozhodnutie podla kamerovej kontroly paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
           
			IF CAM6.PAR.ResultFotky = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 540;
			ELSIF CAM6.PAR.ResultFotky = 'FAIL' THEN
				P1_Vizu.ZobrazHL6_ST2:= TRUE;
				IF P1_Srobov_KAM_Result_OK THEN
					P1_Srobov_KAM_Result_OK:= FALSE;
					P1_Vizu.ZobrazHL6_ST2:= FALSE;
					CAM6.PAR.ResultFotky:= 'PASS';
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 540;
				ELSIF P1_Srobov_KAM_Result_NG THEN
					P1_Srobov_KAM_Result_NG:= FALSE;
					P1_Vizu.ZobrazHL6_ST2:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 540;    
				END_IF
			END_IF  
            
            
			
			
			
			
			
			
			//*********************************************Model 5H*******************************************************************//
		350:
			SC_P1_StoperSrobovania.StepName:='350 - Automaticky Rezim - model 5H kontrola vysledku kamery';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;	
            
                        
			IF NOT CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30 AND
				NOT CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30 THEN
				CAM6.PAR.ResultFotky:= 'PASS';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 353;
			ELSE 
				CAM6.PAR.ResultFotky:= 'FAIL';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 353;
			END_IF
			
		353:
			SC_P1_StoperSrobovania.StepName:='353 - Automaticky Rezim - model 5H rozhodnutie podla kamerovej kontroly paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
		         
			IF CAM6.PAR.ResultFotky = 'PASS' THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 355;
			ELSIF CAM6.PAR.ResultFotky = 'FAIL' THEN
				P1_Vizu.ZobrazHL7_ST2:= TRUE;
				IF P1_Srobov_KAM_Result_OK THEN
					P1_Srobov_KAM_Result_OK:= FALSE;
					P1_Vizu.ZobrazHL7_ST2:= FALSE;
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 355;
				ELSIF P1_Srobov_KAM_Result_NG THEN
					P1_Srobov_KAM_Result_NG:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P1_Vizu.ZobrazHL7_ST2:= FALSE;
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 540;    
				END_IF
			END_IF    
			           	
		355:			
			SC_P1_StoperSrobovania.StepName:='355 - Automaticky Rezim - model 5H vymazanie fotky CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
            
			IF Linka.KOM_FTP_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 360;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 THEN
				FTP_CAM6.CMD.VymazFotku:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM6.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM6.CMD.VymazFotku:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 360;
			ELSIF FTP_CAM6.STATUS.KomunikaciaError THEN
				P1_Alarmy[116]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF				
			
			
			
		360:
			SC_P1_StoperSrobovania.StepName:='360 - Automaticky Rezim - model 5H vystavenie signalu pre robota odober spodny busbar z paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#7s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#10s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			SC_P1_StoperSrobovania.IdleTime.IN:= P1_Robot.COM_IN.Stav_RobotOdoberaBusbary;
            
            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Robot.COM_OUT.OdoberSpodnyBusbar5H_z_Paletky:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF EDGEPOS(SC_P1_StoperSrobovania.IdleTime.Q)THEN
				IF PocetZopakovaniOdobratia <= 3 THEN
					P1_Robot.COM_OUT.ZopakujOdoberanie:= TRUE;
				END_IF     
				PocetZopakovaniOdobratia:= PocetZopakovaniOdobratia + 1;
			END_IF    
            
			IF NOT P1_Robot.COM_IN.Stav_RobotOdoberaBusbary THEN
				P1_Robot.COM_OUT.ZopakujOdoberanie:= FALSE;
			END_IF    
            
            
			IF P1_Robot.COM_IN.Stav_SpodnyBusbar5H_Odobraty AND NOT P1_Robot.COM_IN.Stav_SpodnyBusbar5H_Polozeny THEN
				P1_Robot.STAV.DrziBusbar_5H:= TRUE;
				P1_Robot.COM_OUT.OdoberSpodnyBusbar5H_z_Paletky:= FALSE;
				P1_Robot.COM_OUT.ZopakujOdoberanie:= FALSE;
				PocetZopakovaniOdobratia:= 0;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 363;
			ELSIF NOT P1_Robot.COM_IN.Stav_ProgramRUN THEN
				P1_Alarmy[145]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF PocetZopakovaniOdobratia > 3 THEN
				P1_Alarmy[160]:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 500;
			END_IF	
	
		
		363:
			SC_P1_StoperSrobovania.StepName:='363 - Automaticky Rezim - model 5H vystavenie signalu pre robota poloz spodny busbar na PowerCP';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Robot.COM_OUT.PolozSpodnyBusbar5H_na_PowerCP:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P1_Robot.COM_IN.Stav_SpodnyBusbar5H_Polozeny THEN
				P1_Robot.STAV.DrziBusbar_5H:= FALSE;
				P1_Robot.COM_OUT.PolozSpodnyBusbar5H_na_PowerCP:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 365;
			ELSIF NOT P1_Robot.COM_IN.Stav_ProgramRUN THEN
				P1_Alarmy[145]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF		
			
		
		365:
			SC_P1_StoperSrobovania.StepName:='365 - Automaticky Rezim - model 5H vystavenie signalu zaskrutkuj lavú skrutku K30';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
		
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_K30:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_K30:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 366;
			END_IF		
		
		366:
			SC_P1_StoperSrobovania.StepName:='366 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 370;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 368;
				END_IF	
			END_IF	
			
		
		368:
			SC_P1_StoperSrobovania.StepName:='368 - Automaticky Rezim - model 5H kontrola stavu zaskrutkovania lavej skrutky K30';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                         
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_LavaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_LavaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_LavaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_DosiahnutyUhol);
            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_5H_LavaK30_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaK30);
				IF (P1_Skrutk_5H_LavaK30_Vysunutie <= P1_RemPremenne.P1_Srob5H_LavaK30_Vysunutie_HI) AND (P1_Skrutk_5H_LavaK30_Vysunutie >= P1_RemPremenne.P1_Srob5H_LavaK30_Vysunutie_LO) THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF  
            
            
            
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaK30:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 370;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaK30:= 'FAIL';
					IF P1_Srobov_K30_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 370;
					ELSE	
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF
				END_IF
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaK30:= 'FAIL';
				IF P1_Srobov_K30_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 370;
				ELSE	
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF
			END_IF
		
		
		370:
			SC_P1_StoperSrobovania.StepName:='370 - Automaticky Rezim - model 5H vystavenie signalu zaskrutkuj pravu skrutku K30';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
		
			
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_K30:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_K30:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 371;
			END_IF		
		
		371:
			SC_P1_StoperSrobovania.StepName:='371 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 375;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 373;
				END_IF	
			END_IF	
		
		
		373:
			SC_P1_StoperSrobovania.StepName:='373 - Automaticky Rezim - model 5H kontrola stavu zaskrutkovania pravej skrutky K30';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                       
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.STAV.K30_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_PravaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_PravaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_PravaSkrutkaK30:= UDINT_TO_STRING(P1_Srobovanie.STAV.K30_DosiahnutyUhol);
            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_5H_PravaK30_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaK30);
				IF (P1_Skrutk_5H_PravaK30_Vysunutie <= P1_RemPremenne.P1_Srob5H_PravaK30_Vysunutie_HI) AND (P1_Skrutk_5H_PravaK30_Vysunutie >= P1_RemPremenne.P1_Srob5H_PravaK30_Vysunutie_LO) THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF      
            
            
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaK30:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 375;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaK30:= 'FAIL';
					IF P1_Srobov_K30_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 375;
					ELSE	
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF
				END_IF 
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaK30:= 'FAIL';
				IF P1_Srobov_K30_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 375;
				ELSE	
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF
			END_IF
		
		
		375:
			SC_P1_StoperSrobovania.StepName:='375 - Automaticky Rezim - model 5H vystavenie signalu zaskrutkuj strednu skrutku M5';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
			
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednu_M5:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednu_M5:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 376;
			END_IF		
			
		376:
			SC_P1_StoperSrobovania.StepName:='376 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 380;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 378;
				END_IF	
			END_IF	
		
		
		378:
			SC_P1_StoperSrobovania.StepName:='378 - Automaticky Rezim - model 5H kontrola stavu zaskrutkovania strednej skrutky M5';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                 
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_StrednaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_StrednaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_StrednaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_StrednaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_Uhol_ToleranciaMIN);
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_StrednaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_StrednaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_DosiahnutyUhol);
                        
            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_5H_StrednaM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_StrednaSkrutkaM5);
				IF (P1_Skrutk_5H_StrednaM5_Vysunutie <= P1_RemPremenne.P1_Srob5H_StrednaM5_Vysunutie_HI) AND (P1_Skrutk_5H_StrednaM5_Vysunutie >= P1_RemPremenne.P1_Srob5H_StrednaM5_Vysunutie_LO) THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF   
            
            
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_StrednaSkrutkaM5:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 380;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_StrednaSkrutkaM5:= 'FAIL';
					IF P1_Srobov_M5_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 380;
					ELSE
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF
				END_IF	
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_StrednaSkrutkaM5:= 'FAIL';
				IF P1_Srobov_M5_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 380;
				ELSE
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF
			END_IF	
		
		
		380:
			SC_P1_StoperSrobovania.StepName:='380 - Automaticky Rezim - model 5H vystavenie signalu zaskrutkuj lavú skrutku M5';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
			
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_M5:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_M5:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 381;
			END_IF	
		
		381:
			SC_P1_StoperSrobovania.StepName:='381 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 385;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 383;
				END_IF	
			END_IF	
		
		
		383:
			SC_P1_StoperSrobovania.StepName:='383 - Automaticky Rezim - model 5H kontrola stavu zaskrutkovania lavej skrutky M5';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_LavaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_LavaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_LavaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_LavaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_Uhol_ToleranciaMIN);
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_LavaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_LavaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_DosiahnutyUhol);
           
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_5H_LavaM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaM5);
				IF (P1_Skrutk_5H_LavaM5_Vysunutie <= P1_RemPremenne.P1_Srob5H_LavaM5_Vysunutie_HI) AND (P1_Skrutk_5H_LavaM5_Vysunutie >= P1_RemPremenne.P1_Srob5H_LavaM5_Vysunutie_LO) THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF  
            
            
            
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaM5:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 385;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaM5:= 'FAIL';
					IF P1_Srobov_M5_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 385;
					ELSE
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF
				END_IF
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaM5:= 'FAIL';
				IF P1_Srobov_M5_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 385;
				ELSE
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF
			END_IF
		
		
		385:
			SC_P1_StoperSrobovania.StepName:='385 - Automaticky Rezim - model 5H vystavenie signalu zaskrutkuj pravu skrutku M5';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
						
			
			
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= '';
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_M5:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_M5:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 386;
			END_IF		
		
		386:
			SC_P1_StoperSrobovania.StepName:='386 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.SkrutkovanieResult_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 390;
				ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				ELSE	
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 387;
				END_IF	
			END_IF	
		
		
		387:
			SC_P1_StoperSrobovania.StepName:='387 - Automaticky Rezim - model 5H kontrola stavu zaskrutkovania pravej skrutky M5';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_PravaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_PravaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P1_PravaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_PravaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_Uhol_ToleranciaMIN);
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_PravaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_PravaSkrutkaM5:= UDINT_TO_STRING(P1_Srobovanie.STAV.M5_DosiahnutyUhol);
            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Skrutk_5H_PravaM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaM5);
				IF (P1_Skrutk_5H_PravaM5_Vysunutie <= P1_RemPremenne.P1_Srob5H_PravaM5_Vysunutie_HI) AND (P1_Skrutk_5H_PravaM5_Vysunutie >= P1_RemPremenne.P1_Srob5H_PravaM5_Vysunutie_LO) THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF  
            
            
            
			IF P1_Srobovanie.STAV.Vysledok_Srobovania = 'OK' THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaM5:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 390;
				ELSE
					Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaM5:= 'FAIL';
					IF P1_Srobov_M5_Result_OFF THEN
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 390;
					ELSE
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 500;
					END_IF
				END_IF	
			ELSIF P1_Srobovanie.STAV.Vysledok_Srobovania = 'NG' THEN
				Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaM5:= 'FAIL';
				IF P1_Srobov_M5_Result_OFF THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 390;
				ELSE
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 500;
				END_IF
			END_IF	
		
		
		390:
			SC_P1_StoperSrobovania.StepName:='390 - Automaticky Rezim - model 5H presun manipulatora vzad';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1  THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 391;
			END_IF
		
		391:
			SC_P1_StoperSrobovania.StepName:='391 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny AND NOT P1_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 393;
			END_IF	
		
		393:
			SC_P1_StoperSrobovania.StepName:='393 - Automaticky Rezim - model 5H vystavenie signalu pre robota chod do cakacej pozicie';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Robot.COM_OUT.Presun_CakaciaPozicia:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P1_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				P1_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 395;
			END_IF	
		
		
		395:
			SC_P1_StoperSrobovania.StepName:='395 - Inicializacia - model 5H kamerova kontrola paletky CAM6';//CAM 6//
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF Linka.Kamery_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 545;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 AND CAM6.STAV.Command_READY THEN
				CAM6.CMD.Triger:= TRUE;
				SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
		
			IF CAM6.STAV.Results_READY AND CAM6.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 398;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM6.STAV.Results_READY:= FALSE;
				CAM6.CMD.Triger:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 397;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P1_Alarmy[168]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;    
			END_IF	
            
		
		397:
			SC_P1_StoperSrobovania.StepName:='397 - Automaticky Rezim - cakam na opatovny triger kamery CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF SC_P1_StoperSrobovania.IdleTime.Q THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 395;
			END_IF		
		
		398:
			SC_P1_StoperSrobovania.StepName:='398 - Automaticky Rezim - model 5H kontrola vysledku kamery';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;	
            
            
			IF NOT CAM6.STAV.BUSY THEN
				CAM6.CMD.Triger:= FALSE;
				IF NOT CAM6.RESULT.Paletka.Pritom_KrytuBusbarov_5H AND
					NOT CAM6.RESULT.Paletka.Pritom_SpodnychBusbarov_5H AND
					CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30 AND
					CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30 THEN
					CAM6.PAR.ResultFotky:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 403;
				ELSE 
					CAM6.PAR.ResultFotky:= 'FAIL';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 403;
				END_IF
			END_IF
			
       
			
		403:
			SC_P1_StoperSrobovania.StepName:='403 - Automaticky Rezim - model 5H rozhodnutie podla kamerovej kontroly paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
					
			IF CAM6.PAR.ResultFotky = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 540;
			ELSIF CAM6.PAR.ResultFotky = 'FAIL' THEN
				P1_Vizu.ZobrazHL8_ST2:= TRUE;
				IF P1_Srobov_KAM_Result_OK THEN
					P1_Srobov_KAM_Result_OK:= FALSE;
					P1_Vizu.ZobrazHL8_ST2:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					CAM6.PAR.ResultFotky:= 'PASS';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 540;
				ELSIF P1_Srobov_KAM_Result_NG THEN
					P1_Srobov_KAM_Result_NG:= FALSE;
					P1_Vizu.ZobrazHL8_ST2:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 540;    
				END_IF
			END_IF  
		
			//**************************Uvolnenie robota a vyfotenie paletky po zlom skrutkovaní*****************************************************//	
		
		
		500:
			SC_P1_StoperSrobovania.StepName:='500 - Automaticky Rezim - presun manipulatora vzad';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			            
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				P1_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 501;
			END_IF
		
		501:
			SC_P1_StoperSrobovania.StepName:='501 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 503;
			END_IF	
			
			
			
			
		503:
			SC_P1_StoperSrobovania.StepName:='503 - Automaticky Rezim - kontrola ci robot drzi foamy';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				IF P1_Robot.STAV.DrziFoamy_45F THEN
					P1_Robot.COM_OUT.PolozFoam4F_na_PowerCP:= TRUE;
					IF P1_Robot.COM_IN.Stav_Foam4F_Polozeny THEN
						P1_Robot.COM_OUT.PolozFoam4F_na_PowerCP:= FALSE;
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 505;
					END_IF
				ELSE    
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 505;
				END_IF
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				IF P1_Robot.STAV.DrziFoamy_45F THEN
					P1_Robot.COM_OUT.PolozFoam5F_na_PowerCP:= TRUE;
					IF P1_Robot.COM_IN.Stav_Foam5F_Polozeny THEN
						P1_Robot.COM_OUT.PolozFoam5F_na_PowerCP:= FALSE;
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 505;
					END_IF
				ELSE    
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 505;
				END_IF 
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN  
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 505;
			END_IF   
			
		
           
            
		505:
			SC_P1_StoperSrobovania.StepName:='505 - Automaticky Rezim - kontrola ci robot drzi busbary';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				IF P1_Robot.STAV.DrziBusbar_45F THEN
					P1_Robot.COM_OUT.PolozSpodnyBusbar4F_na_PowerCP:= TRUE;
					IF P1_Robot.COM_IN.Stav_SpodnyBusbar4F_Polozeny THEN
						P1_Robot.COM_OUT.PolozSpodnyBusbar4F_na_PowerCP:= FALSE;
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 508;
					END_IF
				ELSE    
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 508;
				END_IF
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				IF P1_Robot.STAV.DrziBusbar_45F THEN
					P1_Robot.COM_OUT.PolozSpodnyBusbar5F_na_PowerCP:= TRUE;
					IF P1_Robot.COM_IN.Stav_SpodnyBusbar5F_Polozeny THEN
						P1_Robot.COM_OUT.PolozSpodnyBusbar5F_na_PowerCP:= FALSE;
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 508;
					END_IF
				ELSE    
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 508;
				END_IF   
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
				IF P1_Robot.STAV.DrziBusbar_5H THEN
					P1_Robot.COM_OUT.PolozSpodnyBusbar5H_na_PowerCP:= TRUE;
					IF P1_Robot.COM_IN.Stav_SpodnyBusbar5H_Polozeny THEN
						P1_Robot.COM_OUT.PolozSpodnyBusbar5H_na_PowerCP:= FALSE;
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 510;
					END_IF
				ELSE    
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 510;
				END_IF 
			END_IF    
            
            
		508:
			SC_P1_StoperSrobovania.StepName:='508 - Automaticky Rezim - kontrola ci robot drzi DPS';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				IF P1_Robot.STAV.DrziDPS_45F THEN
					P1_Robot.COM_OUT.PolozDPS_4F_na_PowerCP:= TRUE;
					IF P1_Robot.COM_IN.Stav_DPS_4F_Polozeny THEN
						P1_Robot.COM_OUT.PolozDPS_4F_na_PowerCP:= FALSE;
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 510;
					END_IF
				ELSE    
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 510;
				END_IF
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				IF P1_Robot.STAV.DrziDPS_45F THEN
					P1_Robot.COM_OUT.PolozDPS_5F_na_PowerCP:= TRUE;
					IF P1_Robot.COM_IN.Stav_DPS_5F_Polozeny THEN
						P1_Robot.COM_OUT.PolozDPS_5F_na_PowerCP:= FALSE;
						SC_P1_StoperSrobovania.ResetStep:= TRUE;
						SC_P1_StoperSrobovania.Step:= 510;
					END_IF
				ELSE    
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 510;
				END_IF   
			END_IF    
            
            
            
		510:	
			SC_P1_StoperSrobovania.StepName:='510 - Automaticky Rezim - vystavenie signalu pre robota chod do cakacej pozicie';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				P1_Robot.COM_OUT.Presun_CakaciaPozicia:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			IF P1_Robot.COM_IN.Stav_RobotPoziciaCakania THEN
				P1_Robot.COM_OUT.Presun_CakaciaPozicia:= FALSE;
				CAM6.STAV.Results_READY:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 513;
			END_IF	
			
			
			
		513:
			SC_P1_StoperSrobovania.StepName:='513 - Automaticky Rezim - kamerova kontrola paletky CAM6';//CAM 6//
			SC_P1_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Linka.Kamery_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 540;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 AND CAM6.STAV.Command_READY THEN
				CAM6.CMD.Triger:= TRUE;
				SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			
			IF CAM6.STAV.Results_READY AND CAM6.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM6.STAV.Results_READY:= FALSE;
				CAM6.PAR.ResultFotky:= 'FAIL';
				CAM6.CMD.Triger:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 540;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM6.STAV.Results_READY:= FALSE;
				CAM6.CMD.Triger:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 515;
			ELSIF SC_P1_StoperSrobovania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P1_Alarmy[168]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;      
			END_IF	
			
            
                 
            
            
            
            
		515:
			SC_P1_StoperSrobovania.StepName:='506 - Automaticky Rezim - cakam na opatovny triger kamery CAM6';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#1s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P1_StoperSrobovania.IdleTime.IN:= TRUE;
            
			IF SC_P1_StoperSrobovania.IdleTime.Q THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 513;
			END_IF	
		
		
		
		
			//**************************Odoslanie fotiek na server************************************//		
		
		
		540:
			SC_P1_StoperSrobovania.StepName:='540 - Automaticky Rezim - odoslanie fotiek na server Panasonic';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 545;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 THEN
				FTP_CAM6.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM6.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM6.INPUTS.Result:= CAM6.PAR.ResultFotky;
				Reports.Kamery.P1_CAM6_KontrolaPaletky:= CAM6.PAR.ResultFotky;
				FTP_CAM6.CMD.OdosliFotku:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
            
			
			IF FTP_CAM6.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM6.CMD.OdosliFotku:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 545;
			ELSIF FTP_CAM6.STATUS.KomunikaciaError THEN
				P1_Alarmy[116]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
		
	
			//******************Odcentrovanie paletky************************************//				
		545:
			SC_P1_StoperSrobovania.StepName:='545 - Automaticky Rezim - odcentrovanie paletky';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P1_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 550;
			END_IF   
				
		
		
		
		
			//**************************Odoslanie dát na server******************************************//	
		
		550:
			SC_P1_StoperSrobovania.StepName:='550 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 560;
			ELSIF NOT SC_P1_StoperSrobovania.Switch1 THEN
				TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaUkoncena THEN
				TRCB_P1_Srobovanie_ST2.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 552;
			ELSIF TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaError THEN	
				P1_Alarmy[114]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
			
		552:
			SC_P1_StoperSrobovania.StepName:='552 - Automaticky Rezim - kontrola odpovede servera';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 552;	
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 552;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 552;
				END_IF   
			END_IF
			
			
		555:
			SC_P1_StoperSrobovania.StepName:='555 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#10s;
			
			IF NOT SC_P1_StoperSrobovania.Switch1 THEN
				TRCB_P1_Srobovanie_ST2.CMD.OdosliStavPaletky_TYP2:= TRUE;
				SC_P1_StoperSrobovania.Switch1:= TRUE;
			END_IF			
			
			IF TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaUkoncena THEN
				TRCB_P1_Srobovanie_ST2.CMD.OdosliStavPaletky_TYP2:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 556;
			ELSIF TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaError THEN	
				P1_Alarmy[114]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
			
		556:
			SC_P1_StoperSrobovania.StepName:='556 - Automaticky Rezim - kontrola odpovede servera'; 
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#10s;
	
			IF NOT TRCB_P1_Srobovanie_ST2.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Srobovanie_ST2.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 560;
				ELSIF TRCB_P1_Srobovanie_ST2.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P1_StoperSrobovania.ResetStep:= TRUE;
					SC_P1_StoperSrobovania.Step:= 560;
				END_IF	
			END_IF
		
		
				
			
			
			//***********************************Vyvezenie paletky**************************************************//			
			
		560:
			SC_P1_StoperSrobovania.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na akumulacny stoper';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
            
            
            
			IF P1_StoperSrobovania.KoniecCyklu THEN
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 0;
			ELSIF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 0;
			ELSIF NOT P1_AkumulacnyStoper.IN.PritomnostPaletky AND SC_P1_AkumulacnyStoper.Step = 100 AND NOT P1_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky THEN
				P1_StoperSrobovania.OUT.ZasunStoper:= TRUE;
				P1_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 561;
			END_IF	
		
		
		561:
			SC_P1_StoperSrobovania.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na akumulacny stoper';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#10s;
		
			SC_P1_StoperSrobovania.AlarmTime.IN:= P1_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			SC_P1_StoperSrobovania.IdleTime.IN:= NOT P1_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			
			IF NOT P1_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				CisloFotky:= 0;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaK30:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaK30:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_ZadnaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PrednaSkrutkaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_SkrutkaDPS_M4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P1_StrednaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P1_StrednaSkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P1_StrednaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyslednyReport.P1_StrednaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P1_StrednaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P1_StrednaSkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P1_StrednaSkrutkaM5:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P1_StrednaSkrutkaM5:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_StrednaSkrutkaM5:= '';
				Reports.Kamery.P1_CAM6_KontrolaPaletky:= '';
				P1_Robot.STAV.DrziBusbar_45F:= FALSE;
				P1_Robot.STAV.DrziBusbar_5H:= FALSE;
				P1_Robot.STAV.DrziDPS_45F:= FALSE;
				P1_Robot.STAV.DrziFoamy_45F:= FALSE;
				P1_StoperSrobovania.OUT.ZasunStoper:= FALSE;
				SC_P1_StoperSrobovania.ResetStep:= TRUE;
				SC_P1_StoperSrobovania.Step:= 100;
			ELSIF SC_P1_StoperSrobovania.AlarmTime.Q THEN
				P1_Alarmy[161]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF     
                         
          			
			//*******************************************************Manuálny režim*******************************************************************************//	
			
		700:
			SC_P1_StoperSrobovania.StepName:='700 - Manualny Rezim';
			SC_P1_StoperSrobovania.IdleTime.PT:= T#8s;
			SC_P1_StoperSrobovania.AlarmTime.PT:= T#5s;
		
		
		
		
		
	
	END_CASE
			END_PROGRAM

PROGRAM _EXIT
			(* Insert code here *)
	 
			END_PROGRAM

