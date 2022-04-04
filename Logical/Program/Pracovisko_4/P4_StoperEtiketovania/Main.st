
PROGRAM _INIT
	
	//Init parametre serva zdvihu aplikatora//
	P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Override:= 100;
	P4_Etiketovacka.PAR.ZdvihAplikatora_JoggRychlost:= 0.1;
	P4_Etiketovacka.ServoZdvihuAplikatora.Command.TorqueLimitation:= TRUE;
	P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Torque:= 1.0;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P4_Etiketovacka);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	OvlOtacaniaAplikatora;
	IOLinkKomunikacia;
	COM_Tlaciaren;
	
	//Enable serva//
	IF Safety.STAV.P4_ZonaBunky_AKTIVNA AND NOT P4_Etiketovacka.ServoZdvihuAplikatora.Command.ErrReset THEN
		P4_Etiketovacka.ServoZdvihuAplikatora.Command.PowerON:= TRUE;
	ELSE
		P4_Etiketovacka.ServoZdvihuAplikatora.Command.PowerON:= FALSE;
	END_IF	
	
	
	//Reset poruchy serva//
	IF P4_Etiketovacka.ServoZdvihuAplikatora.Command.ErrReset AND NOT P4_Etiketovacka.ServoZdvihuAplikatora.Status.Error THEN
		P4_Etiketovacka.ServoZdvihuAplikatora.Command.ErrReset:= FALSE;
	END_IF
	
	
	
	
	//Reset sekcie //
	IF P4_Etiketovacka.Reset THEN
		SC_P4_Etiketovacka.Step:= 0;
		P4_Etiketovacka.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P4_Etiketovacka.Step:= 0;
	ELSIF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN	
		SC_P4_Etiketovacka.Step:= 0;
	END_IF	
	
	
	CASE SC_P4_Etiketovacka.Step OF 
	
	
		0:
			SC_P4_Etiketovacka.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			SC_OvlOtacaniaAplikatora.Step:= 0;
			P4_Etiketovacka.Automat:= FALSE;
			P4_Etiketovacka.KoniecCyklu:= FALSE;
			P4_Etiketovacka.Manual:= FALSE;
			P4_Etiketovacka.STAV.PoINIT:= FALSE;
			P4_Etiketovacka.OUT.ZasunStoper:= FALSE;
			P4_Etiketovacka.OUT.Aplikator_VYSUN:= FALSE;
			P4_Etiketovacka.OUT.Aplikator_OtocVPRED:= FALSE;
			P4_Etiketovacka.OUT.Aplikator_OtocVZAD:= TRUE;
			P4_Etiketovacka.OUT.OfukEtikety_ON:= FALSE;
			P4_Etiketovacka.OUT.PritlakPowerCP_VYSUN:= FALSE;
			P4_Etiketovacka.OUT.PrisavanieEtikety_ON:= FALSE;
			P4_Etiketovacka.OUT.PrisavanieEtikety_OFF:= FALSE;
			P4_Etiketovacka.RFID_hlava.PrecitajChipRFID:= FALSE;
			
			P4_Etiketovacka.ServoZdvihuAplikatora.Command.JogNeg:= FALSE;
			P4_Etiketovacka.ServoZdvihuAplikatora.Command.JogPos:= FALSE;
			P4_Etiketovacka.ServoZdvihuAplikatora.Command.MoveAdditive:= FALSE;
			P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= FALSE;
			IF NOT P4_Etiketovacka.ServoZdvihuAplikatora.Status.StandStill THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.Stop:= TRUE;
			END_IF	
			
			P4_Etiketovacka.CMD.RR_ZdvihAplikatora_DOLE:= FALSE;
			P4_Etiketovacka.CMD.RR_ZdvihAplikatora_HORE:= FALSE;
			P4_Etiketovacka.CMD.RR_NalepEtiketu:= FALSE;			
			
			CAM14.CMD.Triger:= FALSE;
			CAM14.STAV.Results_READY:= FALSE;
			FTP_CAM14.CMD.OdosliFotku:= FALSE;
			FTP_CAM14.CMD.VymazFotku:= FALSE;
			CAM15.CMD.Triger:= FALSE;
			CAM15.STAV.Results_READY:= FALSE;
			FTP_CAM15.CMD.OdosliFotku:= FALSE;
			FTP_CAM15.CMD.VymazFotku:= FALSE;
			
			TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P4_Etiketovacka_ST9.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P4_Etiketovacka_ST9.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P4_Etiketovacka_ST9.CMD.VyziadajCisloEtikety_TYP0:= FALSE;
			TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
			
					
            P4_Etiketov_KAM_Result_Ignoruj:= FALSE;
			P4_Etiketov_KAM_Result_OK:= FALSE;
			P4_Etiketov_KAM_Result_NG:= FALSE;
			P34_Vizu.ZobrazHL1_ST9:= FALSE;
			P34_Vizu.ZobrazHL2_ST9:= FALSE;
			P34_Vizu.ZobrazHL3_ST9:= FALSE;
			TRCB_P4_Etiketov_OpatovnyDopyt:= FALSE;
			TRCB_P4_Etiketov_PaletkaNG:= FALSE;
			PocetTrigrovKamery:= 0;
			PocetDopytovNaServer:= 0;
			CisloFotky:= 0;
			TestovaciKus:= FALSE;
			P4_Etiketovacka.STAV.PowerCP_ZhodaQRkodu_OK:= FALSE;
			P4_Etiketovacka.STAV.Etiketa_ZhodaQRkodu_OK:= FALSE;
			P4_Etiketovacka.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P4_ZdvizkaZaFunkcTestA.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			
			Tlaciaren.CMD.VytlacEtiketu:= FALSE;
			
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P4_ZonaBunky_AKTIVNA AND
				P4_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P4_Pracovisko.STAV.Porucha_ST1 AND
				NOT P4_Pracovisko.STAV.Porucha_ST2 AND
				NOT P4_Pracovisko.STAV.Porucha_ST3 AND
				NOT P4_Pracovisko.STAV.Porucha_ST4 AND
				NOT P4_Pracovisko.STAV.Porucha_ST5 AND
				NOT P4_Pracovisko.STAV.Porucha_ST6 THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 1;
			END_IF
	
		1:
			SC_P4_Etiketovacka.StepName:='1 - Cakam na spustenie vyroby';
			P4_Etiketovacka.KoniecCyklu:= FALSE;
			IF P4_Etiketovacka.Automat THEN
				SC_P4_Etiketovacka.Step:= 2;
			ELSIF P4_Etiketovacka.Manual THEN
				SC_P4_Etiketovacka.Step:= 700;
			END_IF
			
		
		//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P4_Etiketovacka.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P4_Etiketovacka.IdleTime.PT:= T#4s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Acc:= P34_RemPremenne.P4_ZdvihEtiketovacky_Acc;
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Dcc:= P34_RemPremenne.P4_ZdvihEtiketovacky_Dcc;
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Torque:= 1.0;
									
			IF P4_Dopravniky.STAV.PoINIT THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 3;
			END_IF
	 
			
		3:
			SC_P4_Etiketovacka.StepName:='3 - Inicializacia - vymazanie adresara kamery CAM15';
			SC_P4_Etiketovacka.IdleTime.PT:= T#4s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 10;
			ELSIF NOT SC_P4_Etiketovacka.Switch1 THEN
				FTP_CAM15.CMD.VymazFotku:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
			
				
			IF FTP_CAM15.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM15.CMD.VymazFotku:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 10;
			ELSIF FTP_CAM15.STATUS.KomunikaciaError THEN
				P34_Alarmy[434]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
		
		10:
			SC_P4_Etiketovacka.StepName:='10 - Inicializacia - presun zdvihu aplikatora do pozicie odoberania etikety';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
		
			
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Velocity:= P34_RemPremenne.P4_Etiketov_RychlZdvihuAplikat/1000;
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Position:= P34_RemPremenne.P4_Etiketovacka_PozOdoberEtikety;
			
			
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
				
			IF P4_Etiketovacka.ServoZdvihuAplikatora.Status.InPosition THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 15;
			END_IF	
		
		
		15:
			SC_P4_Etiketovacka.StepName:='15 - Inicializacia - zasunutie centrovacky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#4s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Centrovanie_ZASUNUTE THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 18;
			END_IF	
		
		
		18:
			SC_P4_Etiketovacka.StepName:='18 - Inicializacia - hladanie paletky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#5s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
	
			IF P4_Etiketovacka.RFID_hlava.PritomnostPaletky THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 20;		 
			ELSIF SC_P4_Etiketovacka.IdleTime.Q THEN
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 100;
			END_IF	
		
		20:
			SC_P4_Etiketovacka.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
		
			SC_P4_Etiketovacka.IdleTime.IN:= P4_Etiketovacka.RFID_hlava.PritomnostPaletky;
									
			IF SC_P4_Etiketovacka.IdleTime.Q THEN
				P4_Etiketovacka.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
			END_IF
			
			IF P4_Etiketovacka.RFID_hlava.Stav_CitanieZapis_OK AND P4_Etiketovacka.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P4_Etiketovacka.RFID_hlava.PrecitaneCisloPaletky;
				P4_Etiketovacka.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 23;
			END_IF	
		
		
		23:
			SC_P4_Etiketovacka.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P4_Etiketovacka.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 30;
			ELSE
				P34_Alarmy[406]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		30:
			SC_P4_Etiketovacka.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_9' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_9' THEN 
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_9' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_9' THEN
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;	
			END_IF	
		
		
		
		33:
			SC_P4_Etiketovacka.StepName:='33 - Inicializacia - kontrola uzavretia komunikacie'; 
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
            
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;
			ELSE
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 38;
			END_IF	
		
		38:
			SC_P4_Etiketovacka.StepName:='38 - Inicializacia - kontrola odoslania fotiek';
			SC_P4_Etiketovacka.IdleTime.PT:= T#5s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;   
            
			IF Paletka[i].STAV.OdoslanieFotiek_DONE THEN
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 550;
			ELSE
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 40;
			END_IF	
		
		40:
			SC_P4_Etiketovacka.StepName:='40 - Inicializacia - zacentrovanie paletky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Centrovanie_VYSUNUTE THEN
				CAM15.STAV.Results_READY:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 45;
			END_IF	 
		
		
		
		45:
            
			SC_P4_Etiketovacka.StepName:='45 - Inicializacia - kamerova kontrola nalepenej etikety CAM15';//CAM 15//
			SC_P4_Etiketovacka.IdleTime.PT:= T#5s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
            
			IF Linka.P4_Kamery_OFF THEN
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 100;
			ELSIF NOT SC_P4_Etiketovacka.Switch1 AND CAM15.STAV.Command_READY THEN
				CAM15.CMD.Triger:= TRUE;
				SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
			
			
			IF CAM15.STAV.Results_READY AND CAM15.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM15.STAV.Results_READY:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 50;
			ELSIF SC_P4_Etiketovacka.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM15.CMD.Triger:= FALSE;
				CAM15.STAV.Results_READY:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 48;
			ELSIF SC_P4_Etiketovacka.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P34_Alarmy[454]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		
		48:
			SC_P4_Etiketovacka.StepName:='48 - Inicializacia - cakam na opatovny triger kamery CAM15';
			SC_P4_Etiketovacka.IdleTime.PT:= T#1s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
            
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
            
			IF SC_P4_Etiketovacka.IdleTime.Q THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 45;
			END_IF
		
		50:
			SC_P4_Etiketovacka.StepName:='50 - Inicializacia - kontrola vysledku kamery';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
            
            
			IF NOT CAM15.STAV.BUSY  THEN
				CAM15.CMD.Triger:= FALSE;
				IF CAM15.RESULT.Pritomn_Etikety THEN
					CAM15.PAR.ResultFotky:= 'PASS';
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 53;
				ELSE
					CAM15.PAR.ResultFotky:= 'FAIL';
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 53;
				END_IF
			END_IF
		
		
		53:
			SC_P4_Etiketovacka.StepName:='53 - Inicializacia - vymazanie adresara kamery CAM15';
			SC_P4_Etiketovacka.IdleTime.PT:= T#4s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 55;
			ELSIF NOT SC_P4_Etiketovacka.Switch1 THEN
				FTP_CAM15.CMD.VymazFotku:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
							
			IF FTP_CAM15.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM15.CMD.VymazFotku:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 55;
			ELSIF FTP_CAM15.STATUS.KomunikaciaError THEN
				P34_Alarmy[434]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
            
                 
		55:
			SC_P4_Etiketovacka.StepName:='55 - Inicializacia - rozhodnutie podla kamerovej kontroly paletky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
            	
				
			IF CAM15.PAR.ResultFotky = 'PASS' THEN
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 100;
			ELSIF CAM15.PAR.ResultFotky = 'FAIL' THEN
				P4_Etiketovacka.STAV.PoINIT:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 100;
			END_IF    
   
         
			
         
		
			
		//********************************************************Automatický režim****************************************************************************//
	
		100:  
			SC_P4_Etiketovacka.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			SC_P4_Etiketovacka.IdleTime.IN:= P4_Etiketovacka.RFID_hlava.PritomnostPaletky;
			
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Acc:= P34_RemPremenne.P4_ZdvihEtiketovacky_Acc;
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Dcc:= P34_RemPremenne.P4_ZdvihEtiketovacky_Dcc;
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Torque:= 1.0;
			
			
			
			
			IF P4_Etiketovacka.RFID_hlava.PritomnostPaletky THEN
				P4_ZdvizkaZaFunkcTestA.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF
                
			           
			IF P4_Etiketovacka.KoniecCyklu AND NOT P4_ZdvizkaZaFunkcTestA.Automat THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 0;
			ELSIF SC_P4_Etiketovacka.IdleTime.Q THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 101;
			END_IF
		
		
		101:
			SC_P4_Etiketovacka.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#500ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
		
            
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				i:= 0;
				P4_Etiketovacka.RFID_hlava.PrecitajChipRFID:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
			
					
			IF P4_Etiketovacka.RFID_hlava.Stav_CitanieZapis_OK AND P4_Etiketovacka.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P4_Etiketovacka.RFID_hlava.PrecitaneCisloPaletky;
				P2_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 102;
			END_IF	
           
			
		102:
			SC_P4_Etiketovacka.StepName:='102 - Automaticky Rezim - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P4_Etiketovacka.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 103;
			ELSE
				P34_Alarmy[406]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
		
		
		103:
			SC_P4_Etiketovacka.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_9' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_9' THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_9' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_9' THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;
			END_IF		
			
		
		105:
			SC_P4_Etiketovacka.StepName:='105 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 118;
			ELSIF NOT SC_P4_Etiketovacka.Switch1 THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 106;
			ELSIF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaError THEN	
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 115;
			END_IF	
			
		106:
			SC_P4_Etiketovacka.StepName:='106 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 106;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 106;	
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 106;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 106;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 106;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 106;
				END_IF   
			END_IF	
			
		108:
			SC_P4_Etiketovacka.StepName:='108 - Automaticky Rezim - vyziadanie stavu paletky zo servera, zacentrovanie paletky'; 
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#10s;	
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
			
                        
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				Centrovacku_VYSUN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 110;
			ELSIF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaError THEN	
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 115;
			END_IF				
						
		
	            
			
		
			
		110:
			SC_P4_Etiketovacka.StepName:='110 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;		
				
			IF NOT TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena AND P4_Etiketovacka.IN.Centrovanie_VYSUNUTE THEN
				IF TRCB_P4_Etiketovacka_ST9.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST9' THEN
						SC_P4_Etiketovacka.ResetStep:= TRUE;
						SC_P4_Etiketovacka.Step:= 118;
					ELSE
						Paletka[i].STAV.StavPaletky := 'NG';
						SC_P4_Etiketovacka.ResetStep:= TRUE;
						SC_P4_Etiketovacka.Step:= 116;
					END_IF 
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 115;
				END_IF	
			END_IF
			
		
		115:
			SC_P4_Etiketovacka.StepName:='115 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;		
            
			P34_Vizu.ZobrazHL3_ST9:= TRUE;
            
			IF TRCB_P4_Etiketov_OpatovnyDopyt THEN
				TRCB_P4_Etiketov_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL3_ST9:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 105;
			ELSIF TRCB_P4_Etiketov_PaletkaNG THEN
				TRCB_P4_Etiketov_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL3_ST9:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 116;
			END_IF   
            
                
            
            
            
		116:
			SC_P4_Etiketovacka.StepName:='116 - Automaticky Rezim - odcentrovanie paletky po odpovedi servera NG';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Centrovanie_ZASUNUTE THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;
			END_IF			
	
	//Štart aplikovania etikety//		
            
		118:
			SC_P4_Etiketovacka.StepName:='118 - Automaticky Rezim - zacentrovanie paletky ';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Centrovanie_VYSUNUTE THEN
				CAM14.STAV.Results_READY:= FALSE;
				IF P4_Etiketovacka.CMD.RR_NalepEtiketu THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 124;
				ELSE	
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 120;
				END_IF	
			END_IF    
	
		
	
		120:
			SC_P4_Etiketovacka.StepName:='120 - Automaticky Rezim - precitanie QR kodu na Power CP CAM14';//CAM 14//
			SC_P4_Etiketovacka.IdleTime.PT:= T#5s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF Linka.P4_Kamery_OFF THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 124;
			ELSIF NOT SC_P4_Etiketovacka.Switch1 THEN
				CAM14.CMD.Triger:= TRUE;
				P4_Etiketovacka.STAV.PowerCP_ZhodaQRkodu_OK:= FALSE;
				SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
			
			IF CAM14.STAV.Results_READY THEN
				PocetTrigrovKamery:= 0;
				CAM14.STAV.Results_READY:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 122;
			ELSIF SC_P4_Etiketovacka.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM14.CMD.Triger:= FALSE;
				CAM14.STAV.Results_READY:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 121;
			ELSIF SC_P4_Etiketovacka.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P34_Alarmy[453]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;    
			END_IF
		
		
		121:
			SC_P4_Etiketovacka.StepName:='121 - Automaticky Rezim - cakam na opatovny triger kamery CAM14';
			SC_P4_Etiketovacka.IdleTime.PT:= T#1s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
            
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
            
			IF SC_P4_Etiketovacka.IdleTime.Q THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 120;
			END_IF
            
            
            
			
		122:
			SC_P4_Etiketovacka.StepName:='122 - Automaticky Rezim - kontrola vysledku kamery';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
				
			IF NOT CAM14.STAV.BUSY AND SC_P4_Etiketovacka.IdleTime.Q THEN
				CAM14.CMD.Triger:= FALSE;
				IF CAM14.RESULT.PowerCP.CitanieQRkodu_PowerCP_OK THEN
					IF Paletka[i].PAR.QRkodPowerCP = CAM14.RESULT.PowerCP.PrecitanyQRkod_PowerCP THEN
						P4_Etiketovacka.STAV.PowerCP_ZhodaQRkodu_OK:= TRUE;
						CAM14.PAR.ResultFotky:= 'PASS';
						SC_P4_Etiketovacka.ResetStep:= TRUE;
						SC_P4_Etiketovacka.Step:= 123;
					ELSE
						CAM14.PAR.ResultFotky:= 'FAIL';
						P4_Etiketovacka.STAV.PowerCP_ZhodaQRkodu_OK:= FALSE;
						SC_P4_Etiketovacka.ResetStep:= TRUE;
						SC_P4_Etiketovacka.Step:= 123;
					END_IF
				ELSE
					CAM14.PAR.ResultFotky:= 'FAIL';
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 123;
				END_IF
			END_IF
		
		
		123:
			SC_P4_Etiketovacka.StepName:='123 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly paletky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
						
			IF CAM14.PAR.ResultFotky = 'PASS' THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 124;
			ELSIF CAM14.PAR.ResultFotky = 'FAIL' THEN   
				P34_Vizu.ZobrazHL1_ST9:= TRUE;
				IF P4_Etiketov_KAM_Result_OK THEN
					P4_Etiketov_KAM_Result_OK:= FALSE;
					CAM14.PAR.ResultFotky:= 'PASS';
					P34_Vizu.ZobrazHL1_ST9:= FALSE;
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 124;
				ELSIF P4_Etiketov_KAM_Result_NG THEN
					P4_Etiketov_KAM_Result_NG:= FALSE;
					P34_Vizu.ZobrazHL1_ST9:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 540;
				END_IF	
			END_IF
		
			
		124:
			SC_P4_Etiketovacka.StepName:='123 - Automaticky Rezim - zapnutie prisavania etikety a spodneho ofuku etikety';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			
			P4_Etiketovacka.OUT.OfukEtikety_ON:= TRUE;
			P4_Etiketovacka.OUT.PrisavanieEtikety_OFF:= FALSE;
			P4_Etiketovacka.OUT.PrisavanieEtikety_ON:= TRUE;
			IF P4_Etiketovacka.CMD.RR_NalepEtiketu THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 138;
			ELSIF Linka.KOM_Panatrace_OFF THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 138;	
			ELSE	
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 127;
			END_IF	
			
			
			
		
		127:
			SC_P4_Etiketovacka.StepName:='127 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#10s;	
			
			
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 127;
			ELSIF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaError THEN	
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P34_Alarmy[409]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
			
		128:
			SC_P4_Etiketovacka.StepName:='128 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 127;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 127;	
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 127;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 127;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 127;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 127;
				END_IF   
			END_IF	
		
		130:
			SC_P4_Etiketovacka.StepName:='130 - Automaticky Rezim - vyziadanie serioveho cisla etikety zo servera';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#10s;	
			
				
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajCisloEtikety_TYP0:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
			
			IF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajCisloEtikety_TYP0:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 133;
			ELSIF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaError THEN	
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajCisloEtikety_TYP0:= FALSE;
				P34_Alarmy[409]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF				
						
		
            
            
            
			
		133:
			SC_P4_Etiketovacka.StepName:='133 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				Paletka[i].STAV.CisloEtiketyVyziadane:= TRUE;
				IF TRCB_P4_Etiketovacka_ST9.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					SerioveCisloEtikety:= TRCB_P4_Etiketovacka_ST9.OUTPUTS.CisloEtikety;
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 140;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.StavPaletky := 'NG';
					P4_Etiketovacka.OUT.PrisavanieEtikety_ON:= FALSE;
					P4_Etiketovacka.OUT.PrisavanieEtikety_OFF:= TRUE;
					P4_Etiketovacka.OUT.OfukEtikety_ON:= FALSE;
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 560;
				END_IF	
			END_IF
			
		
		138:
			SC_P4_Etiketovacka.StepName:='138 - Automaticky Rezim - vytlacenie etikety z PLC';
			SC_P4_Etiketovacka.IdleTime.PT:= T#500ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
            
			P4_Etiketovacka.OUT.PrisavanieEtikety_ON:= TRUE;
			P4_Etiketovacka.OUT.PrisavanieEtikety_OFF:= FALSE;
			P4_Etiketovacka.OUT.OfukEtikety_ON:= TRUE;
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
            
			IF NOT SC_P4_Etiketovacka.Switch1 AND SC_P4_Etiketovacka.IdleTime.Q THEN
				Tlaciaren.CMD.VytlacEtiketu:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
            	
			IF Tlaciaren.STAV.VytlacenieEtikety_OK THEN
				Tlaciaren.CMD.VytlacEtiketu:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 140;
			ELSIF Tlaciaren.STAV.VytlacenieEtikety_ERROR THEN	
				Tlaciaren.CMD.VytlacEtiketu:= FALSE;
				P34_Alarmy[431]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
		
		
		140:
			SC_P4_Etiketovacka.StepName:='140 - Automaticky Rezim - cakam na vysunutie etikety z tlaciarne, vypnutie ofuku etikety';
			SC_P4_Etiketovacka.IdleTime.PT:= T#500ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#7s;
			
			SC_P4_Etiketovacka.AlarmTime.IN:= NOT P4_Etiketovacka.IN.PrisavanieEtikety_Vakum_OK;
            
			SC_P4_Etiketovacka.IdleTime.IN:= P4_Etiketovacka.IN.PrisavanieEtikety_Vakum_OK;
			
			IF SC_P4_Etiketovacka.IdleTime.Q THEN
				P4_Etiketovacka.OUT.OfukEtikety_ON:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 155;
			ELSIF SC_P4_Etiketovacka.AlarmTime.Q THEN
				P4_Etiketovacka.OUT.OfukEtikety_ON:= FALSE;
				P34_Alarmy[431]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		155:
			SC_P4_Etiketovacka.StepName:='155 - Automaticky Rezim - napolohovanie zdvihu na poziciu nalepenia etikety';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			
			
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Velocity:= P34_RemPremenne.P4_Etiketov_RychlZdvihuAplikat/1000;
			
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Position:= P34_RemPremenne.P4_Etiketovacka_PozEtikety_4F;
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Position:= P34_RemPremenne.P4_Etiketovacka_PozEtikety_5F;
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Position:= P34_RemPremenne.P4_Etiketovacka_PozEtikety_5H;
			END_IF	
				
			IF NOT SC_P4_Etiketovacka.Switch1 AND P4_Etiketovacka.IN.Aplikator_OtocenyVZAD AND P4_Etiketovacka.IN.Aplikator_ZASUNUTY THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
				
			IF P4_Etiketovacka.ServoZdvihuAplikatora.Status.InPosition THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 158;
			END_IF	
			
						
		158:
			SC_P4_Etiketovacka.StepName:='158 - Automaticky Rezim - otocenie aplikatora vpred k Power CP';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				OtocAplikator_VPRED:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
		
			IF P4_Etiketovacka.IN.Aplikator_OtocenyVPRED THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 160;
			END_IF	
		
		
		160:
			SC_P4_Etiketovacka.StepName:='160 - Automaticky Rezim - vysunutie aplikatora vpred k Power CP';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				P4_Etiketovacka.OUT.Aplikator_VYSUN:= TRUE;
				SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Aplikator_VYSUNUTY OR SC_P4_Etiketovacka.IdleTime.Q THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 162;
			END_IF	
		
		
		162:
			SC_P4_Etiketovacka.StepName:='162 - Automaticky Rezim - vypnutie prisavania a zasunutie aplikatora etikety';
			SC_P4_Etiketovacka.IdleTime.PT:= T#500ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
		
			IF NOT SC_P4_Etiketovacka.Switch1 AND SC_P4_Etiketovacka.IdleTime.Q THEN
				P4_Etiketovacka.OUT.PrisavanieEtikety_ON:= FALSE;
				P4_Etiketovacka.OUT.PrisavanieEtikety_OFF:= TRUE;
				P4_Etiketovacka.OUT.Aplikator_VYSUN:= FALSE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Aplikator_ZASUNUTY THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 165;
			END_IF
		
		165:
			SC_P4_Etiketovacka.StepName:='165 - Automaticky Rezim - otocenie aplikatora vzad';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				OtocAplikator_VZAD:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
		
			IF P4_Etiketovacka.IN.Aplikator_OtocenyVZAD THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 168;
			END_IF	
		
		
		168:
			SC_P4_Etiketovacka.StepName:='168 - Automaticky Rezim - napolohovanie zdvihu na poziciu 7mm nad etiketu';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Velocity:= P34_RemPremenne.P4_Etiketov_RychlZdvihuAplikat/1000;
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Position:= P4_Etiketovacka.ServoZdvihuAplikatora.Status.ActPosition - 7;
			
				
			IF NOT SC_P4_Etiketovacka.Switch1 AND P4_Etiketovacka.IN.Aplikator_OtocenyVZAD AND P4_Etiketovacka.IN.Aplikator_ZASUNUTY THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
				
			IF P4_Etiketovacka.ServoZdvihuAplikatora.Status.InPosition THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 170;
			END_IF	
		
		170:
			SC_P4_Etiketovacka.StepName:='170 - Automaticky Rezim - otocenie aplikatora vpred k Power CP';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				OtocAplikator_VPRED:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
		
			IF P4_Etiketovacka.IN.Aplikator_OtocenyVPRED THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 173;
			END_IF	
		
		173:
			SC_P4_Etiketovacka.StepName:='173 - Automaticky Rezim - vysunutie aplikatora vpred k Power CP';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				P4_Etiketovacka.OUT.Aplikator_VYSUN:= TRUE;
				SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Aplikator_VYSUNUTY OR SC_P4_Etiketovacka.IdleTime.Q THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 175;
			END_IF	
		
		175:	
			SC_P4_Etiketovacka.StepName:='175 - Automaticky Rezim - zasunutie aplikatora etikety';
			SC_P4_Etiketovacka.IdleTime.PT:= T#500ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
		
			IF NOT SC_P4_Etiketovacka.Switch1 AND SC_P4_Etiketovacka.IdleTime.Q THEN
				P4_Etiketovacka.OUT.Aplikator_VYSUN:= FALSE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Aplikator_ZASUNUTY THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 178;
			END_IF
		
		178:
			SC_P4_Etiketovacka.StepName:='178 - Automaticky Rezim - otocenie aplikatora vzad';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				OtocAplikator_VZAD:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
		
			IF P4_Etiketovacka.IN.Aplikator_OtocenyVZAD THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 180;
			END_IF	
		
		
		180:
			SC_P4_Etiketovacka.StepName:='180 - Automaticky Rezim - napolohovanie zdvihu na poziciu odoberania etikety';
			SC_P4_Etiketovacka.IdleTime.PT:= T#2s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Velocity:= P34_RemPremenne.P4_Etiketov_RychlZdvihuAplikat/1000;
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Position:= P34_RemPremenne.P4_Etiketovacka_PozOdoberEtikety;
			
			
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF	
				
			IF P4_Etiketovacka.ServoZdvihuAplikatora.Status.InPosition THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.MovePosition:= FALSE;
				CAM15.STAV.Results_READY:= FALSE;
				IF P4_Etiketovacka.CMD.RR_NalepEtiketu THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 545;
				ELSE	
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 190;
				END_IF	
			END_IF	
		
		
		190:
			SC_P4_Etiketovacka.StepName:='190 - Automaticky Rezim - kamerova kontrola nalepenej etikety CAM15';//CAM 15//
			SC_P4_Etiketovacka.IdleTime.PT:= T#5s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF Linka.P4_Kamery_OFF THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 540;
			ELSIF NOT SC_P4_Etiketovacka.Switch1 AND CAM15.STAV.Command_READY THEN
				CAM15.CMD.Triger:= TRUE;
				P4_Etiketovacka.STAV.Etiketa_ZhodaQRkodu_OK:= FALSE;
				SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
			
			
			IF CAM15.STAV.Results_READY AND CAM15.STAV.Command_AKCEPTOVANY THEN
				PocetTrigrovKamery:= 0;
				CAM15.STAV.Results_READY:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 193;
			ELSIF SC_P4_Etiketovacka.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM15.CMD.Triger:= FALSE;
				CAM15.STAV.Results_READY:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 192;
			ELSIF SC_P4_Etiketovacka.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P34_Alarmy[454]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;    
			END_IF
		
		
		192:
			SC_P4_Etiketovacka.StepName:='192 - Automaticky Rezim - cakam na opatovny triger kamery CAM15';
			SC_P4_Etiketovacka.IdleTime.PT:= T#1s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
            
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
            
			IF SC_P4_Etiketovacka.IdleTime.Q THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 190;
			END_IF
            
		
		193:
			SC_P4_Etiketovacka.StepName:='193 - Automaticky Rezim - kontrola vysledku kamery';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
            
			IF NOT CAM15.STAV.BUSY  THEN
				CAM15.CMD.Triger:= FALSE;
				IF CAM15.RESULT.CitanieQRkodu_Etikety_OK AND
					CAM15.RESULT.Pritomn_Etikety THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 194;
				ELSE
					CAM15.PAR.ResultFotky:= 'FAIL';
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 198;
				END_IF
			END_IF
		
            
		194:
			SC_P4_Etiketovacka.StepName:='194 - Automaticky Rezim - kontrola obsahu QR kodu etikety';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			SC_P4_Etiketovacka.IdleTime.IN:= TRUE;
			
			IF SerioveCisloEtikety = CAM15.RESULT.PrecitanyQRkod_Etikety THEN
				P4_Etiketovacka.STAV.Etiketa_ZhodaQRkodu_OK:= TRUE;
				CAM15.PAR.ResultFotky:= 'PASS';
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 198;
			ELSE
				CAM15.PAR.ResultFotky:= 'FAIL';
				P4_Etiketovacka.STAV.Etiketa_ZhodaQRkodu_OK:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 198;
			END_IF 
			
		
		198:
			SC_P4_Etiketovacka.StepName:='198 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly paletky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
							
			IF CAM15.PAR.ResultFotky = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 540;
			ELSIF CAM15.PAR.ResultFotky = 'FAIL' THEN    
				P34_Vizu.ZobrazHL2_ST9:= TRUE;
				IF P4_Etiketov_KAM_Result_OK THEN
					P4_Etiketov_KAM_Result_OK:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					CAM15.PAR.ResultFotky:= 'PASS';
					P34_Vizu.ZobrazHL2_ST9:= FALSE;
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 540;
				ELSIF P4_Etiketov_KAM_Result_NG THEN
					P4_Etiketov_KAM_Result_NG:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					P34_Vizu.ZobrazHL2_ST9:= FALSE;
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 540;
				END_IF
			END_IF
			
			
			
			
		//******************************Odoslanie fotiek na server***************************************//		
		
		540:
			SC_P4_Etiketovacka.StepName:='540 - Automaticky Rezim - odoslanie fotiek na server Panasonic';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;		
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 545; 
			ELSIF NOT SC_P4_Etiketovacka.Switch1 THEN
				FTP_CAM15.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM15.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM15.INPUTS.Result:= CAM15.PAR.ResultFotky;
				Reports.Kamery.P4_CAM15_KontrolaPaletky:= CAM15.PAR.ResultFotky;
			           
				FTP_CAM15.CMD.OdosliFotku:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
            
			
				
			
			IF FTP_CAM15.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM15.CMD.OdosliFotku:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 545; 
			ELSIF FTP_CAM15.STATUS.KomunikaciaError THEN
				P34_Alarmy[407]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
			
			
			
			
		//*************************Odcentrovanie paletky*********************************************//		
		545:
			SC_P4_Etiketovacka.StepName:='545 - Automaticky Rezim - odcentrovanie paletky';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
		
			IF P4_Etiketovacka.IN.Centrovanie_ZASUNUTE THEN
				IF P4_Etiketovacka.CMD.RR_NalepEtiketu THEN
					P4_Etiketovacka.CMD.RR_NalepEtiketu:= FALSE;
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 700;
				ELSE    
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 550;
				END_IF    
			END_IF
          		
		
			
			
		//*******************************Odoslanie dát na server*******************************//		
		
		550:
			SC_P4_Etiketovacka.StepName:='550 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 560;
			ELSIF NOT SC_P4_Etiketovacka.Switch1 THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 552;
			ELSIF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaError THEN	
				TRCB_P4_Etiketovacka_ST9.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P34_Alarmy[409]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF	
			
		552:
			SC_P4_Etiketovacka.StepName:='552 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 552;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 552;	
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 552;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 552;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 552;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 552;
				END_IF   
			END_IF	
		
		555:
			SC_P4_Etiketovacka.StepName:='555 - Automaticky Rezim - odoslanie dat na server';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			
			IF NOT SC_P4_Etiketovacka.Switch1 THEN
				TRCB_P4_Etiketovacka_ST9.CMD.OdosliStavPaletky_TYP2:= TRUE;
				SC_P4_Etiketovacka.Switch1:= TRUE;
			END_IF
			
			
			IF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				TRCB_P4_Etiketovacka_ST9.CMD.OdosliStavPaletky_TYP2:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 556;
			ELSIF TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaError THEN	
				TRCB_P4_Etiketovacka_ST9.CMD.OdosliStavPaletky_TYP2:= FALSE;
				P34_Alarmy[409]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
			
		            
            
			
		556:
			SC_P4_Etiketovacka.StepName:='556 - Automaticky Rezim - kontrola odpovede servera';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
			
			
			IF NOT TRCB_P4_Etiketovacka_ST9.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P4_Etiketovacka_ST9.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 560;
				ELSIF TRCB_P4_Etiketovacka_ST9.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P4_Etiketovacka.ResetStep:= TRUE;
					SC_P4_Etiketovacka.Step:= 560;
				END_IF	
			END_IF
		
		
		//***************************Vyvezenie paletky**********************************************//	
		
		560:
			SC_P4_Etiketovacka.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na stoper vytahu';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
			
		   
			IF P4_Etiketovacka.KoniecCyklu THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 0;		
			ELSIF NOT P4_Vytah.RFID_hlava.PritomnostPaletky AND SC_P4_Vytah.Step = 100 AND NOT P4_Vytah.IN.PrechodDopravnika AND NOT P4_Etiketovacka.STAV.PrebiehaVyvezeniePaletky  THEN
				P4_Etiketovacka.OUT.ZasunStoper:= TRUE;
				P4_Etiketovacka.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 561;
			END_IF	
		
		
		561:
			SC_P4_Etiketovacka.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na stoper vytahu';
			SC_P4_Etiketovacka.IdleTime.PT:= T#200ms;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#10s;
			
			
			SC_P4_Etiketovacka.IdleTime.IN:= NOT P4_Etiketovacka.RFID_hlava.PritomnostPaletky;
			SC_P4_Etiketovacka.AlarmTime.IN:= P4_Etiketovacka.RFID_hlava.PritomnostPaletky;
			
			IF NOT P4_Etiketovacka.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				CisloFotky:= 0;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Reports.Kamery.P4_CAM15_KontrolaPaletky:= '';
				P4_Etiketovacka.OUT.ZasunStoper:= FALSE;
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 100;
			ELSIF SC_P4_Etiketovacka.AlarmTime.Q THEN
				P34_Alarmy[452]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF    
                
          		
		
		
		//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P4_Etiketovacka.StepName:='700 - Manualny Rezim';
			SC_P4_Etiketovacka.IdleTime.PT:= T#8s;
			SC_P4_Etiketovacka.AlarmTime.PT:= T#5s;
		
		
			//Parametre serva pre jogging//
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Jog.Acc:= 1;
			P4_Etiketovacka.ServoZdvihuAplikatora.Parameters.Jog.Velocity:= P4_Etiketovacka.PAR.ZdvihAplikatora_JoggRychlost;
			P4_Etiketovacka.ServoZdvihuAplikatora.Command.TorqueLimitation:= TRUE;
		
		
		
			//Ovládanie zdvihu aplikátora//
			IF P4_Etiketovacka.CMD.RR_ZdvihAplikatora_DOLE AND P4_Etiketovacka.ServoZdvihuAplikatora.Status.ActPosition < 200 THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.JogNeg:= FALSE;
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.JogPos:= TRUE;
			ELSIF P4_Etiketovacka.CMD.RR_ZdvihAplikatora_HORE AND P4_Etiketovacka.ServoZdvihuAplikatora.Status.ActPosition > 5 THEN
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.JogPos:= FALSE;	
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.JogNeg:= TRUE;
			ELSE
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.JogNeg:= FALSE;
				P4_Etiketovacka.ServoZdvihuAplikatora.Command.JogPos:= FALSE;
			END_IF	
		
		
		
		//Spustenie sekvencie nalepenia etikety//
			IF P4_Etiketovacka.CMD.RR_NalepEtiketu THEN
				SC_P4_Etiketovacka.ResetStep:= TRUE;
				SC_P4_Etiketovacka.Step:= 118;
			END_IF	
		
		
		
	END_CASE		
			
			
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

