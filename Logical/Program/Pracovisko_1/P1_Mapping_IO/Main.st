
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//**********************************************************IO modul Wedmuller**********************************************************************//
	//************Karta AB 1.2 8DI**************//
	P1_Srobovanie.IN.NapajanieSkrutkovackyK30_OK :=  P1_Pracovisko.COM_Weidmuller.AB1_2_8DI.0;
	P1_Srobovanie.IN.NapajanieSkrutkovackyM5_OK := P1_Pracovisko.COM_Weidmuller.AB1_2_8DI.1;
	P1_Srobovanie.IN.NapajanieSkrutkovackyM4_OK := P1_Pracovisko.COM_Weidmuller.AB1_2_8DI.2;
	P1_Srobovanie.SkrutSet_M4.IN.NapajanieZasobnika_OK := P1_Pracovisko.COM_Weidmuller.AB1_2_8DI.3;
	P1_Srobovanie.SkrutSet_M4.IN.NapajanieVibrolisty_OK := P1_Pracovisko.COM_Weidmuller.AB1_2_8DI.4;
	P1_Srobovanie.SkrutSet_M5.IN.NapajanieZasobnika_OK := P1_Pracovisko.COM_Weidmuller.AB1_2_8DI.5;
	P1_Srobovanie.SkrutSet_M5.IN.NapajanieVibrolisty_OK := P1_Pracovisko.COM_Weidmuller.AB1_2_8DI.6;
	P1_Vytah.IN.StavRiadeniaDopravVytahu_READY := P1_Pracovisko.COM_Weidmuller.AB1_2_8DI.7;
	
	//***********Karta AB 1.3 8DI***************//
	P1_Dopravniky.IN.StavRiadeniaDopravBunky_READY := P1_Pracovisko.COM_Weidmuller.AB1_3_8DI.0;
	P1_Dopravniky.IN.StavRiadeniaVratnehoDoprav_READY := P1_Pracovisko.COM_Weidmuller.AB1_3_8DI.1;
	P1_Vytah.IN.TeplotaMotoraDopravVytahu_NG := P1_Pracovisko.COM_Weidmuller.AB1_3_8DI.2;
	P1_Dopravniky.IN.TeplotaMotoraDopravBunky_NG := P1_Pracovisko.COM_Weidmuller.AB1_3_8DI.3;
	P1_Dopravniky.IN.TeplotaMotoraVratnehoDoprav_NG := P1_Pracovisko.COM_Weidmuller.AB1_3_8DI.4;
	P1_Pracovisko.COM_Weidmuller.AB1_3_8DI.5;
	P1_Pracovisko.COM_Weidmuller.AB1_3_8DI.6;
	P1_Srobovanie.IN.NapajanieZasobnikaK30_OK := P1_Pracovisko.COM_Weidmuller.AB1_3_8DI.7;
	
	
	//************Karta AB 1.4 8DI**************//
	P1_Pracovisko.COM_Weidmuller.AB1_4_8DI.0;
	P1_Pracovisko.COM_Weidmuller.AB1_4_8DI.1;
	P1_Pracovisko.COM_Weidmuller.AB1_4_8DI.2;
	P1_Pracovisko.COM_Weidmuller.AB1_4_8DI.3;
	P1_Pracovisko.COM_Weidmuller.AB1_4_8DI.4;
	P1_Pracovisko.COM_Weidmuller.AB1_4_8DI.5;
	P1_Pracovisko.COM_Weidmuller.AB1_4_8DI.6;
	P1_Pracovisko.COM_Weidmuller.AB1_4_8DI.7;
	
	//************Karta AB 1.5 8DI***************//
	Safety.IN.Linka_SV_ZonaCS := P1_Pracovisko.COM_Weidmuller.AB1_5_8DI.0;
	Safety.IN.P1_SV_ZonaBunky := P1_Pracovisko.COM_Weidmuller.AB1_5_8DI.1;
	Safety.IN.P1_SV_ZonaVytahu := P1_Pracovisko.COM_Weidmuller.AB1_5_8DI.2;
	P1_Pracovisko.COM_Weidmuller.AB1_5_8DI.3;
	P1_Pracovisko.COM_Weidmuller.AB1_5_8DI.4;
	P1_Pracovisko.COM_Weidmuller.AB1_5_8DI.5;
	P1_Pracovisko.COM_Weidmuller.AB1_5_8DI.6;
	P1_Pracovisko.COM_Weidmuller.AB1_5_8DI.7;
	
	
	//************Karta AB 1.6 8DO***************//
	P1_Pracovisko.COM_Weidmuller.AB1_6_8DO.0 := P1_Pracovisko.OUT.Majak_ZeleneSvetlo_ON;
	P1_Pracovisko.COM_Weidmuller.AB1_6_8DO.1 := P1_Pracovisko.OUT.Majak_OranzoveSvetlo_ON; 
	P1_Pracovisko.COM_Weidmuller.AB1_6_8DO.2 := P1_Pracovisko.OUT.Majak_CerveneSvetlo_ON;
	P1_Pracovisko.COM_Weidmuller.AB1_6_8DO.3 := P1_Pracovisko.OUT.Majak_Hukacka_ON;
	P1_Pracovisko.COM_Weidmuller.AB1_6_8DO.4 := P1_Srobovanie.SkrutSet_M4.OUT.VibropohonZasobnika_RUN;
	P1_Pracovisko.COM_Weidmuller.AB1_6_8DO.5 := P1_Srobovanie.SkrutSet_M4.OUT.VibropohonListy_RUN;
	P1_Pracovisko.COM_Weidmuller.AB1_6_8DO.6 := P1_Srobovanie.SkrutSet_M5.OUT.VibropohonZasobnika_RUN;
	P1_Pracovisko.COM_Weidmuller.AB1_6_8DO.7 := P1_Srobovanie.SkrutSet_M5.OUT.VibropohonListy_RUN;
	
	
	//************Karta AB 1.7 8DO***************//
	P1_Pracovisko.COM_Weidmuller.AB1_7_8DO.0 := P1_Pracovisko.OUT.OsvetlenieBunky_ON;
	P1_Pracovisko.COM_Weidmuller.AB1_7_8DO.1 := P1_Vytah.OUT.DopravnikChod_VPRED;
	P1_Pracovisko.COM_Weidmuller.AB1_7_8DO.2 := P1_Vytah.OUT.DopravnikChod_VZAD;
	P1_Pracovisko.COM_Weidmuller.AB1_7_8DO.3 := P1_Dopravniky.OUT.DopravnikBunky_ON;
	P1_Pracovisko.COM_Weidmuller.AB1_7_8DO.4 := P1_Dopravniky.OUT.VratnyDopravnik_ON;
	P1_Pracovisko.COM_Weidmuller.AB1_7_8DO.5 := P1_Robot.OUT.Griper_OTVOR;
	P1_Pracovisko.COM_Weidmuller.AB1_7_8DO.6 := P1_Robot.OUT.Griper_ZATVOR;
	P1_Pracovisko.COM_Weidmuller.AB1_7_8DO.7;
	
	//***********Karta AB 1.9 8DO*****************//
	P1_Pracovisko.COM_Weidmuller.AB1_9_8DO.0;
	P1_Pracovisko.COM_Weidmuller.AB1_9_8DO.1;
	P1_Pracovisko.COM_Weidmuller.AB1_9_8DO.2;
	P1_Pracovisko.COM_Weidmuller.AB1_9_8DO.3;
	P1_Pracovisko.COM_Weidmuller.AB1_9_8DO.4;
	P1_Pracovisko.COM_Weidmuller.AB1_9_8DO.5;
	P1_Pracovisko.COM_Weidmuller.AB1_9_8DO.6;
	P1_Pracovisko.COM_Weidmuller.AB1_9_8DO.7 := P1_Srobovanie.SkrutSet_K30.OUT.VibracnyHrniec.ZapniVibromotor;
	
		
	//**********Karta AB 1.10 8DO***************//
	P1_Pracovisko.COM_Weidmuller.AB1_10_8DO.0;
	P1_Pracovisko.COM_Weidmuller.AB1_10_8DO.1;
	P1_Pracovisko.COM_Weidmuller.AB1_10_8DO.2;
	P1_Pracovisko.COM_Weidmuller.AB1_10_8DO.3;
	P1_Pracovisko.COM_Weidmuller.AB1_10_8DO.4;
	P1_Pracovisko.COM_Weidmuller.AB1_10_8DO.5;
	P1_Pracovisko.COM_Weidmuller.AB1_10_8DO.6;
	P1_Pracovisko.COM_Weidmuller.AB1_10_8DO.7;
	
	
	
	//**************************************************************IO modul Festo**********************************************************************************//
	
	//**********Modul DM 1.1 4DI4DO**************//
	//Inputs//
	P1_Pracovisko.IN.PredneDvere_PritomnostAdaptera := P1_Pracovisko.COM_Festo.DM1_1_4DI[0];
	P1_Pracovisko.IN.ZadneDvere_PritomnostAdaptera := P1_Pracovisko.COM_Festo.DM1_1_4DI[1];
	P1_Pracovisko.COM_Festo.DM1_1_4DI[2];
	P1_Pracovisko.COM_Festo.DM1_1_4DI[3];
		
	//Outputs//
	P1_Pracovisko.COM_Festo.DM1_1_4DO[0]:= P1_Pracovisko.OUT.PredneDvere_ZAMKNI ;
	P1_Pracovisko.COM_Festo.DM1_1_4DO[1]:= P1_Pracovisko.OUT.ZadneDvere_ZAMKNI;
	P1_Pracovisko.COM_Festo.DM1_1_4DO[2];
	P1_Pracovisko.COM_Festo.DM1_1_4DO[3];
	
	
	
	//***********Modul DI 1.1 8DI****************//
	P1_StoperSrobovania.IN.Centrovanie_VYSUNUTE := P1_Pracovisko.COM_Festo.DI1_1_8DI[0];
	P1_StoperSrobovania.IN.Centrovanie_ZASUNUTE := P1_Pracovisko.COM_Festo.DI1_1_8DI[1];
	P1_AkumulacnyStoper.IN.PritomnostPaletky := P1_Pracovisko.COM_Festo.DI1_1_8DI[2];
	P1_SpodnyStoper.IN.PritomnostPaletky := P1_Pracovisko.COM_Festo.DI1_1_8DI[3];
	P1_SpodnyStoper.IN.ZaplnenieDopravnika := P1_Pracovisko.COM_Festo.DI1_1_8DI[4];
	P1_Robot.IN.Vakum_OK := P1_Pracovisko.COM_Festo.DI1_1_8DI[5];
	P1_Robot.IN.DokStanica_PritomnGripra5H := P1_Pracovisko.COM_Festo.DI1_1_8DI[6];
	P1_Robot.IN.DokStanica_PritomnGripra45F := P1_Pracovisko.COM_Festo.DI1_1_8DI[7];
	
	
	
	
	//************Modul DI 1.2 8DI***************//
	P1_Srobovanie.SkrutSet_M4.IN.ZasobnikSkrutiekPrazdny := P1_Pracovisko.COM_Festo.DI1_2_8DI[0];
	P1_Srobovanie.SkrutSet_M4.IN.ZaplnenieListyZasobnika := P1_Pracovisko.COM_Festo.DI1_2_8DI[1];
	P1_Srobovanie.SkrutSet_M4.IN.ZaplnenieVibrolisty_MAX := P1_Pracovisko.COM_Festo.DI1_2_8DI[2];
	P1_Srobovanie.SkrutSet_M4.IN.ZaplnenieVibrolisty_MIN := P1_Pracovisko.COM_Festo.DI1_2_8DI[3];
	P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVstupe := P1_Pracovisko.COM_Festo.DI1_2_8DI[4];
	P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe := P1_Pracovisko.COM_Festo.DI1_2_8DI[5];
	P1_Srobovanie.SkrutSet_M4.IN.PodavacOtoceny_VSTUP := P1_Pracovisko.COM_Festo.DI1_2_8DI[6];
	P1_Srobovanie.SkrutSet_M4.IN.PodavacOtoceny_VYSTUP := P1_Pracovisko.COM_Festo.DI1_2_8DI[7];
	
	
	
	
	
	//************Modul DI 1.3 8DI**************//
	P1_Srobovanie.SkrutSet_K30.IN.VibracnyHrniec.PritomnostSkrutiekVHrnci := P1_Pracovisko.COM_Festo.DI1_3_8DI[0];
	P1_Srobovanie.SkrutSet_K30.IN.VibracnyHrniec.VibracnaListaZaplnena := P1_Pracovisko.COM_Festo.DI1_3_8DI[1];
	P1_Srobovanie.SkrutSet_K30.IN.Brzda.PreletSkrutky := P1_Pracovisko.COM_Festo.DI1_3_8DI[2];
	P1_Srobovanie.SkrutSet_K30.IN.Brzda.SkrutkaPritomnaVBrzde := P1_Pracovisko.COM_Festo.DI1_3_8DI[3];
	P1_Srobovanie.SkrutSet_K30.IN.Brzda.ZakladnaPoloha := P1_Pracovisko.COM_Festo.DI1_3_8DI[4];
	P1_Srobovanie.SkrutSet_K30.IN.Brzda.PodajSkrutku  := P1_Pracovisko.COM_Festo.DI1_3_8DI[5];
	P1_Srobovanie.SkrutSet_K30.IN.VibracnyHrniec.PreletovySnimac  := P1_Pracovisko.COM_Festo.DI1_3_8DI[6];
	P1_Srobovanie.IN.Skrutkovacka_K30_ZASUNUTA := P1_Pracovisko.COM_Festo.DI1_3_8DI[7];
	
	
	
	
	
	
	//*************Modul DI 1.4 8DI**************//
	P1_Srobovanie.SkrutSet_M5.IN.ZasobnikSkrutiekPrazdny := P1_Pracovisko.COM_Festo.DI1_4_8DI[0];
	P1_Srobovanie.SkrutSet_M5.IN.ZaplnenieListyZasobnika := P1_Pracovisko.COM_Festo.DI1_4_8DI[1];
	P1_Srobovanie.SkrutSet_M5.IN.ZaplnenieVibrolisty_MAX := P1_Pracovisko.COM_Festo.DI1_4_8DI[2];
	P1_Srobovanie.SkrutSet_M5.IN.ZaplnenieVibrolisty_MIN := P1_Pracovisko.COM_Festo.DI1_4_8DI[3];
	P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVstupe := P1_Pracovisko.COM_Festo.DI1_4_8DI[4];
	P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe := P1_Pracovisko.COM_Festo.DI1_4_8DI[5];
	P1_Srobovanie.SkrutSet_M5.IN.PodavacOtoceny_VSTUP := P1_Pracovisko.COM_Festo.DI1_4_8DI[6];
	P1_Srobovanie.SkrutSet_M5.IN.PodavacOtoceny_VYSTUP := P1_Pracovisko.COM_Festo.DI1_4_8DI[7];
	
	
	
	//**************Modul DI 1.5 8DI***************//
	P1_Vytah.IN.PrechodDopravnika := P1_Pracovisko.COM_Festo.DI1_5_8DI[0];
	P1_Pracovisko.IN.TlakVzduchu_OK := P1_Pracovisko.COM_Festo.DI1_5_8DI[1];
	Safety.IN.P1_SV_PrivodVzduchu_CH1 := P1_Pracovisko.COM_Festo.DI1_5_8DI[2];
	Safety.IN.P1_SV_PrivodVzduchu_CH2 := P1_Pracovisko.COM_Festo.DI1_5_8DI[3];
	P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK := P1_Pracovisko.COM_Festo.DI1_5_8DI[4];
	P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK := P1_Pracovisko.COM_Festo.DI1_5_8DI[5];
	P1_Pracovisko.COM_Festo.DI1_5_8DI[6];
	P1_Pracovisko.COM_Festo.DI1_5_8DI[7];
	
	
	
	
	
	//********Modul DS 1.1 IO link Port 0 - IO_Modul Balluff***************//
	//Inputs//
	P1_Robot.IN.Griper45F_Otvoreny:= P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[0].0;
	P1_Robot.IN.Griper45F_Zatvoreny:= P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[0].1;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[0].2;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[0].3;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[0].4;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[0].5;
	P1_Robot.IN.KodGripra_Bit0:= P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[0].6;
	P1_Robot.IN.KodGripra_Bit1:= P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[0].7;
	
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[1].0;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[1].1;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[1].2;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[1].3;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[1].4;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[1].5;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[1].6;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_IN[1].7;
	
	
	//Outputs//
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[0].0;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[0].1;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[0].2;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[0].3;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[0].4;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[0].5;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[0].6;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[0].7;
	
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[1].0;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[1].1;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[1].2;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[1].3;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[1].4;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[1].5;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[1].6;
	P1_Pracovisko.COM_Festo.DS1_1_Port0_OUT[1].7;
	
	
	
	
	
	//*************Modul DS 1.1 IO link Port 1 - Banner*********************//
	//Inputs//
	P1_Vytah.Banner.Mapping_IN[0]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[0];
	P1_Vytah.Banner.Mapping_IN[1]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[1];
	P1_Vytah.Banner.Mapping_IN[2]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[2];
	P1_Vytah.Banner.Mapping_IN[3]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[3];
	P1_Vytah.Banner.Mapping_IN[4]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[4];
	P1_Vytah.Banner.Mapping_IN[5]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[5];
	P1_Vytah.Banner.Mapping_IN[6]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[6];
	P1_Vytah.Banner.Mapping_IN[7]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[7];
	P1_Vytah.Banner.Mapping_IN[8]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[8];
	P1_Vytah.Banner.Mapping_IN[9]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[9];
	P1_Vytah.Banner.Mapping_IN[10]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[10];
	P1_Vytah.Banner.Mapping_IN[11]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[11];
	P1_Vytah.Banner.Mapping_IN[12]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[12];
	P1_Vytah.Banner.Mapping_IN[13]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[13];
	P1_Vytah.Banner.Mapping_IN[14]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[14];
	P1_Vytah.Banner.Mapping_IN[15]:= P1_Pracovisko.COM_Festo.DS1_1_Port1_IN[15];
	
	//Outputs//
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[0]:= P1_Vytah.Banner.Mapping_OUT[0];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[1]:= P1_Vytah.Banner.Mapping_OUT[1];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[2]:= P1_Vytah.Banner.Mapping_OUT[2];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[3]:= P1_Vytah.Banner.Mapping_OUT[3];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[4]:= P1_Vytah.Banner.Mapping_OUT[4];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[5]:= P1_Vytah.Banner.Mapping_OUT[5];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[6]:= P1_Vytah.Banner.Mapping_OUT[6];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[7]:= P1_Vytah.Banner.Mapping_OUT[7];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[8]:= P1_Vytah.Banner.Mapping_OUT[8];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[9]:= P1_Vytah.Banner.Mapping_OUT[9];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[10]:= P1_Vytah.Banner.Mapping_OUT[10];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[11]:= P1_Vytah.Banner.Mapping_OUT[11];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[12]:= P1_Vytah.Banner.Mapping_OUT[12];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[13]:= P1_Vytah.Banner.Mapping_OUT[13];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[14]:= P1_Vytah.Banner.Mapping_OUT[14];
	P1_Pracovisko.COM_Festo.DS1_1_Port1_OUT[15]:= P1_Vytah.Banner.Mapping_OUT[15];
	
	
	
	
	
	
	//********Modul DS 1.1 IO link Port 2 - RFID snÌmaË paletky v˝ùahu**************//
	//Inputs//
	P1_Vytah.RFID_hlava.Mapping_IN[0]:= P1_Pracovisko.COM_Festo.DS1_1_Port2_IN[0];
	P1_Vytah.RFID_hlava.Mapping_IN[1]:= P1_Pracovisko.COM_Festo.DS1_1_Port2_IN[1];
	P1_Vytah.RFID_hlava.Mapping_IN[2]:= P1_Pracovisko.COM_Festo.DS1_1_Port2_IN[2];
	P1_Vytah.RFID_hlava.Mapping_IN[3]:= P1_Pracovisko.COM_Festo.DS1_1_Port2_IN[3];
	P1_Vytah.RFID_hlava.Mapping_IN[4]:= P1_Pracovisko.COM_Festo.DS1_1_Port2_IN[4];
	P1_Vytah.RFID_hlava.Mapping_IN[5]:= P1_Pracovisko.COM_Festo.DS1_1_Port2_IN[5];
	P1_Vytah.RFID_hlava.Mapping_IN[6]:= P1_Pracovisko.COM_Festo.DS1_1_Port2_IN[6];
	P1_Vytah.RFID_hlava.Mapping_IN[7]:= P1_Pracovisko.COM_Festo.DS1_1_Port2_IN[7];
	
	//Outputs//
	P1_Pracovisko.COM_Festo.DS1_1_Port2_OUT[0]:= P1_Vytah.RFID_hlava.Mapping_OUT[0];
	P1_Pracovisko.COM_Festo.DS1_1_Port2_OUT[1]:= P1_Vytah.RFID_hlava.Mapping_OUT[1];
	P1_Pracovisko.COM_Festo.DS1_1_Port2_OUT[2]:= P1_Vytah.RFID_hlava.Mapping_OUT[2];
	P1_Pracovisko.COM_Festo.DS1_1_Port2_OUT[3]:= P1_Vytah.RFID_hlava.Mapping_OUT[3];
	P1_Pracovisko.COM_Festo.DS1_1_Port2_OUT[4]:= P1_Vytah.RFID_hlava.Mapping_OUT[4];
	P1_Pracovisko.COM_Festo.DS1_1_Port2_OUT[5]:= P1_Vytah.RFID_hlava.Mapping_OUT[5];
	P1_Pracovisko.COM_Festo.DS1_1_Port2_OUT[6]:= P1_Vytah.RFID_hlava.Mapping_OUT[6];
	P1_Pracovisko.COM_Festo.DS1_1_Port2_OUT[7]:= P1_Vytah.RFID_hlava.Mapping_OUT[7];
	
	
	
	
	
	
	
	//*******Modul DS 1.1 IO link Port 3 - RFID snÌmaË paletky stoper skrutkovania**********//
	//Inputs//
	P1_StoperSrobovania.RFID_hlava.Mapping_IN[0]:= P1_Pracovisko.COM_Festo.DS1_1_Port3_IN[0];
	P1_StoperSrobovania.RFID_hlava.Mapping_IN[1]:= P1_Pracovisko.COM_Festo.DS1_1_Port3_IN[1];
	P1_StoperSrobovania.RFID_hlava.Mapping_IN[2]:= P1_Pracovisko.COM_Festo.DS1_1_Port3_IN[2];
	P1_StoperSrobovania.RFID_hlava.Mapping_IN[3]:= P1_Pracovisko.COM_Festo.DS1_1_Port3_IN[3];
	P1_StoperSrobovania.RFID_hlava.Mapping_IN[4]:= P1_Pracovisko.COM_Festo.DS1_1_Port3_IN[4];
	P1_StoperSrobovania.RFID_hlava.Mapping_IN[5]:= P1_Pracovisko.COM_Festo.DS1_1_Port3_IN[5];
	P1_StoperSrobovania.RFID_hlava.Mapping_IN[6]:= P1_Pracovisko.COM_Festo.DS1_1_Port3_IN[6];
	P1_StoperSrobovania.RFID_hlava.Mapping_IN[7]:= P1_Pracovisko.COM_Festo.DS1_1_Port3_IN[7];
	
	
	//Outputs//
	P1_Pracovisko.COM_Festo.DS1_1_Port3_OUT[0]:= P1_StoperSrobovania.RFID_hlava.Mapping_OUT[0];
	P1_Pracovisko.COM_Festo.DS1_1_Port3_OUT[1]:= P1_StoperSrobovania.RFID_hlava.Mapping_OUT[1];
	P1_Pracovisko.COM_Festo.DS1_1_Port3_OUT[2]:= P1_StoperSrobovania.RFID_hlava.Mapping_OUT[2];
	P1_Pracovisko.COM_Festo.DS1_1_Port3_OUT[3]:= P1_StoperSrobovania.RFID_hlava.Mapping_OUT[3];
	P1_Pracovisko.COM_Festo.DS1_1_Port3_OUT[4]:= P1_StoperSrobovania.RFID_hlava.Mapping_OUT[4];
	P1_Pracovisko.COM_Festo.DS1_1_Port3_OUT[5]:= P1_StoperSrobovania.RFID_hlava.Mapping_OUT[5];
	P1_Pracovisko.COM_Festo.DS1_1_Port3_OUT[6]:= P1_StoperSrobovania.RFID_hlava.Mapping_OUT[6];
	P1_Pracovisko.COM_Festo.DS1_1_Port3_OUT[7]:= P1_StoperSrobovania.RFID_hlava.Mapping_OUT[7];
	
	
	//*********Modul DS 1.2 IO link Port 0 - SnÌmaË vysunutia skrutkovaËky K30****************//
	//Inputs//
	Convert_0.IN_Byte0:= P1_Pracovisko.COM_Festo.DS1_2_Port0_IN[0];
	Convert_0.IN_Byte1:= P1_Pracovisko.COM_Festo.DS1_2_Port0_IN[1];
	
	P1_Srobovanie.PAR.Skrutkov_K30_AktualHodnVysunutia:= Convert_0.OUT_UINT;
	Convert_0();
	
	
	
	
	
	
	
	//************************************Ventilov˝ termin·l*******************************************//
	
	//1-8
	P1_Pracovisko.COM_VentilovyTerminal[0].0 :=P1_Robot.OUT.Vakum_OFF;
	P1_Pracovisko.COM_VentilovyTerminal[0].1 :=P1_Robot.OUT.Vakum_ON;
	P1_Pracovisko.COM_VentilovyTerminal[0].2 :=P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON;
	P1_Pracovisko.COM_VentilovyTerminal[0].3 :=P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF;
	P1_Pracovisko.COM_VentilovyTerminal[0].4 :=P1_Srobovanie.OUT.Skrutkovacka_M5_Odvzdusn_ON;
	P1_Pracovisko.COM_VentilovyTerminal[0].5 :=P1_Srobovanie.OUT.Skrutkovacka_M4_Odvzdusn_ON;
	P1_Pracovisko.COM_VentilovyTerminal[0].6 :=P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON;
	P1_Pracovisko.COM_VentilovyTerminal[0].7 :=P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF;
	
	//9-16
	P1_Pracovisko.COM_VentilovyTerminal[1].0 :=P1_StoperSrobovania.OUT.ZasunStoper;
	P1_Pracovisko.COM_VentilovyTerminal[1].1 :=P1_AkumulacnyStoper.OUT.ZasunStoper;
	P1_Pracovisko.COM_VentilovyTerminal[1].2 :=P1_SpodnyStoper.OUT.ZasunStoper;
	P1_Pracovisko.COM_VentilovyTerminal[1].3;
	P1_Pracovisko.COM_VentilovyTerminal[1].4 :=P1_Srobovanie.SkrutSet_M4.OUT.ZhadzovaciVzduch_RUN;
	P1_Pracovisko.COM_VentilovyTerminal[1].5 :=P1_Srobovanie.SkrutSet_M4.OUT.TriediaciVzduch_RUN;
	P1_Pracovisko.COM_VentilovyTerminal[1].6 :=P1_Srobovanie.SkrutSet_M4.OUT.OtocPodavac_NaVstup;
	P1_Pracovisko.COM_VentilovyTerminal[1].7 :=P1_Srobovanie.SkrutSet_M4.OUT.OtocPodavac_NaVystup;
	
	//17-24
	P1_Pracovisko.COM_VentilovyTerminal[2].0 :=P1_Srobovanie.SkrutSet_K30.OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek;
	P1_Pracovisko.COM_VentilovyTerminal[2].1 :=P1_Srobovanie.SkrutSet_K30.OUT.VibracnyHrniec.TiedenieSkrutiek;
	P1_Pracovisko.COM_VentilovyTerminal[2].2 :=P1_Srobovanie.SkrutSet_K30.OUT.VibracnyHrniec.OddelovacVysunut;
	P1_Pracovisko.COM_VentilovyTerminal[2].3 ;
	P1_Pracovisko.COM_VentilovyTerminal[2].4 :=P1_Srobovanie.SkrutSet_K30.OUT.VibracnyHrniec.VzduchNastreleniaSkrutky;
	P1_Pracovisko.COM_VentilovyTerminal[2].5;
	P1_Pracovisko.COM_VentilovyTerminal[2].6 :=P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON;
	P1_Pracovisko.COM_VentilovyTerminal[2].7 :=P1_Srobovanie.OUT.Skrutkovacka_K30_Odvzdusn_ON;
	
	//25-32
	P1_Pracovisko.COM_VentilovyTerminal[3].0:=P1_Srobovanie.SkrutSet_K30.OUT.Brzda.PodajSkrutku;
	P1_Pracovisko.COM_VentilovyTerminal[3].1:=P1_Srobovanie.SkrutSet_K30.OUT.Brzda.ZakladnaPoloha;
	P1_Pracovisko.COM_VentilovyTerminal[3].2:=P1_Srobovanie.SkrutSet_K30.OUT.Brzda.OdsavanieNecistot;
	P1_Pracovisko.COM_VentilovyTerminal[3].3:=P1_Srobovanie.SkrutSet_K30.OUT.Brzda.NastrelenieSkrutky;
	P1_Pracovisko.COM_VentilovyTerminal[3].4:=P1_Srobovanie.SkrutSet_M5.OUT.ZhadzovaciVzduch_RUN;
	P1_Pracovisko.COM_VentilovyTerminal[3].5:=P1_Srobovanie.SkrutSet_M5.OUT.TriediaciVzduch_RUN;
	P1_Pracovisko.COM_VentilovyTerminal[3].6:=P1_Srobovanie.SkrutSet_M5.OUT.OtocPodavac_NaVstup;
	P1_Pracovisko.COM_VentilovyTerminal[3].7:=P1_Srobovanie.SkrutSet_M5.OUT.OtocPodavac_NaVystup;
	
	//33-40
	P1_Pracovisko.COM_VentilovyTerminal[4].0 :=P1_Robot.OUT.OdistiGriper;
	P1_Pracovisko.COM_VentilovyTerminal[4].1 :=P1_Robot.OUT.ZaistiGriper;
	P1_Pracovisko.COM_VentilovyTerminal[4].2 :=P1_Robot.OUT.Griper_OTVOR;
	P1_Pracovisko.COM_VentilovyTerminal[4].3 :=P1_Robot.OUT.Griper_ZATVOR;
	P1_Pracovisko.COM_VentilovyTerminal[4].4;
	P1_Pracovisko.COM_VentilovyTerminal[4].5;
	P1_Pracovisko.COM_VentilovyTerminal[4].6;
	P1_Pracovisko.COM_VentilovyTerminal[4].7;
	
	//41-48
	P1_Pracovisko.COM_VentilovyTerminal[5].0:=P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN;
	P1_Pracovisko.COM_VentilovyTerminal[5].1;
	P1_Pracovisko.COM_VentilovyTerminal[5].2:=P1_StoperSrobovania.OUT.Centrovanie_VYSUN;
	P1_Pracovisko.COM_VentilovyTerminal[5].3:=P1_StoperSrobovania.OUT.Centrovanie_ZASUN;
	P1_Pracovisko.COM_VentilovyTerminal[5].4;
	P1_Pracovisko.COM_VentilovyTerminal[5].5;
	P1_Pracovisko.COM_VentilovyTerminal[5].6;
	P1_Pracovisko.COM_VentilovyTerminal[5].7;
	
	
	
	
	
	//Volanie kniûnic//
	P1_Srobovanie.SkrutSet_K30();
	P1_Srobovanie.SkrutSet_M4(); 
	P1_Srobovanie.SkrutSet_M5();
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

