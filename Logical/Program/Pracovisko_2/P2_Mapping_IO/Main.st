
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//**********************************************************IO modul Wedmuller**********************************************************************//
	//************Karta AB 2.5 8DI**************//
	P2_Pracovisko.COM_Weidmuller.AB2_5_8DI.0;
	P2_Srobovanie.IN.NapajanieSkrutkovackyM6_OK := P2_Pracovisko.COM_Weidmuller.AB2_5_8DI.1;
	P2_Srobovanie.IN.NapajanieSkrutkovackyM4_OK := P2_Pracovisko.COM_Weidmuller.AB2_5_8DI.2;
	P2_Srobovanie.IN.NapajanieSkrutkovackyM5_OK := P2_Pracovisko.COM_Weidmuller.AB2_5_8DI.3;
	P2_Srobovanie.IN.NapajanieVibrolistyM4_OK := P2_Pracovisko.COM_Weidmuller.AB2_5_8DI.4;
	P2_Srobovanie.IN.NapajanieZasobnikaM6_OK := P2_Pracovisko.COM_Weidmuller.AB2_5_8DI.5;
	P2_Srobovanie.IN.NapajanieZasobnikaM4_OK := P2_Pracovisko.COM_Weidmuller.AB2_5_8DI.6;
	P2_Srobovanie.IN.NapajanieVibrolistyM4_OK := P2_Pracovisko.COM_Weidmuller.AB2_5_8DI.7;
	
	
	
	//************Karta AB 2.6 8DI**************//
	P2_Srobovanie.IN.NapajanieZasobnikaM5_OK := P2_Pracovisko.COM_Weidmuller.AB2_6_8DI.0;
	P2_Zvaranie.IN.NapajanieZvaracky_OK := P2_Pracovisko.COM_Weidmuller.AB2_6_8DI.1;
	P2_Dopravniky.IN.StavRiadeniaDopravBunky_READY := P2_Pracovisko.COM_Weidmuller.AB2_6_8DI.2;
	P2_Dopravniky.IN.StavRiadeniaVratnehoDoprav_READY := P2_Pracovisko.COM_Weidmuller.AB2_6_8DI.3;
	P2_Cistenie.IN.Ionizator_Alarm1 := P2_Pracovisko.COM_Weidmuller.AB2_6_8DI.4;
	P2_Cistenie.IN.Ionizator_Alarm2 := P2_Pracovisko.COM_Weidmuller.AB2_6_8DI.5;
	P2_Cistenie.IN.Ionizator_Alarm3 := P2_Pracovisko.COM_Weidmuller.AB2_6_8DI.6;
	P2_Zvaranie.IN.ZvarackaStav_RUN := P2_Pracovisko.COM_Weidmuller.AB2_6_8DI.7;
	
	
	
	//************Karta AB 2.7 8DI**************//
	P2_Pracovisko.COM_Weidmuller.AB2_7_8DI.0;
	P2_Pracovisko.COM_Weidmuller.AB2_7_8DI.1;
	Safety.IN.Linka_SV_ZonaCS := P2_Pracovisko.COM_Weidmuller.AB2_7_8DI.2;
	Safety.IN.P2_SV_ZonaAutostopRobota := P2_Pracovisko.COM_Weidmuller.AB2_7_8DI.3;
	Safety.IN.P2_SV_ZonaBunky := P2_Pracovisko.COM_Weidmuller.AB2_7_8DI.4;
	Safety.IN.P2_SV_ZonaZakladacaTesnenia := P2_Pracovisko.COM_Weidmuller.AB2_7_8DI.5;
	P2_Pracovisko.COM_Weidmuller.AB2_7_8DI.6;
	Safety.IN.P2_SV_ZonaMaticovacky := P2_Pracovisko.COM_Weidmuller.AB2_7_8DI.7;
	
	
	
	//************Karta AB 2.8 8DI**************//
	P2_Dopravniky.IN.TeplotaMotoraDopravBunky_OK := P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.0;
	P2_Dopravniky.IN.TeplotaMotoraVratnehoDoprav_OK := P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.1;
	P2_Zvaranie.IN.ZvarackaStav_READY := P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.2;
	P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.3;
	P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.4;
	P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.5;
	P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.6;
	P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.7;
	
	
	
	
	//************Karta AB 2.9 8DO***************//
	P2_Pracovisko.COM_Weidmuller.AB2_9_8DO.0 := P2_Pracovisko.OUT.Majak_ZeleneSvetlo_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_9_8DO.1 := P2_Pracovisko.OUT.Majak_OranzoveSvetlo_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_9_8DO.2 := P2_Pracovisko.OUT.Majak_CerveneSvetlo_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_9_8DO.3 := P2_Pracovisko.OUT.Majak_Hukacka_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_9_8DO.4 := P2_StoperMaticovacky.SkrutSet_MaticaM4.OUT.VibropohonZasobnika_RUN;
	P2_Pracovisko.COM_Weidmuller.AB2_9_8DO.5 := P2_Srobovanie.SkrutSet_M6.OUT.VibracnyHrniec.ZapniVibromotor;
	P2_Pracovisko.COM_Weidmuller.AB2_9_8DO.6 := P2_Srobovanie.SkrutSet_M4.OUT.VibropohonZasobnika_RUN;
	P2_Pracovisko.COM_Weidmuller.AB2_9_8DO.7 := P2_Srobovanie.SkrutSet_M4.OUT.VibropohonListy_RUN;
	
	
	
	//************Karta AB 2.10 8DO***************//
	P2_Pracovisko.COM_Weidmuller.AB2_10_8DO.0 := P2_Cistenie.OUT.Ionizator_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_10_8DO.1 := P2_Zvaranie.OUT.Zvaracka_START;
	P2_Pracovisko.COM_Weidmuller.AB2_10_8DO.2 := P2_Zvaranie.OUT.Zvaracka_RESET;
	P2_Pracovisko.COM_Weidmuller.AB2_10_8DO.3 := P2_Dopravniky.OUT.DopravnikBunky_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_10_8DO.4 := P2_Dopravniky.OUT.VratnyDopravnik_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_10_8DO.5 := P2_ZakladacTesnenia.OUT.LED_DvojrucneOvladanie_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_10_8DO.6 := P2_Pracovisko.OUT.Osvetlenie_CAM1;
	P2_Pracovisko.COM_Weidmuller.AB2_10_8DO.7 := P2_Pracovisko.OUT.Osvetlenie_CAM7_CAM17;
	
	
	
	//************Karta AB 2.12 8DO***************//
	P2_Pracovisko.COM_Weidmuller.AB2_12_8DO.0 := P2_Pracovisko.OUT.OsvetlenieBunky_ON;
	P2_Pracovisko.COM_Weidmuller.AB2_12_8DO.1;
	P2_Pracovisko.COM_Weidmuller.AB2_12_8DO.2;
	P2_Pracovisko.COM_Weidmuller.AB2_12_8DO.3;
	P2_Pracovisko.COM_Weidmuller.AB2_12_8DO.4;
	P2_Pracovisko.COM_Weidmuller.AB2_12_8DO.5;
	P2_Pracovisko.COM_Weidmuller.AB2_12_8DO.6;
	P2_Pracovisko.COM_Weidmuller.AB2_12_8DO.7 := P2_Srobovanie.SkrutSet_M5.OUT.VibracnyHrniec.ZapniVibromotor;
	
	//************Karta AB 2.13 8DO***************//
	P2_Pracovisko.COM_Weidmuller.AB2_13_8DO.0;
	P2_Pracovisko.COM_Weidmuller.AB2_13_8DO.1;
	P2_Pracovisko.COM_Weidmuller.AB2_13_8DO.2;
	P2_Pracovisko.COM_Weidmuller.AB2_13_8DO.3;
	P2_Pracovisko.COM_Weidmuller.AB2_13_8DO.4;
	P2_Pracovisko.COM_Weidmuller.AB2_13_8DO.5;
	P2_Pracovisko.COM_Weidmuller.AB2_13_8DO.6;
	P2_Pracovisko.COM_Weidmuller.AB2_13_8DO.7;
	
	
	//**************************************************************IO modul Festo**********************************************************************************//
	
	//**********Modul DM 2.1 4DI4DO**************//
	//Inputs//
	P2_Pracovisko.IN.PredneDvereLS_PritomnostAdaptera := P2_Pracovisko.COM_Festo.DM2_1_4DI[0];
	P2_Pracovisko.IN.PredneDverePS_PritomnostAdaptera := P2_Pracovisko.COM_Festo.DM2_1_4DI[1];
	P2_Pracovisko.IN.ZadneDverePS_PritomnostAdaptera :=  P2_Pracovisko.COM_Festo.DM2_1_4DI[2];
	P2_Pracovisko.IN.ZadneDvereLS_PritomnostAdaptera :=  P2_Pracovisko.COM_Festo.DM2_1_4DI[3];
	
	
	//Outputs//
	P2_Pracovisko.OUT.PredneDvereLS_ZAMKNI := P2_Pracovisko.COM_Festo.DM2_1_4DO[0];
	P2_Pracovisko.OUT.PredneDverePS_ZAMKNI := P2_Pracovisko.COM_Festo.DM2_1_4DO[1];
	P2_Pracovisko.OUT.ZadneDverePS_ZAMKNI := P2_Pracovisko.COM_Festo.DM2_1_4DO[2];
	P2_Pracovisko.OUT.ZadneDvereLS_ZAMKNI := P2_Pracovisko.COM_Festo.DM2_1_4DO[3];
	
	
	
	
	//**********Modul DI 2.1 8DI**************//
	P2_Pracovisko.IN.TlakVzduchu_OK := P2_Pracovisko.COM_Festo.DI2_1_8DI[0];
	Safety.IN.P2_SV_PrivodVzduchu_CH1 := P2_Pracovisko.COM_Festo.DI2_1_8DI[1];
	Safety.IN.P2_SV_PrivodVzduchu_CH2 := P2_Pracovisko.COM_Festo.DI2_1_8DI[2];
	P2_ZakladacTesnenia.IN.Pojazd_PritomPowerCP := P2_Pracovisko.COM_Festo.DI2_1_8DI[3];
	P2_ZakladacTesnenia.IN.Kopito_ZakladPoloha := P2_Pracovisko.COM_Festo.DI2_1_8DI[4];
	P2_SpodnyStoper.IN.ZaplnenieDopravnika := P2_Pracovisko.COM_Festo.DI2_1_8DI[5];
	P2_Pracovisko.COM_Festo.DI2_1_8DI[6];
	P2_Pracovisko.COM_Festo.DI2_1_8DI[7];
	
	//**********Modul DI 2.2 8DI**************//
	P2_Zvaranie.IN.ZvaraniePresunute_VPRAVO := P2_Pracovisko.COM_Festo.DI2_2_8DI[0];
	P2_Zvaranie.IN.ZvaraniePresunute_VLAVO := P2_Pracovisko.COM_Festo.DI2_2_8DI[1];
	P2_Pracovisko.COM_Festo.DI2_2_8DI[2];
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.OddelovacOtoceny_VYSTUP := P2_Pracovisko.COM_Festo.DI2_2_8DI[3];
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.OddelovacOtoceny_VSTUP := P2_Pracovisko.COM_Festo.DI2_2_8DI[4];
	P2_Srobovanie.SkrutSet_M4.IN.PodavacOtoceny_VSTUP := P2_Pracovisko.COM_Festo.DI2_2_8DI[5];
	P2_Srobovanie.SkrutSet_M4.IN.PodavacOtoceny_VYSTUP := P2_Pracovisko.COM_Festo.DI2_2_8DI[6];
	P2_Pracovisko.COM_Festo.DI2_2_8DI[7];
	
	
	
	//**********Modul DI 2.3 8DI**************//
	P2_Cistenie.IN.Dvere_OTVORENE := P2_Pracovisko.COM_Festo.DI2_3_8DI[0];
	P2_Cistenie.IN.Dvere_ZATVORENE := P2_Pracovisko.COM_Festo.DI2_3_8DI[1];
	P2_Cistenie.IN.Vakum_OK := P2_Pracovisko.COM_Festo.DI2_3_8DI[2];
	P2_Robot.IN.DokStanica_PritomGripraMvCase := P2_Pracovisko.COM_Festo.DI2_3_8DI[3];
	P2_Robot.IN.DokStanica_PritomGripraBusbar45F := P2_Pracovisko.COM_Festo.DI2_3_8DI[4];
	P2_Robot.IN.DokStanica_PritomGripraBusbar5H := P2_Pracovisko.COM_Festo.DI2_3_8DI[5];
	P2_Robot.IN.Model45F_Vakum_OK := P2_Pracovisko.COM_Festo.DI2_3_8DI[6];
	P2_Robot.IN.Model5H_Vakum_OK := P2_Pracovisko.COM_Festo.DI2_3_8DI[7];
	
	
	
	
	//**********Modul DI 2.4 8DI**************//
	P2_StoperMaticovacky.IN.Centrovanie_ZASUNUTE := P2_Pracovisko.COM_Festo.DI2_4_8DI[0];
	P2_StoperMaticovacky.IN.Centrovanie_VYSUNUTE := P2_Pracovisko.COM_Festo.DI2_4_8DI[1];
	P2_StoperSrobovania.IN.Centrovanie_VYSUNUTE := P2_Pracovisko.COM_Festo.DI2_4_8DI[2];
	P2_AkumulacnyStoper.IN.PritomnostPaletky := P2_Pracovisko.COM_Festo.DI2_4_8DI[3];
	P2_StoperZvarania.IN.Centrovanie_VYSUNUTE := P2_Pracovisko.COM_Festo.DI2_4_8DI[4];
	P2_StoperSrobovania.IN.Centrovanie_ZASUNUTE := P2_Pracovisko.COM_Festo.DI2_4_8DI[5];
	P2_SpodnyStoper.IN.PritomnostPaletky := P2_Pracovisko.COM_Festo.DI2_4_8DI[6];
	P2_StoperZvarania.IN.Centrovanie_ZASUNUTE := P2_Pracovisko.COM_Festo.DI2_4_8DI[7];
	
	
	
	
	//**********Modul DI 2.5 8DI**************//
	P2_Srobovanie.SkrutSet_M5.IN.VibracnyHrniec.PritomnostSkrutiekVHrnci := P2_Pracovisko.COM_Festo.DI2_5_8DI[0];
	P2_Srobovanie.SkrutSet_M5.IN.VibracnyHrniec.VibracnaListaZaplnena := P2_Pracovisko.COM_Festo.DI2_5_8DI[1];
	P2_Srobovanie.SkrutSet_M5.IN.Brzda.PreletSkrutky := P2_Pracovisko.COM_Festo.DI2_5_8DI[2];
	P2_Srobovanie.SkrutSet_M5.IN.Brzda.PodajSkrutku := P2_Pracovisko.COM_Festo.DI2_5_8DI[3];
	P2_Srobovanie.SkrutSet_M5.IN.Brzda.ZakladnaPoloha := P2_Pracovisko.COM_Festo.DI2_5_8DI[4];
	P2_Srobovanie.SkrutSet_M5.IN.Brzda.SkrutkaPritomnaVBrzde := P2_Pracovisko.COM_Festo.DI2_5_8DI[5];
	P2_Srobovanie.SkrutSet_M5.IN.VibracnyHrniec.PreletovySnimac := P2_Pracovisko.COM_Festo.DI2_5_8DI[6];
	P2_Srobovanie.IN.Skrutkovacka_M5_ZASUNUTA := P2_Pracovisko.COM_Festo.DI2_5_8DI[7];
	
	
	
	
	//**********Modul DI 2.6 8DI**************//
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.ZasobnikMaticPrazdny := P2_Pracovisko.COM_Festo.DI2_6_8DI[0];
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.ZaplnenieListyZasobnika := P2_Pracovisko.COM_Festo.DI2_6_8DI[1];
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.Oddelovac_SnimPrechoduMatice := P2_Pracovisko.COM_Festo.DI2_6_8DI[2];
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.PritomnostMaticeNaVystupe :=  P2_Pracovisko.COM_Festo.DI2_6_8DI[3];
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.PodavacMatice_ZASUNUTY :=  P2_Pracovisko.COM_Festo.DI2_6_8DI[4];
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.PodavacMatice_VYSUNUTY := P2_Pracovisko.COM_Festo.DI2_6_8DI[5];
	P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.Podavac_SnimPrechoduMatice := P2_Pracovisko.COM_Festo.DI2_6_8DI[6];
	P2_StoperMaticovacky.IN.Maticovacka_M4_ZASUNUTA := P2_Pracovisko.COM_Festo.DI2_6_8DI[7];
	
	
	
	
	//**********Modul DI 2.7 8DI**************//
	P2_Srobovanie.SkrutSet_M4.IN.ZasobnikSkrutiekPrazdny := P2_Pracovisko.COM_Festo.DI2_7_8DI[0];
	P2_Srobovanie.SkrutSet_M4.IN.ZaplnenieListyZasobnika := P2_Pracovisko.COM_Festo.DI2_7_8DI[1];
	P2_Srobovanie.SkrutSet_M4.IN.ZaplnenieVibrolisty_MAX := P2_Pracovisko.COM_Festo.DI2_7_8DI[2];
	P2_Srobovanie.SkrutSet_M4.IN.ZaplnenieVibrolisty_MIN := P2_Pracovisko.COM_Festo.DI2_7_8DI[3];
	P2_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVstupe := P2_Pracovisko.COM_Festo.DI2_7_8DI[4];
	P2_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe := P2_Pracovisko.COM_Festo.DI2_7_8DI[5];
	P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK := P2_Pracovisko.COM_Festo.DI2_7_8DI[6];
	P2_Pracovisko.COM_Festo.DI2_7_8DI[7];
	
	//**********Modul DI 2.8 8DI**************//
	P2_Srobovanie.SkrutSet_M6.IN.VibracnyHrniec.PritomnostSkrutiekVHrnci := P2_Pracovisko.COM_Festo.DI2_8_8DI[0];
	P2_Srobovanie.SkrutSet_M6.IN.VibracnyHrniec.VibracnaListaZaplnena := P2_Pracovisko.COM_Festo.DI2_8_8DI[1];
	P2_Srobovanie.SkrutSet_M6.IN.Brzda.PreletSkrutky := P2_Pracovisko.COM_Festo.DI2_8_8DI[2];
	P2_Srobovanie.SkrutSet_M6.IN.Brzda.PodajSkrutku := P2_Pracovisko.COM_Festo.DI2_8_8DI[3];
	P2_Srobovanie.SkrutSet_M6.IN.Brzda.ZakladnaPoloha := P2_Pracovisko.COM_Festo.DI2_8_8DI[4];
	P2_Srobovanie.SkrutSet_M6.IN.Brzda.SkrutkaPritomnaVBrzde := P2_Pracovisko.COM_Festo.DI2_8_8DI[5];
	P2_Srobovanie.SkrutSet_M6.IN.VibracnyHrniec.PreletovySnimac := P2_Pracovisko.COM_Festo.DI2_8_8DI[6];
	P2_Srobovanie.IN.Skrutkovacka_M6_ZASUNUTA := P2_Pracovisko.COM_Festo.DI2_8_8DI[7];
	
	
	//********Modul DS 2.1 IO link Port 0 - IO_Modul Balluff***************//
	//Inputs//
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[0].0;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[0].1;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[0].2;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[0].3;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[0].4;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[0].5;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[0].6;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[0].7;
	
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[1].0;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[1].1;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[1].2;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[1].3;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[1].4;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[1].5;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[1].6;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_IN[1].7;
	
	
	
	//Outputs//
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[0].0;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[0].1;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[0].2;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[0].3;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[0].4;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[0].5;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[0].6;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[0].7;
	
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[1].0;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[1].1;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[1].2;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[1].3;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[1].4;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[1].5;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[1].6;
	P2_Pracovisko.COM_Festo.DS2_1_Port0_OUT[1].7;
	
	
	
	//*************Modul DS 2.1 IO link Port 1 - Snímaè vysunutia skrutkovaèky M5*********************//
	//Inputs//
	Convert_0.IN_Byte0:= P2_Pracovisko.COM_Festo.DS2_1_Port1_IN[0];
	Convert_0.IN_Byte1:= P2_Pracovisko.COM_Festo.DS2_1_Port1_IN[1];
	
	P2_Srobovanie.PAR.Skrutkov_M5_AktualHodnVysunutia:= Convert_0.OUT_UINT;
	Convert_0();
	
	
	
	//*************Modul DS 2.1 IO link Port 2 - Snímaè vysunutia skrutkovaèky M6*********************//
	//Inputs//
	Convert_1.IN_Byte0:= P2_Pracovisko.COM_Festo.DS2_1_Port2_IN[0];
	Convert_1.IN_Byte1:= P2_Pracovisko.COM_Festo.DS2_1_Port2_IN[1];
	
	P2_Srobovanie.PAR.Skrutkov_M6_AktualHodnVysunutia:= Convert_1.OUT_UINT;
	Convert_1();
	
	
	//*************Modul DS 2.1 IO link Port 3 - Snímaè otvorenia zatvorenia gripra robota*********************//
	//Inputs//
	Convert_2.IN_Byte0:= P2_Pracovisko.COM_Festo.DS2_1_Port3_IN[0];
	Convert_2.IN_Byte1:= P2_Pracovisko.COM_Festo.DS2_1_Port3_IN[1];
	
	
	IF NOT P2_Robot.IN.KodGripra_Bit0 AND P2_Robot.IN.KodGripra_Bit1 THEN
		P2_Robot.PAR.Griper_Busbary5H_HodnOtvorenia:= 0;
		P2_Robot.PAR.Griper_Busbary45F_HodnOtvorenia:= Convert_2.OUT_UINT;
	ELSIF P2_Robot.IN.KodGripra_Bit0 AND P2_Robot.IN.KodGripra_Bit1 THEN
		P2_Robot.PAR.Griper_Busbary45F_HodnOtvorenia:= 0;
		P2_Robot.PAR.Griper_Busbary5H_HodnOtvorenia:= Convert_2.OUT_UINT;
	ELSE
		P2_Robot.PAR.Griper_Busbary5H_HodnOtvorenia:= 0;
		P2_Robot.PAR.Griper_Busbary45F_HodnOtvorenia:= 0;
	END_IF	
	
	Convert_2();
	
	
	
	//********Modul DS 2.2 IO link Port 0 - RFID snímaè paletky zakladaè tesnenia**************//
	//Inputs//
	P2_StoperZaklTesnenia.RFID_hlava.Mapping_IN[0]:= P2_Pracovisko.COM_Festo.DS2_2_Port0_IN[0];
	P2_StoperZaklTesnenia.RFID_hlava.Mapping_IN[1]:= P2_Pracovisko.COM_Festo.DS2_2_Port0_IN[1];
	P2_StoperZaklTesnenia.RFID_hlava.Mapping_IN[2]:= P2_Pracovisko.COM_Festo.DS2_2_Port0_IN[2];
	P2_StoperZaklTesnenia.RFID_hlava.Mapping_IN[3]:= P2_Pracovisko.COM_Festo.DS2_2_Port0_IN[3];
	P2_StoperZaklTesnenia.RFID_hlava.Mapping_IN[4]:= P2_Pracovisko.COM_Festo.DS2_2_Port0_IN[4];
	P2_StoperZaklTesnenia.RFID_hlava.Mapping_IN[5]:= P2_Pracovisko.COM_Festo.DS2_2_Port0_IN[5];
	P2_StoperZaklTesnenia.RFID_hlava.Mapping_IN[6]:= P2_Pracovisko.COM_Festo.DS2_2_Port0_IN[6];
	P2_StoperZaklTesnenia.RFID_hlava.Mapping_IN[7]:= P2_Pracovisko.COM_Festo.DS2_2_Port0_IN[7];
	
	//Outputs//
	P2_Pracovisko.COM_Festo.DS2_2_Port0_OUT[0]:= P2_StoperZaklTesnenia.RFID_hlava.Mapping_OUT[0];
	P2_Pracovisko.COM_Festo.DS2_2_Port0_OUT[1]:= P2_StoperZaklTesnenia.RFID_hlava.Mapping_OUT[1];
	P2_Pracovisko.COM_Festo.DS2_2_Port0_OUT[2]:= P2_StoperZaklTesnenia.RFID_hlava.Mapping_OUT[2];
	P2_Pracovisko.COM_Festo.DS2_2_Port0_OUT[3]:= P2_StoperZaklTesnenia.RFID_hlava.Mapping_OUT[3];
	P2_Pracovisko.COM_Festo.DS2_2_Port0_OUT[4]:= P2_StoperZaklTesnenia.RFID_hlava.Mapping_OUT[4];
	P2_Pracovisko.COM_Festo.DS2_2_Port0_OUT[5]:= P2_StoperZaklTesnenia.RFID_hlava.Mapping_OUT[5];
	P2_Pracovisko.COM_Festo.DS2_2_Port0_OUT[6]:= P2_StoperZaklTesnenia.RFID_hlava.Mapping_OUT[6];
	P2_Pracovisko.COM_Festo.DS2_2_Port0_OUT[7]:= P2_StoperZaklTesnenia.RFID_hlava.Mapping_OUT[7];
	
	
	//********Modul DS 2.2 IO link Port 1 - RFID snímaè paletky maticovaèka**************//
	//Inputs//
	P2_StoperMaticovacky.RFID_hlava.Mapping_IN[0]:= P2_Pracovisko.COM_Festo.DS2_2_Port1_IN[0];
	P2_StoperMaticovacky.RFID_hlava.Mapping_IN[1]:= P2_Pracovisko.COM_Festo.DS2_2_Port1_IN[1];
	P2_StoperMaticovacky.RFID_hlava.Mapping_IN[2]:= P2_Pracovisko.COM_Festo.DS2_2_Port1_IN[2];
	P2_StoperMaticovacky.RFID_hlava.Mapping_IN[3]:= P2_Pracovisko.COM_Festo.DS2_2_Port1_IN[3];
	P2_StoperMaticovacky.RFID_hlava.Mapping_IN[4]:= P2_Pracovisko.COM_Festo.DS2_2_Port1_IN[4];
	P2_StoperMaticovacky.RFID_hlava.Mapping_IN[5]:= P2_Pracovisko.COM_Festo.DS2_2_Port1_IN[5];
	P2_StoperMaticovacky.RFID_hlava.Mapping_IN[6]:= P2_Pracovisko.COM_Festo.DS2_2_Port1_IN[6];
	P2_StoperMaticovacky.RFID_hlava.Mapping_IN[7]:= P2_Pracovisko.COM_Festo.DS2_2_Port1_IN[7];
	
	//Outputs//
	P2_Pracovisko.COM_Festo.DS2_2_Port1_OUT[0]:= P2_StoperMaticovacky.RFID_hlava.Mapping_OUT[0];
	P2_Pracovisko.COM_Festo.DS2_2_Port1_OUT[1]:= P2_StoperMaticovacky.RFID_hlava.Mapping_OUT[1];
	P2_Pracovisko.COM_Festo.DS2_2_Port1_OUT[2]:= P2_StoperMaticovacky.RFID_hlava.Mapping_OUT[2];
	P2_Pracovisko.COM_Festo.DS2_2_Port1_OUT[3]:= P2_StoperMaticovacky.RFID_hlava.Mapping_OUT[3];
	P2_Pracovisko.COM_Festo.DS2_2_Port1_OUT[4]:= P2_StoperMaticovacky.RFID_hlava.Mapping_OUT[4];
	P2_Pracovisko.COM_Festo.DS2_2_Port1_OUT[5]:= P2_StoperMaticovacky.RFID_hlava.Mapping_OUT[5];
	P2_Pracovisko.COM_Festo.DS2_2_Port1_OUT[6]:= P2_StoperMaticovacky.RFID_hlava.Mapping_OUT[6];
	P2_Pracovisko.COM_Festo.DS2_2_Port1_OUT[7]:= P2_StoperMaticovacky.RFID_hlava.Mapping_OUT[7];
	
	

	//********Modul DS 2.2 IO link Port 2 - RFID snímaè paletky šrobovanie**************//
	//Inputs//
	P2_StoperSrobovania.RFID_hlava.Mapping_IN[0]:= P2_Pracovisko.COM_Festo.DS2_2_Port2_IN[0];
	P2_StoperSrobovania.RFID_hlava.Mapping_IN[1]:= P2_Pracovisko.COM_Festo.DS2_2_Port2_IN[1];
	P2_StoperSrobovania.RFID_hlava.Mapping_IN[2]:= P2_Pracovisko.COM_Festo.DS2_2_Port2_IN[2];
	P2_StoperSrobovania.RFID_hlava.Mapping_IN[3]:= P2_Pracovisko.COM_Festo.DS2_2_Port2_IN[3];
	P2_StoperSrobovania.RFID_hlava.Mapping_IN[4]:= P2_Pracovisko.COM_Festo.DS2_2_Port2_IN[4];
	P2_StoperSrobovania.RFID_hlava.Mapping_IN[5]:= P2_Pracovisko.COM_Festo.DS2_2_Port2_IN[5];
	P2_StoperSrobovania.RFID_hlava.Mapping_IN[6]:= P2_Pracovisko.COM_Festo.DS2_2_Port2_IN[6];
	P2_StoperSrobovania.RFID_hlava.Mapping_IN[7]:= P2_Pracovisko.COM_Festo.DS2_2_Port2_IN[7];
	
	//Outputs//
	P2_Pracovisko.COM_Festo.DS2_2_Port2_OUT[0]:= P2_StoperSrobovania.RFID_hlava.Mapping_OUT[0];
	P2_Pracovisko.COM_Festo.DS2_2_Port2_OUT[1]:= P2_StoperSrobovania.RFID_hlava.Mapping_OUT[1];
	P2_Pracovisko.COM_Festo.DS2_2_Port2_OUT[2]:= P2_StoperSrobovania.RFID_hlava.Mapping_OUT[2];
	P2_Pracovisko.COM_Festo.DS2_2_Port2_OUT[3]:= P2_StoperSrobovania.RFID_hlava.Mapping_OUT[3];
	P2_Pracovisko.COM_Festo.DS2_2_Port2_OUT[4]:= P2_StoperSrobovania.RFID_hlava.Mapping_OUT[4];
	P2_Pracovisko.COM_Festo.DS2_2_Port2_OUT[5]:= P2_StoperSrobovania.RFID_hlava.Mapping_OUT[5];
	P2_Pracovisko.COM_Festo.DS2_2_Port2_OUT[6]:= P2_StoperSrobovania.RFID_hlava.Mapping_OUT[6];
	P2_Pracovisko.COM_Festo.DS2_2_Port2_OUT[7]:= P2_StoperSrobovania.RFID_hlava.Mapping_OUT[7];
	
	
	//********Modul DS 2.2 IO link Port 3 - RFID snímaè paletky zváranie**************//
	//Inputs//
	P2_StoperZvarania.RFID_hlava.Mapping_IN[0]:= P2_Pracovisko.COM_Festo.DS2_2_Port3_IN[0];
	P2_StoperZvarania.RFID_hlava.Mapping_IN[1]:= P2_Pracovisko.COM_Festo.DS2_2_Port3_IN[1];
	P2_StoperZvarania.RFID_hlava.Mapping_IN[2]:= P2_Pracovisko.COM_Festo.DS2_2_Port3_IN[2];
	P2_StoperZvarania.RFID_hlava.Mapping_IN[3]:= P2_Pracovisko.COM_Festo.DS2_2_Port3_IN[3];
	P2_StoperZvarania.RFID_hlava.Mapping_IN[4]:= P2_Pracovisko.COM_Festo.DS2_2_Port3_IN[4];
	P2_StoperZvarania.RFID_hlava.Mapping_IN[5]:= P2_Pracovisko.COM_Festo.DS2_2_Port3_IN[5];
	P2_StoperZvarania.RFID_hlava.Mapping_IN[6]:= P2_Pracovisko.COM_Festo.DS2_2_Port3_IN[6];
	P2_StoperZvarania.RFID_hlava.Mapping_IN[7]:= P2_Pracovisko.COM_Festo.DS2_2_Port3_IN[7];
	
	//Outputs//
	P2_Pracovisko.COM_Festo.DS2_2_Port3_OUT[0]:= P2_StoperZvarania.RFID_hlava.Mapping_OUT[0];
	P2_Pracovisko.COM_Festo.DS2_2_Port3_OUT[1]:= P2_StoperZvarania.RFID_hlava.Mapping_OUT[1];
	P2_Pracovisko.COM_Festo.DS2_2_Port3_OUT[2]:= P2_StoperZvarania.RFID_hlava.Mapping_OUT[2];
	P2_Pracovisko.COM_Festo.DS2_2_Port3_OUT[3]:= P2_StoperZvarania.RFID_hlava.Mapping_OUT[3];
	P2_Pracovisko.COM_Festo.DS2_2_Port3_OUT[4]:= P2_StoperZvarania.RFID_hlava.Mapping_OUT[4];
	P2_Pracovisko.COM_Festo.DS2_2_Port3_OUT[5]:= P2_StoperZvarania.RFID_hlava.Mapping_OUT[5];
	P2_Pracovisko.COM_Festo.DS2_2_Port3_OUT[6]:= P2_StoperZvarania.RFID_hlava.Mapping_OUT[6];
	P2_Pracovisko.COM_Festo.DS2_2_Port3_OUT[7]:= P2_StoperZvarania.RFID_hlava.Mapping_OUT[7];
	
	
	//*************Modul DS 2.3 IO link Port 0 - Banner*********************//
	//Inputs//
	P2_StoperZaklTesnenia.Banner.Mapping_IN[0]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[0];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[1]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[1];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[2]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[2];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[3]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[3];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[4]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[4];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[5]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[5];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[6]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[6];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[7]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[7];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[8]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[8];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[9]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[9];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[10]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[10];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[11]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[11];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[12]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[12];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[13]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[13];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[14]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[14];
	P2_StoperZaklTesnenia.Banner.Mapping_IN[15]:= P2_Pracovisko.COM_Festo.DS2_3_Port0_IN[15];
	
	//Outputs//
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[0]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[0];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[1]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[1];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[2]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[2];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[3]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[3];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[4]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[4];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[5]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[5];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[6]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[6];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[7]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[7];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[8]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[8];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[9]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[9];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[10]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[10];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[11]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[11];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[12]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[12];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[13]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[13];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[14]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[14];
	P2_Pracovisko.COM_Festo.DS2_3_Port0_OUT[15]:= P2_StoperZaklTesnenia.Banner.Mapping_OUT[15];
	
	
	
	//*************Modul DS 2.3 IO link Port 1 - Snímaè vysunutia maticovaèky M4*********************//
	//Inputs//
	Convert_3.IN_Byte0:= P2_Pracovisko.COM_Festo.DS2_3_Port1_IN[0];
	Convert_3.IN_Byte1:= P2_Pracovisko.COM_Festo.DS2_3_Port1_IN[1];
	
	P2_StoperMaticovacky.PAR.Maticov_M4_AktualHodnVysunutia:= Convert_3.OUT_UINT;
	Convert_3();
	
	
	//************************************Ventilový terminál*******************************************//
	
	//1-8
	P2_Pracovisko.COM_VentilovyTerminal[0].0 := P2_Robot.OUT.Model45F_Vakum_ON;
	P2_Pracovisko.COM_VentilovyTerminal[0].1 := P2_Robot.OUT.Model45F_Vakum_OFF;
	P2_Pracovisko.COM_VentilovyTerminal[0].2 := P2_Robot.OUT.Model5H_Vakum_ON;
	P2_Pracovisko.COM_VentilovyTerminal[0].3 := P2_Robot.OUT.Model5H_Vakum_OFF;
	P2_Pracovisko.COM_VentilovyTerminal[0].4 := P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON;
	P2_Pracovisko.COM_VentilovyTerminal[0].5 := P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF;
	P2_Pracovisko.COM_VentilovyTerminal[0].6 := P2_Srobovanie.OUT.Skrutkovacka_M4_Odvzdusn_ON;
	P2_Pracovisko.COM_VentilovyTerminal[0].7;
	
	//9-16
	P2_Pracovisko.COM_VentilovyTerminal[1].0 := P2_StoperZaklTesnenia.OUT.ZasunStoper;
	P2_Pracovisko.COM_VentilovyTerminal[1].1 := P2_StoperMaticovacky.OUT.ZasunStoper;
	P2_Pracovisko.COM_VentilovyTerminal[1].2 := P2_AkumulacnyStoper.OUT.ZasunStoper;
	P2_Pracovisko.COM_VentilovyTerminal[1].3 := P2_StoperSrobovania.OUT.ZasunStoper;
	P2_Pracovisko.COM_VentilovyTerminal[1].4 := P2_StoperZvarania.OUT.ZasunStoper;
	P2_Pracovisko.COM_VentilovyTerminal[1].5 := P2_SpodnyStoper.OUT.ZasunStoper;
	P2_Pracovisko.COM_VentilovyTerminal[1].6 := P2_Robot.OUT.ZaistiGriper;
	P2_Pracovisko.COM_VentilovyTerminal[1].7 := P2_Robot.OUT.OdistiGriper;
	
	
	//17-24
	P2_Pracovisko.COM_VentilovyTerminal[2].0 := P2_Robot.OUT.PneuZamokUchopovaca_ODOMKNI;
	P2_Pracovisko.COM_VentilovyTerminal[2].1;
	P2_Pracovisko.COM_VentilovyTerminal[2].2 := P2_StoperMaticovacky.SkrutSet_MaticaM4.OUT.ZhadzovaciVzduch_RUN;
	P2_Pracovisko.COM_VentilovyTerminal[2].3 := P2_StoperMaticovacky.SkrutSet_MaticaM4.OUT.TriediaciVzduch_RUN;
	P2_Pracovisko.COM_VentilovyTerminal[2].4 := P2_StoperMaticovacky.SkrutSet_MaticaM4.OUT.OtocOddelovacMatice_NaVystup;
	P2_Pracovisko.COM_VentilovyTerminal[2].5;
	P2_Pracovisko.COM_VentilovyTerminal[2].6 := P2_StoperMaticovacky.SkrutSet_MaticaM4.OUT.NastrelenieMatice_RUN;
	P2_Pracovisko.COM_VentilovyTerminal[2].7;
	
	//25-32
	P2_Pracovisko.COM_VentilovyTerminal[3].0 := P2_StoperMaticovacky.SkrutSet_MaticaM4.OUT.PodavacMatice_Vysun;
	P2_Pracovisko.COM_VentilovyTerminal[3].1;
	P2_Pracovisko.COM_VentilovyTerminal[3].2 := P2_StoperMaticovacky.OUT.Maticovacka_M4_Prisavanie_ON;
	P2_Pracovisko.COM_VentilovyTerminal[3].3 := P2_StoperMaticovacky.OUT.Maticovacka_M4_Odvzdusn_ON;
	P2_Pracovisko.COM_VentilovyTerminal[3].4 := P2_Srobovanie.SkrutSet_M5.OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek;
	P2_Pracovisko.COM_VentilovyTerminal[3].5 := P2_Srobovanie.SkrutSet_M5.OUT.VibracnyHrniec.TiedenieSkrutiek;
	P2_Pracovisko.COM_VentilovyTerminal[3].6 := P2_Srobovanie.SkrutSet_M5.OUT.VibracnyHrniec.OddelovacVysunut;
	P2_Pracovisko.COM_VentilovyTerminal[3].7;
	
	//33-40
	P2_Pracovisko.COM_VentilovyTerminal[4].0 := P2_Srobovanie.SkrutSet_M5.OUT.VibracnyHrniec.VzduchNastreleniaSkrutky;
	P2_Pracovisko.COM_VentilovyTerminal[4].1;
	P2_Pracovisko.COM_VentilovyTerminal[4].2 := P2_Srobovanie.SkrutSet_M6.OUT.VibracnyHrniec.TiedenieSkrutiek;
	P2_Pracovisko.COM_VentilovyTerminal[4].3 := P2_Srobovanie.SkrutSet_M6.OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek;
	P2_Pracovisko.COM_VentilovyTerminal[4].4 := P2_Srobovanie.SkrutSet_M6.OUT.VibracnyHrniec.OddelovacVysunut;
	P2_Pracovisko.COM_VentilovyTerminal[4].5;
	P2_Pracovisko.COM_VentilovyTerminal[4].6 := P2_Srobovanie.SkrutSet_M6.OUT.VibracnyHrniec.VzduchNastreleniaSkrutky;
	P2_Pracovisko.COM_VentilovyTerminal[4].7;
	
	//41-48
	P2_Pracovisko.COM_VentilovyTerminal[5].0 := P2_Srobovanie.SkrutSet_M4.OUT.ZhadzovaciVzduch_RUN;
	P2_Pracovisko.COM_VentilovyTerminal[5].1 := P2_Srobovanie.SkrutSet_M4.OUT.TriediaciVzduch_RUN;
	P2_Pracovisko.COM_VentilovyTerminal[5].2 := P2_Srobovanie.SkrutSet_M4.OUT.OtocPodavac_NaVystup;
	P2_Pracovisko.COM_VentilovyTerminal[5].3 := P2_Srobovanie.SkrutSet_M4.OUT.OtocPodavac_NaVstup;
	P2_Pracovisko.COM_VentilovyTerminal[5].4 := P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON;
	P2_Pracovisko.COM_VentilovyTerminal[5].5 := P2_Srobovanie.OUT.Skrutkovacka_M6_Odvzdusn_ON;
	P2_Pracovisko.COM_VentilovyTerminal[5].6 := P2_Srobovanie.SkrutSet_M6.OUT.Brzda.PodajSkrutku;
	P2_Pracovisko.COM_VentilovyTerminal[5].7 := P2_Srobovanie.SkrutSet_M6.OUT.Brzda.ZakladnaPoloha;
	
	//49-56
	P2_Pracovisko.COM_VentilovyTerminal[6].0 := P2_Srobovanie.SkrutSet_M6.OUT.Brzda.OdsavanieNecistot;
	P2_Pracovisko.COM_VentilovyTerminal[6].1 := P2_Srobovanie.SkrutSet_M6.OUT.Brzda.NastrelenieSkrutky;
	P2_Pracovisko.COM_VentilovyTerminal[6].2 := P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON;
	P2_Pracovisko.COM_VentilovyTerminal[6].3 := P2_Srobovanie.OUT.Skrutkovacka_M5_Odvzdusn_ON;
	P2_Pracovisko.COM_VentilovyTerminal[6].4 := P2_Srobovanie.SkrutSet_M5.OUT.Brzda.PodajSkrutku;
	P2_Pracovisko.COM_VentilovyTerminal[6].5 := P2_Srobovanie.SkrutSet_M5.OUT.Brzda.ZakladnaPoloha;
	P2_Pracovisko.COM_VentilovyTerminal[6].6 := P2_Srobovanie.SkrutSet_M5.OUT.Brzda.OdsavanieNecistot;
	P2_Pracovisko.COM_VentilovyTerminal[6].7 := P2_Srobovanie.SkrutSet_M5.OUT.Brzda.NastrelenieSkrutky;
	
	//57-64
	P2_Pracovisko.COM_VentilovyTerminal[7].0 := P2_Cistenie.OUT.VzduchPreIonizator_ON;
	P2_Pracovisko.COM_VentilovyTerminal[7].1 := P2_Cistenie.OUT.OdsavanieOfuk_ON;
	P2_Pracovisko.COM_VentilovyTerminal[7].2 := P2_Cistenie.OUT.Odsavanie_ON;
	P2_Pracovisko.COM_VentilovyTerminal[7].3;
	P2_Pracovisko.COM_VentilovyTerminal[7].4;
	P2_Pracovisko.COM_VentilovyTerminal[7].5;
	P2_Pracovisko.COM_VentilovyTerminal[7].6;
	P2_Pracovisko.COM_VentilovyTerminal[7].7;
	
	
	//65-72
	P2_Pracovisko.COM_VentilovyTerminal[8].0;
	P2_Pracovisko.COM_VentilovyTerminal[8].1;
	P2_Pracovisko.COM_VentilovyTerminal[8].2;
	P2_Pracovisko.COM_VentilovyTerminal[8].3;
	P2_Pracovisko.COM_VentilovyTerminal[8].4 := P2_StoperMaticovacky.OUT.Maticovacku_M4_VYSUN;
	P2_Pracovisko.COM_VentilovyTerminal[8].5;
	P2_Pracovisko.COM_VentilovyTerminal[8].6 := P2_StoperMaticovacky.OUT.Centrovanie_VYSUN;
	P2_Pracovisko.COM_VentilovyTerminal[8].7 := P2_StoperMaticovacky.OUT.Centrovanie_ZASUN;
	
	
	//73-80
	P2_Pracovisko.COM_VentilovyTerminal[9].0 := P2_StoperSrobovania.OUT.Centrovanie_VYSUN;
	P2_Pracovisko.COM_VentilovyTerminal[9].1 := P2_StoperSrobovania.OUT.Centrovanie_ZASUN;
	P2_Pracovisko.COM_VentilovyTerminal[9].2 := P2_StoperZvarania.OUT.Centrovanie_VYSUN;
	P2_Pracovisko.COM_VentilovyTerminal[9].3 := P2_StoperZvarania.OUT.Centrovanie_ZASUN;
	P2_Pracovisko.COM_VentilovyTerminal[9].4 := P2_Robot.OUT.Griper_OTVOR;
	P2_Pracovisko.COM_VentilovyTerminal[9].5 := P2_Robot.OUT.Griper_ZATVOR ;
	P2_Pracovisko.COM_VentilovyTerminal[9].6 := P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN;
	P2_Pracovisko.COM_VentilovyTerminal[9].7;
	
	
	//81-88
	P2_Pracovisko.COM_VentilovyTerminal[10].0 := P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN;
	P2_Pracovisko.COM_VentilovyTerminal[10].1;
	P2_Pracovisko.COM_VentilovyTerminal[10].2 := P2_Zvaranie.OUT.PresunZvaranie_VPRAVO;
	P2_Pracovisko.COM_VentilovyTerminal[10].3 := P2_Zvaranie.OUT.PresunZvarania_VLAVO;
	P2_Pracovisko.COM_VentilovyTerminal[10].4 := P2_Cistenie.OUT.Dvere_OTVOR;
	P2_Pracovisko.COM_VentilovyTerminal[10].5 := P2_Cistenie.OUT.Dvere_ZATVOR;
	P2_Pracovisko.COM_VentilovyTerminal[10].6;
	P2_Pracovisko.COM_VentilovyTerminal[10].7;
	
	
	
	
	
	//Volanie knižnic//
	P2_ZakladacTesnenia.ServoPojazduZakladaca();
	P2_ZakladacTesnenia.ServoZdvihuZakladaca();
	P2_StoperMaticovacky.SkrutSet_MaticaM4();
	P2_Srobovanie.SkrutSet_M4(); 
	P2_Srobovanie.SkrutSet_M5(); 
	P2_Srobovanie.SkrutSet_M6(); 
	P2_Srobovanie.ServoManipulOsX();
	P2_Srobovanie.ServoManipulOsY();
	P2_Srobovanie.ServoManipulOsZ_M4();
	P2_Zvaranie.ServoZdvihuZvarania();
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

