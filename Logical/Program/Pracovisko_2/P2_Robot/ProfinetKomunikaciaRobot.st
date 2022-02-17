
ACTION ProfinetKomunikaciaRobot: 

	
	//Vstupy z Robota do PLC//
	P2_Robot.COM_IN.Stav_RezimAUTOMAT:= P2_Robot.COM_IN.BYTE_IN[0].0;
	P2_Robot.COM_IN.Stav_ProgramRUN:= P2_Robot.COM_IN.BYTE_IN[0].1;
	P2_Robot.COM_IN.Stav_MotoryOFF:= P2_Robot.COM_IN.BYTE_IN[0].2;
	P2_Robot.COM_IN.Stav_MotoryON:= P2_Robot.COM_IN.BYTE_IN[0].3;
	P2_Robot.COM_IN.Stav_RobotCS:= P2_Robot.COM_IN.BYTE_IN[0].4;
	P2_Robot.COM_IN.BYTE_IN[0].5;
	P2_Robot.COM_IN.BYTE_IN[0].6;
	P2_Robot.COM_IN.BYTE_IN[0].7;
	
	P2_Robot.OUT.Griper_ZATVOR:= P2_Robot.COM_IN.BYTE_IN[1].0;
	P2_Robot.OUT.Griper_OTVOR:= P2_Robot.COM_IN.BYTE_IN[1].1;
	P2_Robot.OUT.ZaistiGriper:= P2_Robot.COM_IN.BYTE_IN[1].2;
	P2_Robot.OUT.OdistiGriper:= P2_Robot.COM_IN.BYTE_IN[1].3;
	P2_Robot.OUT.Model5H_Vakum_ON:= P2_Robot.COM_IN.BYTE_IN[1].4;
	P2_Robot.OUT.Model45F_Vakum_ON:= P2_Robot.COM_IN.BYTE_IN[1].5;
	P2_Robot.COM_IN.Stav_Busbary5H_Odobrate:= P2_Robot.COM_IN.BYTE_IN[1].6;
	P2_Robot.COM_IN.Stav_Busbary5F_Odobrate:= P2_Robot.COM_IN.BYTE_IN[1].7;
	
	P2_Robot.COM_IN.Stav_Busbary4F_Odobrate:= P2_Robot.COM_IN.BYTE_IN[2].0;
	P2_Robot.COM_IN.Stav_Busbary5H_Polozene:= P2_Robot.COM_IN.BYTE_IN[2].1;
	P2_Robot.COM_IN.Stav_Busbary5F_Polozene:= P2_Robot.COM_IN.BYTE_IN[2].2;
	P2_Robot.COM_IN.Stav_Busbary4F_Polozene:= P2_Robot.COM_IN.BYTE_IN[2].3;
	P2_Robot.COM_IN.Stav_RobotPoziciaCakania:= P2_Robot.COM_IN.BYTE_IN[2].4;
	P2_Robot.COM_IN.Stav_Filter5H_Dotlaceny:= P2_Robot.COM_IN.BYTE_IN[2].5;
	P2_Robot.COM_IN.BYTE_IN[2].6;
	P2_Robot.COM_IN.Stav_Cistenie_PowerCP_Odobrate:= P2_Robot.COM_IN.BYTE_IN[2].7;
	
	P2_Robot.COM_IN.BYTE_IN[3].0;
	P2_Robot.COM_IN.BYTE_IN[3].1;
	P2_Robot.COM_IN.Stav_Cistenie_Otacanie_Ukoncene:= P2_Robot.COM_IN.BYTE_IN[3].2;
	P2_Robot.COM_IN.Stav_Cistenie_PowerCP_v_Cisteni:= P2_Robot.COM_IN.BYTE_IN[3].3;
	P2_Robot.COM_IN.Stav_Cistenie_PowerCP_Polozene:= P2_Robot.COM_IN.BYTE_IN[3].4;
	P2_Robot.COM_IN.BYTE_IN[3].5;
	P2_Robot.COM_IN.BYTE_IN[3].6;
	P2_Robot.COM_IN.Stav_LavyMvCase5H_Odobraty:= P2_Robot.COM_IN.BYTE_IN[3].7;
	
	P2_Robot.COM_IN.Stav_LavyMvCase5F_Odobraty:= P2_Robot.COM_IN.BYTE_IN[4].0;
	P2_Robot.COM_IN.Stav_LavyMvCase4F_Odobraty:= P2_Robot.COM_IN.BYTE_IN[4].1;
	P2_Robot.COM_IN.Stav_PravyMvCase5H_Odobraty:= P2_Robot.COM_IN.BYTE_IN[4].2;
	P2_Robot.COM_IN.Stav_PravyMvCase5F_Odobraty:= P2_Robot.COM_IN.BYTE_IN[4].3;
	P2_Robot.COM_IN.Stav_PravyMvCase4F_Odobraty:= P2_Robot.COM_IN.BYTE_IN[4].4;
	P2_Robot.COM_IN.Stav_TopCover5H_Odobraty:= P2_Robot.COM_IN.BYTE_IN[4].5;
	P2_Robot.COM_IN.Stav_TopCover5F_Odobraty:= P2_Robot.COM_IN.BYTE_IN[4].6;
	P2_Robot.COM_IN.Stav_TopCover4F_Odobraty:= P2_Robot.COM_IN.BYTE_IN[4].7;
	
	P2_Robot.OUT.Model5H_Vakum_OFF:= P2_Robot.COM_IN.BYTE_IN[5].0;
	P2_Robot.OUT.Model45F_Vakum_OFF:= P2_Robot.COM_IN.BYTE_IN[5].1;
	P2_Robot.OUT.PneuZamokUchopovaca_ODOMKNI:= P2_Robot.COM_IN.BYTE_IN[5].2;
	P2_Robot.COM_IN.Stav_LavyMvCase5H_Polozeny:= P2_Robot.COM_IN.BYTE_IN[5].3;
	P2_Robot.COM_IN.Stav_LavyMvCase5F_Polozeny:= P2_Robot.COM_IN.BYTE_IN[5].4;
	P2_Robot.COM_IN.Stav_LavyMvCase4F_Polozeny:= P2_Robot.COM_IN.BYTE_IN[5].5;
	P2_Robot.COM_IN.Stav_PravyMvCase5H_Polozeny:= P2_Robot.COM_IN.BYTE_IN[5].6;
	P2_Robot.COM_IN.Stav_PravyMvCase5F_Polozeny:= P2_Robot.COM_IN.BYTE_IN[5].7;
	
	
	P2_Robot.COM_IN.Stav_PravyMvCase4F_Polozeny:= P2_Robot.COM_IN.BYTE_IN[6].0;
	P2_Robot.COM_IN.Stav_TopCover5H_Polozeny:= P2_Robot.COM_IN.BYTE_IN[6].1;
	P2_Robot.COM_IN.Stav_TopCover5F_Polozeny:= P2_Robot.COM_IN.BYTE_IN[6].2;
	P2_Robot.COM_IN.Stav_TopCover4F_Polozeny:= P2_Robot.COM_IN.BYTE_IN[6].3;
	P2_Robot.COM_IN.Stav_RobotOdparkovany:= P2_Robot.COM_IN.BYTE_IN[6].4;
	P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie:= P2_Robot.COM_IN.BYTE_IN[6].5;
	P2_Robot.COM_IN.Stav_RobotBezpPozicia_Zvaranie:= P2_Robot.COM_IN.BYTE_IN[6].6;
	P2_Robot.COM_IN.Stav_VystupyZresetovane:= P2_Robot.COM_IN.BYTE_IN[6].7;
	
	P2_Robot.COM_IN.Stav_BusbaryUvolnene:= P2_Robot.COM_IN.BYTE_IN[7].0;
    P2_Robot.COM_IN.Stav_Griper4F5F_Vymeneny:= P2_Robot.COM_IN.BYTE_IN[7].1;
    P2_Robot.COM_IN.Stav_Griper5H_Vymeneny:= P2_Robot.COM_IN.BYTE_IN[7].2;
    P2_Robot.COM_IN.Stav_GriperCistenia_Vymeneny:= P2_Robot.COM_IN.BYTE_IN[7].3;
	P2_Robot.COM_IN.Stav_RobotOdoberaCover:= P2_Robot.COM_IN.BYTE_IN[7].4;
	
	
	//Vystupy z PLC do Robota//
	P2_Robot.COM_OUT.BYTE_OUT[0].0:= P2_Robot.COM_OUT.VypniMotory;
	P2_Robot.COM_OUT.BYTE_OUT[0].1:= P2_Robot.COM_OUT.ZapniMotory;
	P2_Robot.COM_OUT.BYTE_OUT[0].2:= P2_Robot.COM_OUT.PP_na_Main;
	P2_Robot.COM_OUT.BYTE_OUT[0].3:= P2_Robot.COM_OUT.StartProgramu;
	P2_Robot.COM_OUT.BYTE_OUT[0].4:= P2_Robot.COM_OUT.StartProgramuMain;
	P2_Robot.COM_OUT.BYTE_OUT[0].5:= P2_Robot.COM_OUT.StopProgramu;
	P2_Robot.COM_OUT.BYTE_OUT[0].6:= P2_Robot.COM_OUT.Reset_CS;
	P2_Robot.COM_OUT.BYTE_OUT[0].7;
	
	P2_Robot.COM_OUT.BYTE_OUT[1].0:= P2_Robot.IN.TypGripra_5H;
	P2_Robot.COM_OUT.BYTE_OUT[1].1:= P2_Robot.IN.TypGripra_45F;
	P2_Robot.COM_OUT.BYTE_OUT[1].2:= P2_Robot.IN.TypGripra_MvCase;
	P2_Robot.COM_OUT.BYTE_OUT[1].3:= P2_Robot.IN.Griper45F_Otvoreny;
	P2_Robot.COM_OUT.BYTE_OUT[1].4:= P2_Robot.IN.Griper45F_DrziBusbary;
	P2_Robot.COM_OUT.BYTE_OUT[1].5:= P2_Robot.IN.Griper45F_Zatvoreny;
	P2_Robot.COM_OUT.BYTE_OUT[1].6:= P2_Robot.IN.Griper5H_Otvoreny;
	P2_Robot.COM_OUT.BYTE_OUT[1].7:= P2_Robot.IN.Griper5H_DrziBusbary;
	
	P2_Robot.COM_OUT.BYTE_OUT[2].0:= P2_Robot.IN.Griper5H_Zatvoreny;
	P2_Robot.COM_OUT.BYTE_OUT[2].1:= P2_Robot.IN.GriperMvCase_Otvoreny;
	P2_Robot.COM_OUT.BYTE_OUT[2].2:= P2_Robot.IN.GriperMvCase_DrziMvCase;
	P2_Robot.COM_OUT.BYTE_OUT[2].3:= P2_Robot.IN.GriperMvCase_DrziPowerCP;
	P2_Robot.COM_OUT.BYTE_OUT[2].4:= P2_Robot.IN.GriperMvCase_Zatvoreny;
	P2_Robot.COM_OUT.BYTE_OUT[2].5:= P2_Robot.IN.Model5H_Vakum_OK;
	P2_Robot.COM_OUT.BYTE_OUT[2].6:= P2_Robot.IN.Model45F_Vakum_OK;
	P2_Robot.COM_OUT.BYTE_OUT[2].7:= P2_Robot.COM_OUT.Odober_Busbary5H;
	
	P2_Robot.COM_OUT.BYTE_OUT[3].0:= P2_Robot.COM_OUT.Odober_Busbary5F;
	P2_Robot.COM_OUT.BYTE_OUT[3].1:= P2_Robot.COM_OUT.Odober_Busbary4F;
	P2_Robot.COM_OUT.BYTE_OUT[3].2:= P2_Robot.COM_OUT.Poloz_Busbary5H;
	P2_Robot.COM_OUT.BYTE_OUT[3].3:= P2_Robot.COM_OUT.Poloz_Busbary5F;
	P2_Robot.COM_OUT.BYTE_OUT[3].4:= P2_Robot.COM_OUT.Poloz_Busbary4F;
	P2_Robot.COM_OUT.BYTE_OUT[3].5:= P2_Robot.COM_OUT.Presun_CakaciaPozicia;
	P2_Robot.COM_OUT.BYTE_OUT[3].6:= P2_Robot.COM_OUT.Dotlac_Filter5H;
	P2_Robot.COM_OUT.BYTE_OUT[3].7;
	
	P2_Robot.COM_OUT.BYTE_OUT[4].0:= P2_Robot.COM_OUT.Cistenie_OdoberPowerCP_5H;
	P2_Robot.COM_OUT.BYTE_OUT[4].1:= P2_Robot.COM_OUT.Cistenie_OdoberPowerCP_5F;
	P2_Robot.COM_OUT.BYTE_OUT[4].2:= P2_Robot.COM_OUT.Cistenie_OdoberPowerCP_4F;
	P2_Robot.COM_OUT.BYTE_OUT[4].3;
	P2_Robot.COM_OUT.BYTE_OUT[4].4;
	P2_Robot.COM_OUT.BYTE_OUT[4].5;
	P2_Robot.COM_OUT.BYTE_OUT[4].6:= P2_Robot.COM_OUT.Cistenie_PolozPowerCP_5H;
	P2_Robot.COM_OUT.BYTE_OUT[4].7:= P2_Robot.COM_OUT.Cistenie_PolozPowerCP_5F;
	
	P2_Robot.COM_OUT.BYTE_OUT[5].0:= P2_Robot.COM_OUT.Cistenie_PolozPowerCP_4F;
	P2_Robot.COM_OUT.BYTE_OUT[5].1:= P2_Robot.COM_OUT.Odober_LavyMvCase5H;
	P2_Robot.COM_OUT.BYTE_OUT[5].2:= P2_Robot.COM_OUT.Odober_LavyMvCase5F;
	P2_Robot.COM_OUT.BYTE_OUT[5].3:= P2_Robot.COM_OUT.Odober_LavyMvCase4F;
	P2_Robot.COM_OUT.BYTE_OUT[5].4:= P2_Robot.COM_OUT.Odober_PravyMvCase5H;
	P2_Robot.COM_OUT.BYTE_OUT[5].5:= P2_Robot.COM_OUT.Odober_PravyMvCase5F;
	P2_Robot.COM_OUT.BYTE_OUT[5].6:= P2_Robot.COM_OUT.Odober_PravyMvCase4F;
	P2_Robot.COM_OUT.BYTE_OUT[5].7:= P2_Robot.COM_OUT.Odober_TopCover5H;
	
	P2_Robot.COM_OUT.BYTE_OUT[6].0:= P2_Robot.COM_OUT.Odober_TopCover5F;
	P2_Robot.COM_OUT.BYTE_OUT[6].1:= P2_Robot.COM_OUT.Odober_TopCover4F;
	P2_Robot.COM_OUT.BYTE_OUT[6].2:= P2_Robot.IN.DokStanica_PritomGripraBusbar5H;
	P2_Robot.COM_OUT.BYTE_OUT[6].3:= P2_Robot.IN.DokStanica_PritomGripraBusbar45F;
	P2_Robot.COM_OUT.BYTE_OUT[6].4:= P2_Robot.IN.DokStanica_PritomGripraMvCase;
	P2_Robot.COM_OUT.BYTE_OUT[6].5:= P2_Robot.COM_OUT.Cistenie_BezpecnaPozicia;
	P2_Robot.COM_OUT.BYTE_OUT[6].6:= P2_Robot.COM_OUT.Cistenie_OtacajPowerCP;
	P2_Robot.COM_OUT.BYTE_OUT[6].7:= P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia;
	
	P2_Robot.COM_OUT.BYTE_OUT[7].0:= P2_Robot.COM_OUT.Poloz_LavyMvCase5H;
	P2_Robot.COM_OUT.BYTE_OUT[7].1:= P2_Robot.COM_OUT.Poloz_LavyMvCase5F;
	P2_Robot.COM_OUT.BYTE_OUT[7].2:= P2_Robot.COM_OUT.Poloz_LavyMvCase4F;
	P2_Robot.COM_OUT.BYTE_OUT[7].3:= P2_Robot.COM_OUT.Poloz_PravyMvCase5H;
	P2_Robot.COM_OUT.BYTE_OUT[7].4:= P2_Robot.COM_OUT.Poloz_PravyMvCase5F;
	P2_Robot.COM_OUT.BYTE_OUT[7].5:= P2_Robot.COM_OUT.Poloz_PravyMvCase4F;
	P2_Robot.COM_OUT.BYTE_OUT[7].6:= P2_Robot.COM_OUT.Poloz_TopCover5H;
	P2_Robot.COM_OUT.BYTE_OUT[7].7:= P2_Robot.COM_OUT.Poloz_TopCover5F;
	
	P2_Robot.COM_OUT.BYTE_OUT[8].0:= P2_Robot.COM_OUT.Poloz_TopCover4F;
	P2_Robot.COM_OUT.BYTE_OUT[8].1:= P2_Robot.COM_OUT.Odparkovanie;
	P2_Robot.COM_OUT.BYTE_OUT[8].2:= P2_Robot.COM_OUT.Zvaranie_BezpecnaPozicia;
	P2_Robot.COM_OUT.BYTE_OUT[8].3:= P2_Robot.COM_OUT.UvolniBusbary;
    P2_Robot.COM_OUT.BYTE_OUT[8].4:= P2_Robot.COM_OUT.ZmenaGripra_4F5F;
    P2_Robot.COM_OUT.BYTE_OUT[8].5:= P2_Robot.COM_OUT.ZmenaGripra_5H;
    P2_Robot.COM_OUT.BYTE_OUT[8].6:= P2_Robot.COM_OUT.ZmenaGripra_Cistenie;
    P2_Robot.COM_OUT.BYTE_OUT[8].7:= P2_Robot.COM_OUT.ZopakujOdoberanie;
	
	
	
	//Typ gripra//
	P2_Robot.IN.TypGripra_5H:= P2_Robot.IN.KodGripra_Bit0 AND P2_Robot.IN.KodGripra_Bit1;
	P2_Robot.IN.TypGripra_45F:= NOT P2_Robot.IN.KodGripra_Bit0 AND P2_Robot.IN.KodGripra_Bit1;
	P2_Robot.IN.TypGripra_MvCase:= P2_Robot.IN.KodGripra_Bit0 AND NOT P2_Robot.IN.KodGripra_Bit1;
	
	
	//Stavy gripra 5H//
	IF P2_Robot.IN.TypGripra_5H THEN
		IF P2_Robot.PAR.Griper_Busbary5H_HodnOtvorenia > 0 THEN
			P2_Robot.IN.Griper5H_Zatvoreny:= FALSE;
			P2_Robot.IN.Griper5H_DrziBusbary:= FALSE;
			P2_Robot.IN.Griper5H_Otvoreny:= TRUE;
		ELSIF P2_Robot.PAR.Griper_Busbary5H_HodnOtvorenia > 0 THEN	
			P2_Robot.IN.Griper5H_Otvoreny:= FALSE;
			P2_Robot.IN.Griper5H_DrziBusbary:= FALSE;
			P2_Robot.IN.Griper5H_Zatvoreny:= TRUE;
		ELSIF P2_Robot.PAR.Griper_Busbary5H_HodnOtvorenia > 0 THEN	
			P2_Robot.IN.Griper5H_Otvoreny:= FALSE;
			P2_Robot.IN.Griper5H_Zatvoreny:= FALSE;
			P2_Robot.IN.Griper5H_DrziBusbary:= TRUE;
		ELSE
			P2_Robot.IN.Griper5H_Otvoreny:= FALSE;
			P2_Robot.IN.Griper5H_Zatvoreny:= FALSE;
			P2_Robot.IN.Griper5H_DrziBusbary:= FALSE;
		END_IF	
	ELSE
		P2_Robot.IN.Griper5H_Otvoreny:= FALSE;
		P2_Robot.IN.Griper5H_Zatvoreny:= FALSE;
		P2_Robot.IN.Griper5H_DrziBusbary:= FALSE;
	END_IF	
	
	
	
	
	
	//Stavy gripra 45F//
	IF P2_Robot.IN.TypGripra_45F THEN
		IF P2_Robot.PAR.Griper_Busbary45F_HodnOtvorenia > 0 THEN
			P2_Robot.IN.Griper45F_Zatvoreny:= FALSE;
			P2_Robot.IN.Griper45F_DrziBusbary:= FALSE;
			P2_Robot.IN.Griper45F_Otvoreny:= TRUE;
		ELSIF P2_Robot.PAR.Griper_Busbary45F_HodnOtvorenia > 0 THEN	
			P2_Robot.IN.Griper45F_Otvoreny:= FALSE;
			P2_Robot.IN.Griper45F_DrziBusbary:= FALSE;
			P2_Robot.IN.Griper45F_Zatvoreny:= TRUE;
		ELSIF P2_Robot.PAR.Griper_Busbary45F_HodnOtvorenia > 0 THEN	
			P2_Robot.IN.Griper45F_Otvoreny:= FALSE;
			P2_Robot.IN.Griper45F_Zatvoreny:= FALSE;
			P2_Robot.IN.Griper45F_DrziBusbary:= TRUE;
		ELSE
			P2_Robot.IN.Griper45F_Otvoreny:= FALSE;
			P2_Robot.IN.Griper45F_Zatvoreny:= FALSE;
			P2_Robot.IN.Griper45F_DrziBusbary:= FALSE;
		END_IF
	ELSE
		P2_Robot.IN.Griper45F_Otvoreny:= FALSE;
		P2_Robot.IN.Griper45F_Zatvoreny:= FALSE;
		P2_Robot.IN.Griper45F_DrziBusbary:= FALSE;
	END_IF	
	
	
	
	
	
	
END_ACTION
