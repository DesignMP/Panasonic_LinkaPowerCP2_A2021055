
ACTION ProfinetKomunikaciaRobot: 

	//Vstupy z Robota do PLC//
	P1_Robot.COM_IN.Stav_RezimAUTOMAT:= P1_Robot.COM_IN.BYTE_IN[0].0;
	P1_Robot.COM_IN.Stav_ProgramRUN:= P1_Robot.COM_IN.BYTE_IN[0].1;
	P1_Robot.COM_IN.Stav_MotoryOFF:= P1_Robot.COM_IN.BYTE_IN[0].2;
	P1_Robot.COM_IN.Stav_MotoryON:= P1_Robot.COM_IN.BYTE_IN[0].3;
	P1_Robot.COM_IN.Stav_RobotCS:= P1_Robot.COM_IN.BYTE_IN[0].4;
	
	
	P1_Robot.COM_IN.Stav_DPS_4F_Odobraty:= P1_Robot.COM_IN.BYTE_IN[1].0;
	P1_Robot.COM_IN.Stav_DPS_4F_Polozeny:= P1_Robot.COM_IN.BYTE_IN[1].1;
	P1_Robot.COM_IN.Stav_DPS_5F_Odobraty:= P1_Robot.COM_IN.BYTE_IN[1].2;
	P1_Robot.COM_IN.Stav_DPS_5F_Polozeny:= P1_Robot.COM_IN.BYTE_IN[1].3;
	P1_Robot.COM_IN.Stav_Foam4F_Odobraty:= P1_Robot.COM_IN.BYTE_IN[1].4;
	P1_Robot.COM_IN.Stav_Foam4F_Polozeny:= P1_Robot.COM_IN.BYTE_IN[1].5;
	P1_Robot.COM_IN.Stav_Foam5F_Odobraty:= P1_Robot.COM_IN.BYTE_IN[1].6;
	P1_Robot.COM_IN.Stav_Foam5F_Polozeny:= P1_Robot.COM_IN.BYTE_IN[1].7;
	
	P1_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie:= TRUE;(*P1_Robot.COM_IN.BYTE_IN[2].0;*)
	P1_Robot.COM_IN.Stav_RobotOdparkovany:= P1_Robot.COM_IN.BYTE_IN[2].1;
	P1_Robot.COM_IN.Stav_RobotPoziciaCakania:= P1_Robot.COM_IN.BYTE_IN[2].2;
	P1_Robot.COM_IN.Stav_SpodnyBusbar4F_Odobraty:= P1_Robot.COM_IN.BYTE_IN[2].3;
	P1_Robot.COM_IN.Stav_SpodnyBusbar4F_Polozeny:= P1_Robot.COM_IN.BYTE_IN[2].4;
	P1_Robot.COM_IN.Stav_SpodnyBusbar5F_Odobraty:= P1_Robot.COM_IN.BYTE_IN[2].5;
	P1_Robot.COM_IN.Stav_SpodnyBusbar5F_Polozeny:= P1_Robot.COM_IN.BYTE_IN[2].6;
	P1_Robot.COM_IN.Stav_SpodnyBusbar5H_Odobraty:= P1_Robot.COM_IN.BYTE_IN[2].7;
	
	P1_Robot.COM_IN.Stav_SpodnyBusbar5H_Polozeny:= P1_Robot.COM_IN.BYTE_IN[3].0;
    P1_Robot.COM_IN.Stav_VystupyZresetovane:= P1_Robot.COM_IN.BYTE_IN[3].1;
    P1_Robot.COM_IN.Stav_BusbaryUvolnene:= P1_Robot.COM_IN.BYTE_IN[3].2;
    P1_Robot.COM_IN.Stav_RobotOdoberaBusbary:= P1_Robot.COM_IN.BYTE_IN[3].3;
    P1_Robot.COM_IN.Stav_RobotOdoberaFoamy:= P1_Robot.COM_IN.BYTE_IN[3].4;
	
	
	P1_Robot.OUT.OdistiGriper:= P1_Robot.COM_IN.BYTE_IN[4].0;
	P1_Robot.OUT.ZaistiGriper:= P1_Robot.COM_IN.BYTE_IN[4].1;
	P1_Robot.OUT.Griper_OTVOR:= P1_Robot.COM_IN.BYTE_IN[4].2;
	P1_Robot.OUT.Griper_ZATVOR:= P1_Robot.COM_IN.BYTE_IN[4].3;
	P1_Robot.OUT.Vakum_ON:= P1_Robot.COM_IN.BYTE_IN[4].4;
	P1_Robot.OUT.Vakum_OFF:= P1_Robot.COM_IN.BYTE_IN[4].5;
	
	
	
	//Vystupy z PLC do Robota//
	P1_Robot.COM_OUT.BYTE_OUT[0].0:= P1_Robot.COM_OUT.VypniMotory;
	P1_Robot.COM_OUT.BYTE_OUT[0].1:= P1_Robot.COM_OUT.ZapniMotory;
	P1_Robot.COM_OUT.BYTE_OUT[0].2:= P1_Robot.COM_OUT.PP_na_Main;
	P1_Robot.COM_OUT.BYTE_OUT[0].3:= P1_Robot.COM_OUT.StartProgramu;
	P1_Robot.COM_OUT.BYTE_OUT[0].4:= P1_Robot.COM_OUT.StartProgramuMain;
	P1_Robot.COM_OUT.BYTE_OUT[0].5:= P1_Robot.COM_OUT.StopProgramu;
	P1_Robot.COM_OUT.BYTE_OUT[0].6:= P1_Robot.COM_OUT.Reset_CS;
	
	P1_Robot.COM_OUT.BYTE_OUT[1].0:= P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia;
	P1_Robot.COM_OUT.BYTE_OUT[1].1:= P1_Robot.COM_OUT.OdoberDPS_4F_z_Paletky;
	P1_Robot.COM_OUT.BYTE_OUT[1].2:= P1_Robot.COM_OUT.OdoberDPS_5F_z_Paletky;
	P1_Robot.COM_OUT.BYTE_OUT[1].3:= P1_Robot.COM_OUT.OdoberFoam4F_z_Paletky;
	P1_Robot.COM_OUT.BYTE_OUT[1].4:= P1_Robot.COM_OUT.OdoberFoam5F_z_Paletky;
	P1_Robot.COM_OUT.BYTE_OUT[1].5:= P1_Robot.COM_OUT.OdoberSpodnyBusbar4F_z_Paletky;
	P1_Robot.COM_OUT.BYTE_OUT[1].6:= P1_Robot.COM_OUT.OdoberSpodnyBusbar5F_z_Paletky;
	P1_Robot.COM_OUT.BYTE_OUT[1].7:= P1_Robot.COM_OUT.OdoberSpodnyBusbar5H_z_Paletky;
	
	P1_Robot.COM_OUT.BYTE_OUT[2].0:= P1_Robot.COM_OUT.PolozDPS_4F_na_PowerCP;
	P1_Robot.COM_OUT.BYTE_OUT[2].1:= P1_Robot.COM_OUT.PolozDPS_5F_na_PowerCP;
	P1_Robot.COM_OUT.BYTE_OUT[2].2:= P1_Robot.COM_OUT.PolozFoam4F_na_PowerCP;
	P1_Robot.COM_OUT.BYTE_OUT[2].3:= P1_Robot.COM_OUT.PolozFoam5F_na_PowerCP;
	P1_Robot.COM_OUT.BYTE_OUT[2].4:= P1_Robot.COM_OUT.PolozSpodnyBusbar4F_na_PowerCP;
	P1_Robot.COM_OUT.BYTE_OUT[2].5:= P1_Robot.COM_OUT.PolozSpodnyBusbar5F_na_PowerCP;
	P1_Robot.COM_OUT.BYTE_OUT[2].6:= P1_Robot.COM_OUT.PolozSpodnyBusbar5H_na_PowerCP;
	P1_Robot.COM_OUT.BYTE_OUT[2].7:= P1_Robot.COM_OUT.Presun_CakaciaPozicia;
	
	P1_Robot.COM_OUT.BYTE_OUT[3].0:= P1_Robot.IN.DokStanica_PritomnGripra5H;
	P1_Robot.COM_OUT.BYTE_OUT[3].1:= P1_Robot.IN.DokStanica_PritomnGripra45F;
	P1_Robot.COM_OUT.BYTE_OUT[3].2:= P1_Robot.IN.Griper45F_Otvoreny;
	P1_Robot.COM_OUT.BYTE_OUT[3].3:= P1_Robot.IN.Griper45F_Zatvoreny;
	P1_Robot.COM_OUT.BYTE_OUT[3].4:= P1_Robot.IN.Vakum_OK;
	P1_Robot.COM_OUT.BYTE_OUT[3].5:= P1_Robot.IN.TypGripra_45F;
	P1_Robot.COM_OUT.BYTE_OUT[3].6:= P1_Robot.IN.TypGripra_5H;
    P1_Robot.COM_OUT.BYTE_OUT[3].7:= P1_Robot.COM_OUT.Odparkovanie;
    
    P1_Robot.COM_OUT.BYTE_OUT[4].0:= P1_Robot.COM_OUT.UvolniBusbary;
	P1_Robot.COM_OUT.BYTE_OUT[4].1:= P1_Robot.COM_OUT.ZopakujOdoberanie;
	
	
	
	//Typ gripra//
	P1_Robot.IN.TypGripra_45F:= P1_Robot.IN.KodGripra_Bit0 AND NOT P1_Robot.IN.KodGripra_Bit1;	
	P1_Robot.IN.TypGripra_5H:= NOT P1_Robot.IN.KodGripra_Bit0 AND P1_Robot.IN.KodGripra_Bit1;
	
	
	
END_ACTION
