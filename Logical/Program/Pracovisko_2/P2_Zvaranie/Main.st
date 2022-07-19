
PROGRAM _INIT
	
	//Init parametre serva zdvihu zvárania//
	P2_Zvaranie.ServoZdvihuZvarania.Parameters.Override:= 100;
	P2_Zvaranie.PAR.ZdvihZvarania_JoggRychlost:= 5;
	P2_Zvaranie.ServoZdvihuZvarania.Command.TorqueLimitation:= TRUE;
	P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= 1.0;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie podprogramov a knižníc//
	OvlPojazdu;
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_Zvaranie);
	
	
	//Enable serva//
	IF Safety.STAV.P2_ZonaBunky_AKTIVNA AND NOT P2_Zvaranie.ServoZdvihuZvarania.Command.ErrReset THEN
		P2_Zvaranie.ServoZdvihuZvarania.Command.PowerON:= TRUE;
	ELSE
		P2_Zvaranie.ServoZdvihuZvarania.Command.PowerON:= FALSE;
	END_IF	
	
	
	
	
	//Reset poruchy serva//
	IF EDGEPOS(Safety.STAV.P2_ZonaBunky_AKTIVNA)THEN
		P2_Zvaranie.ServoZdvihuZvarania.Command.ErrReset:= TRUE;
	END_IF	
	
	CasResetServo_1.IN:= P2_Zvaranie.ServoZdvihuZvarania.Command.ErrReset;
	IF CasResetServo_1.Q  AND NOT P2_Zvaranie.ServoZdvihuZvarania.Status.Error THEN
		P2_Zvaranie.ServoZdvihuZvarania.Command.ErrReset:= FALSE;
	END_IF
	
	
	CasResetServo_1.PT:= T#500ms;
	CasResetServo_1();
	
	
	
	
	
	//Reset sekcie //
	IF P2_Zvaranie.Reset THEN
		SC_P2_Zvaranie.Step:= 0;
		P2_Zvaranie.ServoZdvihuZvarania.Command.ErrReset:= TRUE;
		P2_Zvaranie.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P2_Zvaranie.Step:= 0;
	END_IF	
	
	
	CASE SC_P2_Zvaranie.Step OF 
	
	
		0:
			SC_P2_Zvaranie.StepName:='0 - Nulovanie';
			P2_Zvaranie.Automat:= FALSE;
			P2_Zvaranie.KoniecCyklu:= FALSE;
			P2_Zvaranie.Manual:= FALSE;
			P2_Zvaranie.STAV.PoINIT:= FALSE;
			SC_OvlPojazdu.Step:= 0;
			P2_Zvaranie.ServoZdvihuZvarania.Command.JogNeg:= FALSE;
			P2_Zvaranie.ServoZdvihuZvarania.Command.JogPos:= FALSE;
			P2_Zvaranie.ServoZdvihuZvarania.Command.MoveAdditive:= FALSE;
			P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
			IF NOT P2_Zvaranie.ServoZdvihuZvarania.Status.StandStill THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.Stop:= TRUE;
			END_IF	
		
			P2_Zvaranie.CMD.RR_ZdvihZvarania_DOLE:= FALSE;
			P2_Zvaranie.CMD.RR_ZdvihZvarania_HORE:= FALSE;
			P2_Zvaranie.CMD.RR_SekvenciaZvarania_START:= FALSE;
			P2_Zvaranie.CMD.RR_Presun_VLAVO:= FALSE;
			P2_Zvaranie.CMD.RR_Presun_VPRAVO:= FALSE;
			P2_Zvaranie.STAV.RR_SekvenciaZvarania_BUSY:= FALSE;
			P2_Zvaranie.OUT.Zvaracka_RESET:= FALSE;
			P2_Zvaranie.OUT.Zvaracka_START:= FALSE;
		
			P2_Zvaranie.COM_OUT.Stav_ZvaranieUkoncene:= FALSE;
			P2_Zvaranie.COM_OUT.Stav_ZatlacenieUkoncene:= FALSE;
			
			
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P2_ZonaBunky_AKTIVNA AND
				P2_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P2_Pracovisko.STAV.Porucha_ST2 AND
				NOT P2_Pracovisko.STAV.Porucha_ST3 AND
				NOT P2_Pracovisko.STAV.Porucha_ST4 AND
				NOT P2_Pracovisko.STAV.Porucha_ST5 AND
				(P2_Zvaranie.ServoZdvihuZvarania.Status.Ready AND P2_Zvaranie.ServoZdvihuZvarania.Status.StandStill) THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.Stop:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 1;
			END_IF
		
		
		1:
			SC_P2_Zvaranie.StepName:='1 - Cakam na spustenie vyroby';
			P2_Zvaranie.KoniecCyklu:= FALSE;
			IF P2_Zvaranie.Automat THEN
				SC_P2_Zvaranie.Step:= 2;
			ELSIF P2_Zvaranie.Manual THEN
				SC_P2_Zvaranie.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		
		2:
			SC_P2_Zvaranie.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_Zvaranie.IdleTime.PT:= T#2s;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Acc:= P2_RemPremenne.P2_Zvaranie_Acc;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Dcc:= P2_RemPremenne.P2_Zvaranie_Dcc;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= 1.0;
				
			
			SC_P2_Zvaranie.IdleTime.IN:= TRUE;
									
			IF SC_P2_Zvaranie.IdleTime.Q THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 5;
			END_IF
		
			
		5:
			SC_P2_Zvaranie.StepName:='5 - Inicializacia - presun zdvihu zvarania do vychodiskovej pozicie';
			SC_P2_Zvaranie.IdleTime.PT:= T#2s;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
		
					
			P2_Robot.COM_OUT.Zvaranie_BezpecnaPozicia:= FALSE;
			
			
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZdvihu/1000;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= 0;
			
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF	
				
			IF P2_Zvaranie.ServoZdvihuZvarania.Status.InPosition THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 10;
			END_IF
			
			
					
		10:
			SC_P2_Zvaranie.StepName:='10 - Inicializacia - presun pojazdu zvarania vpravo';
			SC_P2_Zvaranie.IdleTime.PT:= T#2s;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				PresunVPRAVO:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
			
			IF P2_Zvaranie.IN.ZvaraniePresunute_VPRAVO THEN
				P2_Robot.COM_OUT.Zvaranie_BezpecnaPozicia:= TRUE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 12;
			END_IF
				
			
		12:
			SC_P2_Zvaranie.StepName:='12 - Inicializacia - kontrola stavu zvaracky';
			SC_P2_Zvaranie.IdleTime.PT:= T#2s;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Zvaranie.IN.ZvarackaStav_READY THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 15;
			ELSE
				P2_Zvaranie.STAV.PoINIT:= TRUE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 100;
			END_IF	
			
		15:
			SC_P2_Zvaranie.StepName:='15 - Inicializacia - reset zvaracky';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.OUT.Zvaracka_RESET:= TRUE;
				SC_P2_Zvaranie.IdleTime.IN:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
			
	
			IF SC_P2_Zvaranie.IdleTime.Q THEN
				P2_Zvaranie.OUT.Zvaracka_RESET:= FALSE;
			END_IF
			
			IF P2_Zvaranie.IN.ZvarackaStav_READY THEN
				P2_Zvaranie.STAV.PoINIT:= TRUE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 100;
			END_IF
			
			
			//********************************************************Automatický režim****************************************************************************//
		
		100:  
			SC_P2_Zvaranie.StepName:='100 - Automaticky Rezim - cakam na spustenie zvarania';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;			
	
			P2_Robot.COM_OUT.Zvaranie_BezpecnaPozicia:= TRUE;
			
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Acc:= P2_RemPremenne.P2_Zvaranie_Acc;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Dcc:= P2_RemPremenne.P2_Zvaranie_Dcc;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= 1.0;
			
			
			
			IF P2_Zvaranie.KoniecCyklu AND NOT P2_StoperZvarania.Automat THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 0;
			ELSIF P2_Zvaranie.COM_IN.Zvaranie_START THEN
				P2_Robot.COM_OUT.Zvaranie_BezpecnaPozicia:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 102;
			ELSIF  P2_Zvaranie.COM_IN.Zatlacanie_START THEN
				P2_Robot.COM_OUT.Zvaranie_BezpecnaPozicia:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 200;   
			END_IF	
					
		
		102:
			SC_P2_Zvaranie.StepName:='102 - Automaticky Rezim - napolohovanie zdvihu zvaracky nad bod zvarania';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
			
			IF NOT P2_Zvaranie.Manual THEN
				P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZdvihu/1000;
			ELSE
				P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_Zvaranie.PAR.ZdvihZvarania_JoggRychlost/1000;
			END_IF
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= 236;
			
					
			
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				PresunVPRAVO:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF	
				
			IF EDGEPOS(P2_Zvaranie.ServoZdvihuZvarania.Status.InPosition) AND P2_Zvaranie.IN.ZvaraniePresunute_VPRAVO THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 105;
			END_IF
			
				
			
		
		105:
			SC_P2_Zvaranie.StepName:='105 - Automaticky Rezim - spustenie zvaracky';
			SC_P2_Zvaranie.IdleTime.PT:= T#500ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#2s;	
			
			SC_P2_Zvaranie.AlarmTime.IN:= NOT P2_Zvaranie.IN.ZvarackaStav_READY;
            
			IF NOT SC_P2_Zvaranie.Switch1 AND P2_Zvaranie.IN.ZvarackaStav_READY THEN
				P2_Zvaranie.OUT.Zvaracka_START:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
			
                        
			IF P2_Zvaranie.IN.ZvarackaStav_RUN THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 108;
			ELSIF SC_P2_Zvaranie.AlarmTime.Q THEN
				P2_Zvaranie.OUT.Zvaracka_START:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 106;
			END_IF
	
		106:
			SC_P2_Zvaranie.StepName:='106 - Automaticky Rezim - resetovanie zvaracky';
			SC_P2_Zvaranie.IdleTime.PT:= T#500ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
                    
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.OUT.Zvaracka_RESET:= TRUE;
				SC_P2_Zvaranie.IdleTime.IN:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
               
			IF SC_P2_Zvaranie.IdleTime.Q THEN
				P2_Zvaranie.OUT.Zvaracka_RESET:= FALSE;
			END_IF	
			
			
			IF P2_Zvaranie.IN.ZvarackaStav_READY AND NOT P2_Zvaranie.OUT.Zvaracka_RESET THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 105;
			END_IF    
            
			
			
			
			
			//Zváranie//		                             
			
		108:
			SC_P2_Zvaranie.StepName:='108 - Automaticky Rezim - zvaranie pravej casti';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;   
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			
			
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZvarania/1000;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= P2_RemPremenne.P2_Zvaranie_MomentZvarania_PS;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= P2_RemPremenne.P2_Zvaranie_PoziciaZvarania_PS;
			
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF	
				
			IF EDGEPOS(P2_Zvaranie.ServoZdvihuZvarania.Status.InTorque) THEN
				Reports.Zvaranie.Moment.PravyZvar:= REAL_TO_STRING(P2_Zvaranie.ServoZdvihuZvarania.Status.ActTorque);
				Reports.Zvaranie.Vyska.PravyZvar:= REAL_TO_STRING(P2_Zvaranie.ServoZdvihuZvarania.Status.ActPosition);
				Reports.Zvaranie.Frekvencia:= '80';
				P2_Zvaranie.STAV.Vysledok_Zvarania:= 'OK';
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 110;
			END_IF
			
			
			
		110:
			SC_P2_Zvaranie.StepName:='110 - Automaticky Rezim - napolohovanie zdvihu zvaracky nad bod zvarania, vypnutie zvaracky';
			SC_P2_Zvaranie.IdleTime.PT:= P2_RemPremenne.P2_Zvaranie_CasZvarania;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
			SC_P2_Zvaranie.IdleTime.IN:= TRUE;
			
			IF NOT P2_Zvaranie.Manual THEN
				P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZdvihu/1000;
			ELSE
				P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_Zvaranie.PAR.ZdvihZvarania_JoggRychlost/1000;
			END_IF
			
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= 1.0;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= 236;
			
			
			IF NOT SC_P2_Zvaranie.Switch1 AND SC_P2_Zvaranie.IdleTime.Q THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF	
				
			IF EDGEPOS(P2_Zvaranie.ServoZdvihuZvarania.Status.InPosition) THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 112;
			END_IF	
			
		
		112:
			SC_P2_Zvaranie.StepName:='112 - Automaticky Rezim - presun pojazdu zvarania vlavo';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				PresunVLAVO:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
			
			IF P2_Zvaranie.IN.ZvaraniePresunute_VLAVO THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 115;
			END_IF
			
		115:
			SC_P2_Zvaranie.StepName:='115 - Automaticky Rezim - spustenie zvaracky';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#2s;	
			
			SC_P2_Zvaranie.AlarmTime.IN:= NOT P2_Zvaranie.IN.ZvarackaStav_READY;
            
			IF NOT SC_P2_Zvaranie.Switch1 AND P2_Zvaranie.IN.ZvarackaStav_READY THEN
				P2_Zvaranie.OUT.Zvaracka_START:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
			
			IF P2_Zvaranie.IN.ZvarackaStav_RUN THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 118;
			ELSIF SC_P2_Zvaranie.AlarmTime.Q THEN
				P2_Zvaranie.OUT.Zvaracka_START:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 116;    
			END_IF
	
                    
            
	        
		116:
			SC_P2_Zvaranie.StepName:='116 - Automaticky Rezim - resetovanie zvaracky';
			SC_P2_Zvaranie.IdleTime.PT:= T#500ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
                    
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.OUT.Zvaracka_RESET:= TRUE;
				SC_P2_Zvaranie.IdleTime.IN:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
            
			IF SC_P2_Zvaranie.IdleTime.Q THEN
				P2_Zvaranie.OUT.Zvaracka_RESET:= FALSE;
			END_IF	
			
			
			IF P2_Zvaranie.IN.ZvarackaStav_READY AND NOT P2_Zvaranie.OUT.Zvaracka_RESET THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 115;
			END_IF    
            
            
            
	
		118:
			SC_P2_Zvaranie.StepName:='118 - Automaticky Rezim - zvaranie lavej casti';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			
          	
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZvarania/1000;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= P2_RemPremenne.P2_Zvaranie_MomentZvarania_LS;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= P2_RemPremenne.P2_Zvaranie_PoziciaZvarania_LS;
			
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF	
				
			IF EDGEPOS(P2_Zvaranie.ServoZdvihuZvarania.Status.InTorque) THEN
				Reports.Zvaranie.Moment.LavyZvar:= REAL_TO_STRING(P2_Zvaranie.ServoZdvihuZvarania.Status.ActTorque);
				Reports.Zvaranie.Vyska.LavyZvar:= REAL_TO_STRING(P2_Zvaranie.ServoZdvihuZvarania.Status.ActPosition);
				Reports.Zvaranie.Frekvencia:= '80';
				P2_Zvaranie.STAV.Vysledok_Zvarania:= 'OK';
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 119;
			END_IF
			
		119:
			SC_P2_Zvaranie.StepName:='119 - Automaticky Rezim - cakam na zrusenie signalu servo v pozicii';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Zvaranie.ServoZdvihuZvarania.Status.InPosition THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 120;
			END_IF
			
			
			
		120:
			SC_P2_Zvaranie.StepName:='120 - Automaticky Rezim - napolohovanie zdvihu zvaracky do vychodiskovej polohy,presun vpravo a vypnutie zvaracky';
			SC_P2_Zvaranie.IdleTime.PT:= P2_RemPremenne.P2_Zvaranie_CasZvarania;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
			SC_P2_Zvaranie.IdleTime.IN:= TRUE;
			
			IF NOT P2_Zvaranie.Manual THEN
				P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZdvihu/1000;
			ELSE
				P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_Zvaranie.PAR.ZdvihZvarania_JoggRychlost/1000;
			END_IF
			
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= 1.0;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= 0;
			
			
			IF NOT SC_P2_Zvaranie.Switch1 AND SC_P2_Zvaranie.IdleTime.Q THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF	
				
			IF EDGEPOS(P2_Zvaranie.ServoZdvihuZvarania.Status.ActPosition < 200) THEN
				PresunVPRAVO:= TRUE;
			END_IF
			
			
			
			IF P2_Zvaranie.ServoZdvihuZvarania.Status.InPosition AND P2_Zvaranie.IN.ZvaraniePresunute_VPRAVO THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				P2_Zvaranie.OUT.Zvaracka_START:= FALSE;
				IF P2_Zvaranie.STAV.RR_SekvenciaZvarania_BUSY THEN
					P2_Zvaranie.STAV.RR_SekvenciaZvarania_BUSY:= FALSE;
					P2_StoperZvarania.CMD.RR_VysunCentrovanie:= FALSE;
					SC_P2_Zvaranie.ResetStep:= TRUE;
					SC_P2_Zvaranie.Step:= 700;
				ELSE	
					SC_P2_Zvaranie.ResetStep:= TRUE;
					SC_P2_Zvaranie.Step:= 122;
				END_IF	
			END_IF	
			
			
			
			
			
		122:
			SC_P2_Zvaranie.StepName:='122 - Automaticky Rezim - vystavenie signalu ukoncenie zvarania';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
			
			P2_Robot.COM_OUT.Zvaranie_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.COM_OUT.Stav_ZvaranieUkoncene:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Zvaranie.COM_IN.Zvaranie_START THEN
				P2_Zvaranie.COM_OUT.Stav_ZvaranieUkoncene:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 100;
			END_IF	

            
			//Zatláèanie Coveru//            
            
		
		200:
			SC_P2_Zvaranie.StepName:='200 - Automaticky Rezim - napolohovanie zdvihu zatlacania nad bod zatlacenia';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
			
		     
			
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZdvihu/1000;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= 200;
			
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				PresunVLAVO:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
			
			
			
			IF NOT SC_P2_Zvaranie.Switch2 AND P2_Zvaranie.IN.ZvaraniePresunute_VLAVO THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				SC_P2_Zvaranie.Switch2:= TRUE;
			END_IF	
				
			IF EDGEPOS(P2_Zvaranie.ServoZdvihuZvarania.Status.InPosition) THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 205;
			END_IF	
			
			
			
			
		205:
			SC_P2_Zvaranie.StepName:='205 - Automaticky Rezim - zatlacanie coveru';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			
			
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZatlacania/1000;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= P2_RemPremenne.P2_Zvaranie_MomentZatlacania;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= 280;
			
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF	
				
			IF P2_Zvaranie.ServoZdvihuZvarania.Status.InTorque THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 206;
			END_IF
			
       
		206:
			SC_P2_Zvaranie.StepName:='206 - Automaticky Rezim - cakam na zrusenie signalu servo v pozicii';
			SC_P2_Zvaranie.IdleTime.PT:= P2_RemPremenne.P2_Zvaranie_CasZatlacania;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
			SC_P2_Zvaranie.IdleTime.IN:= TRUE;
			
			IF NOT P2_Zvaranie.ServoZdvihuZvarania.Status.InPosition THEN
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 208;
			END_IF
				
				
			
		208:
			SC_P2_Zvaranie.StepName:='208 - Automaticky Rezim - napolohovanie zdvihu zatlacania do vychodiskovej polohy';
			SC_P2_Zvaranie.IdleTime.PT:= P2_RemPremenne.P2_Zvaranie_CasZatlacania;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
			SC_P2_Zvaranie.IdleTime.IN:= TRUE;
				
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_RemPremenne.P2_Zvaranie_RychlostZdvihu/1000;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= 1.0;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= 0;
			
			
			IF NOT SC_P2_Zvaranie.Switch1 AND SC_P2_Zvaranie.IdleTime.Q THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF	
				
			IF EDGEPOS(P2_Zvaranie.ServoZdvihuZvarania.Status.ActPosition < 200) THEN
				PresunVPRAVO:= TRUE;
			END_IF
			
			
			
			IF P2_Zvaranie.ServoZdvihuZvarania.Status.InPosition AND P2_Zvaranie.IN.ZvaraniePresunute_VPRAVO THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 210;
			END_IF	
			
				
			
		210:
			SC_P2_Zvaranie.StepName:='210 - Automaticky Rezim - vystavenie signalu ukoncenie zatlacania';
			SC_P2_Zvaranie.IdleTime.PT:= T#200ms;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;	
			
			P2_Robot.COM_OUT.Zvaranie_BezpecnaPozicia:= TRUE;
			
			IF NOT SC_P2_Zvaranie.Switch1 THEN
				P2_Zvaranie.COM_OUT.Stav_ZatlacenieUkoncene:= TRUE;
				SC_P2_Zvaranie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Zvaranie.COM_IN.Zatlacanie_START THEN
				P2_Zvaranie.COM_OUT.Stav_ZatlacenieUkoncene:= FALSE;
				SC_P2_Zvaranie.ResetStep:= TRUE;
				SC_P2_Zvaranie.Step:= 100;
			END_IF	    
            
			
			
	
	
	
			//*******************************************************Manuálny režim*******************************************************************************//
		
		700:
			SC_P2_Zvaranie.StepName:='700 - Manualny Rezim';
			SC_P2_Zvaranie.IdleTime.PT:= T#8s;
			SC_P2_Zvaranie.AlarmTime.PT:= T#5s;
		
		
		
				
			//Ovládanie zdvihu zvárania//
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Acc:= 1;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Dcc:= 1;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Velocity:= P2_Zvaranie.PAR.ZdvihZvarania_JoggRychlost/1000;
			P2_Zvaranie.ServoZdvihuZvarania.Command.TorqueLimitation:= TRUE;
			P2_Zvaranie.ServoZdvihuZvarania.Parameters.Torque:= 1.5;
			
			IF P2_Zvaranie.CMD.RR_ZdvihZvarania_DOLE AND NOT P2_Zvaranie.ServoZdvihuZvarania.Command.Stop THEN
				P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= P2_RemPremenne.P2_Zvaranie_PoziciaZvarania_LS;
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
			ELSIF P2_Zvaranie.CMD.RR_ZdvihZvarania_HORE AND NOT P2_Zvaranie.ServoZdvihuZvarania.Command.Stop THEN
				P2_Zvaranie.ServoZdvihuZvarania.Parameters.Position:= 0;
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= TRUE;
			ELSE
				P2_Zvaranie.ServoZdvihuZvarania.Command.MovePosition:= FALSE;
				P2_Zvaranie.ServoZdvihuZvarania.Command.Stop:= TRUE;
			END_IF	
					
			IF P2_Zvaranie.ServoZdvihuZvarania.Command.Stop AND P2_Zvaranie.ServoZdvihuZvarania.Status.StandStill THEN
				P2_Zvaranie.ServoZdvihuZvarania.Command.Stop:= FALSE;
			END_IF	
			
			
			
			//Presun zvárania //
			IF P2_Zvaranie.CMD.RR_Presun_VLAVO THEN
				PresunVLAVO:= TRUE;
				P2_Zvaranie.CMD.RR_Presun_VLAVO:= FALSE;
			ELSIF P2_Zvaranie.CMD.RR_Presun_VPRAVO THEN
				PresunVPRAVO:= TRUE;
				P2_Zvaranie.CMD.RR_Presun_VPRAVO:= FALSE;
			END_IF	
			
			
			
			
			
		
			//Spustenie sekvencie zvárania//
			IF P2_Zvaranie.CMD.RR_SekvenciaZvarania_START THEN
				IF Safety.STAV.P2_ZonaBunky_AKTIVNA AND P2_StoperZvarania.RFID_hlava.PritomnostPaletky THEN
					P2_Zvaranie.STAV.RR_SekvenciaZvarania_BUSY:= TRUE;
					P2_StoperZvarania.CMD.RR_VysunCentrovanie:= TRUE;
					SC_P2_Zvaranie.ResetStep:= TRUE;
					SC_P2_Zvaranie.Step:= 102;
				END_IF	
				P2_Zvaranie.CMD.RR_SekvenciaZvarania_START:= FALSE;
			END_IF	
		
			
			
		
		
		
	END_CASE	
		
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

