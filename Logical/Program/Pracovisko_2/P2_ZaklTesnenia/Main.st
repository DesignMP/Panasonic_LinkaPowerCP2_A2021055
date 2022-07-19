
PROGRAM _INIT
	
	//Init parametre serva pojazdu zakladaèa//
	P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Override:= 100;
	P2_ZakladacTesnenia.PAR.ZakladacPojazd_JoggRychlost:= 10;
	P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.TorqueLimitation:= TRUE;
	P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Torque:= 1.0;
	
	
	
	//Init parametre serva zdvihu zakladaèa//
	P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Override:= 100;
	P2_ZakladacTesnenia.PAR.ZakladacZdvih_JoggRychlost:= 10;
	P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.TorqueLimitation:= TRUE;
	P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1.0;
	
	
	
	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie podprogramov a knižníc//
	
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_ZakladacTesnenia);
	
	
	
	//Enable serv//
	IF Safety.STAV.P2_ZonaZakladacaZdvih_AKTIVNA AND NOT P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.ErrReset THEN
		P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.PowerON:= TRUE;
	ELSE
		P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.PowerON:= FALSE;
	END_IF
	
	IF Safety.STAV.P2_ZonaZakladacaPojazd_AKTIVNA AND NOT P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.ErrReset THEN
		P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.PowerON:= TRUE;
	ELSE
		P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.PowerON:= FALSE;
	END_IF
	
	
	
	//Reset serv//
	IF EDGEPOS(Safety.STAV.P2_ZonaZakladacaZdvih_AKTIVNA)THEN
		P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.ErrReset:= TRUE;
	END_IF
	
	IF EDGEPOS(Safety.STAV.P2_ZonaZakladacaPojazd_AKTIVNA)THEN
		P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.ErrReset:= TRUE;
	END_IF	
	
	
	CasResetServo_1.IN:= P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.ErrReset;
	IF CasResetServo_1.Q AND NOT P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.Error THEN
		P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.ErrReset:= FALSE;
	END_IF
	
	CasResetServo_2.IN:= P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.ErrReset;
	IF CasResetServo_2.Q AND NOT P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Error THEN
		P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.ErrReset:= FALSE;
	END_IF
	
	
	CasResetServo_1.PT:= T#500ms;
	CasResetServo_1();
	
	CasResetServo_2.PT:= T#500ms;
	CasResetServo_2();
	
	//Index paletky//
	i:= P2_ZakladacTesnenia.PAR.IndexPaletky; 
	
	
	//Reset sekcie //
	IF P2_ZakladacTesnenia.Reset THEN
		SC_P2_ZakladacTesnenia.Step:= 0;
		P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.ErrReset:= TRUE;
		P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.ErrReset:= TRUE;
		P2_ZakladacTesnenia.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P2_ZakladacTesnenia.Step:= 0;
	END_IF	
	
	
	
	CASE SC_P2_ZakladacTesnenia.Step OF 
		
		0:
			SC_P2_ZakladacTesnenia.StepName:='0 - Nulovanie';
			P2_ZakladacTesnenia.Automat:= FALSE;
			P2_ZakladacTesnenia.KoniecCyklu:= FALSE;
			P2_ZakladacTesnenia.Manual:= FALSE;
			P2_ZakladacTesnenia.STAV.PoINIT:= FALSE;
			P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= FALSE;
						
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.JogNeg:= FALSE;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.JogPos:= FALSE;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MoveAdditive:= FALSE;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
			IF NOT P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.StandStill THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.Stop:= TRUE;
			END_IF	
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.JogNeg:= FALSE;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.JogPos:= FALSE;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MoveAdditive:= FALSE;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= FALSE;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= FALSE;
			IF NOT P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.StandStill THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Stop:= TRUE;
			END_IF	
			
			P2_ZakladacTesnenia.CMD.RR_PojazdZakladaca_VYSUN:= FALSE;
			P2_ZakladacTesnenia.CMD.RR_PojazdZakladaca_ZASUN:= FALSE;
			P2_ZakladacTesnenia.CMD.RR_ZdvihZakladaca_DOLE:= FALSE;
			P2_ZakladacTesnenia.CMD.RR_ZdvihZakladaca_HORE:= FALSE;
			
			P2_ZakladacTesnenia.COM_OUT.Stav_ZalozenieTesneniaUkoncene:= FALSE;
			
			PocetZatlaceni:= 0;
			Stav_ZvihPoINIT:= FALSE;
			Stav_PojazdPoINIT:= FALSE;
			PocetTrigrovKamery:= 0;
            
			            
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P2_ZonaZakladacaPojazd_AKTIVNA AND
				(Safety.STAV.P2_ZonaZakladacaZdvih_AKTIVNA OR NOT Safety.STAV.P2_ZaklTesn_PojazdMuting_AKTIVNY) AND
				P2_Pracovisko.STAV.HardwareZaklTesnenia_OK AND 
				NOT P2_Pracovisko.STAV.Porucha_ST1 AND
				(P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.Ready AND P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.StandStill) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.Stop:= FALSE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Stop:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 1;
			END_IF
	
			
			
			
			
		1:
			SC_P2_ZakladacTesnenia.StepName:='1 - Cakam na spustenie vyroby';
			P2_ZakladacTesnenia.KoniecCyklu:= FALSE;
			IF P2_ZakladacTesnenia.Automat THEN
				SC_P2_ZakladacTesnenia.Step:= 2;
			ELSIF P2_ZakladacTesnenia.Manual THEN
				SC_P2_ZakladacTesnenia.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		
		2:
			SC_P2_ZakladacTesnenia.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#2s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
			
			
			
			IF SC_P2_ZakladacTesnenia.IdleTime.Q THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 20;
			END_IF
	
	       
                      
		
		20:
			SC_P2_ZakladacTesnenia.StepName:='20 - Inicializacia - rozhodnutie o inicializacii';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#2s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;	
			
						
			IF NOT Stav_ZvihPoINIT AND Safety.STAV.P2_ZaklTesn_Bariera_AKTIVNA AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 25;
			ELSIF NOT Stav_PojazdPoINIT THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 27;
			ELSIF Stav_ZvihPoINIT AND Stav_PojazdPoINIT AND NOT Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 30;
			END_IF    
          			
            
		25:
			SC_P2_ZakladacTesnenia.StepName:='25 - Inicializacia - presun zdvihu do vychodiskovej pozicie automaticky';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Acc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Dcc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Zdvih_RychlostZdvihu/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 0;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			
					
			IF EDGEPOS(P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				Stav_ZvihPoINIT:= TRUE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 20;
			END_IF	
	
			
		27:
			SC_P2_ZakladacTesnenia.StepName:='27 - Inicializacia - kontrola pozície pojazdu';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			

			IF P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.ActPosition > (P2_RemPremenne.P2_ZaklTesn_Pojazd_PozZatlacenia + 0.5) THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 28;
			ELSIF P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.ActPosition < (P2_RemPremenne.P2_ZaklTesn_Pojazd_PozZatlacenia - 0.5) THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 28;
			ELSE
				Stav_PojazdPoINIT:= TRUE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 20;
			END_IF	
			
			
			
			
		
		28:
			SC_P2_ZakladacTesnenia.StepName:='28 - Inicializacia - presun pojazdu do vychodiskovej pozicie';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		
			P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= Blikac500ms;
			
			SC_P2_ZakladacTesnenia.IdleTime.IN:= Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE;
			
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Acc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Dcc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Pojazd_RychlZasun/1000;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Position:= P2_RemPremenne.P2_ZaklTesn_Pojazd_PozZatlacenia;
			
			
									
			IF SC_P2_ZakladacTesnenia.IdleTime.Q AND P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= FALSE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= TRUE;
			END_IF
			
			IF P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition AND NOT Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= TRUE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= FALSE;
			END_IF	
			
		
			
			
			
			IF EDGEPOS(P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= FALSE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= FALSE;
				P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= FALSE;
				Stav_PojazdPoINIT:= TRUE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 20;
			END_IF	
						
	
		30:
			SC_P2_ZakladacTesnenia.StepName:='30 - Inicializacia - kontrola pritomnosti PowerCP vo voziku';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		
			P2_ZakladacTesnenia.STAV.PoINIT:= TRUE;
			IF P2_ZakladacTesnenia.IN.Pojazd_PritomPowerCP THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 166;
			ELSE
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 100;
			END_IF	
            
	
		//********************************************************Automatický režim****************************************************************************//
	
		100:  
			SC_P2_ZakladacTesnenia.StepName:='100 - Automaticky Rezim - cakam na spustenie zakladania tesnenia';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;			
			
			IF P2_ZakladacTesnenia.KoniecCyklu AND NOT P2_StoperZaklTesnenia.Automat THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 0;
			ELSIF P2_ZakladacTesnenia.COM_IN.ZalozTesnenie AND Safety.STAV.P2_ZaklTesn_Bumper_AKTIVNY THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 101;
			END_IF
			
			
		101:
			SC_P2_ZakladacTesnenia.StepName:='101 - Automaticky Rezim - vysuvam suflik k obsluhe';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;	
			
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Acc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Dcc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Pojazd_RychlVysun/1000;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Position:= P2_RemPremenne.P2_ZaklTesn_Pojazd_PozVkladania;
            
                      
			
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND Safety.STAV.P2_ZaklTesn_Bumper_AKTIVNY AND P2_ZakladacTesnenia.IN.Kopito_ZakladPoloha AND P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
		
			IF EDGEPOS(P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 105;
			END_IF
			
      		
		
		105:
			SC_P2_ZakladacTesnenia.StepName:='105 - Automaticky Rezim - cakam na zasunutie suflika pod pritlacanie';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			IF P2_ZakladacTesnenia.IN.Pojazd_PritomPowerCP THEN
				P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= Blikac200ms;
				P2_Vizu.ZobrazHL14_ST3:= FALSE;
			ELSE
				P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= FALSE;
				P2_Vizu.ZobrazHL14_ST3:= TRUE;
			END_IF
			
			SC_P2_ZakladacTesnenia.IdleTime.IN:= Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE AND P2_ZakladacTesnenia.IN.Pojazd_PritomPowerCP;
			
			IF P2_ZakladacTesnenia.KoniecCyklu THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 0;
			ELSIF SC_P2_ZakladacTesnenia.IdleTime.Q THEN
				P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= FALSE;
				P2_Vizu.ZobrazHL14_ST3:= FALSE;
				CAM1.STAV.Results_READY:= FALSE;
				IF Linka.PAR.ZvolenyModel = '5H' THEN
					CAM7.STAV.OldRunCounter:= CAM7.STAV.RunCounter;
					CAM7.STAV.Results_READY:= FALSE;
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 108;
				ELSE
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 120;
				END_IF	
			END_IF
		
		108:
			SC_P2_ZakladacTesnenia.StepName:='108 - Automaticky Rezim - kamerova kontrola pritomnosti filtra 5H v drziaku filtra';//CAM 7 - iba model 5H//
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			P2_StoperZaklTesnenia.Banner.IN.ModraLED_ON:= TRUE;	
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND CAM7.STAV.Command_READY THEN
				CAM7.CMD.Triger:= TRUE;
				SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF
			
			IF CAM7.STAV.Results_READY AND CAM7.STAV.Command_AKCEPTOVANY AND CAM7.STAV.OldRunCounter <> CAM7.STAV.RunCounter THEN
				PocetTrigrovKamery:= 0;
				CAM7.STAV.Results_READY:= FALSE;
				CAM7.STAV.OldRunCounter:= CAM7.STAV.RunCounter;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 110;
			ELSIF SC_P2_ZakladacTesnenia.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE;
				CAM7.STAV.Results_READY:= FALSE;
				CAM7.STAV.OldRunCounter:= CAM7.STAV.RunCounter;
				CAM7.CMD.Triger:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 109;
			ELSIF SC_P2_ZakladacTesnenia.IdleTime.Q AND  PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[291]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
			
            
                    
            

		109:
			SC_P2_ZakladacTesnenia.StepName:='109 - Automaticky Rezim - cakam na opatovny triger kamery CAM7';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#1s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
            
			IF SC_P2_ZakladacTesnenia.IdleTime.Q THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 108;
			END_IF
            
            
            
			
		110:
			SC_P2_ZakladacTesnenia.StepName:='110 - Automaticky Rezim - vysledok kamerovej kontroly filtra 5H';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#500ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
			
            
			IF Linka.P2_Kamery_OFF THEN
				CAM7.CMD.Triger:= FALSE;
				CAM7.PAR.ResultFotky:= 'PASS';
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 115;
			ELSIF NOT CAM7.STAV.BUSY THEN
				CAM7.CMD.Triger:= FALSE;
				IF CAM7.RESULT.CitanieQRkodu_Filtra5H_OK THEN
					Paletka[i].PAR.QRkodFiltra_5H:= CAM7.RESULT.PrecitanyQRkod_Filtra5H;
					CAM7.PAR.ResultFotky:= 'PASS';
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 115;
				ELSE
					CAM7.PAR.ResultFotky:= 'FAIL';
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 115;
				END_IF
			END_IF
	
		115:
			SC_P2_ZakladacTesnenia.StepName:='115 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly filtra 5H';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
				
				
			IF CAM7.PAR.ResultFotky = 'PASS' THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 120;                
			ELSIF CAM7.PAR.ResultFotky = 'FAIL' THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 118;
			END_IF
			
	
		118:
			SC_P2_ZakladacTesnenia.StepName:='118 - Automaticky Rezim - zobrazenie hlasenia neprecitany QR kod filtra 5H';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			P2_StoperZaklTesnenia.Banner.IN.CervenaLED_ON:= Blikac500ms;
			P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= Blikac500ms;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 THEN	
				P2_Vizu.ZobrazHL4_ST3:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
				
						
			
			IF EDGEPOS(Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE) THEN
				CAM7.STAV.Results_READY:= FALSE;
				CAM7.STAV.OldRunCounter:= CAM7.STAV.RunCounter;
				P2_Vizu.ZobrazHL4_ST3:= FALSE;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner//	
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 105;
			END_IF
		
			
		120:
			SC_P2_ZakladacTesnenia.StepName:='120 - Automaticky Rezim - kontrola pritomnosti Power CP v zakladaci';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			IF P2_ZakladacTesnenia.IN.Pojazd_PritomPowerCP THEN
				CAM1.STAV.Results_READY:= FALSE;
				CAM1.STAV.OldRunCounter:= CAM1.STAV.RunCounter;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 130;
			ELSE
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 123;
			END_IF	
			
		123:
			SC_P2_ZakladacTesnenia.StepName:='123 - Automaticky Rezim - zobrazenie hlasenia vloz Power CP';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;		
			
			P2_StoperZaklTesnenia.Banner.IN.CervenaLED_ON:= Blikac500ms;
			P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= Blikac500ms;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 THEN	
				P2_Vizu.ZobrazHL5_ST3:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
					
				
			
			IF EDGEPOS(Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE) THEN
				P2_Vizu.ZobrazHL5_ST3:= FALSE;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner//	
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 105;
			END_IF
			
							
			
		130:
			SC_P2_ZakladacTesnenia.StepName:='130 - Automaticky Rezim - kamerova kontrola pritomnosti tesnenia na Power CP';//CAM 1//
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			P2_StoperZaklTesnenia.Banner.IN.ModraLED_ON:= TRUE;
            
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND CAM1.STAV.Command_READY THEN
				CAM1.CMD.Triger:= TRUE;
				SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF
			
			IF CAM1.STAV.Results_READY AND CAM1.STAV.Command_AKCEPTOVANY AND CAM1.STAV.OldRunCounter <> CAM1.STAV.RunCounter THEN
				PocetTrigrovKamery:= 0;
				CAM1.STAV.Results_READY:= FALSE;
				CAM1.STAV.OldRunCounter:= CAM1.STAV.RunCounter;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 133;
			ELSIF SC_P2_ZakladacTesnenia.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM1.STAV.Results_READY:= FALSE;
				CAM1.STAV.OldRunCounter:= CAM1.STAV.RunCounter;
				CAM1.CMD.Triger:= FALSE;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 131;
			ELSIF SC_P2_ZakladacTesnenia.IdleTime.Q AND  PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[290]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST1:= TRUE;    
			END_IF	
			
            
                       
            
            
		131:
			SC_P2_ZakladacTesnenia.StepName:='131 - Automaticky Rezim - cakam na opatovny triger kamery CAM1';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#1s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
            
			IF SC_P2_ZakladacTesnenia.IdleTime.Q THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 130;
			END_IF
            
            
			
		133:
			SC_P2_ZakladacTesnenia.StepName:='133 - Automaticky Rezim - vysledok kamerovej kontroly pritomnosti tesnenia na Power CP';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#500ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
			
            
			IF Linka.P2_Kamery_OFF THEN
				CAM1.CMD.Triger:= FALSE;
				CAM1.PAR.ResultFotky:= 'PASS';
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 135; 
			ELSIF NOT CAM1.STAV.BUSY THEN
				CAM1.CMD.Triger:= FALSE;
				IF Linka.PAR.ZvolenyModel = '4F' THEN
					IF NOT CAM1.RESULT.NepritomnostTesnenia THEN
						CAM1.PAR.ResultFotky:= 'PASS';
						SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
						SC_P2_ZakladacTesnenia.Step:= 135; 
					ELSE
						CAM1.PAR.ResultFotky:= 'FAIL';
						SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
						SC_P2_ZakladacTesnenia.Step:= 135;
					END_IF	
				ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
					IF NOT CAM1.RESULT.NepritomnostTesnenia THEN
						CAM1.PAR.ResultFotky:= 'PASS';
						SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
						SC_P2_ZakladacTesnenia.Step:= 135;   
					ELSE
						CAM1.PAR.ResultFotky:= 'FAIL';
						SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
						SC_P2_ZakladacTesnenia.Step:= 135;
					END_IF
				ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
					IF NOT CAM1.RESULT.NepritomnostTesnenia THEN    
						CAM1.PAR.ResultFotky:= 'PASS';
						SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
						SC_P2_ZakladacTesnenia.Step:= 135;   
					ELSE
						CAM1.PAR.ResultFotky:= 'FAIL';
						SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
						SC_P2_ZakladacTesnenia.Step:= 135;
					END_IF
				END_IF	
			END_IF
		
		
		135:
			SC_P2_ZakladacTesnenia.StepName:='135 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly '; 
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			IF CAM1.PAR.ResultFotky = 'PASS' THEN
				IF CAM1.RESULT.ZalozenieTesnenia_OK THEN
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 180;
				ELSIF NOT CAM1.RESULT.ZalozenieTesnenia_OK THEN
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 145;
				END_IF	
			ELSIF CAM1.PAR.ResultFotky = 'FAIL' THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 140;
			END_IF
			
		
		140:
			SC_P2_ZakladacTesnenia.StepName:='140 - Automaticky Rezim - zobrazenie hlasenia vloz tesnenie ';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			P2_StoperZaklTesnenia.Banner.IN.CervenaLED_ON:= Blikac500ms;
			P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= Blikac500ms;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 THEN	
				P2_Vizu.ZobrazHL6_ST3:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
				
					
			
			IF EDGEPOS(Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE) THEN
				CAM1.STAV.Results_READY:= FALSE;
				CAM1.STAV.OldRunCounter:= CAM1.STAV.RunCounter;
				P2_Vizu.ZobrazHL6_ST3:= FALSE;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner//	
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 145;
			END_IF
			
		
		145:
			SC_P2_ZakladacTesnenia.StepName:='145 - Automaticky Rezim - vymazanie fotky kamery CAM1';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
            
			IF Linka.KOM_FTP_OFF THEN
				IF CAM1.PAR.ResultFotky = 'PASS' THEN
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 150;
				ELSIF CAM1.PAR.ResultFotky = 'FAIL' THEN
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 105;
				END_IF
			ELSIF NOT SC_P2_ZakladacTesnenia.Switch1 THEN
				FTP_CAM1.CMD.VymazFotku:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM1.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM1.CMD.VymazFotku:= FALSE;
				IF CAM1.PAR.ResultFotky = 'PASS' THEN
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 150;
				ELSIF CAM1.PAR.ResultFotky = 'FAIL' THEN
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 105;
				END_IF
			ELSIF FTP_CAM1.STATUS.KomunikaciaError THEN
				P2_Alarmy[225]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
            
            
          
			
			
					
		150:
			SC_P2_ZakladacTesnenia.StepName:='150 - Automaticky Rezim - presunutie suflika pod pritlacanie, cakam na stlacenie dvojrucneho ovladania';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;		
			
			P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= Blikac500ms;
			
			
			SC_P2_ZakladacTesnenia.IdleTime.IN:= Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE AND P2_ZakladacTesnenia.IN.Pojazd_PritomPowerCP;
			
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Acc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Dcc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Pojazd_RychlZasun/1000;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Position:= P2_RemPremenne.P2_ZaklTesn_Pojazd_PozZatlacenia;
			
				
										
			IF SC_P2_ZakladacTesnenia.IdleTime.Q AND P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= FALSE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= TRUE;
			END_IF
			
			IF P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition AND NOT Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= TRUE;
			END_IF	
			
							
			
			
			
			IF P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.InPosition THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= FALSE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= FALSE;
				P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= FALSE;
				PocetZatlaceni:= 0;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 153;
			END_IF	
             
        	
		153:
			SC_P2_ZakladacTesnenia.StepName:='153 - Automaticky Rezim - kontrola bariery pred zostupom';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
				
			IF Safety.STAV.P2_ZaklTesn_Bariera_AKTIVNA AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 155;
			END_IF
			
			
			
			
		155:
			SC_P2_ZakladacTesnenia.StepName:='155 - Automaticky Rezim - presun zdvihu do pozicie pred pritlakom';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		
		 
            
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Acc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Dcc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Zdvih_RychlostZdvihu/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 60;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			
					
			IF EDGEPOS(P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 156;
			END_IF	
		
		156:
			SC_P2_ZakladacTesnenia.StepName:='156 - Automaticky Rezim - cakam na zrusenie stavu serva v pozicii';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			IF NOT P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 157;
			END_IF	
			
			
		157:
			SC_P2_ZakladacTesnenia.StepName:='157 - Automaticky Rezim - presun zdvihu do pozicie prveho zatlacenia na poziciu';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		
                       
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Acc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Dcc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Zdvih_RychlZatlacen/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1.5;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 85; 
			
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			
			IF EDGEPOS(P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 158;
			END_IF
			
		158:
			SC_P2_ZakladacTesnenia.StepName:='158 - Automaticky Rezim - cakam na zrusenie stavu serva v pozicii';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			IF NOT P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 159;
			END_IF		
		
			
		159:
			SC_P2_ZakladacTesnenia.StepName:='159 - Automaticky Rezim - presun zdvihu do pozicie pred pritlakom';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		
		 
            
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Acc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Dcc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Zdvih_RychlostZdvihu/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 60;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			
					
			IF EDGEPOS(P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 160;
			END_IF		
			
		160:
			SC_P2_ZakladacTesnenia.StepName:='160 - Automaticky Rezim - cakam na zrusenie stavu serva v pozicii';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			IF NOT P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 161;
			END_IF		
			
		
				
		161:
			SC_P2_ZakladacTesnenia.StepName:='160 - Automaticky Rezim - presun zdvihu do pozicie zatlacenia na moment';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		
                       
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Acc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Dcc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Zdvih_RychlZatlacen/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= P2_RemPremenne.P2_ZaklTesn_Zdvih_MomZatlacen;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 150; 
			
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			
			IF EDGEPOS(P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InTorque) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				PocetZatlaceni:= PocetZatlaceni + 1;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 162;
			END_IF
			
		
		162:
			SC_P2_ZakladacTesnenia.StepName:='162 - Automaticky Rezim - ratanie poctu zatlaceni';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		
			            
			IF PocetZatlaceni < P2_RemPremenne.P2_ZaklTesn_PocetZatlaceni THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 163;
			ELSE
				PocetZatlaceni:= 0;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 164;
			END_IF    
		
		
		163:
			SC_P2_ZakladacTesnenia.StepName:='163 - Automaticky Rezim - presun zdvihu do pozicie pred pritlakom';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		            
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Acc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Dcc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Zdvih_RychlZatlacen/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 60;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
								
			IF EDGEPOS(P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 160;
			END_IF	
		
		164:
			SC_P2_ZakladacTesnenia.StepName:='164 - Automaticky Rezim - presun zdvihu do pozicie pred pritlakom po ukonceni zatlacenia';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		            
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Acc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Dcc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Zdvih_RychlZatlacen/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 60;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
								
			IF EDGEPOS(P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 165;
			END_IF		
			
			
		
		165:
			SC_P2_ZakladacTesnenia.StepName:='165 - Automaticky Rezim - presun zdvihu do vychodiskovej pozicie ';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
		
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Acc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Zdvih_Dcc;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Zdvih_RychlostZdvihu/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 0;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			
					
			IF EDGEPOS(P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 166;
			END_IF	
            
          		
			
			
		166:
			SC_P2_ZakladacTesnenia.StepName:='166 - Automaticky Rezim - vysunutie vozíka';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			
			
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Acc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Dcc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Pojazd_RychlVysun/1000;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Position:= P2_RemPremenne.P2_ZaklTesn_Pojazd_PozVkladania;
            
                      
			
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND Safety.STAV.P2_ZaklTesn_Bumper_AKTIVNY AND P2_ZakladacTesnenia.IN.Kopito_ZakladPoloha AND P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
		
			IF EDGEPOS(P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.InPosition) THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= FALSE;
				CAM1.STAV.OldRunCounter:= CAM1.STAV.RunCounter;
				CAM1.STAV.Results_READY:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 168;
			END_IF
			
			
				
			
		168:
			SC_P2_ZakladacTesnenia.StepName:='168 - Automaticky Rezim - kamerova kontrola zalozenia tesnenia na Power CP';//CAM 1//
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
            P2_StoperZaklTesnenia.Banner.IN.ModraLED_ON:= TRUE;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 AND CAM1.STAV.Command_READY THEN
				CAM1.CMD.Triger:= TRUE;
				SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF
			
			IF CAM1.STAV.Results_READY AND CAM1.STAV.Command_AKCEPTOVANY AND CAM1.STAV.OldRunCounter <> CAM1.STAV.RunCounter THEN
				PocetTrigrovKamery:= 0;
				CAM1.STAV.Results_READY:= FALSE;
				CAM1.STAV.OldRunCounter:= CAM1.STAV.RunCounter;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 172;
			ELSIF SC_P2_ZakladacTesnenia.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM1.STAV.Results_READY:= FALSE;
				CAM1.STAV.OldRunCounter:= CAM1.STAV.RunCounter;
				CAM1.CMD.Triger:= FALSE;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 170;
			ELSIF SC_P2_ZakladacTesnenia.IdleTime.Q AND  PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[290]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST1:= TRUE;    
			END_IF	
		
            
             
            
            
            
		170:
			SC_P2_ZakladacTesnenia.StepName:='170 - Automaticky Rezim - cakam na opatovny triger kamery CAM1';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#1s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
            
			IF SC_P2_ZakladacTesnenia.IdleTime.Q THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 168;
			END_IF	
            
			
		172:
			SC_P2_ZakladacTesnenia.StepName:='172 - Automaticky Rezim - vysledok kamerovej kontroly zalozenia tesnenia na Power CP';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#500ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			SC_P2_ZakladacTesnenia.IdleTime.IN:= TRUE;
			
            
			IF Linka.P2_Kamery_OFF THEN
				CAM1.CMD.Triger:= FALSE;
				CAM1.PAR.ResultFotky:= 'PASS';
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 174;
			ELSIF NOT CAM1.STAV.BUSY THEN
				CAM1.CMD.Triger:= FALSE;
				IF CAM1.RESULT.ZalozenieTesnenia_OK THEN
					CAM1.PAR.ResultFotky:= 'PASS';
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 174;
				ELSE 
					CAM1.PAR.ResultFotky:= 'FAIL';
					SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
					SC_P2_ZakladacTesnenia.Step:= 174;        
				END_IF	
			END_IF
		
		
			
			
		174:
			SC_P2_ZakladacTesnenia.StepName:='174 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly spravnosti zalozenia tesnenia';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
				
				
			IF CAM1.PAR.ResultFotky = 'PASS' THEN
				P2_ZakladacTesnenia.COM_OUT.VysledokZalozeniaTesnenia:= 'OK';
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 180;       
			ELSIF CAM1.PAR.ResultFotky = 'FAIL' THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 176;
			END_IF
		
                   
            
			
		176:
			SC_P2_ZakladacTesnenia.StepName:='176 - Automaticky Rezim - zobrazenie hlasenia zle zalozene tesnenie';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			P2_StoperZaklTesnenia.Banner.IN.CervenaLED_ON:= Blikac500ms;
			P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= Blikac500ms;
			
			
			
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 THEN
				P2_Vizu.ZobrazHL7_ST3:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF
			
						
			
			
			IF EDGEPOS(Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE) THEN
				CAM1.STAV.Results_READY:= FALSE;
				CAM1.STAV.OldRunCounter:= CAM1.STAV.RunCounter;
				P2_Vizu.ZobrazHL7_ST3:= FALSE;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner//	
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 178;
			ELSIF P2_ZaklTesn_KAM_Result_Ignoruj THEN
				CAM1.PAR.ResultFotky:= 'PASS';
				CAM1.STAV.Results_READY:= FALSE;
				P2_ZaklTesn_KAM_Result_Ignoruj:= FALSE;
				P2_Vizu.ZobrazHL7_ST3:= FALSE;
				P2_StoperZaklTesnenia.CMD.Banner_LED_OFF:= TRUE; //Zhasnem banner//	
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 180;
			END_IF
			
						
			
		178:
			SC_P2_ZakladacTesnenia.StepName:='178 - Automaticky Rezim - vymazanie fotky kamery CAM1';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 105;
			ELSIF NOT SC_P2_ZakladacTesnenia.Switch1 THEN
				FTP_CAM1.CMD.VymazFotku:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM1.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM1.CMD.VymazFotku:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 105;
			ELSIF FTP_CAM1.STATUS.KomunikaciaError THEN
				P2_Alarmy[225]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
			
		
			
									
		180:
			SC_P2_ZakladacTesnenia.StepName:='180 - Automaticky Rezim - vystavenie signalu tesnenie zalozene';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;	
			
			P2_Vizu.ZobrazHL8_ST3:= TRUE;
			
			IF NOT SC_P2_ZakladacTesnenia.Switch1 THEN
				P2_ZakladacTesnenia.COM_OUT.Stav_ZalozenieTesneniaUkoncene:= TRUE;
				SC_P2_ZakladacTesnenia.Switch1:= TRUE;
			END_IF	
			
			IF NOT P2_ZakladacTesnenia.IN.Pojazd_PritomPowerCP THEN
				P2_Vizu.ZobrazHL8_ST3:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 181;
			END_IF 
           
			
		181:
			SC_P2_ZakladacTesnenia.StepName:='181 - Automaticky Rezim - cakanie na zrusenie signalu zaloz tesnenie';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#200ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_ZakladacTesnenia.COM_IN.ZalozTesnenie THEN
				P2_ZakladacTesnenia.COM_OUT.Stav_ZalozenieTesneniaUkoncene:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 185;
			END_IF
		
		
		185:
			SC_P2_ZakladacTesnenia.StepName:='185 - Automaticky Rezim - zasunutie suflika pod pritlacanie, cakanie na stlacenie dvojrucneho ovladania';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#300ms;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;	
		
			P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= Blikac500ms;
			SC_P2_ZakladacTesnenia.IdleTime.IN:= Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE AND NOT P2_ZakladacTesnenia.IN.Pojazd_PritomPowerCP;
				
					
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Acc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Acc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Dcc:= P2_RemPremenne.P2_ZaklTesn_Pojazd_Dcc;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Velocity:= P2_RemPremenne.P2_ZaklTesn_Pojazd_RychlZasun/1000;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Torque:= 1.0;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Position:= P2_RemPremenne.P2_ZaklTesn_Pojazd_PozZatlacenia;
			
											
			IF SC_P2_ZakladacTesnenia.IdleTime.Q AND P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.Ready THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= FALSE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= TRUE;
			END_IF
			
			IF P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition AND NOT Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= TRUE;
			END_IF	
			
						
			
			IF P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.InPosition THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= FALSE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Pause:= FALSE;
				P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON:= FALSE;
				SC_P2_ZakladacTesnenia.ResetStep:= TRUE;
				SC_P2_ZakladacTesnenia.Step:= 100;
			END_IF	
             
							
			
		
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P2_ZakladacTesnenia.StepName:='700 - Manualny Rezim';
			SC_P2_ZakladacTesnenia.IdleTime.PT:= T#8s;
			SC_P2_ZakladacTesnenia.AlarmTime.PT:= T#5s;	
		
			
			
			//Ovládanie zdvihu zakladaèa//
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Acc:= 1;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Dcc:= 1;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Velocity:= P2_ZakladacTesnenia.PAR.ZakladacZdvih_JoggRychlost/1000;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.TorqueLimitation:= TRUE;
			P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Torque:= 1;
			
					
			IF P2_ZakladacTesnenia.CMD.RR_ZdvihZakladaca_DOLE AND NOT P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.Stop AND Safety.STAV.P2_ZaklTesn_PojazdMuting_AKTIVNY THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= P2_RemPremenne.P2_ZaklTesn_Zdvih_PozZatlacenia;
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
			ELSIF P2_ZakladacTesnenia.CMD.RR_ZdvihZakladaca_HORE AND NOT P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.Stop THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Parameters.Position:= 0;
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= TRUE;
			ELSE
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.MovePosition:= FALSE;
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.Stop:= TRUE;
			END_IF	
					
			IF P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.Stop AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.StandStill THEN
				P2_ZakladacTesnenia.ServoZdvihuZakladaca.Command.Stop:= FALSE;
			END_IF	
			
			
			
			//Ovládanie pojazdu zakladaèa//
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Acc:= 1;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Dcc:= 1;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Velocity:= P2_ZakladacTesnenia.PAR.ZakladacPojazd_JoggRychlost/1000;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.TorqueLimitation:= TRUE;
			P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Torque:= 1;
			
					
			IF P2_ZakladacTesnenia.CMD.RR_PojazdZakladaca_VYSUN AND NOT P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Stop AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.ActPosition < 50 THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Position:= P2_RemPremenne.P2_ZaklTesn_Pojazd_PozVkladania;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= TRUE;
			ELSIF P2_ZakladacTesnenia.CMD.RR_PojazdZakladaca_ZASUN AND NOT P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Stop AND P2_ZakladacTesnenia.ServoZdvihuZakladaca.Status.ActPosition < 50 THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Parameters.Position:= P2_RemPremenne.P2_ZaklTesn_Pojazd_PozZatlacenia;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= TRUE;
			ELSE
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.MovePosition:= FALSE;
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Stop:= TRUE;
			END_IF	
					
			IF P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Stop AND P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.StandStill THEN
				P2_ZakladacTesnenia.ServoPojazduZakladaca.Command.Stop:= FALSE;
			END_IF	
			
		
		
		
		
		
		
	
	END_CASE
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

