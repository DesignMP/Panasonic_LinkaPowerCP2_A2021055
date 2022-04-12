
PROGRAM _INIT
	
	//Init parametre serva zdvihu v˝ùahu//
	P1_Vytah.ServoZdvihuVytahu.Parameters.Override:= 100;
	P1_Vytah.PAR.Zdvih_JoggRychlost:= 0.1;
	P1_Vytah.ServoZdvihuVytahu.Command.TorqueLimitation:= TRUE;
	P1_Vytah.ServoZdvihuVytahu.Parameters.Torque:= 1.0;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie podprogramov a kniûnÌc//
	IOLinkKomunikacia;
	
	 
	
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P1_Vytah);
	
	//Enable serva//
	IF Safety.STAV.P1_ZonaVytahu_AKTIVNA AND NOT P1_Vytah.ServoZdvihuVytahu.Command.ErrReset THEN
		P1_Vytah.ServoZdvihuVytahu.Command.PowerON:= TRUE;
	ELSE
		P1_Vytah.ServoZdvihuVytahu.Command.PowerON:= FALSE;
	END_IF	
	
	
	//Reset poruchy serva//
	IF P1_Vytah.ServoZdvihuVytahu.Command.ErrReset AND NOT P1_Vytah.ServoZdvihuVytahu.Status.Error THEN
		P1_Vytah.ServoZdvihuVytahu.Command.ErrReset:= FALSE;
	END_IF	
	
	
	//Zhasnutie Bannera//
	IF P1_Vytah.CMD.Banner_LED_OFF THEN
		P1_Vytah.Banner.IN.ModraLED_ON:= FALSE;
		P1_Vytah.Banner.IN.CervenaLED_ON:= FALSE;
		P1_Vytah.Banner.IN.CyanLED_ON:= FALSE;
		P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= FALSE;
		P1_Vytah.Banner.IN.OranzovaLED_ON:= FALSE;
		P1_Vytah.Banner.IN.ZelenaLED_ON:= FALSE;
		P1_Vytah.Banner.IN.ZltaLED_ON:= FALSE;
		P1_Vytah.CMD.Banner_LED_OFF:= FALSE;
	END_IF	
	
	
	//Reset sekcie //
	IF P1_Vytah.Reset THEN
		SC_P1_Vytah.Step:= 0;
		P1_Vytah.ServoZdvihuVytahu.Command.ErrReset:= TRUE;
		P1_Vytah.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P1_Vytah.Step:= 0;
	ELSIF NOT Safety.STAV.P1_ZonaVytahu_AKTIVNA THEN
		SC_P1_Vytah.Step:= 0;
	END_IF	
	
	
	
	CASE SC_P1_Vytah.Step OF 
	
	
		0:
			SC_P1_Vytah.StepName:='0 - Nulovanie';
			P1_Vytah.Automat:= FALSE;
			P1_Vytah.KoniecCyklu:= FALSE;
			P1_Vytah.Manual:= FALSE;
			P1_Vytah.STAV.PoINIT:= FALSE;
			P1_Vytah.ServoZdvihuVytahu.Command.JogNeg:= FALSE;
			P1_Vytah.ServoZdvihuVytahu.Command.JogPos:= FALSE;
			P1_Vytah.ServoZdvihuVytahu.Command.MoveAdditive:= FALSE;
			P1_Vytah.ServoZdvihuVytahu.Command.MovePosition:= FALSE;
			IF NOT P1_Vytah.ServoZdvihuVytahu.Status.StandStill THEN
				P1_Vytah.ServoZdvihuVytahu.Command.Stop:= TRUE;
			END_IF	
			P1_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
			P1_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
			P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
			P1_Vytah.RFID_hlava.PrecitajChipRFID:= FALSE;
			TRCB_P1_Vytah_ST1.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P1_Vytah_ST1.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P1_Vytah_ST1.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
			P1_Vytah.CMD.RR_ChodDopravnika_VPRED:= FALSE;
			P1_Vytah.CMD.RR_ChodDopravnika_VZAD:= FALSE;
			P1_Vytah.CMD.RR_ZdvihVytahu_DOLE:= FALSE;
			P1_Vytah.CMD.RR_ZdvihVytahu_HORE:= FALSE;
			CAM2.CMD.Triger:= FALSE;
			CAM2.STAV.Results_READY:= FALSE;
			FTP_CAM2.CMD.OdosliFotku:= FALSE;
			FTP_CAM2.CMD.VymazFotku:= FALSE;
			CAM3.CMD.Triger:= FALSE;
			CAM3.STAV.Results_READY:= FALSE;
			FTP_CAM3.CMD.OdosliFotku:= FALSE;
			FTP_CAM3.CMD.VymazFotku:= FALSE;
			CAM4.CMD.Triger:= FALSE;
			CAM4.STAV.Results_READY:= FALSE;
			FTP_CAM4.CMD.OdosliFotku:= FALSE;
			FTP_CAM4.CMD.VymazFotku:= FALSE;
			CAM5.CMD.Triger:= FALSE;
			CAM5.STAV.Results_READY:= FALSE;
			FTP_CAM5.CMD.OdosliFotku:= FALSE;
			FTP_CAM5.CMD.VymazFotku:= FALSE;
			P1_Vizu.ZobrazHL1_ST1:= FALSE;
			P1_Vizu.ZobrazHL2_ST1:= FALSE;
			P1_Vizu.ZobrazHL3_ST1:= FALSE;
			P1_Vizu.ZobrazHL4_ST1:= FALSE;
			P1_Vizu.ZobrazHL5_ST1:= FALSE;
			P1_Vizu.ZobrazHL6_ST1:= FALSE;
			P1_Vizu.ZobrazHL7_ST1:= FALSE;
			P1_Vizu.ZobrazHL8_ST1:= FALSE;
			P1_Vizu.ZobrazHL9_ST1:= FALSE;
			P1_Vizu.ZobrazHL10_ST1:= FALSE;
			P1_Vizu.ZobrazHL11_ST1:= FALSE;
			P1_Vizu.ZobrazHL12_ST1:= FALSE;
			P1_Vizu.ZobrazHL13_ST1:= FALSE;
			P1_Vizu.ZobrazHL14_ST1:= FALSE;
			P1_Vytah_KAM_Result_Ignoruj:= FALSE;
			P1_Vytah.PAR.IndexFotky:= 0;
			PocetTrigrovKamery:= 0;
			PocetDopytovNaServer:= 0;
			CisloFotky:= 0;
			TestovaciKus:= FALSE;
			Linka.PAR.PaletkaPrechadza:= FALSE;
			Linka.PAR.TestovaciKus:= FALSE;
			Linka.PAR.RevorkovyKus:= FALSE;
			P1_Vytah.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= FALSE;
            
			
			IF Safety.STAV.P1_ZonaVytahu_AKTIVNA AND NOT P1_Pracovisko.STAV.Porucha_ST1 AND P1_Pracovisko.STAV.HardwareVytahu_OK AND P1_Vytah.ServoZdvihuVytahu.Status.Ready AND P1_Vytah.ServoZdvihuVytahu.Status.StandStill THEN
				P1_Vytah.ServoZdvihuVytahu.Command.Stop:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 1;
			END_IF
	
		1:
			SC_P1_Vytah.StepName:='1 - Cakam na spustenie vyroby';
			P1_Vytah.KoniecCyklu:= FALSE;
			IF P1_Vytah.Automat THEN
				SC_P1_Vytah.Step:= 2;
			ELSIF P1_Vytah.Manual THEN
				SC_P1_Vytah.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializ·cia****************************************************************************//	
		
		2:
			SC_P1_Vytah.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P1_Vytah.IdleTime.PT:= T#2s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			SC_P1_Vytah.IdleTime.IN:= P1_Dopravniky.STAV.PoINIT;
			
			P1_Vytah.ServoZdvihuVytahu.Parameters.Acc:= P1_RemPremenne.P1_Vytah_Zdvih_Acc;
			P1_Vytah.ServoZdvihuVytahu.Parameters.Dcc:= P1_RemPremenne.P1_Vytah_Zdvih_Dcc;
			P1_Vytah.ServoZdvihuVytahu.Parameters.Torque:= 1.5;
			
			IF SC_P1_Vytah.IdleTime.Q THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 3;
			END_IF	
		
		
		3:		
			SC_P1_Vytah.StepName:='3 - Inicializacia - vymazanie adresara kamier CAM 2 a CAM4'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 4;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				FTP_CAM4.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena  AND FTP_CAM4.STATUS.KomunikaciaUkoncena THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				FTP_CAM3.CMD.VymazFotku:= FALSE;
				FTP_CAM4.CMD.VymazFotku:= FALSE;
				FTP_CAM5.CMD.VymazFotku:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 4;
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			ELSIF FTP_CAM4.STATUS.KomunikaciaError THEN
				P1_Alarmy[108]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF	
			
				
		4:
			SC_P1_Vytah.StepName:='4 - Inicializacia - spustam dopravnik vytahu pre navezenie paletky';
			SC_P1_Vytah.IdleTime.PT:= T#500ms;
			SC_P1_Vytah.AlarmTime.PT:= T#7s;
			
			SC_P1_Vytah.IdleTime.IN:= P1_Vytah.RFID_hlava.PritomnostPaletky;
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				P1_Vytah.OUT.DopravnikChod_VZAD:= TRUE;
				SC_P1_Vytah.AlarmTime.IN:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF SC_P1_Vytah.IdleTime.Q AND NOT P1_Vytah.IN.PrechodDopravnika THEN
				P1_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 13;
			ELSIF SC_P1_Vytah.AlarmTime.Q AND NOT P1_Vytah.RFID_hlava.PritomnostPaletky AND NOT P1_Vytah.IN.PrechodDopravnika THEN	
				P1_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 13;
			ELSIF SC_P1_Vytah.IdleTime.Q AND P1_Vytah.IN.PrechodDopravnika THEN		
				P1_Alarmy[102]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF	
			
	        
			
		
				
				
	
		13:
			SC_P1_Vytah.StepName:='13 - Inicializacia - presuvam vytah do hornej pozicie vyvazania';
			SC_P1_Vytah.IdleTime.PT:= T#1s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
	
			SC_P1_Vytah.IdleTime.IN:= Safety.STAV.P1_Vytah_Bariera_AKTIVNA;
			P1_Vizu.ZobrazHL13_ST1:= NOT Safety.STAV.P1_Vytah_Bariera_AKTIVNA;
			
			
			P1_Vytah.ServoZdvihuVytahu.Parameters.Velocity:= P1_RemPremenne.P1_Vytah_RychlostZdvihu /1000;
			P1_Vytah.ServoZdvihuVytahu.Parameters.Position:= P1_RemPremenne.P1_Vytah_PoziciaVykladania;
			
			
			P1_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;		
					
			IF NOT SC_P1_Vytah.Switch1 AND SC_P1_Vytah.IdleTime.Q THEN
				P1_Vytah.ServoZdvihuVytahu.Command.MovePosition:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P1_Vytah.ServoZdvihuVytahu.Status.InPosition) THEN
				P1_Vytah.ServoZdvihuVytahu.Command.MovePosition:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				P1_Vizu.ZobrazHL13_ST1:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 15;
			END_IF	
	
            			
	
		15:
			SC_P1_Vytah.StepName:='15 - Inicializacia - kontrola pritomnosti paletky';
			SC_P1_Vytah.IdleTime.PT:= T#2s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			IF P1_Vytah.RFID_hlava.PritomnostPaletky THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 18;
			ELSE
				P1_Vytah.STAV.PoINIT:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 100;
			END_IF	
			
		
		18:
			SC_P1_Vytah.StepName:='18 - Inicializacia -  precitanie cisla paletky';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			SC_P1_Vytah.IdleTime.IN:= P1_Vytah.RFID_hlava.PritomnostPaletky;
			
												
			IF SC_P1_Vytah.IdleTime.Q AND NOT SC_P1_Vytah.Switch1 THEN
				P1_Vytah.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			
			IF P1_Vytah.RFID_hlava.Stav_CitanieZapis_OK AND P1_Vytah.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P1_Vytah.RFID_hlava.PrecitaneCisloPaletky;
				P1_Vytah.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 20;
			END_IF	  
        
			
		20:
			SC_P1_Vytah.StepName:='20 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P1_Vytah.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				CAM2.STAV.Results_READY:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 50;
			ELSE
				P1_Alarmy[103]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
				
						    
                       
	                   
		50:
			SC_P1_Vytah.StepName:='50 - Inicializacia - kamerova kontrola paletky CAM 2';//CAM 2 - kontrola kusov na paletke//
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
		
            P1_Vytah.Banner.IN.ModraLED_ON:= TRUE;           
            
			
			IF Linka.P1_Kamery_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				P1_Vytah.STAV.PoINIT:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 100; 
			ELSIF P1_Vytah.RFID_hlava.PritomnostPaletky THEN   
				IF NOT SC_P1_Vytah.Switch1 AND CAM2.STAV.Command_READY THEN
					CAM2.CMD.Triger:= TRUE;
					SC_P1_Vytah.IdleTime.IN:= TRUE;
					SC_P1_Vytah.Switch1:= TRUE;
				END_IF
			ELSE   
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				P1_Vytah.STAV.PoINIT:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 100; 
			END_IF
			

			IF CAM2.STAV.Results_READY AND CAM2.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM2.STAV.Results_READY:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 55;
			ELSIF SC_P1_Vytah.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM2.STAV.Results_READY:= FALSE;
				CAM2.CMD.Triger:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 53;
			ELSIF SC_P1_Vytah.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN  
				P1_Alarmy[164]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
	    
		53:
			SC_P1_Vytah.StepName:='53 - Inicializacia - cakam na opatovny triger kamery CAM 2';
			SC_P1_Vytah.IdleTime.PT:= T#1s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
            
			IF SC_P1_Vytah.IdleTime.Q THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 50;
			END_IF
        
            
                       
            
			
		55:
			SC_P1_Vytah.StepName:='55 - Inicializacia - kontrola vysledku kamery CAM 2';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
			
						
			IF NOT CAM2.STAV.BUSY THEN
				CAM2.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF CAM2.RESULT.Paletka.Pritom_Busbaru_Spodny_4F AND
						CAM2.RESULT.Paletka.Pritom_DPS_4F5F AND
						CAM2.RESULT.Paletka.Pritom_Foamu_4F5F AND 
						CAM2.RESULT.Paletka.Pritom_PowerCP_4F AND
						CAM2.RESULT.Paletka.Pritomn_Skeletonu_4F5F AND
						CAM2.RESULT.Paletka.OsadeniePlastuDPS_OK AND
						CAM2.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM2.RESULT.Paletka.Pritomn_PravyMVcase  THEN
						CAM2.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM2.PAR.ResultFotky:= 'FAIL';
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF CAM2.RESULT.Paletka.Pritom_Busbaru_Spodny_5F AND
						CAM2.RESULT.Paletka.Pritom_DPS_4F5F AND
						CAM2.RESULT.Paletka.Pritom_Foamu_4F5F AND
						CAM2.RESULT.Paletka.Pritom_PowerCP_5F AND
						CAM2.RESULT.Paletka.Pritomn_Skeletonu_4F5F AND
						CAM2.RESULT.Paletka.OsadeniePlastuDPS_OK AND
						CAM2.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM2.RESULT.Paletka.Pritomn_PravyMVcase THEN
						CAM2.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM2.PAR.ResultFotky:= 'FAIL';
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					IF CAM2.RESULT.Paletka.Pritom_Busbar_SpodnyLavy_5H AND
						CAM2.RESULT.Paletka.Pritom_Busbar_SpodnyPravy_5H AND
						CAM2.RESULT.Paletka.Pritom_KrytuBusbarov_5H AND
						CAM2.RESULT.Paletka.Pritom_PowerCP_5H AND
						CAM2.RESULT.Paletka.Pritomn_Skeletonu_5H AND
						CAM2.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM2.RESULT.Paletka.Pritomn_PravyMVcase THEN
						CAM2.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM2.PAR.ResultFotky:= 'FAIL';
					END_IF
				END_IF
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 58;
			END_IF
            
	
            
		
		58:
			SC_P1_Vytah.StepName:='58 - Inicializacia - rozhodnutie podla kamerovej kontroly CAM 2';
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
					
			IF CAM2.PAR.ResultFotky = 'PASS' THEN
				CAM5.STAV.Results_READY:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 65;
			ELSIF CAM2.PAR.ResultFotky = 'FAIL' THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 60;
			END_IF		
		
                   
            
			
		60:
			SC_P1_Vytah.StepName:='60 - Inicializacia - cakam na vlozenie materialu do paletky a potvrdenie bannerom';
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
				
			P1_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P1_Vizu.ZobrazHL1_ST1:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P1_Vizu.ZobrazHL2_ST1:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					P1_Vizu.ZobrazHL3_ST1:= TRUE;
				END_IF  
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
		
			
			
			
			IF P1_Vytah.Banner.OUT.Stlaceny THEN
				P1_Vizu.ZobrazHL1_ST1:= FALSE;
				P1_Vizu.ZobrazHL2_ST1:= FALSE;
				P1_Vizu.ZobrazHL3_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				CAM2.STAV.Results_READY:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 65;
			ELSIF P1_Vytah_KAM_Result_Ignoruj THEN
				P1_Vytah_KAM_Result_Ignoruj:= FALSE;
				CAM2.STAV.Results_READY:= FALSE;
				CAM5.STAV.Results_READY:= FALSE;
				CAM2.PAR.ResultFotky:= 'PASS';
				P1_Vizu.ZobrazHL1_ST1:= FALSE;
				P1_Vizu.ZobrazHL2_ST1:= FALSE;
				P1_Vizu.ZobrazHL3_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 65;
			END_IF	
				
			
		65:
			SC_P1_Vytah.StepName:='65 - Inicializacia - vymazanie adresara kamery CAM 2'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 70;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena AND CAM2.PAR.ResultFotky = 'PASS' THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 70;
			ELSIF FTP_CAM2.STATUS.KomunikaciaUkoncena AND CAM2.PAR.ResultFotky = 'FAIL' THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 50;    
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
            
		70:
			SC_P1_Vytah.StepName:='70 - Inicializacia - rozhodnutie podla stavu paletky'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
            
            
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P1_Vytah.STAV.PoINIT:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 560;    
			ELSIF Paletka[i].STAV.QRkodFiltraPriradeny AND Linka.PAR.ZvolenyModel = '4F' THEN
				P1_Vytah.STAV.PoINIT:= TRUE;
				IF Paletka[i].STAV.OdoslanieFotiek_DONE THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 550;
				ELSE    
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 540;
				END_IF  
			ELSIF Paletka[i].STAV.QRkodFiltraPriradeny AND Linka.PAR.ZvolenyModel = '5F' THEN
				P1_Vytah.STAV.PoINIT:= TRUE;
				IF Paletka[i].STAV.OdoslanieFotiek_DONE THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 550;
				ELSE    
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 540;
				END_IF   
			ELSE 
				P1_Vytah.STAV.PoINIT:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 100;
			END_IF 
            
               
            
			
			
		//********************************************************Automatick˝ reûim****************************************************************************//
	
		100:
			SC_P1_Vytah.StepName:='100 - Automaticky Rezim - cakam na navezenie paletky na vytah zo spodneho dopravnika';
			SC_P1_Vytah.IdleTime.PT:= T#1s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
		
			SC_P1_Vytah.IdleTime.IN:= Safety.STAV.P1_Vytah_Bariera_AKTIVNA;
			P1_Vizu.ZobrazHL13_ST1:= NOT Safety.STAV.P1_Vytah_Bariera_AKTIVNA;
              
			P1_Vytah.ServoZdvihuVytahu.Parameters.Acc:= P1_RemPremenne.P1_Vytah_Zdvih_Acc;
			P1_Vytah.ServoZdvihuVytahu.Parameters.Dcc:= P1_RemPremenne.P1_Vytah_Zdvih_Dcc;
			P1_Vytah.ServoZdvihuVytahu.Parameters.Torque:= 1.5;
			            
			IF P1_Vytah.KoniecCyklu THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 0;
			ELSIF SC_P1_SpodnyStoper.Step = 101 AND NOT P1_Vytah.RFID_hlava.PritomnostPaletky AND NOT P1_Vytah.IN.PrechodDopravnika AND SC_P1_Vytah.IdleTime.Q THEN
				P1_Vizu.ZobrazHL13_ST1:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 103;
			ELSIF P1_Vytah.RFID_hlava.PritomnostPaletky THEN
				P1_Vizu.ZobrazHL13_ST1:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 113;
			END_IF	
		
                  
		103:
			SC_P1_Vytah.StepName:='103 - Automaticky Rezim - presuvam vytah do spodnej pozicie navazania';
			SC_P1_Vytah.IdleTime.PT:= T#3s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
		
			P1_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;
		
			
			P1_Vytah.ServoZdvihuVytahu.Parameters.Velocity:= P1_RemPremenne.P1_Vytah_RychlostZdvihu/1000;
			P1_Vytah.ServoZdvihuVytahu.Parameters.Position:= P1_RemPremenne.P1_Vytah_PoziciaNakladania;
			
			
			
					
			IF NOT SC_P1_Vytah.Switch1 AND NOT P1_Vytah.IN.PrechodDopravnika THEN
				P1_Vytah.ServoZdvihuVytahu.Command.MovePosition:= TRUE;
				P1_Vytah.OUT.DopravnikChod_VZAD:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P1_Vytah.ServoZdvihuVytahu.Status.InPosition) THEN
				P1_Vytah.ServoZdvihuVytahu.Command.MovePosition:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 105;
			END_IF	
	
			
			
			
            		
		
		105:
			SC_P1_Vytah.StepName:='105 - Automaticky Rezim - navazam paletku na dopravnik vytahu';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#20s;
		
			
			P1_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;
			
			
			SC_P1_Vytah.IdleTime.IN:= P1_Vytah.RFID_hlava.PritomnostPaletky;
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				P1_Vytah.OUT.DopravnikChod_VZAD:= TRUE;
				SC_P1_Vytah.AlarmTime.IN:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			            
            
			IF SC_P1_Vytah.IdleTime.Q AND NOT P1_Vytah.IN.PrechodDopravnika THEN
				P1_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 108;
			ELSIF SC_P1_Vytah.AlarmTime.Q THEN
				P1_Alarmy[102]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
		
						
		
		108:
			SC_P1_Vytah.StepName:='108 - Automaticky Rezim - cakam na presun vytahu do hornej pozicie vyvazania';
			SC_P1_Vytah.IdleTime.PT:= T#1s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
		
			P1_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;
			
			SC_P1_Vytah.IdleTime.IN:= Safety.STAV.P1_Vytah_Bariera_AKTIVNA;
			P1_Vizu.ZobrazHL13_ST1:= NOT Safety.STAV.P1_Vytah_Bariera_AKTIVNA;
			
			
			IF NOT P1_Vytah.IN.PrechodDopravnika AND SC_P1_Vytah.IdleTime.Q THEN
				P1_Vizu.ZobrazHL13_ST1:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 110;
			END_IF	
		
		110:
			SC_P1_Vytah.StepName:='110 - Automaticky Rezim - presuvam vytah do hornej pozicie vyvazania';
			SC_P1_Vytah.IdleTime.PT:= T#500ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
		
			
			P1_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;
			
			P1_Vytah.ServoZdvihuVytahu.Parameters.Velocity:= P1_RemPremenne.P1_Vytah_RychlostZdvihu/1000;
			P1_Vytah.ServoZdvihuVytahu.Parameters.Position:= P1_RemPremenne.P1_Vytah_PoziciaVykladania;
			
						
					
			IF NOT SC_P1_Vytah.Switch1 AND NOT P1_Vytah.IN.PrechodDopravnika THEN
				P1_Vytah.ServoZdvihuVytahu.Command.MovePosition:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P1_Vytah.ServoZdvihuVytahu.Status.InPosition) THEN
				P1_Vytah.ServoZdvihuVytahu.Command.MovePosition:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 113;
			END_IF	
			
				
				
				
		113:
			SC_P1_Vytah.StepName:='113 - Automaticky Rezim -  precitanie cisla paletky';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				i:= 0;
				P1_Vytah.RFID_hlava.PrecitajChipRFID:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
					
			IF P1_Vytah.RFID_hlava.Stav_CitanieZapis_OK AND P1_Vytah.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P1_Vytah.RFID_hlava.PrecitaneCisloPaletky;
				P1_Vytah.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 115;
			END_IF	  
        
			
		115:
			SC_P1_Vytah.StepName:='115 - Automaticky Rezim - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P1_Vytah.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 125;
			ELSE
				P1_Alarmy[103]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
					
	
			
					
			
		125:
			SC_P1_Vytah.StepName:='125 - Automaticky Rezim - cakam na potvrdenie bannerom, kontrola prihlasenia operatora';
			SC_P1_Vytah.IdleTime.PT:= T#500ms;
			SC_P1_Vytah.AlarmTime.PT:= T#7s;	
			
			IF P1_UzivatelPrihlaseny THEN
				P1_Vizu.ZobrazHL14_ST1:= FALSE;
				P1_Vytah.Banner.IN.ZelenaLED_ON:= TRUE;
				P1_Vytah.Banner.IN.CyanLED_ON:= FALSE;
			ELSE    
				P1_Vizu.ZobrazHL14_ST1:= TRUE;
				P1_Vytah.Banner.IN.ZelenaLED_ON:= FALSE;
				P1_Vytah.Banner.IN.CyanLED_ON:= Blikac500ms;
			END_IF    
          
                       
                
			IF P1_Vytah.KoniecCyklu THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 0;
			ELSIF P1_Vytah.RFID_hlava.PritomnostPaletky AND Linka.PAR.PaletkaPrechadza THEN
				P1_Vizu.ZobrazHL14_ST1:= FALSE;
				Linka.PAR.PaletkaPrechadza:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				Paletka[i].STAV.StavPaletky:= 'PRECH';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 560;
			ELSIF P1_Vytah.Banner.OUT.Stlaceny AND P1_Vytah.RFID_hlava.PritomnostPaletky AND P1_UzivatelPrihlaseny THEN
				P1_Vizu.ZobrazHL14_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				Paletka[i].PAR.ID_Operatora:= 'E2';//UsersVizu.CisloPrihlasenejKarty_Panel1;
				IF Linka.PAR.TestovaciKus THEN
					Paletka[i].STAV.StavPaletky:= '';
					CAM2.STAV.Results_READY:= FALSE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 150;
				ELSIF Linka.PAR.RevorkovyKus THEN
					Paletka[i].STAV.StavPaletky:= '';
					CAM2.STAV.Results_READY:= FALSE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 150;
				ELSE
					Paletka[i].STAV.StavPaletky:= '';
					CAM2.STAV.Results_READY:= FALSE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 130;
				END_IF 
			ELSIF P1_Vytah.Banner.OUT.Stlaceny AND P1_Vytah.RFID_hlava.PritomnostPaletky AND NOT P1_UzivatelPrihlaseny THEN 
				Paletka[i].PAR.ID_Operatora:= '';
			ELSIF NOT P1_Vytah.RFID_hlava.PritomnostPaletky THEN
				Paletka[i].STAV.StavPaletky:= '';
				P1_Vizu.ZobrazHL14_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 128;
			END_IF
		
            
		128:
			SC_P1_Vytah.StepName:='128 - Automaticky Rezim - hladanie paletky na dopravnÌku vytahu';
			SC_P1_Vytah.IdleTime.PT:= T#500ms;
			SC_P1_Vytah.AlarmTime.PT:= T#7s;	
            
			SC_P1_Vytah.IdleTime.IN:= P1_Vytah.RFID_hlava.PritomnostPaletky;
			SC_P1_Vytah.AlarmTime.IN:= NOT P1_Vytah.RFID_hlava.PritomnostPaletky; 
            
			P1_Vytah.OUT.DopravnikChod_VZAD:= TRUE; 
            
			IF SC_P1_Vytah.IdleTime.Q THEN
				P1_Vytah.OUT.DopravnikChod_VZAD:= FALSE; 
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 125;
			ELSIF SC_P1_Vytah.AlarmTime.Q THEN
				P1_Vytah.OUT.DopravnikChod_VZAD:= FALSE; 
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 100;
			END_IF    
            
					
			
		130:
			SC_P1_Vytah.StepName:='130 - Automaticky Rezim - kamerova kontrola CAM 2';//CAM 2 - kontrola kusov na paletke//
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
		
            
		
			IF P1_Vytah.KoniecCyklu THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 0;
			ELSIF Linka.P1_Kamery_OFF THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 165;//300	
			ELSIF NOT P1_UzivatelPrihlaseny THEN
				Paletka[i].STAV.StavPaletky:= '';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 125;
			ELSIF P1_Vytah.RFID_hlava.PritomnostPaletky AND Linka.PAR.PaletkaPrechadza THEN
				Linka.PAR.PaletkaPrechadza:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				Paletka[i].STAV.StavPaletky:= 'PRECH';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 560;
			ELSIF P1_Vytah.RFID_hlava.PritomnostPaletky AND Linka.PAR.TestovaciKus THEN
				Paletka[i].PAR.ID_Operatora:= 'E2';//UsersVizu.CisloPrihlasenejKarty_Panel1;
				Paletka[i].STAV.StavPaletky:= '';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 150;
			ELSIF P1_Vytah.RFID_hlava.PritomnostPaletky AND Linka.PAR.RevorkovyKus THEN
				Paletka[i].PAR.ID_Operatora:= 'E2';//UsersVizu.CisloPrihlasenejKarty_Panel1;
				Paletka[i].STAV.StavPaletky:= '';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 150;    
			ELSIF NOT P1_Vytah.RFID_hlava.PritomnostPaletky THEN
				Paletka[i].STAV.StavPaletky:= '';
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 100;    
			ELSIF NOT SC_P1_Vytah.Switch1 AND CAM2.STAV.Command_READY THEN
				CAM2.CMD.Triger:= TRUE;
				P1_Vytah.Banner.IN.ModraLED_ON:= TRUE;
				SC_P1_Vytah.IdleTime.IN:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			
			
				
			IF CAM2.STAV.Results_READY AND CAM2.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM2.STAV.Results_READY:= FALSE;
				Paletka[i].PAR.ID_Operatora:= 'E2';//UsersVizu.CisloPrihlasenejKarty_Panel1;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 133;
			ELSIF SC_P1_Vytah.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM2.STAV.Results_READY:= FALSE;
				CAM2.CMD.Triger:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 131;
			ELSIF SC_P1_Vytah.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN  
				P1_Alarmy[164]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;   
			END_IF	
	    
                      
            
            
            
		131:
			SC_P1_Vytah.StepName:='131 - Automaticky Rezim - cakam na opatovny triger kamery CAM 2';
			SC_P1_Vytah.IdleTime.PT:= T#1s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
            
			IF SC_P1_Vytah.IdleTime.Q THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			END_IF
        
            
                       
            
			
		133:
			SC_P1_Vytah.StepName:='133 - Automaticky Rezim - kontrola vysledku kamery CAM 2'; //kontrola kusov na paletke
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
			
						
			IF NOT CAM2.STAV.BUSY THEN
				CAM2.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF CAM2.RESULT.Paletka.Pritom_Busbaru_Spodny_4F AND
						CAM2.RESULT.Paletka.Pritom_DPS_4F5F AND
						CAM2.RESULT.Paletka.Pritom_Foamu_4F5F AND 
						CAM2.RESULT.Paletka.Pritom_PowerCP_4F AND
						CAM2.RESULT.Paletka.Pritomn_Skeletonu_4F5F AND
						CAM2.RESULT.Paletka.OsadeniePlastuDPS_OK AND
						CAM2.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM2.RESULT.Paletka.Pritomn_PravyMVcase  THEN
						CAM2.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM2.PAR.ResultFotky:= 'FAIL';
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF CAM2.RESULT.Paletka.Pritom_Busbaru_Spodny_5F AND
						CAM2.RESULT.Paletka.Pritom_DPS_4F5F AND
						CAM2.RESULT.Paletka.Pritom_Foamu_4F5F AND
						CAM2.RESULT.Paletka.Pritom_PowerCP_5F AND
						CAM2.RESULT.Paletka.Pritomn_Skeletonu_4F5F AND
						CAM2.RESULT.Paletka.OsadeniePlastuDPS_OK AND
						CAM2.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM2.RESULT.Paletka.Pritomn_PravyMVcase THEN
						CAM2.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM2.PAR.ResultFotky:= 'FAIL';
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					IF CAM2.RESULT.Paletka.Pritom_Busbar_SpodnyLavy_5H AND
						CAM2.RESULT.Paletka.Pritom_Busbar_SpodnyPravy_5H AND
						CAM2.RESULT.Paletka.Pritom_KrytuBusbarov_5H AND
						CAM2.RESULT.Paletka.Pritom_PowerCP_5H AND
						CAM2.RESULT.Paletka.Pritomn_Skeletonu_5H AND
						CAM2.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM2.RESULT.Paletka.Pritomn_PravyMVcase THEN
						CAM2.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM2.PAR.ResultFotky:= 'FAIL';
					END_IF
				END_IF
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 135;
			END_IF
            
	
            
		
		135:
			SC_P1_Vytah.StepName:='135 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly CAM 2';
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
					
			IF CAM2.PAR.ResultFotky = 'PASS' THEN
				CAM5.STAV.Results_READY:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 150;
			ELSIF CAM2.PAR.ResultFotky = 'FAIL' THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 138;
			END_IF		
		
                   
		138:
			SC_P1_Vytah.StepName:='138 - Automaticky Rezim - cakam na vlozenie materialu do paletky a potvrdenie bannerom';
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			P1_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P1_Vizu.ZobrazHL1_ST1:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P1_Vizu.ZobrazHL2_ST1:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					P1_Vizu.ZobrazHL3_ST1:= TRUE;
				END_IF  
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
				
			
			IF P1_Vytah.Banner.OUT.Stlaceny THEN
				P1_Vizu.ZobrazHL1_ST1:= FALSE;
				P1_Vizu.ZobrazHL2_ST1:= FALSE;
				P1_Vizu.ZobrazHL3_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				CAM2.STAV.Results_READY:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 148;
			ELSIF P1_Vytah_KAM_Result_Ignoruj THEN
				P1_Vytah_KAM_Result_Ignoruj:= FALSE;
				CAM2.STAV.Results_READY:= FALSE;
				CAM5.STAV.Results_READY:= FALSE;
				CAM2.PAR.ResultFotky:= 'PASS';
				P1_Vizu.ZobrazHL1_ST1:= FALSE;
				P1_Vizu.ZobrazHL2_ST1:= FALSE;
				P1_Vizu.ZobrazHL3_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 150;
			END_IF	
				
			
		148:
			SC_P1_Vytah.StepName:='148 - Automaticky Rezim - vymazanie adresara kamery CAM 2'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
		
                   
				
			
		150:
			SC_P1_Vytah.StepName:='150 - Automaticky Rezim - kamerova kontrola CAM 5';//CAM 5 - kontrola QR kÛdu na Power CP//
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;	
            
			P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= TRUE;
			P1_Vytah.Banner.IN.ModraLED_ON:= TRUE;
			
			IF NOT SC_P1_Vytah.Switch1 AND SC_P1_Vytah.IdleTime.Q THEN 
				CAM5.CMD.Triger:= TRUE;
				SC_P1_Vytah.AlarmTime.IN:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			

			IF CAM5.STAV.Results_READY THEN
				PocetTrigrovKamery:= 0;
				CAM5.STAV.Results_READY:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 153;
			ELSIF SC_P1_Vytah.AlarmTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM5.STAV.Results_READY:= FALSE;
				CAM5.CMD.Triger:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 151;
			ELSIF SC_P1_Vytah.AlarmTime.Q AND PocetTrigrovKamery >= 5 THEN    
				P1_Alarmy[165]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE; 
			END_IF	
		
                       
            
		151:
			SC_P1_Vytah.StepName:='151 - Automaticky Rezim - cakam na opatovny triger kamery CAM 5';
			SC_P1_Vytah.IdleTime.PT:= T#1s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
            
			IF SC_P1_Vytah.IdleTime.Q THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 150;
			END_IF    
            
            
		153:
			SC_P1_Vytah.StepName:='153 - Automaticky Rezim - kontrola vysledku kamery CAM 5';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
				
			
			
			IF NOT CAM5.STAV.BUSY THEN
				CAM5.CMD.Triger:= FALSE;
				IF CAM5.RESULT.PowerCP.CitanieQRkodu_PowerCP_OK THEN
					IF (P1_Vytah.PAR.StaryQRkod_PowerCP <> CAM5.RESULT.PowerCP.PrecitanyQRkod_PowerCP) OR Paletka[i].STAV.StavPaletky = 'TEST' OR Paletka[i].STAV.StavPaletky = 'REV' THEN
						Paletka[i].PAR.QRkodPowerCP:= CAM5.RESULT.PowerCP.PrecitanyQRkod_PowerCP;
						TRCB_P1_Vytah_ST1.INPUTS.QRkodPowerCP:= CAM5.RESULT.PowerCP.PrecitanyQRkod_PowerCP;
						CAM5.PAR.ResultFotky:= 'PASS';
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 155;
					ELSIF (P1_Vytah.PAR.StaryQRkod_PowerCP = CAM5.RESULT.PowerCP.PrecitanyQRkod_PowerCP) THEN
						CAM5.PAR.ResultFotky:= 'FAIL';
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 155;
					END_IF    
				ELSE
					CAM5.PAR.ResultFotky:= 'FAIL';
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 155;
				END_IF
			END_IF
			
		
		155:
			SC_P1_Vytah.StepName:='155 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly CAM 5';
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
					
			IF CAM5.PAR.ResultFotky = 'PASS' THEN
				IF Linka.PAR.TestovaciKus THEN
					P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= FALSE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 300;
				ELSIF Linka.PAR.RevorkovyKus THEN
					P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= FALSE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 300;
				ELSE
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 165;
				END_IF    
			ELSIF CAM5.PAR.ResultFotky = 'FAIL' THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 158;
			END_IF	
	
            
            
            
            
			
		158:
			SC_P1_Vytah.StepName:='158 - Automaticky Rezim - zobrazenie hlasenia neprecitany QR kod PowerCP';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= FALSE;
			
			P1_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				P1_Vizu.ZobrazHL4_ST1:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			
				
			
			IF P1_Vytah.Banner.OUT.Stlaceny THEN
				CAM5.STAV.Results_READY:= FALSE;
				P1_Vizu.ZobrazHL4_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 160;
			END_IF	
		
			
			
		160:
			SC_P1_Vytah.StepName:='160 - Automaticky Rezim - vymazanie adresara kamery CAM 2'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
       		
               
		
		
		165:
			SC_P1_Vytah.StepName:='165 - Automaticky Rezim - rozhodnutie podla typu modelu';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				CAM4.STAV.Results_READY:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 170;
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				CAM4.STAV.Results_READY:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 170;
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN	
				P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 300;
			END_IF	
				
				
			
		170:
			SC_P1_Vytah.StepName:='170 - Automaticky Rezim - kamerova kontrola CAM 4';//CAM 4 - kontrola klipov krytu DPS iba moly 4F a 5F//
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
            
			P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= TRUE;
			P1_Vytah.Banner.IN.ModraLED_ON:= TRUE;
			
			IF SC_P1_Vytah.IdleTime.Q THEN
				IF NOT SC_P1_Vytah.Switch1 AND CAM4.STAV.Command_READY THEN
					CAM4.CMD.Triger:= TRUE;
					SC_P1_Vytah.AlarmTime.IN:= TRUE;
					SC_P1_Vytah.Switch1:= TRUE;
				END_IF
			END_IF
			

			IF CAM4.STAV.Results_READY AND CAM4.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM4.STAV.Results_READY:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 173;
			ELSIF SC_P1_Vytah.AlarmTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM4.STAV.Results_READY:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				CAM4.CMD.Triger:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 171;
			ELSIF SC_P1_Vytah.AlarmTime.Q AND PocetTrigrovKamery >= 5 THEN    
				P1_Alarmy[166]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;    
			END_IF	
		
                    
            
            
            
            
		171:
			SC_P1_Vytah.StepName:='171 - Automaticky Rezim - cakam na opatovny triger kamery CAM 4';
			SC_P1_Vytah.IdleTime.PT:= T#2s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
            
			IF SC_P1_Vytah.IdleTime.Q THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 170;
			END_IF
            
			
		173:
			SC_P1_Vytah.StepName:='173 - Automaticky Rezim - kontrola vysledku kamery CAM 4';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
				
			P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= FALSE;
			
			IF NOT CAM4.STAV.BUSY  THEN
				CAM4.CMD.Triger:= FALSE;
				IF CAM4.RESULT.Paletka.Pritomn_Pinu1_KrytDPS_4F5F AND
					CAM4.RESULT.Paletka.Pritomn_Pinu2_KrytDPS_4F5F AND
					CAM4.RESULT.Paletka.Pritomn_Pinu3_KrytDPS_4F5F AND
					CAM4.RESULT.Paletka.Pritomn_Pinu4_KrytDPS_4F5F AND
					CAM4.RESULT.Paletka.Pritomn_Pinu5_KrytDPS_4F5F AND
					CAM4.RESULT.Paletka.Pritomn_Pinu6_KrytDPS_4F5F AND
					CAM4.RESULT.Paletka.Pritom_DPS_4F5F THEN
					CAM4.PAR.ResultFotky:= 'PASS';
				ELSE
					CAM4.PAR.ResultFotky:= 'FAIL';
				END_IF
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 175;
			END_IF
		
			
		175:
			SC_P1_Vytah.StepName:='175 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly CAM 4';
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
					
			IF CAM4.PAR.ResultFotky = 'PASS' THEN
				CAM3.STAV.Results_READY:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 300;//190
			ELSIF CAM4.PAR.ResultFotky = 'FAIL' THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 178;
			END_IF		
			
		
       
            
            
			
		178:
			SC_P1_Vytah.StepName:='178 - Automaticky Rezim - zobrazenie hlasenia chyba DPS alebo zle zacvaknute piny na DPS';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			P1_Pracovisko.OUT.Osvetlenie_CAM4_ON:= FALSE;
			P1_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				P1_Vizu.ZobrazHL5_ST1:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			
			
			
			
			IF P1_Vytah.Banner.OUT.Stlaceny THEN
				CAM4.STAV.Results_READY:= FALSE;
				P1_Vizu.ZobrazHL5_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 180;
			ELSIF P1_Vytah_KAM_Result_Ignoruj THEN 
				CAM4.STAV.Results_READY:= FALSE;
				CAM3.STAV.Results_READY:= FALSE;
				P1_Vytah_KAM_Result_Ignoruj:= FALSE;
				P1_Vizu.ZobrazHL5_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				CAM4.PAR.ResultFotky:= 'PASS';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 300;//190
			END_IF	
			
						
			
		180:
			SC_P1_Vytah.StepName:='180 - Automaticky Rezim - vymazanie adresara kamery CAM4, CAM2'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				FTP_CAM4.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena AND FTP_CAM4.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				FTP_CAM4.CMD.VymazFotku:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;    
			ELSIF FTP_CAM4.STATUS.KomunikaciaError THEN    
				P1_Alarmy[108]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
        
                   
		190:
			SC_P1_Vytah.StepName:='190 - Automaticky Rezim - kamerova kontrola CAM 3';//CAM 3 - kontrola QR kÛdu DPS iba modely 4F a 5F//
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
		
            P1_Vytah.Banner.IN.ModraLED_ON:= TRUE;
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				CAM3.CMD.Triger:= TRUE;
				SC_P1_Vytah.IdleTime.IN:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			
						
			IF CAM3.STAV.Results_READY THEN
				PocetTrigrovKamery:= 0;
				CAM3.STAV.Results_READY:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 193;
			ELSIF SC_P1_Vytah.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM3.STAV.Results_READY:= FALSE;
				CAM3.CMD.Triger:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 191;
			ELSIF SC_P1_Vytah.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN    
				P1_Alarmy[167]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;      
			END_IF
		
                      
            
            
            
            
		191:
			SC_P1_Vytah.StepName:='191 - Automaticky Rezim - cakam na opatovny triger kamery CAM 3';
			SC_P1_Vytah.IdleTime.PT:= T#2s;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
            
			IF SC_P1_Vytah.IdleTime.Q THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 190;
			END_IF
            
            
            
            
		193:
			SC_P1_Vytah.StepName:='193 - Automaticky Rezim - kontrola vysledku kamery CAM 3';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
            
						
			IF NOT CAM3.STAV.BUSY  THEN
				CAM3.CMD.Triger:= FALSE;
				IF CAM3.RESULT.Paletka.CitanieQRkodu_DPS_OK THEN
					IF P1_Vytah.PAR.StaryQRkod_DPS_4F5F <> CAM3.RESULT.Paletka.PrecitanyQRkod_DPS THEN
						Paletka[i].PAR.QRkodFiltra_4F5F:= CAM3.RESULT.Paletka.PrecitanyQRkod_DPS;
						CAM3.PAR.ResultFotky:= 'PASS';
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 195;
					END_IF    
				ELSE
					CAM3.PAR.ResultFotky:= 'FAIL';
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 195;
				END_IF
			END_IF
			
		195:
			SC_P1_Vytah.StepName:='195 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly CAM 3';
			SC_P1_Vytah.IdleTime.PT:= T#5s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
					
			IF CAM3.PAR.ResultFotky = 'PASS' THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 300;
			ELSIF CAM3.PAR.ResultFotky = 'FAIL' THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 198;
			END_IF		
			
			
		
		198:
			SC_P1_Vytah.StepName:='198 - Automaticky Rezim - zobrazenie hlasenia neprecitany QR kod DPS';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			P1_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				P1_Vizu.ZobrazHL6_ST1:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			
				
		
			IF P1_Vytah.Banner.OUT.Stlaceny THEN
				CAM3.STAV.Results_READY:= FALSE;
				P1_Vizu.ZobrazHL6_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 200;
			END_IF	
			
		
				
			
		200:
			SC_P1_Vytah.StepName:='200 - Automaticky Rezim - vymazanie adresara kamery, CAM4,CAM2'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				FTP_CAM4.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena AND FTP_CAM4.STATUS.KomunikaciaUkoncena  THEN
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				FTP_CAM4.CMD.VymazFotku:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;  
			ELSIF FTP_CAM4.STATUS.KomunikaciaError THEN    
				P1_Alarmy[108]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;  
			END_IF	
            
		300:
			SC_P1_Vytah.StepName:='300 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
			
			IF Linka.KOM_Panatrace_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 560;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 301;
			ELSIF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaError THEN	
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 305;
			END_IF
		
			
		301:
			SC_P1_Vytah.StepName:='301 - Automaticky Rezim - kontrola odpovede servera';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 301;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 301;	
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 301;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 301;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 301;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 301;
				END_IF   
			END_IF
			
		
		302:
			SC_P1_Vytah.StepName:='302 - Automaticky Rezim - vyziadanie stavu paletky zo servera'; 
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#50s;	
			
			            
			IF NOT SC_P1_Vytah.Switch1 THEN
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF    
			
			IF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 303;
			ELSIF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaError THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 305;
			END_IF
            
		
		
		303:
			SC_P1_Vytah.StepName:='303 - Automaticky Rezim - kontrola odpovede servera'; 
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
	
			IF NOT TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Vytah_ST1.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST1' THEN
						Paletka[i].STAV.StavPaletky:= 'OK';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.CisloRevorkovejStanice:= '';
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 308;
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'SMP;HV' THEN
						Paletka[i].STAV.StavPaletky:= 'TEST';
						Paletka[i].STAV.CisloTestovacejStanice:= 'ST_7';
						Paletka[i].STAV.CisloRevorkovejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'SMP;FT1,FT2' THEN
						Paletka[i].STAV.StavPaletky:= 'TEST';
						Paletka[i].STAV.CisloTestovacejStanice:= 'ST_FT1,FT2';
						Paletka[i].STAV.CisloRevorkovejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560; 
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'SMP;ST8A,ST8B' THEN
						Paletka[i].STAV.StavPaletky:= 'TEST';
						Paletka[i].STAV.CisloTestovacejStanice:= 'ST_8A,8B';
						Paletka[i].STAV.CisloRevorkovejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;   
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'SMP;ST6' THEN
						Paletka[i].STAV.StavPaletky:= 'TEST';
						Paletka[i].STAV.CisloTestovacejStanice:= 'ST_6';
						Paletka[i].STAV.CisloRevorkovejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST2' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_2';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;      
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST3' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_3';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;     
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST4' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_4';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;      
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST5' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_5';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;  
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST6' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_6';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;      
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST7' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_7';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;  
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;HV' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_7_HV';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;      
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST8A,ST8B' THEN  
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_8A,8B';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;FT1,FT2' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_FT1,FT2';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST9' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_9';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;
					ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST10' THEN
						Paletka[i].STAV.StavPaletky:= 'REV';
						Paletka[i].STAV.CisloRevorkovejStanice:= 'ST_10';
						Paletka[i].STAV.CisloTestovacejStanice:= '';
						Paletka[i].STAV.Komunikacia_DONE:= TRUE;
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 560;      
					ELSE 
						SC_P1_Vytah.ResetStep:= TRUE;
						SC_P1_Vytah.Step:= 555; 
					END_IF   
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 305;
				END_IF	
			END_IF
	      
        
            
            
		305:
			SC_P1_Vytah.StepName:='305 - Automaticky Rezim - zobrazenie hlasenia nespravny QR kod Power CP';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			P1_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				P1_Vizu.ZobrazHL7_ST1:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			
			
				
			
		
			IF P1_Vytah.Banner.OUT.Stlaceny THEN
				P1_Vizu.ZobrazHL7_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 306;
			END_IF		
		
		306:
			SC_P1_Vytah.StepName:='306 - Automaticky Rezim - vymazanie adresara kamery, CAM4, CAM2'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				FTP_CAM4.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena AND FTP_CAM4.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				FTP_CAM4.CMD.VymazFotku:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			ELSIF FTP_CAM4.STATUS.KomunikaciaError THEN    
				P1_Alarmy[108]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	    
            
            
            
		
		308:
			SC_P1_Vytah.StepName:='308 - Automaticky Rezim - kontrola typu modelu'; 
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
			
					
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS'; //DoËasne
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 310;
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS'; //Docasne
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 310;
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN	
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 540;
			END_IF	
		
			
		310:
			SC_P1_Vytah.StepName:='310 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
			
			IF Linka.KOM_Panatrace_OFF THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 540;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 311;
			ELSIF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaError THEN	
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P1_Alarmy[104]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
			
		311:
			SC_P1_Vytah.StepName:='301 - Automaticky Rezim - kontrola odpovede servera';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 311;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 311;	
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 311;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 311;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 311;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 311;
				END_IF   
			END_IF
			
	
		
		
		312:
			SC_P1_Vytah.StepName:='312 - Automaticky Rezim - priradenie QRkodu DPS'; 
			SC_P1_Vytah.IdleTime.PT:= T#500ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;	
			SC_P1_Vytah.IdleTime.IN:= TRUE;
			
			            
			IF SC_P1_Vytah.IdleTime.Q THEN
				TRCB_P1_Vytah_ST1.CMD.PriradQRkodFiltra_TYP3:= TRUE;
				SC_P1_Vytah.AlarmTime.IN:= TRUE;
			END_IF	
			
			IF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P1_Vytah_ST1.CMD.PriradQRkodFiltra_TYP3:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 313;
			ELSIF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaError THEN	
				P1_Alarmy[104]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
		
			
			
		313:
			SC_P1_Vytah.StepName:='313 - Automaticky Rezim - kontrola odpovede servera'; 
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
	
			IF NOT TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Vytah_ST1.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.QRkodFiltraPriradeny:= TRUE;
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					Paletka[i].STAV.StavPaletky:= 'OK';
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 540;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.QRkodFiltraPriradeny:= FALSE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 315;
				END_IF		
			END_IF
            
		315:
			SC_P1_Vytah.StepName:='315 - Automaticky Rezim - zobrazenie hlasenia nespravny QR kod DPS';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			P1_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				P1_Vizu.ZobrazHL8_ST1:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
						
			
		
			IF P1_Vytah.Banner.OUT.Stlaceny THEN
				P1_Vizu.ZobrazHL8_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 318;
			END_IF		
				
			
		318:
			SC_P1_Vytah.StepName:='318 - Automaticky Rezim - vymazanie adresara kamery CAM 2, CAM4'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				FTP_CAM4.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena AND FTP_CAM4.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				FTP_CAM4.CMD.VymazFotku:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			ELSIF FTP_CAM4.STATUS.KomunikaciaError THEN    
				P1_Alarmy[108]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
            
            
            
            
            
            
			
			
				
		//*******************************Odoslanie fotiek na server*****************************************//	
		
		540:
			SC_P1_Vytah.StepName:='540 - Automaticky Rezim - odoslanie fotky kontroly paletky a pinov na server Panasonic';//CAM 2 a CAM 4
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
            
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			
				
			IF NOT SC_P1_Vytah.Switch2 THEN
				IF Linka.PAR.ZvolenyModel = '4F' OR Linka.PAR.ZvolenyModel = '5F' THEN
					FTP_CAM2.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
					CisloFotky:= CisloFotky + 1;
					FTP_CAM2.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
					FTP_CAM2.INPUTS.Result:= CAM2.PAR.ResultFotky;
					Reports.Kamery.P1_CAM2_KontrolaPaletky:= CAM2.PAR.ResultFotky;
            
					FTP_CAM4.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
					CisloFotky:= CisloFotky + 1;
					FTP_CAM4.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
					FTP_CAM4.INPUTS.Result:= CAM4.PAR.ResultFotky;
					Reports.Kamery.P1_CAM4_KontrolaPinovDPS:= CAM4.PAR.ResultFotky;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					FTP_CAM2.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
					CisloFotky:= CisloFotky + 1;
					FTP_CAM2.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
					FTP_CAM2.INPUTS.Result:= CAM2.PAR.ResultFotky;
					Reports.Kamery.P1_CAM2_KontrolaPaletky:= CAM2.PAR.ResultFotky;
				END_IF     
				SC_P1_Vytah.Switch2:= TRUE;
			END_IF        
               
			
			IF Linka.KOM_FTP_OFF THEN   
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 550;
			ELSIF NOT SC_P1_Vytah.Switch1 AND Linka.PAR.ZvolenyModel = '4F' THEN
				FTP_CAM2.CMD.OdosliFotku:= TRUE;
				FTP_CAM4.CMD.OdosliFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			ELSIF NOT SC_P1_Vytah.Switch1 AND Linka.PAR.ZvolenyModel = '5F' THEN  
				FTP_CAM2.CMD.OdosliFotku:= TRUE;
				FTP_CAM4.CMD.OdosliFotku:= TRUE; 
				SC_P1_Vytah.Switch1:= TRUE; 
			ELSIF NOT SC_P1_Vytah.Switch1 AND Linka.PAR.ZvolenyModel = '5H' THEN 
				FTP_CAM2.CMD.OdosliFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
			
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				IF FTP_CAM2.STATUS.KomunikaciaUkoncena AND FTP_CAM4.STATUS.KomunikaciaUkoncena THEN
					FTP_CAM2.CMD.OdosliFotku:= FALSE;
					FTP_CAM4.CMD.OdosliFotku:= FALSE;
					Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
					P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 550;
				ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
					P1_Alarmy[106]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
				ELSIF FTP_CAM4.STATUS.KomunikaciaError THEN
					P1_Alarmy[108]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST1:= TRUE;    
				END_IF
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN   
				IF FTP_CAM2.STATUS.KomunikaciaUkoncena AND FTP_CAM4.STATUS.KomunikaciaUkoncena THEN
					FTP_CAM2.CMD.OdosliFotku:= FALSE;
					FTP_CAM4.CMD.OdosliFotku:= FALSE;
					Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
					P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 550;
				ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
					P1_Alarmy[106]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
				ELSIF FTP_CAM4.STATUS.KomunikaciaError THEN
					P1_Alarmy[108]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST1:= TRUE; 
				END_IF
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN  
				IF FTP_CAM2.STATUS.KomunikaciaUkoncena THEN
					FTP_CAM2.CMD.OdosliFotku:= FALSE;
					Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
					P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 550;
				ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
					P1_Alarmy[106]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
				END_IF
			END_IF   
         
                       
            
         				
		//*********************************Odoslanie stavu paletky na server**************************************//	
		
		550:
			SC_P1_Vytah.StepName:='550 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 560;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 551;
			ELSIF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaError THEN	
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P1_Vytah_ST1.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P1_Alarmy[104]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
			
		551:
			SC_P1_Vytah.StepName:='551 - Automaticky Rezim - kontrola odpovede servera';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 551;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 551;	
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 551;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 551;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 551;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 551;
				END_IF   
			END_IF
		
		
		
		552:
			SC_P1_Vytah.StepName:='552 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P1_Vytah.IdleTime.PT:= T#500ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
			SC_P1_Vytah.IdleTime.IN:= TRUE;
			
           
            
            
			IF NOT SC_P1_Vytah.Switch1 THEN
				TRCB_P1_Vytah_ST1.CMD.OdosliStavPaletky_TYP2:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF    
           	
			
			IF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P1_Vytah_ST1.CMD.OdosliStavPaletky_TYP2:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 553;
			ELSIF TRCB_P1_Vytah_ST1.STATUS.KomunikaciaError THEN	
				P1_Alarmy[104]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
			
		553:
			SC_P1_Vytah.StepName:='553 - Automaticky Rezim - kontrola odpovede servera'; 
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#10s;
	
			IF NOT TRCB_P1_Vytah_ST1.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P1_Vytah_ST1.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 560;
				ELSIF TRCB_P1_Vytah_ST1.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.QRkodFiltraPriradeny:= FALSE;
					Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
					SC_P1_Vytah.ResetStep:= TRUE;
					SC_P1_Vytah.Step:= 555;
				END_IF	
			END_IF
			
		555:
			SC_P1_Vytah.StepName:='555 - Automaticky Rezim - zobrazenie hlasenia komunikacia zo serverom neprebehla korektne';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
			
			P1_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			IF NOT SC_P1_Vytah.Switch1 THEN
				P1_Vizu.ZobrazHL9_ST1:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF
					
			
		
			IF P1_Vytah.KoniecCyklu THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 0;
			ELSIF P1_Vytah.Banner.OUT.Stlaceny THEN
				P1_Vizu.ZobrazHL9_ST1:= FALSE;
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 558;
			END_IF	
			
		558:
			SC_P1_Vytah.StepName:='558 - Automaticky Rezim - vymazanie adresara kamery CAM 2, CAM4'; 
			SC_P1_Vytah.IdleTime.PT:= T#4s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;	
			
			P1_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF NOT SC_P1_Vytah.Switch1 THEN
				FTP_CAM2.CMD.VymazFotku:= TRUE;
				FTP_CAM4.CMD.VymazFotku:= TRUE;
				SC_P1_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM2.STATUS.KomunikaciaUkoncena AND FTP_CAM4.STATUS.KomunikaciaUkoncena THEN
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM2.CMD.VymazFotku:= FALSE;
				FTP_CAM4.CMD.VymazFotku:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 130;
			ELSIF FTP_CAM2.STATUS.KomunikaciaError THEN
				P1_Alarmy[106]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			ELSIF FTP_CAM4.STATUS.KomunikaciaError THEN    
				P1_Alarmy[108]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF		
			
			
			
			
		
			
			

		//************************************Vyvezenie paletky*****************************************//	
		
		560:
			SC_P1_Vytah.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na stoper srobovania';
			SC_P1_Vytah.IdleTime.PT:= T#200ms;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
		
			P1_Vytah.Banner.IN.ZelenaLED_ON:= Blikac500ms;
            
                        
			IF P1_Vytah.KoniecCyklu THEN
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 0;			
			ELSIF NOT P1_StoperSrobovania.RFID_hlava.PritomnostPaletky AND SC_P1_StoperSrobovania.Step = 100 THEN
				TestovaciKus:= FALSE;
				CisloFotky:= 0;
				P1_Vytah.OUT.DopravnikChod_VPRED:= TRUE;
				P1_Vytah.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				Linka.PAR.TestovaciKus:= FALSE;
				Linka.PAR.RevorkovyKus:= FALSE;
				Linka.PAR.PaletkaPrechadza:= FALSE;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Paletka[i].STAV.QRkodFiltraPriradeny:= FALSE;
				Paletka[i].STAV.FunkcnyTest_Ukonceny:= FALSE;
				Paletka[i].STAV.HV_Test_Ukonceny:= FALSE;
				Paletka[i].STAV.LeakageTest_Ukonceny:= FALSE;
				Paletka[i].STAV.VytlacenieEtikety_DONE:= FALSE;
				Paletka[i].STAV.Zvaranie_Ukoncene:= FALSE;
				Paletka[i].STAV.CisloEtiketyVyziadane:= FALSE;
				Reports.Kamery.P1_CAM2_KontrolaPaletky:= '';
				Reports.Kamery.P1_CAM4_KontrolaPinovDPS:= '';
				P1_Vytah.CMD.Banner_LED_OFF:= TRUE;
				P1_Vytah.PAR.StaryQRkod_DPS_4F5F:= Paletka[i].PAR.QRkodFiltra_4F5F;
				P1_Vytah.PAR.StaryQRkod_PowerCP:= Paletka[i].PAR.QRkodPowerCP;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 561;
			END_IF	
		
            
            
            
		
		561:
			SC_P1_Vytah.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na stoper srobovania';
			SC_P1_Vytah.IdleTime.PT:= T#1s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
		
			SC_P1_Vytah.IdleTime.IN:= NOT P1_Vytah.RFID_hlava.PritomnostPaletky AND NOT P1_Vytah.IN.PrechodDopravnika;
				
				
			 
			
			IF SC_P1_Vytah.IdleTime.Q AND NOT P1_Vytah.IN.PrechodDopravnika AND NOT P1_Vytah.RFID_hlava.PritomnostPaletky THEN
				P1_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
				SC_P1_Vytah.ResetStep:= TRUE;
				SC_P1_Vytah.Step:= 100;
			END_IF		
		
       
	
			
	
	
			//*******************************************************Manu·lny reûim*******************************************************************************//
		700:
			SC_P1_Vytah.StepName:='700 - Manualny Rezim';
			SC_P1_Vytah.IdleTime.PT:= T#8s;
			SC_P1_Vytah.AlarmTime.PT:= T#5s;
				
					
			
			//Parametre serva pre jogging//
			P1_Vytah.ServoZdvihuVytahu.Parameters.Jog.Acc:= 50;
			P1_Vytah.ServoZdvihuVytahu.Parameters.Jog.Velocity:= P1_Vytah.PAR.Zdvih_JoggRychlost;
			P1_Vytah.ServoZdvihuVytahu.Command.TorqueLimitation:= TRUE;
			
			
			IF P1_Vytah.CMD.RR_ZdvihVytahu_DOLE AND P1_Vytah.ServoZdvihuVytahu.Status.ActPosition > P1_RemPremenne.P1_Vytah_PoziciaNakladania THEN
				P1_Vytah.ServoZdvihuVytahu.Command.JogPos:= FALSE;
				P1_Vytah.ServoZdvihuVytahu.Command.JogNeg:= TRUE;
			ELSIF P1_Vytah.CMD.RR_ZdvihVytahu_HORE AND P1_Vytah.ServoZdvihuVytahu.Status.ActPosition < P1_RemPremenne.P1_Vytah_PoziciaVykladania THEN
				P1_Vytah.ServoZdvihuVytahu.Command.JogNeg:= FALSE;
				P1_Vytah.ServoZdvihuVytahu.Command.JogPos:= TRUE;
			ELSE
				P1_Vytah.ServoZdvihuVytahu.Command.JogNeg:= FALSE;
				P1_Vytah.ServoZdvihuVytahu.Command.JogPos:= FALSE;
			END_IF	
			
        
			//Ovl·danie dopravnÌka v˝ùahu//
			IF P1_Vytah.CMD.RR_ChodDopravnika_VPRED THEN
				P1_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
				P1_Vytah.OUT.DopravnikChod_VPRED:= TRUE;
			ELSIF P1_Vytah.CMD.RR_ChodDopravnika_VZAD THEN
				P1_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
				P1_Vytah.OUT.DopravnikChod_VZAD:= TRUE; 
			ELSE
				P1_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
				P1_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
			END_IF    
        
		
		
		
		
		
	END_CASE
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

