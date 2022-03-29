
PROGRAM _INIT
	
	//Init parametre serva zdvihu v˝ùahu//
	P4_Vytah.ServoZdvihuVytahu.Parameters.Override:= 100;
	P4_Vytah.PAR.Zdvih_JoggRychlost:= 0.1;
	P4_Vytah.ServoZdvihuVytahu.Command.TorqueLimitation:= TRUE;
	P4_Vytah.ServoZdvihuVytahu.Parameters.Torque:= 1.0;
 
END_PROGRAM

PROGRAM _CYCLIC
	
	
		
	//Volanie podprogramov a kniûnÌc//
	IOLinkKomunikacia;
	
	 
	
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P4_Vytah);
	
	//Enable serva//
	IF Safety.STAV.P4_ZonaVytahu_AKTIVNA AND NOT P4_Vytah.ServoZdvihuVytahu.Command.ErrReset THEN
		P4_Vytah.ServoZdvihuVytahu.Command.PowerON:= TRUE;
	ELSE
		P4_Vytah.ServoZdvihuVytahu.Command.PowerON:= FALSE;
	END_IF	
	
	
	//Reset poruchy serva//
	IF P4_Vytah.ServoZdvihuVytahu.Command.ErrReset AND NOT P4_Vytah.ServoZdvihuVytahu.Status.Error THEN
		P4_Vytah.ServoZdvihuVytahu.Command.ErrReset:= FALSE;
	END_IF	
	
	
	//Zhasnutie Bannera//
	IF P4_Vytah.CMD.Banner_LED_OFF THEN
		P4_Vytah.Banner.IN.ModraLED_ON:= FALSE;
		P4_Vytah.Banner.IN.CervenaLED_ON:= FALSE;
		P4_Vytah.Banner.IN.CyanLED_ON:= FALSE;
		P4_Vytah.Banner.IN.ModraRotujucaLED_ON:= FALSE;
		P4_Vytah.Banner.IN.OranzovaLED_ON:= FALSE;
		P4_Vytah.Banner.IN.ZelenaLED_ON:= FALSE;
		P4_Vytah.Banner.IN.ZltaLED_ON:= FALSE;
		P4_Vytah.CMD.Banner_LED_OFF:= FALSE;
	END_IF	
	
	
	//Reset sekcie //
	IF P4_Vytah.Reset THEN
		SC_P4_Vytah.Step:= 0;
		P4_Vytah.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P4_Vytah.Step:= 0;
	ELSIF NOT Safety.STAV.P4_ZonaVytahu_AKTIVNA THEN
		SC_P4_Vytah.Step:= 0;
	END_IF	
	
	
	
	CASE SC_P4_Vytah.Step OF 
	
	
		0:
			SC_P4_Vytah.StepName:='0 - Nulovanie';
			P4_Vytah.Automat:= FALSE;
			P4_Vytah.KoniecCyklu:= FALSE;
			P4_Vytah.Manual:= FALSE;
			P4_Vytah.STAV.PoINIT:= FALSE;
			P4_Vytah.ServoZdvihuVytahu.Command.JogNeg:= FALSE;
			P4_Vytah.ServoZdvihuVytahu.Command.JogPos:= FALSE;
			P4_Vytah.ServoZdvihuVytahu.Command.MoveAdditive:= FALSE;
			P4_Vytah.ServoZdvihuVytahu.Command.MovePosition:= FALSE;
			IF NOT P4_Vytah.ServoZdvihuVytahu.Status.StandStill THEN
				P4_Vytah.ServoZdvihuVytahu.Command.Stop:= TRUE;
			END_IF	
			P4_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
			P4_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
			P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
			P4_Vytah.RFID_hlava.PrecitajChipRFID:= FALSE;
			TRCB_P4_Vytah_ST10.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P4_Vytah_ST10.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P4_Vytah_ST10.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P4_Vytah_ST10.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
			P4_Vytah.CMD.RR_ChodDopravnika_VPRED:= FALSE;
			P4_Vytah.CMD.RR_ChodDopravnika_VZAD:= FALSE;
			P4_Vytah.CMD.RR_ZdvihVytahu_DOLE:= FALSE;
			P4_Vytah.CMD.RR_ZdvihVytahu_HORE:= FALSE;
			CAM16.CMD.Triger:= FALSE;
			CAM16.STAV.Results_READY:= FALSE;
			FTP_CAM16.CMD.OdosliFotku:= FALSE;
			FTP_CAM16.CMD.VymazFotku:= FALSE;
			P34_Vizu.ZobrazHL1_ST10:= FALSE;
			P34_Vizu.ZobrazHL2_ST10:= FALSE;
			P34_Vizu.ZobrazHL3_ST10:= FALSE;
			P34_Vizu.ZobrazHL4_ST10:= FALSE;
			P34_Vizu.ZobrazHL5_ST10:= FALSE;
			P34_Vizu.ZobrazHL6_ST10:= FALSE;
			P34_Vizu.ZobrazHL7_ST10:= FALSE;
			P34_Vizu.ZobrazHL8_ST10:= FALSE;
			P34_Vizu.ZobrazHL9_ST10:= FALSE;
			P4_Vytah_KAM_Result_Ignoruj:= FALSE;
			P4_Vytah_KAM_Result_OK:= FALSE;
			P4_Vytah_KAM_Result_NG:= FALSE;
			P4_Vytah.PAR.IndexFotky:= 0;
			TRCB_P4_Vytah_OpatovnyDopyt:= FALSE;
			TRCB_P4_Vytah_PaletkaNG:= FALSE;
			PocetTrigrovKamery:= 0;
			PocetDopytovNaServer:= 0;
			CisloFotky:= 0;
			TestovaciKus:= FALSE;
			Stav_VlozenaPaletka:= FALSE;
			
			P4_Etiketovacka.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P4_Vytah.STAV.PrebiehaVyvezeniePaletky:= FALSE;
            
			
			IF Safety.STAV.P4_ZonaVytahu_AKTIVNA AND
				P4_Pracovisko.STAV.HardwareVytahu_OK AND
				NOT P4_Pracovisko.STAV.Porucha_ST6 AND
				P4_Vytah.ServoZdvihuVytahu.Status.Ready AND
				P4_Vytah.ServoZdvihuVytahu.Status.StandStill THEN
				P4_Vytah.ServoZdvihuVytahu.Command.Stop:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 1;
			END_IF
	
		1:
			SC_P4_Vytah.StepName:='1 - Cakam na spustenie vyroby';
			P4_Vytah.KoniecCyklu:= FALSE;
			IF P4_Vytah.Automat THEN
				SC_P4_Vytah.Step:= 2;
			ELSIF P4_Vytah.Manual THEN
				SC_P4_Vytah.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializ·cia****************************************************************************//	
		
		2:
			SC_P4_Vytah.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P4_Vytah.IdleTime.PT:= T#2s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			SC_P4_Vytah.IdleTime.IN:= P4_Dopravniky.STAV.PoINIT;
			
			P4_Vytah.ServoZdvihuVytahu.Parameters.Acc:= P34_RemPremenne.P4_Vytah_Zdvih_Acc;
			P4_Vytah.ServoZdvihuVytahu.Parameters.Dcc:= P34_RemPremenne.P4_Vytah_Zdvih_Dcc;
			P4_Vytah.ServoZdvihuVytahu.Parameters.Torque:= 1.5;
			
			IF SC_P4_Vytah.IdleTime.Q THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 3;
			END_IF
		
		3:		
			SC_P4_Vytah.StepName:='3 - Inicializacia - vymazanie adresara kamery'; 
			SC_P4_Vytah.IdleTime.PT:= T#4s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;	
			
			P4_Vytah.Banner.IN.ModraLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 4;
			ELSIF NOT SC_P4_Vytah.Switch1 THEN
				FTP_CAM16.CMD.VymazFotku:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM16.STATUS.KomunikaciaUkoncena THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM16.CMD.VymazFotku:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 4;
			ELSIF FTP_CAM16.STATUS.KomunikaciaError THEN
				P34_Alarmy[410]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	
		
		
		4:
			SC_P4_Vytah.StepName:='4 - Inicializacia - spustam dopravnik vytahu pre navezenie paletky';
			SC_P4_Vytah.IdleTime.PT:= T#500ms;
			SC_P4_Vytah.AlarmTime.PT:= T#7s;
			
			SC_P4_Vytah.IdleTime.IN:= P4_Vytah.RFID_hlava.PritomnostPaletky;
			
			IF NOT SC_P4_Vytah.Switch1 THEN
				P4_Vytah.OUT.DopravnikChod_VPRED:= TRUE;
				SC_P4_Vytah.AlarmTime.IN:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF SC_P4_Vytah.IdleTime.Q AND NOT P4_Vytah.IN.PrechodDopravnika THEN
				P4_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 13;
			ELSIF SC_P4_Vytah.AlarmTime.Q AND NOT P4_Vytah.RFID_hlava.PritomnostPaletky AND NOT P4_Vytah.IN.PrechodDopravnika THEN	
				P4_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 13;
			ELSIF SC_P4_Vytah.IdleTime.Q AND P4_Vytah.IN.PrechodDopravnika THEN		
				P34_Alarmy[411]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	
			
		13:
			SC_P4_Vytah.StepName:='13 - Inicializacia - presuvam vytah do hornej pozicie vyvazania';
			SC_P4_Vytah.IdleTime.PT:= T#1s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
	
			SC_P4_Vytah.IdleTime.IN:= Safety.STAV.P4_Vytah_Bariera_AKTIVNA;
			P34_Vizu.ZobrazHL6_ST10:= NOT Safety.STAV.P4_Vytah_Bariera_AKTIVNA;
			
			
			P4_Vytah.ServoZdvihuVytahu.Parameters.Velocity:= P34_RemPremenne.P4_Vytah_RychlostZdvihu/1000;
			P4_Vytah.ServoZdvihuVytahu.Parameters.Position:= P34_RemPremenne.P4_Vytah_PoziciaNakladania;
			
			
			P4_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;		
					
			IF NOT SC_P4_Vytah.Switch1 AND SC_P4_Vytah.IdleTime.Q THEN
				P4_Vytah.ServoZdvihuVytahu.Command.MovePosition:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P4_Vytah.ServoZdvihuVytahu.Status.InPosition) THEN
				P4_Vytah.ServoZdvihuVytahu.Command.MovePosition:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				P34_Vizu.ZobrazHL6_ST10:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 15;
			END_IF	
		
		
		15:
			SC_P4_Vytah.StepName:='15 - Inicializacia - kontrola pritomnosti paletky';
			SC_P4_Vytah.IdleTime.PT:= T#2s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			IF P4_Vytah.RFID_hlava.PritomnostPaletky THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 18;   
			ELSE
				P4_Vytah.STAV.PoINIT:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 100;
			END_IF	
		
		18:
			SC_P4_Vytah.StepName:='18 - Inicializacia -  precitanie cisla paletky';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			SC_P4_Vytah.IdleTime.IN:= TRUE;
			
			SC_P4_Vytah.IdleTime.IN:= P4_Vytah.RFID_hlava.PritomnostPaletky;
									
			IF SC_P4_Vytah.IdleTime.Q THEN
				P4_Vytah.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
			END_IF
			
			IF P4_Vytah.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P4_Vytah.RFID_hlava.PrecitaneCisloPaletky;
				P4_Vytah.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 20;
			END_IF	  
		
	
		20:
			SC_P4_Vytah.StepName:='20 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P4_Vytah.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 30;
			ELSE
				P34_Alarmy[418]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	
		
		
		30:
			SC_P1_StoperSrobovania.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P4_Vytah.STAV.PoINIT:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' THEN
				P4_Vytah.STAV.PoINIT:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_10' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_10' THEN
				P4_Vytah.STAV.PoINIT:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P4_Vytah.STAV.PoINIT:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			END_IF	
		
		
		33:
			SC_P4_Vytah.StepName:='33 - Inicializacia - kontrola uzavretia komunikacie s Panatrace';
			SC_P4_Vytah.IdleTime.PT:= T#5s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
            
			
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P4_Vytah.STAV.PoINIT:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			ELSE
				P4_Vytah.STAV.PoINIT:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 111;
			END_IF	
		
		
		//********************************************************Automatick˝ reûim****************************************************************************//
	
		100:
			SC_P4_Vytah.StepName:='100 - Automaticky Rezim - cakam na navezenie paletky na vytah z vrchneho dopravnika';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;	
		
			
			P4_Vytah.ServoZdvihuVytahu.Parameters.Acc:= P34_RemPremenne.P4_Vytah_Zdvih_Acc;
			P4_Vytah.ServoZdvihuVytahu.Parameters.Dcc:= P34_RemPremenne.P4_Vytah_Zdvih_Dcc;
			P4_Vytah.ServoZdvihuVytahu.Parameters.Torque:= 1.5;
			
			
						
			IF P4_Vytah.KoniecCyklu AND NOT P4_Etiketovacka.Automat THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 0;
			ELSIF SC_P4_Etiketovacka.Step = 561 AND NOT P4_Vytah.RFID_hlava.PritomnostPaletky AND NOT P4_Vytah.IN.PrechodDopravnika THEN
				Stav_VlozenaPaletka:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 101;
			ELSIF P4_Vytah.RFID_hlava.PritomnostPaletky THEN
				P4_Etiketovacka.STAV.PrebiehaVyvezeniePaletky:= FALSE;
				Stav_VlozenaPaletka:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 105;
			END_IF	
		
		
		
		101:
			SC_P4_Vytah.StepName:='101 - Automaticky Rezim - navazam paletku na dopravnik vytahu';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#20s;
		
			SC_P4_Vytah.IdleTime.IN:= P4_Vytah.RFID_hlava.PritomnostPaletky;
			
		    
            
			IF NOT SC_P4_Vytah.Switch1 THEN
				P4_Vytah.OUT.DopravnikChod_VPRED:= TRUE;
				SC_P4_Vytah.AlarmTime.IN:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF SC_P4_Vytah.IdleTime.Q THEN
				P4_Etiketovacka.STAV.PrebiehaVyvezeniePaletky:= FALSE;
				P4_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 105;
			ELSIF SC_P4_Vytah.AlarmTime.Q THEN
				P34_Alarmy[416]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	
		
		
		105:
			SC_P4_Vytah.StepName:='105 - Automaticky Rezim - precitanie cisla paletky';
			SC_P4_Vytah.IdleTime.PT:= T#500ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			SC_P4_Vytah.IdleTime.IN:= TRUE;
			
			IF NOT SC_P4_Vytah.Switch1 THEN
				i:= 0;
				P4_Vytah.RFID_hlava.PrecitajChipRFID:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF	
			
					
			IF P4_Vytah.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P4_Vytah.RFID_hlava.PrecitaneCisloPaletky;
				P4_Vytah.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 108;
			END_IF	
	
		
		108:
			SC_P4_Vytah.StepName:='108 - Automaticky Rezim - kontrola a priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
		
						
			IF i<> 0 THEN
				P4_Vytah.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				IF Stav_VlozenaPaletka THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 130;
				ELSE    
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 110;
				END_IF	
			ELSE
				P34_Alarmy[418]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	
		
		
		110:       
			SC_P4_Vytah.StepName:='110 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_10' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 111;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_10' THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 111;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			END_IF	
		
	
		
		111:
			SC_P4_Vytah.StepName:='111 - Automaticky Rezim - kontrola prihlasenia operatora';
			SC_P4_Vytah.IdleTime.PT:= T#1s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
            
                        
            
			IF P34_UzivatelPrihlaseny THEN
				Paletka[i].PAR.ID_Operatora:= 'E2';//UsersVizu.CisloPrihlasenejKarty_Panel3;
				P34_Vizu.ZobrazHL7_ST10:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 113;
			ELSE
				P4_Vytah.Banner.IN.CyanLED_ON:= Blikac500ms;
				P34_Vizu.ZobrazHL7_ST10:= TRUE;
				Paletka[i].PAR.ID_Operatora:= '';
			END_IF    
		
		
		113:
			SC_P4_Vytah.StepName:='113 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#10s;	
			
			P4_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
			
			IF Linka.KOM_Panatrace_OFF THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 118;
			ELSIF NOT SC_P4_Vytah.Switch1 THEN
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P4_Vytah_ST10.STATUS.KomunikaciaUkoncena THEN
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 114;
			ELSIF TRCB_P4_Vytah_ST10.STATUS.KomunikaciaError THEN	
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 117;
			END_IF	
		
		
		114:
			SC_P4_Vytah.StepName:='114 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P4_Vytah_ST10.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 114;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 114;	
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 114;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 114;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 114;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 114;
				END_IF   
			END_IF
		
		
		115:
			SC_P4_Vytah.StepName:='115 - Automaticky Rezim - vyziadanie stavu paletky zo servera'; 
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;	
			SC_P4_Vytah.IdleTime.IN:= TRUE;
		
			            
			IF NOT SC_P4_Vytah.Switch1 THEN
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P4_Vytah_ST10.STATUS.KomunikaciaUkoncena THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 116;
			ELSIF TRCB_P4_Vytah_ST10.STATUS.KomunikaciaError THEN	
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 117;
			END_IF	
			
		
			
		116:
			SC_P4_Vytah.StepName:='116 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;		
				
			IF NOT TRCB_P4_Vytah_ST10.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P4_Vytah_ST10.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					CAM16.STAV.Results_READY:= FALSE;
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 118;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 117; 
				END_IF	
			END_IF	
		
            
		117:
			SC_P4_Vytah.StepName:='117 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
            
			P34_Vizu.ZobrazHL9_ST10:= TRUE;
            
			IF TRCB_P4_Vytah_OpatovnyDopyt THEN
				TRCB_P4_Vytah_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL9_ST10:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 113;
			ELSIF TRCB_P4_Vytah_PaletkaNG THEN
				TRCB_P4_Vytah_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL9_ST10:= FALSE;
				Paletka[i].PAR.StavPaletky := 'NG';
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			END_IF   
		
		
		118:
			SC_P4_Vytah.StepName:='118 - Automaticky Rezim - kamerova kontrola paletky CAM16';//CAM 16
			SC_P4_Vytah.IdleTime.PT:= T#5s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
            
            P4_Vytah.Banner.IN.ModraLED_ON:= TRUE;
            
			IF Linka.P4_Kamery_OFF THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 122;
			ELSIF NOT SC_P4_Vytah.Switch1 AND CAM16.STAV.Command_READY THEN
				CAM16.CMD.Triger:= TRUE;
				SC_P4_Vytah.IdleTime.IN:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF
			
			IF CAM16.STAV.Results_READY AND CAM16.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM16.STAV.Results_READY:= FALSE;
				CAM16.CMD.Triger:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 120;
			ELSIF SC_P4_Vytah.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM16.CMD.Triger:= FALSE;
				CAM16.STAV.Results_READY:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 119;
			ELSIF SC_P4_Vytah.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P34_Alarmy[455]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF
        
            
                   
            
            
		119:
			SC_P4_Vytah.StepName:='119 - Automaticky Rezim - cakam na opatovny triger kamery CAM16';
			SC_P4_Vytah.IdleTime.PT:= T#1s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;    
            
			SC_P4_Vytah.IdleTime.IN:= TRUE;
            
			IF SC_P4_Vytah.IdleTime.Q THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 118;
			END_IF
		
		120:
			SC_P4_Vytah.StepName:='120 - Automaticky Rezim - vysledok kamerovej kontroly kamery CAM16';
			SC_P4_Vytah.IdleTime.PT:= T#1s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;  
            
            
			IF NOT CAM16.STAV.BUSY THEN
				CAM16.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					P4_Vytah.STAV.Kamera_VysledkyM5_ENABLE:= TRUE;
					IF CAM16.RESULT.PowerCP.PritomnostSkrutky_K40 AND
						CAM16.RESULT.PowerCP.PritomnostSkrutky_M5 THEN
						CAM16.PAR.ResultFotky:= 'PASS';
						SC_P4_Vytah.ResetStep:= TRUE;
						SC_P4_Vytah.Step:= 121;
					ELSE
						CAM16.PAR.ResultFotky:= 'FAIL';
						SC_P4_Vytah.ResetStep:= TRUE;
						SC_P4_Vytah.Step:= 121;
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P4_Vytah.STAV.Kamera_VysledkyM5_ENABLE:= TRUE;
					IF CAM16.RESULT.PowerCP.PritomnostSkrutky_K40 AND
						CAM16.RESULT.PowerCP.PritomnostSkrutky_M5 THEN
						CAM16.PAR.ResultFotky:= 'PASS';
						SC_P4_Vytah.ResetStep:= TRUE;
						SC_P4_Vytah.Step:= 121;
					ELSE
						CAM16.PAR.ResultFotky:= 'FAIL';
						SC_P4_Vytah.ResetStep:= TRUE;
						SC_P4_Vytah.Step:= 121;
					END_IF 
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					P4_Vytah.STAV.Kamera_VysledkyM5_ENABLE:= FALSE;
					IF CAM16.RESULT.PowerCP.PritomnostSkrutky_K40 THEN
						CAM16.PAR.ResultFotky:= 'PASS';
						SC_P4_Vytah.ResetStep:= TRUE;
						SC_P4_Vytah.Step:= 121;
					ELSE
						CAM16.PAR.ResultFotky:= 'PASS';
						(*CAM16.PAR.ResultFotky:= 'FAIL';*)
						SC_P4_Vytah.ResetStep:= TRUE;
						SC_P4_Vytah.Step:= 121;
					END_IF    
				END_IF
			END_IF
            
            
		121:
			SC_P4_Vytah.StepName:='121 - Automaticky Rezim - kontrola vysledku kamery';
			SC_P4_Vytah.IdleTime.PT:= T#1s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
            
			            
			IF CAM16.PAR.ResultFotky = 'PASS' THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 122;
			ELSIF CAM16.PAR.ResultFotky = 'FAIL' THEN
				P34_Vizu.ZobrazHL8_ST10:= TRUE;
				IF P4_Vytah_KAM_Result_OK THEN
					P4_Vytah_KAM_Result_OK:= FALSE;
					P34_Vizu.ZobrazHL8_ST10:= FALSE;
					CAM16.PAR.ResultFotky:= 'PASS';
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 122;
				ELSIF P4_Vytah_KAM_Result_NG THEN
					P4_Vytah_KAM_Result_NG:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					P34_Vizu.ZobrazHL8_ST10:= FALSE;
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 122;
				END_IF
			END_IF    
            
            
                    
            
		122:
			SC_P4_Vytah.StepName:='122 - Automaticky Rezim - odoslanie fotky CAM16 na server Panasonic';
			SC_P4_Vytah.IdleTime.PT:= T#1s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			SC_P4_Vytah.IdleTime.IN:= TRUE;
            
			P4_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 123;
			ELSIF NOT SC_P4_Vytah.Switch1 THEN
				FTP_CAM16.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM16.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM16.INPUTS.Result:= CAM11.PAR.ResultFotky;
				Reports.Kamery.P4_CAM16_KontrolaPaletky:= CAM11.PAR.ResultFotky;
                      
				FTP_CAM16.CMD.OdosliFotku:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF
            
			
			IF FTP_CAM16.STATUS.KomunikaciaUkoncena THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM16.CMD.OdosliFotku:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 123;
			ELSIF FTP_CAM6.STATUS.KomunikaciaError THEN
				P34_Alarmy[413]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	
		
		
		
		123:
			SC_P4_Vytah.StepName:='123 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#10s;	
			
			P4_Vytah.Banner.IN.ModraRotujucaLED_ON:= TRUE;
			
			IF Linka.KOM_Panatrace_OFF THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			ELSIF NOT SC_P4_Vytah.Switch1 THEN
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P4_Vytah_ST10.STATUS.KomunikaciaUkoncena THEN
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 124;
			ELSIF TRCB_P4_Vytah_ST10.STATUS.KomunikaciaError THEN	
				TRCB_P4_Vytah_ST10.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P34_Alarmy[415]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	
		
		
		124:
			SC_P4_Vytah.StepName:='124 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P4_Vytah_ST10.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 124;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 124;	
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 124;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 124;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 124;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 124;
				END_IF   
			END_IF
		
		
		125:
			SC_P4_Vytah.StepName:='125 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P4_Vytah.IdleTime.PT:= T#500ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			SC_P4_Vytah.IdleTime.IN:= TRUE;
			
			            
			IF NOT SC_P4_Vytah.Switch1 THEN
				TRCB_P4_Vytah_ST10.CMD.OdosliStavPaletky_TYP2:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF 
           
                
			
			IF TRCB_P4_Vytah_ST10.STATUS.KomunikaciaUkoncena THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				TRCB_P4_Vytah_ST10.CMD.OdosliStavPaletky_TYP2:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 126;
			ELSIF TRCB_P4_Vytah_ST10.STATUS.KomunikaciaError THEN	
				P34_Alarmy[415]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF
			
		126:
			SC_P4_Vytah.StepName:='126 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			
			IF NOT TRCB_P4_Vytah_ST10.STATUS.KomunikaciaUkoncena THEN
				Paletka[i].STAV.Komunikacia_DONE:= TRUE;
				IF TRCB_P4_Vytah_ST10.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 130;
				ELSIF TRCB_P4_Vytah_ST10.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 130;
				END_IF	
			END_IF
		
		
		130:
			SC_P4_Vytah.StepName:='130 - Automaticky Rezim - cakam na spustenie kamerovej kontroly paletky';
			SC_P4_Vytah.IdleTime.PT:= T#500ms;
			SC_P4_Vytah.AlarmTime.PT:= T#20s;
			
			IF Paletka[i].PAR.StavPaletky = 'NG' THEN
				P4_Vytah.Banner.IN.CervenaLED_ON:= P4_Vytah.RFID_hlava.PritomnostPaletky;
			ELSE    
				P4_Vytah.Banner.IN.ZelenaLED_ON:= P4_Vytah.RFID_hlava.PritomnostPaletky;
			END_IF	
                
                
			IF P4_Vytah.KoniecCyklu THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 0;	
			ELSIF NOT P4_SpodnyStoper.IN.ZaplnenieDopravnika AND P4_Vytah.RFID_hlava.PritomnostPaletky AND Safety.STAV.P4_Vytah_Bariera_AKTIVNA AND P4_Vytah.Banner.OUT.Stlaceny  THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				CAM16.STAV.Results_READY:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 133;
			ELSIF NOT P4_Vytah.RFID_hlava.PritomnostPaletky THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 100;
			END_IF
		
		
		133:
			SC_P4_Vytah.StepName:='133 - Automaticky Rezim - kamerova kontrola paletky CAM16';//CAM 16//
			SC_P4_Vytah.IdleTime.PT:= T#5s;
			SC_P4_Vytah.AlarmTime.PT:= T#10s;
		
            P4_Vytah.Banner.IN.ModraLED_ON:= TRUE;
		
			IF Linka.P4_Kamery_OFF THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;	
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 560;
			ELSIF NOT SC_P4_Vytah.Switch1 AND CAM16.STAV.Command_READY THEN
				CAM16.CMD.Triger:= TRUE;
				SC_P4_Vytah.IdleTime.IN:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF
			
			IF CAM16.STAV.Results_READY AND CAM16.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM16.STAV.Results_READY:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;	
				IF NOT Linka.STAV.VyprazdnenieLinky THEN
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 135;
				ELSE
					SC_P4_Vytah.ResetStep:= TRUE;
					SC_P4_Vytah.Step:= 136;
				END_IF	
			ELSIF SC_P4_Vytah.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM16.CMD.Triger:= FALSE;
				CAM16.STAV.Results_READY:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;	
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 134;
			ELSIF SC_P4_Vytah.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P34_Alarmy[455]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;    
			END_IF	
		
            
                      
            
            
            
		134:
			SC_P4_Vytah.StepName:='134 - Automaticky Rezim - cakam na opatovny triger kamery CAM16';
			SC_P4_Vytah.IdleTime.PT:= T#2s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;    
            
			SC_P4_Vytah.IdleTime.IN:= TRUE;
            
			IF SC_P4_Vytah.IdleTime.Q THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 133;
			END_IF
                
		135:
			SC_P4_Vytah.StepName:='135 - Automaticky Rezim - kontrola vysledku kamery';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			SC_P4_Vytah.IdleTime.IN:= TRUE;
				
            			
			
			IF NOT CAM16.STAV.BUSY THEN
				CAM16.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF CAM16.RESULT.Paletka.Pritomn_Busbarov_4F AND
						CAM16.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM16.RESULT.Paletka.Pritomn_PravyMVcase AND
						NOT CAM16.RESULT.Paletka.Pritomn_PowerCP THEN
						CAM16.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM16.PAR.ResultFotky:= 'FAIL';
					END_IF	
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF CAM16.RESULT.Paletka.Pritomn_Busbarov_5F AND
						CAM16.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM16.RESULT.Paletka.Pritomn_PravyMVcase AND
						NOT CAM16.RESULT.Paletka.Pritomn_PowerCP THEN
						CAM16.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM16.PAR.ResultFotky:= 'FAIL';
					END_IF	
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN	
					IF CAM16.RESULT.Paletka.Pritomn_Busbarov_5H AND
						CAM16.RESULT.Paletka.Pritomn_LavyMVcase AND
						CAM16.RESULT.Paletka.Pritomn_PravyMVcase AND
						NOT CAM16.RESULT.Paletka.Pritomn_PowerCP THEN
						CAM16.PAR.ResultFotky:= 'PASS';
					ELSE
						CAM16.PAR.ResultFotky:= 'FAIL';
					END_IF	
				END_IF	
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 138;
			END_IF	
		
		
		
		136:
			SC_P4_Vytah.StepName:='136 - Automaticky Rezim - kontrola vysledku kamery pri vyprazdneni linky';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			SC_P4_Vytah.IdleTime.IN:= TRUE;
			
            
			
			IF NOT CAM16.STAV.BUSY THEN
				CAM16.CMD.Triger:= FALSE;
				IF NOT CAM16.RESULT.Paletka.Pritomn_Busbarov_4F AND
					NOT CAM16.RESULT.Paletka.Pritomn_Busbarov_5F AND
					NOT CAM16.RESULT.Paletka.Pritomn_Busbarov_5H AND
					NOT	CAM16.RESULT.Paletka.Pritomn_LavyMVcase AND
					NOT	CAM16.RESULT.Paletka.Pritomn_PravyMVcase AND
					NOT CAM16.RESULT.Paletka.Pritomn_PowerCP THEN
					CAM16.PAR.ResultFotky:= 'PASS';
				ELSE
					CAM16.PAR.ResultFotky:= 'FAIL';
				END_IF
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 138;
			END_IF	
		
		
		138:
			SC_P4_Vytah.StepName:='138 - Automaticky Rezim - vymazanie adresara kamery'; 
			SC_P4_Vytah.IdleTime.PT:= T#4s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;	
			
			P4_Vytah.Banner.IN.ModraLED_ON:= TRUE;
            
			IF Linka.KOM_FTP_OFF THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 140;
			IF NOT SC_P4_Vytah.Switch1 THEN
				FTP_CAM16.CMD.VymazFotku:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM16.STATUS.KomunikaciaUkoncena THEN
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				FTP_CAM16.CMD.VymazFotku:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 140;
			ELSIF FTP_CAM16.STATUS.KomunikaciaError THEN
				P34_Alarmy[410]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	   
            
            
            
				
		140:
			SC_P4_Vytah.StepName:='140 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly paletky';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
				
				
			IF CAM16.PAR.ResultFotky = 'PASS' THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 560;
			ELSIF CAM16.PAR.ResultFotky = 'FAIL' THEN    
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 143;
			END_IF
		
			
			
		143:
			SC_P4_Vytah.StepName:='143 - Automaticky Rezim - zobrazenie hlasenia naloz spravny material na paletku';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			P4_Vytah.Banner.IN.CervenaLED_ON:= Blikac500ms;
			
			
			IF NOT SC_P4_Vytah.Switch1 THEN
				IF Linka.STAV.VyprazdnenieLinky THEN
					P34_Vizu.ZobrazHL4_ST10:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '4F' THEN
					P34_Vizu.ZobrazHL1_ST10:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					P34_Vizu.ZobrazHL2_ST10:= TRUE;
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					P34_Vizu.ZobrazHL3_ST10:= TRUE;
				END_IF    
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF
						
				
			IF P4_Vytah.Banner.OUT.Stlaceny THEN
				P34_Vizu.ZobrazHL1_ST10:= FALSE;
				P34_Vizu.ZobrazHL2_ST10:= FALSE;
				P34_Vizu.ZobrazHL3_ST10:= FALSE;
				P34_Vizu.ZobrazHL4_ST10:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 130;
			ELSIF P4_Vytah_KAM_Result_Ignoruj THEN
				P4_Vytah_KAM_Result_Ignoruj:= FALSE;
				P34_Vizu.ZobrazHL1_ST10:= FALSE;
				P34_Vizu.ZobrazHL2_ST10:= FALSE;
				P34_Vizu.ZobrazHL3_ST10:= FALSE;
				P34_Vizu.ZobrazHL4_ST10:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 560;	
			END_IF
				
        
	

		//***********************************Vyvezenie paletky****************************************//		
		560:
			SC_P4_Vytah.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na spodny dopravnik';
			SC_P4_Vytah.IdleTime.PT:= T#1s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
		
						
			SC_P4_Vytah.IdleTime.IN:= NOT P4_SpodnyStoper.IN.ZaplnenieDopravnika;
			P34_Vizu.ZobrazHL6_ST10:= NOT Safety.STAV.P4_Vytah_Bariera_AKTIVNA;
			
			IF P4_Vytah.KoniecCyklu THEN
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 0;	
			ELSIF SC_P4_Vytah.IdleTime.Q AND P4_Vytah.RFID_hlava.PritomnostPaletky AND Safety.STAV.P4_Vytah_Bariera_AKTIVNA AND NOT P4_Vytah.IN.PrechodDopravnika THEN
                Paletka[i].PAR.CisloPaletky:= '';
				Paletka[i].STAV.StavPaletky:= '';
				Paletka[i].STAV.TypModelu:= '';
				Paletka[i].STAV.KodModelu:= '';
				Paletka[i].PAR.QRkodFiltra_4F5F:= '';
				Paletka[i].PAR.QRkodFiltra_5H:= '';
				Paletka[i].PAR.QRkodPowerCP:= '';
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.CisloTestovacejStanice:= '';
				Paletka[i].STAV.CisloRevorkovejStanice:= '';
				Paletka[i].PAR.ID_Operatora:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Paletka[i].STAV.CisloEtiketyVyziadane:= FALSE;
				Paletka[i].STAV.FunkcnyTest_Ukonceny:= FALSE;
				Paletka[i].STAV.HV_Test_Ukonceny:= FALSE;
				Paletka[i].STAV.LeakageTest_Ukonceny:= FALSE;
				Paletka[i].STAV.QRkodFiltraPriradeny:= FALSE;
				Paletka[i].STAV.Zvaranie_Ukoncene:= FALSE;
				CisloFotky:= 0;
                Reports.Kamery.P4_CAM16_KontrolaPaletky:= '';
                P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				P34_Vizu.ZobrazHL6_ST10:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 563;
			ELSIF NOT P4_Vytah.RFID_hlava.PritomnostPaletky THEN
				P34_Vizu.ZobrazHL6_ST10:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 100;
			END_IF	
		
		563:
			SC_P4_Vytah.StepName:='563 - Automaticky Rezim - presuvam vytah do spodnej pozicie vyvazania';
			SC_P4_Vytah.IdleTime.PT:= T#1s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			
			SC_P4_Vytah.IdleTime.IN:= Safety.STAV.P4_Vytah_Bariera_AKTIVNA;
			P34_Vizu.ZobrazHL6_ST10:= NOT Safety.STAV.P4_Vytah_Bariera_AKTIVNA;
			
			P4_Vytah.ServoZdvihuVytahu.Parameters.Velocity:= P34_RemPremenne.P4_Vytah_RychlostZdvihu/1000;
			P4_Vytah.ServoZdvihuVytahu.Parameters.Position:= P34_RemPremenne.P4_Vytah_PoziciaVykladania;
			
			
			P4_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;		
					
			IF NOT SC_P4_Vytah.Switch1 AND SC_P4_Vytah.IdleTime.Q THEN
				P4_Vytah.ServoZdvihuVytahu.Command.MovePosition:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P4_Vytah.ServoZdvihuVytahu.Status.InPosition) THEN
				P4_Vytah.ServoZdvihuVytahu.Command.MovePosition:= FALSE;
				P34_Vizu.ZobrazHL6_ST10:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 565;
			END_IF	
		
		
		565:
			SC_P4_Vytah.StepName:='565 - Automaticky Rezim - vyvazam na spodny dopravnik';
			SC_P4_Vytah.IdleTime.PT:= T#3s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			P4_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;			
					
			IF P4_Dopravniky.STAV.PoINIT THEN
				P4_Vytah.OUT.DopravnikChod_VZAD:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 568;
			END_IF	
		
		
		
		568:
			SC_P4_Vytah.StepName:='568 - Automaticky Rezim - ukoncenie vyvazania na spodny dopravnik';
			SC_P4_Vytah.IdleTime.PT:= T#400ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
		
			P4_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;			
					
			IF EDGEPOS(P4_Vytah.IN.PrechodDopravnika) THEN
				SC_P4_Vytah.IdleTime.IN:= TRUE;
			END_IF    
			
			IF SC_P4_Vytah.IdleTime.Q AND NOT P4_Vytah.IN.PrechodDopravnika AND NOT P4_Vytah.RFID_hlava.PritomnostPaletky THEN
				P4_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 570;
			END_IF	
		
		570:
			SC_P4_Vytah.StepName:='570 - Automaticky Rezim - cakam na spustenie presunu vytahu do hornej pozicie navazania';
			SC_P4_Vytah.IdleTime.PT:= T#100ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
			
			P4_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;			
					
					
			SC_P4_Vytah.IdleTime.IN:= Safety.STAV.P4_Vytah_Bariera_AKTIVNA AND NOT P4_Vytah.IN.VystupDopravnikaVytahu_OS11 AND NOT P4_Vytah.IN.PritomnostPaletky_S13;
			P34_Vizu.ZobrazHL6_ST10:= NOT Safety.STAV.P4_Vytah_Bariera_AKTIVNA;
            
			IF SC_P4_Vytah.IdleTime.Q  THEN
				P34_Vizu.ZobrazHL6_ST10:= FALSE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 573;
			END_IF	
		
		
		573:
			SC_P4_Vytah.StepName:='573 - Automaticky Rezim - presuvam vytah do hornej pozicie navazania';
			SC_P4_Vytah.IdleTime.PT:= T#200ms;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
		
					
			P4_Vytah.Banner.IN.OranzovaLED_ON:= Blikac1s;			
					
			P4_Vytah.ServoZdvihuVytahu.Parameters.Velocity:= P34_RemPremenne.P4_Vytah_RychlostZdvihu/1000;
			P4_Vytah.ServoZdvihuVytahu.Parameters.Position:= P34_RemPremenne.P4_Vytah_PoziciaNakladania;
			
			
						
			IF NOT SC_P4_Vytah.Switch1 THEN
				P4_Vytah.ServoZdvihuVytahu.Command.MovePosition:= TRUE;
				SC_P4_Vytah.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P4_Vytah.ServoZdvihuVytahu.Status.InPosition) THEN
				P4_Vytah.ServoZdvihuVytahu.Command.MovePosition:= FALSE;
				P4_Vytah.CMD.Banner_LED_OFF:= TRUE;
				SC_P4_Vytah.ResetStep:= TRUE;
				SC_P4_Vytah.Step:= 100;
			END_IF	
		
			//*******************************************************Manu·lny reûim*******************************************************************************//
		700:
			SC_P4_Vytah.StepName:='700 - Manualny Rezim';
			SC_P4_Vytah.IdleTime.PT:= T#8s;
			SC_P4_Vytah.AlarmTime.PT:= T#5s;
				
		
		
			//Parametre serva pre jogging//
			P4_Vytah.ServoZdvihuVytahu.Parameters.Jog.Acc:= 50;
			P4_Vytah.ServoZdvihuVytahu.Parameters.Jog.Velocity:= P4_Vytah.PAR.Zdvih_JoggRychlost;
			P4_Vytah.ServoZdvihuVytahu.Command.TorqueLimitation:= TRUE;
			
			
			IF P4_Vytah.CMD.RR_ZdvihVytahu_DOLE AND P4_Vytah.ServoZdvihuVytahu.Status.ActPosition > P34_RemPremenne.P4_Vytah_PoziciaVykladania THEN
				P4_Vytah.ServoZdvihuVytahu.Command.JogPos:= FALSE;
				P4_Vytah.ServoZdvihuVytahu.Command.JogNeg:= TRUE;
			ELSIF P4_Vytah.CMD.RR_ZdvihVytahu_HORE AND P4_Vytah.ServoZdvihuVytahu.Status.ActPosition < P34_RemPremenne.P4_Vytah_PoziciaNakladania THEN
				P4_Vytah.ServoZdvihuVytahu.Command.JogNeg:= FALSE;
				P4_Vytah.ServoZdvihuVytahu.Command.JogPos:= TRUE;
			ELSE
				P4_Vytah.ServoZdvihuVytahu.Command.JogNeg:= FALSE;
				P4_Vytah.ServoZdvihuVytahu.Command.JogPos:= FALSE;
			END_IF	
			
        
			//Ovl·danie dopravnÌka v˝ùahu//
			IF P4_Vytah.CMD.RR_ChodDopravnika_VPRED THEN
				P4_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
				P4_Vytah.OUT.DopravnikChod_VPRED:= TRUE;
			ELSIF P4_Vytah.CMD.RR_ChodDopravnika_VZAD THEN
				P4_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
				P4_Vytah.OUT.DopravnikChod_VZAD:= TRUE; 
			ELSE
				P4_Vytah.OUT.DopravnikChod_VPRED:= FALSE;
				P4_Vytah.OUT.DopravnikChod_VZAD:= FALSE;
			END_IF    
        
		
		
		
		
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

