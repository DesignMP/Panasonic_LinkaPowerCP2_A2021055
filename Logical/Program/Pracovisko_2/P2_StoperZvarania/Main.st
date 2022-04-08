
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_StoperZvarania);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	IOLinkKomunikacia;
	
	
	//Reset sekcie //
	IF P2_StoperZvarania.Reset THEN
		SC_P2_StoperZvarania.Step:= 0;
		P2_StoperZvarania.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P2_StoperZvarania.Step:= 0;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		SC_P2_StoperZvarania.Step:= 0;
	END_IF	
	
	
	CASE SC_P2_StoperZvarania.Step OF 
	
	
		0:
			SC_P2_StoperZvarania.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			P2_StoperZvarania.Automat:= FALSE;
			P2_StoperZvarania.KoniecCyklu:= FALSE;
			P2_StoperZvarania.Manual:= FALSE;
			P2_StoperZvarania.STAV.PoINIT:= FALSE;
			P2_StoperZvarania.OUT.ZasunStoper:= FALSE;
			P2_StoperZvarania.RFID_hlava.PrecitajChipRFID:= FALSE;
			P2_Zvaranie.COM_IN.Zvaranie_START:= FALSE;
			P2_Zvaranie.COM_IN.Zatlacanie_START:= FALSE;
			P2_Cistenie.COM_IN.Cistenie_START:= FALSE;
			P2_Robot.COM_OUT.Odober_LavyMvCase4F:= FALSE;
			P2_Robot.COM_OUT.Odober_LavyMvCase5F:= FALSE;
			P2_Robot.COM_OUT.Odober_LavyMvCase5H:= FALSE;
			P2_Robot.COM_OUT.Odober_PravyMvCase4F:= FALSE;
			P2_Robot.COM_OUT.Odober_PravyMvCase5F:= FALSE;
			P2_Robot.COM_OUT.Odober_PravyMvCase5H:= FALSE;
			P2_Robot.COM_OUT.Odober_TopCover4F:= FALSE;
			P2_Robot.COM_OUT.Odober_TopCover5F:= FALSE;
			P2_Robot.COM_OUT.Odober_TopCover5H:= FALSE;
			P2_Robot.COM_OUT.Poloz_LavyMvCase4F:= FALSE;
			P2_Robot.COM_OUT.Poloz_PravyMvCase4F:= FALSE;
			P2_Robot.COM_OUT.Poloz_LavyMvCase5F:= FALSE;
			P2_Robot.COM_OUT.Poloz_PravyMvCase5F:= FALSE;
			P2_Robot.COM_OUT.Poloz_LavyMvCase5H:= FALSE;
			P2_Robot.COM_OUT.Poloz_PravyMvCase5H:= FALSE;
			P2_Robot.COM_OUT.Poloz_TopCover4F:= FALSE;
			P2_Robot.COM_OUT.Poloz_TopCover5F:= FALSE;
			P2_Robot.COM_OUT.Poloz_TopCover5H:= FALSE;
			P2_Robot.COM_OUT.Cistenie_OdoberPowerCP_4F:= FALSE;
			P2_Robot.COM_OUT.Cistenie_OdoberPowerCP_5F:= FALSE;
			P2_Robot.COM_OUT.Cistenie_OdoberPowerCP_5H:= FALSE;
			P2_Robot.COM_OUT.Cistenie_OtacajPowerCP:= FALSE;
			P2_Robot.COM_OUT.Cistenie_PolozPowerCP_4F:= FALSE;
			P2_Robot.COM_OUT.Cistenie_PolozPowerCP_5F:= FALSE;
			P2_Robot.COM_OUT.Cistenie_PolozPowerCP_5H:= FALSE;
			P2_Robot.COM_OUT.ZopakujOdoberanie:= FALSE;
			P2_Robot.COM_OUT.ZmenaGripra_4F5F:= FALSE;
			P2_Robot.COM_OUT.ZmenaGripra_5H:= FALSE;
			CAM11.CMD.Triger:= FALSE;
			CAM11.STAV.Results_READY:= FALSE;
			FTP_CAM11.CMD.OdosliFotku:= FALSE;
			FTP_CAM11.CMD.VymazFotku:= FALSE;
			CAM12.CMD.Triger:= FALSE;
			CAM12.STAV.Results_READY:= FALSE;
			FTP_CAM12.CMD.OdosliFotku:= FALSE;
			FTP_CAM12.CMD.VymazFotku:= FALSE;
			TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P2_Zvaranie_ST6.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P2_Zvaranie_ST6.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPanatrace_TYP4:= FALSE;		
			P2_Zvaranie_KAM_Result_OK:= FALSE;
			P2_Zvaranie_KAM_Result_NG:= FALSE;
			P2_Vizu.ZobrazHL1_ST6:= FALSE;
			P2_Vizu.ZobrazHL2_ST6:= FALSE;
			P2_Vizu.ZobrazHL3_ST6:= FALSE;
			P2_Vizu.ZobrazHL4_ST6:= FALSE;
			P2_Vizu.ZobrazHL5_ST6:= FALSE;
			P2_Vizu.ZobrazHL6_ST6:= FALSE;
			P2_Vizu.ZobrazHL7_ST6:= FALSE;
			P2_Vizu.ZobrazHL8_ST6:= FALSE;
			TRCB_P2_Zvaranie_OpatovnyDopyt:= FALSE;
			TRCB_P2_Zvaranie_PaletkaNG:= FALSE;
			PocetTrigrovKamery:= 0;
			PocetDopytovNaServer:= 0;
			CisloFotky:= 0;
			PocetZopakovaniOdobratia:= 0;
			TestovaciKus:= FALSE;
			P2_StoperZvarania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_Robot.STAV.Zvaranie_PrebiehaManipulacia:= FALSE;
					
            
            
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P2_ZonaBunky_AKTIVNA AND
				P2_Pracovisko.STAV.HardwareBunky_OK AND 
				NOT P2_Pracovisko.STAV.Porucha_ST2 AND
				NOT P2_Pracovisko.STAV.Porucha_ST3 AND
				NOT P2_Pracovisko.STAV.Porucha_ST4 AND
				NOT P2_Pracovisko.STAV.Porucha_ST5 THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 1;
			END_IF
	
		1:
			SC_P2_StoperZvarania.StepName:='1 - Cakam na spustenie vyroby';
			P2_StoperZvarania.KoniecCyklu:= FALSE;
			IF P2_StoperZvarania.Automat THEN
				SC_P2_StoperZvarania.Step:= 2;
			ELSIF P2_StoperZvarania.Manual THEN
				SC_P2_StoperZvarania.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		
		2:
			SC_P2_StoperZvarania.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_StoperZvarania.IdleTime.PT:= T#4s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
									
			IF P2_Zvaranie.STAV.PoINIT AND P2_Cistenie.STAV.PoINIT AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie AND P2_Dopravniky.STAV.PoINIT THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 3;
			END_IF
		
		3:
			SC_P2_StoperZvarania.StepName:='3 - Inicializacia - vymazanie adresarov kamier';
			SC_P2_StoperZvarania.IdleTime.PT:= T#4s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;	
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 10;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 THEN
				FTP_CAM11.CMD.VymazFotku:= TRUE;
				FTP_CAM12.CMD.VymazFotku:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM11.STATUS.KomunikaciaUkoncena AND FTP_CAM12.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM11.CMD.VymazFotku:= FALSE;
				FTP_CAM12.CMD.VymazFotku:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 10;
			ELSIF FTP_CAM11.STATUS.KomunikaciaError THEN
				P2_Alarmy[234]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			ELSIF FTP_CAM12.STATUS.KomunikaciaError THEN
				P2_Alarmy[235]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
			
	
		10:
			SC_P2_StoperZvarania.StepName:='10 - Inicializacia - zasunutie centrovacky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#4s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperZvarania.IN.Centrovanie_ZASUNUTE AND P2_Dopravniky.STAV.PoINIT THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 13;
			END_IF	
			
			
			
	
	
		13:
			SC_P2_StoperZvarania.StepName:='6 - Inicializacia - hladanie paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
	
			IF P2_StoperZvarania.RFID_hlava.PritomnostPaletky THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 20;		 
			ELSIF SC_P2_StoperZvarania.IdleTime.Q THEN
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 100;
			END_IF
		
		
		20:
			SC_P2_StoperZvarania.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
		
			SC_P2_StoperZvarania.IdleTime.IN:= P2_StoperZvarania.RFID_hlava.PritomnostPaletky;
									
			IF SC_P2_StoperZvarania.IdleTime.Q AND NOT SC_P2_StoperZvarania.Switch1 THEN
				P2_StoperZvarania.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
			
			IF P2_StoperZvarania.RFID_hlava.Stav_CitanieZapis_OK AND P2_StoperZvarania.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P2_StoperZvarania.RFID_hlava.PrecitaneCisloPaletky;
				P2_StoperZvarania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 23;
			END_IF	
			
		23:
			SC_P2_StoperZvarania.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P2_StoperZvarania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 30;
			ELSE
				P2_Alarmy[219]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		
		
		30:
			SC_P2_StoperZvarania.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_6' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_6' THEN 
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_6' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_6' THEN
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;	
			END_IF	
            
		33:
			SC_P2_StoperZvarania.StepName:='33 - Inicializacia - kontrola uzavretia komunikacie'; 
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;
			ELSE
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 38;
			END_IF	
			
					
		38:
			SC_P2_StoperZvarania.StepName:='38 - Inicializacia - kontrola odoslania fotiek';
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;   
            
			IF Paletka[i].STAV.OdoslanieFotiek_DONE THEN
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 550;
			ELSE
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 40;
			END_IF	
            
         
		40:
			SC_P2_StoperZvarania.StepName:='40 - Inicializacia - zacentrovanie paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperZvarania.IN.Centrovanie_VYSUNUTE THEN
				CAM12.STAV.Results_READY:= FALSE;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 45;
			END_IF	    
            
            
		45:
			SC_P2_StoperZvarania.StepName:='45 - Inicializacia - kamerova kontrola paletky CAM12'; //CAM 12//
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;      
            
			IF Linka.P2_Kamery_OFF THEN
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 208;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 208;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 407;
				END_IF   
			ELSIF NOT SC_P2_StoperZvarania.Switch1 AND CAM12.STAV.Command_READY AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie THEN
				CAM12.CMD.Triger:= TRUE;
				SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
		
			IF CAM12.STAV.Results_READY AND CAM12.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM12.STAV.Results_READY:= FALSE;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 50;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM12.STAV.Results_READY:= FALSE;
				CAM12.CMD.Triger:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 48;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[297]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
		
            
            
            
            
            
            
		48:
			SC_P2_StoperZvarania.StepName:='48 - Inicializacia - cakam na opatovny triger kamery CAM12';
			SC_P2_StoperZvarania.IdleTime.PT:= T#1s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;   
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 45;
			END_IF
            
            
		50:
			SC_P2_StoperZvarania.StepName:='50 - Inicializacia - kamerova kontrola PowerCP CAM11';//CAM 11//
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
		
			IF NOT CAM12.STAV.BUSY THEN
				CAM12.CMD.Triger:= FALSE;
				IF NOT SC_P2_StoperZvarania.Switch1 AND CAM11.STAV.Command_READY AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie THEN
					CAM11.CMD.Triger:= TRUE;
					SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
					SC_P2_StoperZvarania.Switch1:= TRUE;
				END_IF
			END_IF
		
			IF CAM11.STAV.Results_READY AND CAM11.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 55;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM11.CMD.Triger:= FALSE;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 53;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[296]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;       
			END_IF	
			
            
                
            
            
            
		53:
			SC_P2_StoperZvarania.StepName:='53 - Inicializacia - cakam na opatovny triger kamery CAM11';
			SC_P2_StoperZvarania.IdleTime.PT:= T#1s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;   
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 50;
			END_IF
       
            
		55:
			SC_P2_StoperZvarania.StepName:='50 - Inicializacia - kontrola vysledku kamery podla typu modelu';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
			IF NOT CAM11.STAV.BUSY THEN
				CAM11.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF CAM12.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM12.RESULT.Paletka.Pritomn_PravyMVcase AND
						CAM12.RESULT.Paletka.Pritomn_TopCover_4F AND
						NOT CAM11.RESULT.PowerCP.Pritomn_LavyMVcase AND
						NOT CAM11.RESULT.PowerCP.Pritomn_PravyMVcase AND
						NOT CAM11.RESULT.PowerCP.Pritomn_TopCover_4F AND
						CAM11.RESULT.PowerCP.Pritomn_PowerCP_4F THEN
						CAM11.PAR.ResultFotky:= 'PASS';
						CAM12.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 58; 
					ELSE
						CAM11.PAR.ResultFotky:= 'FAIL';
						CAM12.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 58;
					END_IF	
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF CAM12.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM12.RESULT.Paletka.Pritomn_PravyMVcase AND
						CAM12.RESULT.Paletka.Pritomn_TopCover_5H5F AND
						NOT CAM11.RESULT.PowerCP.Pritomn_LavyMVcase AND
						NOT CAM11.RESULT.PowerCP.Pritomn_PravyMVcase AND
						NOT CAM11.RESULT.PowerCP.Pritomn_TopCover_5F AND
						CAM11.RESULT.PowerCP.Pritomn_PowerCP_5F THEN
						CAM11.PAR.ResultFotky:= 'PASS';
						CAM12.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 58;
					ELSE
						CAM11.PAR.ResultFotky:= 'FAIL';
						CAM12.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 58;
					END_IF	
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					IF CAM12.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM12.RESULT.Paletka.Pritomn_PravyMVcase AND
						CAM12.RESULT.Paletka.Pritomn_TopCover_5H5F AND
						NOT CAM11.RESULT.PowerCP.Pritomn_LavyMVcase AND
						NOT CAM11.RESULT.PowerCP.Pritomn_PravyMVcase AND
						NOT CAM11.RESULT.PowerCP.Pritomn_TopCover_5H AND
						CAM11.RESULT.PowerCP.Pritomn_PowerCP_5H THEN
						CAM11.PAR.ResultFotky:= 'PASS';
						CAM12.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 58; 
					ELSE
						CAM11.PAR.ResultFotky:= 'FAIL';
						CAM12.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 58;
					END_IF	
				END_IF
			END_IF    
            
            
		58:
			SC_P2_StoperZvarania.StepName:='58 - Inicializacia - vymazanie adresarov kamier';
			SC_P2_StoperZvarania.IdleTime.PT:= T#4s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;	
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 60;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 THEN
				FTP_CAM11.CMD.VymazFotku:= TRUE;
				FTP_CAM12.CMD.VymazFotku:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM11.STATUS.KomunikaciaUkoncena AND FTP_CAM12.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM11.CMD.VymazFotku:= FALSE;
				FTP_CAM12.CMD.VymazFotku:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 60;
			ELSIF FTP_CAM11.STATUS.KomunikaciaError THEN
				P2_Alarmy[234]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			ELSIF FTP_CAM12.STATUS.KomunikaciaError THEN
				P2_Alarmy[235]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
            
            
		60:
			SC_P2_StoperZvarania.StepName:='60 - Inicializacia - rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
            
			IF CAM11.PAR.ResultFotky = 'PASS' AND CAM12.PAR.ResultFotky = 'PASS' THEN
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 208;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 208;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 407;
				END_IF    
			ELSIF (CAM11.PAR.ResultFotky = 'FAIL' OR CAM12.PAR.ResultFotky = 'FAIL') THEN
				P2_StoperZvarania.STAV.PoINIT:= TRUE;
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 545;
			END_IF
            
                
		
			//********************************************************Automatický režim****************************************************************************//
		
		100:  
			SC_P2_StoperZvarania.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			SC_P2_StoperZvarania.IdleTime.IN:= P2_StoperZvarania.RFID_hlava.PritomnostPaletky;
			
			IF P2_StoperZvarania.RFID_hlava.PritomnostPaletky THEN
				P2_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF
                
			           
			IF P2_StoperZvarania.KoniecCyklu THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 0;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 101;
			END_IF
           
		
		101:
			SC_P2_StoperZvarania.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#500ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
		
            
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				i:= 0;
				P2_StoperZvarania.RFID_hlava.PrecitajChipRFID:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
			
					
			IF P2_StoperZvarania.RFID_hlava.Stav_CitanieZapis_OK AND P2_StoperZvarania.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P2_StoperZvarania.RFID_hlava.PrecitaneCisloPaletky;
				P2_StoperZvarania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 102;
			END_IF	
           
			
		102:
			SC_P2_StoperZvarania.StepName:='102 - Automaticky Rezim - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P2_StoperZvarania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 103;
			ELSE
				P2_Alarmy[219]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
		
					
		103:
			SC_P2_StoperZvarania.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_6' THEN
				TestovaciKus:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_6' THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_6' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_6' THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;
			END_IF		
			
		
		105:
			SC_P2_StoperZvarania.StepName:='105 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 120;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 THEN
				TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 106;
			ELSIF TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaError THEN	
				TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 115;
			END_IF	
			
		106:
			SC_P2_StoperZvarania.StepName:='106 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 106;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 106;	
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 106;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 106;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 106;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 106;
				END_IF   
			END_IF	
			
			
			
			
			
		108:
			SC_P2_StoperZvarania.StepName:='108 - Automaticky Rezim - vyziadanie stavu paletky zo servera, zacentrovanie paletky '; 
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
			
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				Centrovacku_VYSUN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 110;
			ELSIF TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaError THEN	
				TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 115;
			END_IF	
					
		
			
		110:
			SC_P2_StoperZvarania.StepName:='110 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;		
				
			IF NOT TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaUkoncena AND P2_StoperZvarania.IN.Centrovanie_VYSUNUTE THEN
				IF TRCB_P2_Zvaranie_ST6.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST6' THEN
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 120;
					ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = 'SMP;ST6' THEN
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 120;    
					END_IF    
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 115;
				END_IF	
			END_IF
		
            
		115:
			SC_P2_StoperZvarania.StepName:='115 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
            
            
			P2_Vizu.ZobrazHL8_ST6:= TRUE;
            
			IF TRCB_P2_Zvaranie_OpatovnyDopyt THEN
				TRCB_P2_Zvaranie_OpatovnyDopyt:= FALSE; 
				P2_Vizu.ZobrazHL8_ST6:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 105;
			ELSIF TRCB_P2_Zvaranie_PaletkaNG THEN
				TRCB_P2_Zvaranie_PaletkaNG:= FALSE;
				P2_Vizu.ZobrazHL8_ST6:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 116;
			END_IF   
            
            
            
            
            
		116:
			SC_P2_StoperZvarania.StepName:='116 - Automaticky Rezim - odcentrovanie paletky po odpovedi servera NG';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperZvarania.IN.Centrovanie_ZASUNUTE THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;
			END_IF	       
            
		
	
		120:
			SC_P2_StoperZvarania.StepName:='120 - Automaticky Rezim - zacentrovanie paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperZvarania.IN.Centrovanie_VYSUNUTE THEN
				IF TestovaciKus THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 130;
				ELSE   
					CAM12.STAV.Results_READY:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 122;
				END_IF
			END_IF		
			
			
		
		122:
			SC_P2_StoperZvarania.StepName:='122 - Automaticky Rezim - kamerova kontrola paletky CAM12';//CAM 12//
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
			IF Linka.P2_Kamery_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 130;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 AND CAM12.STAV.Command_READY AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie THEN
				CAM12.CMD.Triger:= TRUE;
				SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
		
			IF CAM12.STAV.Results_READY AND CAM12.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM12.STAV.Results_READY:= FALSE;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 125;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM12.STAV.Results_READY:= FALSE;
				CAM12.CMD.Triger:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 123;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[297]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE; 
			END_IF	
		
               
            
            
		123:
			SC_P2_StoperZvarania.StepName:='123 - Automaticky Rezim - cakam na opatovny triger kamery CAM12';
			SC_P2_StoperZvarania.IdleTime.PT:= T#1s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;   
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 122;
			END_IF
            
            
		125:
			SC_P2_StoperZvarania.StepName:='125 - Automaticky Rezim - kamerova kontrola PowerCP CAM11';//CAM 11//
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
		
			IF NOT CAM12.STAV.BUSY THEN
				CAM12.CMD.Triger:= FALSE;
				IF NOT SC_P2_StoperZvarania.Switch1 AND CAM11.STAV.Command_READY AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie THEN
					CAM11.CMD.Triger:= TRUE;
					SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
					SC_P2_StoperZvarania.Switch1:= TRUE;
				END_IF
			END_IF
		
			IF CAM11.STAV.Results_READY AND CAM11.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 130;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM11.CMD.Triger:= FALSE;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 126;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[296]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;  
			END_IF	
			
            
                       
            
            
		126:
			SC_P2_StoperZvarania.StepName:='126 - Automaticky Rezim - cakam na opatovny triger kamery CAM11';
			SC_P2_StoperZvarania.IdleTime.PT:= T#1s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;   
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 125;
			END_IF
       
            
            
       			

		130:
			SC_P2_StoperZvarania.StepName:='130 - Automaticky Rezim - rozhodnutie podla typu modelu';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
            
			IF Linka.PAR.ZvolenyModel = '4F'  THEN
				CAM11.STAV.Results_READY:= FALSE;
				IF TestovaciKus THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 210;  
				ELSIF Linka.P2_Kamery_OFF THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 208; 
				ELSE	
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 200;
				END_IF	
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				CAM11.STAV.Results_READY:= FALSE;
				IF TestovaciKus THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 210; 
				ELSIF Linka.P2_Kamery_OFF THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 208; 	
				ELSE	
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 200;
				END_IF	
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
				IF TestovaciKus THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 545;
				ELSIF Linka.P2_Kamery_OFF THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 407; 
				ELSE	
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 400; 
				END_IF	
			END_IF	
         
            
            
            
            
            

			
			
			//*************************Model 45F*********************************//	
		200:
			SC_P2_StoperZvarania.StepName:='200 - Automaticky Rezim - model 45F, kontrola vysledkov kamier';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
				
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				IF CAM12.RESULT.Paletka.Pritomn_LavyMVcase AND
					CAM12.RESULT.Paletka.Pritomn_PravyMVcase AND
					CAM12.RESULT.Paletka.Pritomn_TopCover_4F AND
					NOT CAM11.RESULT.PowerCP.Pritomn_LavyMVcase AND
					NOT CAM11.RESULT.PowerCP.Pritomn_PravyMVcase AND
					NOT CAM11.RESULT.PowerCP.Pritomn_TopCover_4F AND
					CAM11.RESULT.PowerCP.Pritomn_PowerCP_4F THEN
					CAM11.PAR.ResultFotky:= 'PASS';
					CAM12.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 203; 
				ELSE
					CAM11.PAR.ResultFotky:= 'FAIL';
					CAM12.PAR.ResultFotky:= 'FAIL';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 203;
				END_IF
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN	
				IF CAM12.RESULT.Paletka.Pritomn_LavyMVcase AND
					CAM12.RESULT.Paletka.Pritomn_PravyMVcase AND
					CAM12.RESULT.Paletka.Pritomn_TopCover_5H5F AND
					NOT CAM11.RESULT.PowerCP.Pritomn_LavyMVcase AND
					NOT CAM11.RESULT.PowerCP.Pritomn_PravyMVcase AND
					NOT CAM11.RESULT.PowerCP.Pritomn_TopCover_5F AND
					CAM11.RESULT.PowerCP.Pritomn_PowerCP_5F THEN
					CAM11.PAR.ResultFotky:= 'PASS';
					CAM12.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 203;
				ELSE
					CAM11.PAR.ResultFotky:= 'FAIL';
					CAM12.PAR.ResultFotky:= 'FAIL';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 203;
				END_IF	
			END_IF	
            
			
		203:
			SC_P2_StoperZvarania.StepName:='203 - Automaticky Rezim - model 45F,rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
				
				
			IF CAM11.PAR.ResultFotky = 'PASS' AND CAM12.PAR.ResultFotky = 'PASS' THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 205;
			ELSIF (CAM11.PAR.ResultFotky = 'FAIL' OR CAM12.PAR.ResultFotky = 'FAIL') THEN    
				P2_Vizu.ZobrazHL1_ST6:= TRUE;
				IF P2_Zvaranie_KAM_Result_OK THEN
					P2_Zvaranie_KAM_Result_OK:= FALSE;
					P2_Vizu.ZobrazHL1_ST6:= FALSE;
					CAM11.PAR.ResultFotky:= 'PASS';
					CAM12.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 205;
				ELSIF P2_Zvaranie_KAM_Result_NG THEN
					P2_Zvaranie_KAM_Result_NG:= FALSE;
					P2_Vizu.ZobrazHL1_ST6:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 540;    
				END_IF    
			END_IF
            
             
			
		205:
			SC_P2_StoperZvarania.StepName:='205 - Automaticky Rezim - model 45F, vymazanie fotiek CAM11 a CAM12';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 208;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 THEN
				FTP_CAM11.CMD.VymazFotku:= TRUE;
				FTP_CAM12.CMD.VymazFotku:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM11.STATUS.KomunikaciaUkoncena AND FTP_CAM12.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM11.CMD.VymazFotku:= FALSE;
				FTP_CAM12.CMD.VymazFotku:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 208;
			ELSIF FTP_CAM11.STATUS.KomunikaciaError THEN
				P2_Alarmy[234]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE; 
			ELSIF FTP_CAM12.STATUS.KomunikaciaError THEN
				P2_Alarmy[235]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE; 
			END_IF	
			
			
       
			
		208:
			SC_P2_StoperZvarania.StepName:='208 - Automaticky Rezim - model 45F,vystavenie signalu start zvarania';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
												
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				P2_Zvaranie.STAV.Vysledok_Zvarania:= '';
				P2_Zvaranie.COM_IN.Zvaranie_START:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
			
			IF P2_Zvaranie.COM_OUT.Stav_ZvaranieUkoncene THEN
				P2_Zvaranie.COM_IN.Zvaranie_START:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 209;
			END_IF
		
			
		209:
			SC_P2_StoperZvarania.StepName:='209 - Automaticky Rezim - cakam na zrusenie signalu zvaranie ukoncene';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Zvaranie.COM_OUT.Stav_ZvaranieUkoncene THEN
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 210;
			END_IF	
			
			
		
		210:
			SC_P2_StoperZvarania.StepName:='210 - Automaticky Rezim - model 45F,kamerova kontrola paletky po zvarani CAM11 '; //CAM 11//
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF Linka.P2_Kamery_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 219;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 AND CAM11.STAV.Command_READY AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie THEN
				CAM11.CMD.Triger:= TRUE;
				SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
		
			IF CAM11.STAV.Results_READY AND CAM11.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 213;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM11.CMD.Triger:= FALSE;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 212;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[296]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;       
			END_IF	
		
                  
            
            
            
            
		212:
			SC_P2_StoperZvarania.StepName:='212 - Automaticky Rezim - cakam na opatovny triger kamery CAM11 ';
			SC_P2_StoperZvarania.IdleTime.PT:= T#1s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 210;
			END_IF
            
            
            
		213:
			SC_P2_StoperZvarania.StepName:='213 - Automaticky Rezim - model 45F,vysledok kamerovej kontroly paletky po zvarani';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
		
			IF NOT CAM11.STAV.BUSY THEN
				CAM11.CMD.Triger:= FALSE;
				IF CAM11.RESULT.PowerCP.LavyBusbar_Zvaranie_OK AND
					CAM11.RESULT.PowerCP.PravyBusbar_Zvaranie_OK THEN
					CAM11.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 215;
				ELSE
					CAM11.PAR.ResultFotky:= 'FAIL';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 215;
				END_IF
			END_IF
		
            
		215:
			SC_P2_StoperZvarania.StepName:='215 - Automaticky Rezim - model 45F,kontrola vysledku zvarania';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
						
			
			IF CAM11.PAR.ResultFotky = 'PASS' THEN
				Reports.Zvaranie.VyslednyReport:= 'PASS';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 218;
			ELSIF CAM11.PAR.ResultFotky = 'FAIL' THEN
				P2_Vizu.ZobrazHL4_ST6:= TRUE;
				IF TestovaciKus THEN
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Reports.Zvaranie.VyslednyReport:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P2_Vizu.ZobrazHL4_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 218;
				ELSIF P2_Zvaranie_KAM_Result_OK THEN
					P2_Zvaranie_KAM_Result_OK:= FALSE;
					CAM11.PAR.ResultFotky:= 'PASS';
					Reports.Zvaranie.VyslednyReport:= 'PASS';
					P2_Vizu.ZobrazHL4_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 218;
				ELSIF P2_Zvaranie_KAM_Result_NG THEN
					P2_Zvaranie_KAM_Result_NG:= FALSE;
					Reports.Zvaranie.VyslednyReport:= 'FAIL';
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P2_Vizu.ZobrazHL4_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 540;
				END_IF
			END_IF    
                     
             
					
			
            
		218:
			SC_P2_StoperZvarania.StepName:='218 - Automaticky Rezim - model 45F, odoslanie fotky na server Panasonic, ';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 219;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 THEN
				FTP_CAM11.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM11.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM11.INPUTS.Result:= CAM11.PAR.ResultFotky;
				Reports.Kamery.P2_CAM11_KontrolaZvaru:= CAM11.PAR.ResultFotky;
            
				FTP_CAM11.CMD.OdosliFotku:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM11.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM11.CMD.OdosliFotku:= FALSE;
				IF CAM11.PAR.ResultFotky = 'PASS' THEN
					IF TestovaciKus THEN
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 545; 
					ELSE    
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 219;
					END_IF    
				ELSIF CAM11.PAR.ResultFotky = 'FAIL' THEN
					IF TestovaciKus THEN
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 545;
					ELSE
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 219;
					END_IF    
				END_IF 
			ELSIF FTP_CAM11.STATUS.KomunikaciaError THEN
				P2_Alarmy[234]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;  
			END_IF		
			
		219:
			SC_P2_StoperZvarania.StepName:='219 - Automaticky Rezim - model 45F,cakam na spustenie cistenia';
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
			IF NOT P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky AND
				NOT P2_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
			ELSE
				SC_P2_StoperZvarania.IdleTime.IN:= FALSE;
			END_IF    
            
                       
			IF P2_StoperSrobovania.RFID_hlava.PritomnostPaletky AND NOT P2_Robot.STAV.Srobovanie_PrebiehaManipulacia THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 220;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 220;
			END_IF    
            
            
            
					
		220:
			SC_P2_StoperZvarania.StepName:='220 - Automaticky Rezim - model 45F,vystavenie signalu start cistenia, ulozenie MV case a Top Coveru';
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#10s;
			
			SC_P2_StoperZvarania.AlarmTime.IN:= P2_Robot.COM_IN.Stav_RobotOdoberaCover;
           
            
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				P2_Cistenie.COM_IN.Cistenie_START:= TRUE;
				P2_Robot.STAV.Zvaranie_PrebiehaManipulacia:= TRUE;
				SC_P2_StoperZvarania.AlarmTime.IN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
			
			IF P2_Cistenie.COM_OUT.Stav_CistenieUkoncene THEN
				P2_Cistenie.COM_IN.Cistenie_START:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 222;
			ELSIF SC_P2_StoperZvarania.AlarmTime.Q THEN
				P2_Alarmy[285]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;    
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Alarmy[271]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;       
			END_IF	
			
		
		222:
			SC_P2_StoperZvarania.StepName:='222 - Automaticky Rezim - cakam na zrusenie signalu cistenie ukoncene';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Cistenie.COM_OUT.Stav_CistenieUkoncene THEN
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 248;
			END_IF	
			
			
		248:
			SC_P2_StoperZvarania.StepName:='248 - Automaticky Rezim - model 45F,kamerova kontrola polozeneho Top Coveru CAM11, zmena gripra';//CAM 11//
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
		
			IF Linka.P2_Kamery_OFF THEN
				P2_Robot.COM_OUT.ZmenaGripra_4F5F:= TRUE;
				P2_Robot.STAV.Zvaranie_PrebiehaManipulacia:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 540; 
			ELSIF NOT SC_P2_StoperZvarania.Switch1 AND CAM11.STAV.Command_READY AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie  THEN
				CAM11.CMD.Triger:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
		
			IF CAM11.STAV.Results_READY AND CAM11.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM11.STAV.Results_READY:= FALSE;
				P2_Robot.STAV.Zvaranie_PrebiehaManipulacia:= FALSE;
				P2_Robot.COM_OUT.ZmenaGripra_4F5F:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 250;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM11.CMD.Triger:= FALSE;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 249;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[296]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;      
			END_IF	
		
                     
            
            
		249:
			SC_P2_StoperZvarania.StepName:='249 - Automaticky Rezim - model 4F cakam na opatovny triger kamery CAM11 ';
			SC_P2_StoperZvarania.IdleTime.PT:= T#1s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 248;
			END_IF    
            
            
            
			
		250:
			SC_P2_StoperZvarania.StepName:='250 - Automaticky Rezim - model 45F,vysledok kamerovej kontroly polozeneho Top Coveru';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
		
			IF NOT CAM11.STAV.BUSY  THEN
				CAM11.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF CAM11.RESULT.PowerCP.Pritomn_TopCover_4F THEN
						CAM11.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 255;
					ELSE
						CAM11.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 255;
					END_IF	
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF CAM11.RESULT.PowerCP.Pritomn_TopCover_5F THEN
						CAM11.PAR.ResultFotky:= 'PASS';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 255;
					ELSE
						CAM11.PAR.ResultFotky:= 'FAIL';
						SC_P2_StoperZvarania.ResetStep:= TRUE;
						SC_P2_StoperZvarania.Step:= 255;
					END_IF	
				END_IF	
			END_IF
			
	
		
		
		255:
			SC_P2_StoperZvarania.StepName:='255 - Automaticky Rezim - model 45F, rozhodnutie podla kamerovej kontroly PowerCP';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
				
				
			IF CAM11.PAR.ResultFotky = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 540;
			ELSIF CAM11.PAR.ResultFotky = 'FAIL' THEN 
				P2_Vizu.ZobrazHL5_ST6:= TRUE;
				IF P2_Zvaranie_KAM_Result_OK THEN
					P2_Zvaranie_KAM_Result_OK:= FALSE;
					CAM11.PAR.ResultFotky:= 'PASS';
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					P2_Vizu.ZobrazHL5_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 540;
				ELSIF P2_Zvaranie_KAM_Result_NG THEN
					P2_Zvaranie_KAM_Result_NG:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P2_Vizu.ZobrazHL5_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 540;      
				END_IF
			END_IF	
		
		
			//*************************Model 5H*********************************//		
		400:
			SC_P2_StoperZvarania.StepName:='400 - Automaticky Rezim - model 5H, kontrola vysledkov kamier';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;	
				
            
			IF CAM12.RESULT.Paletka.Pritomn_LavyMVcase AND
				CAM12.RESULT.Paletka.Pritomn_PravyMVcase AND
				CAM12.RESULT.Paletka.Pritomn_TopCover_5H5F AND
				NOT CAM11.RESULT.PowerCP.Pritomn_LavyMVcase AND
				NOT CAM11.RESULT.PowerCP.Pritomn_PravyMVcase AND
				NOT CAM11.RESULT.PowerCP.Pritomn_TopCover_5H AND
				CAM11.RESULT.PowerCP.Pritomn_PowerCP_5H THEN
				CAM11.PAR.ResultFotky:= 'PASS';
				CAM12.PAR.ResultFotky:= 'PASS';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 403; 
			ELSE
				CAM11.PAR.ResultFotky:= 'FAIL';
				CAM12.PAR.ResultFotky:= 'FAIL';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 403;
			END_IF	
            
		
            
		403:
			SC_P2_StoperZvarania.StepName:='403 - Automaticky Rezim - model 5H,rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
				
				
			IF CAM11.PAR.ResultFotky = 'PASS' AND CAM12.PAR.ResultFotky = 'PASS' THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 405;
			ELSIF (CAM11.PAR.ResultFotky = 'FAIL' OR CAM12.PAR.ResultFotky = 'FAIL') THEN     
				P2_Vizu.ZobrazHL3_ST6:= TRUE;
				IF P2_Zvaranie_KAM_Result_OK THEN
					P2_Zvaranie_KAM_Result_OK:= FALSE;
					CAM11.PAR.ResultFotky:= 'PASS';
					CAM12.PAR.ResultFotky:= 'PASS';
					P2_Vizu.ZobrazHL3_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 405;
				ELSIF P2_Zvaranie_KAM_Result_NG THEN
					P2_Zvaranie_KAM_Result_NG:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P2_Vizu.ZobrazHL3_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 540;  
				END_IF    
			END_IF		
			     
              
			
			
				
		405:
			SC_P2_StoperZvarania.StepName:='405 - Automaticky Rezim - model 5H, vymazanie fotiek CAM11 a CAM12';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 407;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 THEN
				FTP_CAM11.CMD.VymazFotku:= TRUE;
				FTP_CAM12.CMD.VymazFotku:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM11.STATUS.KomunikaciaUkoncena AND FTP_CAM12.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM11.CMD.VymazFotku:= FALSE;
				FTP_CAM12.CMD.VymazFotku:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 407;
			ELSIF FTP_CAM11.STATUS.KomunikaciaError THEN
				P2_Alarmy[234]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE; 
			ELSIF FTP_CAM12.STATUS.KomunikaciaError THEN
				P2_Alarmy[235]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE; 
			END_IF	
			
			
		407:
			SC_P2_StoperZvarania.StepName:='407 - Automaticky Rezim - model 5H,cakam na spustenie cistenia';
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
			IF NOT P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky AND
				NOT P2_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
			ELSE
				SC_P2_StoperZvarania.IdleTime.IN:= FALSE;
			END_IF   
            
            
           
           
			IF P2_StoperSrobovania.RFID_hlava.PritomnostPaletky AND NOT P2_Robot.STAV.Srobovanie_PrebiehaManipulacia THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 408;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 408;
			END_IF     
			
				
			
			
		408:
			SC_P2_StoperZvarania.StepName:='408 - Automaticky Rezim - model 5H,vystavenie signalu start cistenia,  ulozenia MV Case a Top Coveru';
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#10s;
			
			SC_P2_StoperZvarania.IdleTime.IN:= P2_Robot.COM_IN.Stav_RobotOdoberaCover;
            
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				P2_Cistenie.COM_IN.Cistenie_START:= TRUE;
				P2_Robot.STAV.Zvaranie_PrebiehaManipulacia:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
			
            
			IF EDGEPOS(SC_P2_StoperZvarania.IdleTime.Q)THEN
				IF PocetZopakovaniOdobratia <= 3 THEN
					P2_Robot.COM_OUT.ZopakujOdoberanie:= TRUE;
				END_IF    
				PocetZopakovaniOdobratia:= PocetZopakovaniOdobratia + 1;
			END_IF
            
			IF NOT P2_Robot.COM_IN.Stav_RobotOdoberaCover THEN
				P2_Robot.COM_OUT.ZopakujOdoberanie:= FALSE;
			END_IF    
            
			IF P2_Cistenie.COM_OUT.Stav_CistenieUkoncene THEN
				P2_Cistenie.COM_IN.Cistenie_START:= FALSE;
				P2_Robot.COM_OUT.ZopakujOdoberanie:= FALSE;
				PocetZopakovaniOdobratia:= 0;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 410;
			ELSIF PocetZopakovaniOdobratia > 3 THEN
				P2_Alarmy[285]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE; 
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Alarmy[271]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;      
			END_IF	
			
	
		409:
			SC_P2_StoperZvarania.StepName:='409 - Automaticky Rezim - cakam na zrusenie signalu cistenie ukoncene';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Cistenie.COM_OUT.Stav_CistenieUkoncene THEN
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 410;
			END_IF
			
	           
        
			
		410:
			SC_P2_StoperZvarania.StepName:='410 - Automaticky Rezim - model 5H,vystavenie signalu start zatlacania';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
												
			IF NOT SC_P2_StoperZvarania.Switch1 AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie THEN
				P2_Zvaranie.COM_IN.Zatlacanie_START:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
			
			IF P2_Zvaranie.COM_OUT.Stav_ZatlacenieUkoncene THEN
				P2_Zvaranie.COM_IN.Zatlacanie_START:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 413;
			END_IF    
            
		413:
			SC_P2_StoperZvarania.StepName:='413 - Automaticky Rezim - cakam na zrusenie signalu zatlacanie ukoncene';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Zvaranie.COM_OUT.Stav_ZatlacenieUkoncene THEN
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 435;
			END_IF    
            
            
			
		435:
			SC_P2_StoperZvarania.StepName:='435 - Automaticky Rezim - model 5H,kamerova kontrola polozeneho Top Coveru CAM11, zmena gripra';//CAM 11//
			SC_P2_StoperZvarania.IdleTime.PT:= T#5s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF Linka.P2_Kamery_OFF THEN
				P2_Robot.COM_OUT.ZmenaGripra_5H:= TRUE;
				P2_Robot.STAV.Zvaranie_PrebiehaManipulacia:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 540; 
			ELSIF NOT SC_P2_StoperZvarania.Switch1 AND CAM11.STAV.Command_READY AND P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie THEN
				CAM11.CMD.Triger:= TRUE;
				SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF	
		
			IF CAM11.STAV.Results_READY AND CAM11.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM11.STAV.Results_READY:= FALSE;
				P2_Robot.STAV.Zvaranie_PrebiehaManipulacia:= FALSE;
				P2_Robot.COM_OUT.ZmenaGripra_5H:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 438;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM11.CMD.Triger:= FALSE;
				CAM11.STAV.Results_READY:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 436;
			ELSIF SC_P2_StoperZvarania.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[296]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;      
			END_IF	
		
            
                        
            
            
		436:
			SC_P2_StoperZvarania.StepName:='436 - Automaticky Rezim - cakam na opatovny triger kamery CAM11 ';
			SC_P2_StoperZvarania.IdleTime.PT:= T#1s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperZvarania.IdleTime.Q THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 435;
			END_IF    
                        
			
		438:
			SC_P2_StoperZvarania.StepName:='438 - Automaticky Rezim - model 5H,vysledok kamerovej kontroly polozeneho Top Coveru';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			SC_P2_StoperZvarania.IdleTime.IN:= TRUE;
		
			IF NOT CAM11.STAV.BUSY THEN
				CAM11.CMD.Triger:= FALSE;
				IF CAM11.RESULT.PowerCP.Pritomn_TopCover_5H THEN
					CAM11.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 443;
				ELSE
					CAM11.PAR.ResultFotky:= 'FAIL';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 443;
				END_IF	
			END_IF
			
			
		
		443:
			SC_P2_StoperZvarania.StepName:='443 - Automaticky Rezim - model 5H, rozhodnutie podla kamerovej kontroly PowerCP';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
				
				
			IF CAM11.PAR.ResultFotky = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 540;
			ELSIF CAM11.PAR.ResultFotky = 'FAIL' THEN  
				P2_Vizu.ZobrazHL7_ST6:= TRUE;
				IF P2_Zvaranie_KAM_Result_OK THEN
					P2_Zvaranie_KAM_Result_OK:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					CAM11.PAR.ResultFotky:= 'PASS';
					P2_Vizu.ZobrazHL7_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 540;
				ELSIF P2_Zvaranie_KAM_Result_NG THEN
					P2_Zvaranie_KAM_Result_NG:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P2_Vizu.ZobrazHL7_ST6:= FALSE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 540;  
				END_IF    
			END_IF	
			
				
			
		//*****************************Odoslanie fotiek na server********************************//			
		540:
			SC_P2_StoperZvarania.StepName:='540 - Automaticky Rezim - odoslanie fotky CAM11 a vymazanie fotky CAM12 na server Panasonic';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;		
			
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 545; 
			ELSIF NOT SC_P2_StoperZvarania.Switch1 THEN
				FTP_CAM11.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM11.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM11.INPUTS.Result:= CAM11.PAR.ResultFotky;
				Reports.Kamery.P2_CAM11_KontrolaPowerCP:= CAM11.PAR.ResultFotky;
                       
				FTP_CAM11.CMD.OdosliFotku:= TRUE;
				FTP_CAM12.CMD.VymazFotku:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
           
				
			
			IF FTP_CAM11.STATUS.KomunikaciaUkoncena AND FTP_CAM12.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM11.CMD.OdosliFotku:= FALSE;
				FTP_CAM12.CMD.VymazFotku:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 545; 
			ELSIF FTP_CAM11.STATUS.KomunikaciaError THEN
				P2_Alarmy[234]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE; 
			ELSIF FTP_CAM12.STATUS.KomunikaciaError THEN
				P2_Alarmy[235]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE; 
			END_IF	
			
		
       		
			
		//************************Odcentrovanie paletky**********************************//	
		545:
			SC_P2_StoperZvarania.StepName:='545 - Automaticky Rezim - odcentrovanie paletky';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperZvarania.IN.Centrovanie_ZASUNUTE THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 550;
			END_IF
          			
		
			
			
		//**************************Odoslanie dát na server************************************//	
		
		550:
			SC_P2_StoperZvarania.StepName:='550 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 560;
			ELSIF NOT SC_P2_StoperZvarania.Switch1 THEN
				TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Zvaranie_ST6.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 552;
			ELSIF TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaError THEN	
				P2_Alarmy[236]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
			
		552:
			SC_P2_StoperZvarania.StepName:='552 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 552;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 552;	
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 552;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 552;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 552;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 552;
				END_IF   
			END_IF
		
		555:
			SC_P2_StoperZvarania.StepName:='555 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			
			IF NOT SC_P2_StoperZvarania.Switch1 THEN
				TRCB_P2_Zvaranie_ST6.CMD.OdosliStavPaletky_TYP2:= TRUE;
				SC_P2_StoperZvarania.Switch1:= TRUE;
			END_IF
			
			
			IF TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Zvaranie_ST6.CMD.OdosliStavPaletky_TYP2:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 556;
			ELSIF TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaError THEN	
				TRCB_P2_Zvaranie_ST6.CMD.OdosliStavPaletky_TYP2:= FALSE;
				P2_Alarmy[236]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
			
		
		556:
			SC_P2_StoperZvarania.StepName:='556 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
			
			IF NOT TRCB_P2_Zvaranie_ST6.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Zvaranie_ST6.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 560;
				ELSIF TRCB_P2_Zvaranie_ST6.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperZvarania.ResetStep:= TRUE;
					SC_P2_StoperZvarania.Step:= 560;
				END_IF
			END_IF
			
		
		//***************************Vyvezenie paletky**********************************************//	
		560:
			SC_P2_StoperZvarania.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na stoper srobovania bunky 3';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
            					
			IF P2_StoperZvarania.KoniecCyklu THEN
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 0;
			ELSIF ((NOT P3_StoperSrobovania.RFID_hlava.PritomnostPaletky AND SC_P3_StoperSrobovania.Step = 100) OR (P3_StoperSrobovania.OUT.ZasunStoper AND SC_P3_StoperSrobovania.Step = 561)) AND NOT P2_StoperZvarania.STAV.PrebiehaVyvezeniePaletky THEN
				P2_StoperZvarania.OUT.ZasunStoper:= TRUE;
				P2_StoperZvarania.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 561;
			END_IF	
		
		
		561:
			SC_P2_StoperZvarania.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na stoper srobovania bunky 3';
			SC_P2_StoperZvarania.IdleTime.PT:= T#200ms;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#10s;
		
			SC_P2_StoperZvarania.AlarmTime.IN:= P2_StoperZvarania.RFID_hlava.PritomnostPaletky;
			SC_P2_StoperZvarania.IdleTime.IN:= NOT P2_StoperZvarania.RFID_hlava.PritomnostPaletky;
			            
            
			IF NOT P2_StoperZvarania.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				CisloFotky:= 0;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Reports.Zvaranie.Moment.LavyZvar:= '';
				Reports.Zvaranie.VyslednyReport:= '';
				Reports.Zvaranie.Vyska.LavyZvar:= '';
				Reports.Zvaranie.Frekvencia:= '';
				Reports.Zvaranie.Moment.PravyZvar:= '';
				Reports.Zvaranie.Vyska.PravyZvar:= '';
				Reports.Kamery.P2_CAM11_KontrolaZvaru:= '';
				Reports.Kamery.P2_CAM11_KontrolaPowerCP:= '';
				P2_StoperZvarania.OUT.ZasunStoper:= FALSE;
				SC_P2_StoperZvarania.ResetStep:= TRUE;
				SC_P2_StoperZvarania.Step:= 100;
			ELSIF SC_P2_StoperZvarania.AlarmTime.Q THEN
				P2_Alarmy[289]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF    
           
           
			
			
			
			
			
	
			
			
			
			
		
		
			//*******************************************************Manuálny režim*******************************************************************************//	
			
		700:
			SC_P2_StoperZvarania.StepName:='700 - Manualny Rezim';
			SC_P2_StoperZvarania.IdleTime.PT:= T#8s;
			SC_P2_StoperZvarania.AlarmTime.PT:= T#5s;
		
		
		
		
		
		
	
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

