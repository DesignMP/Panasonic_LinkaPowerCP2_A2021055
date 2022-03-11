
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//**********************************************************IO modul Wedmuller**********************************************************************//
	//************Karta AB 3.5 8DI**************//
	P3_Pracovisko.IN.StavPrepatovejOchrany_OK := P3_Pracovisko.COM_Weidmuller.AB3_5_8DI.0;
	P3_Srobovanie.IN.NapajanieSkrutkovackyK40_OK := P3_Pracovisko.COM_Weidmuller.AB3_5_8DI.1;
	P3_Srobovanie.IN.NapajanieSkrutkovackyM5_OK := P3_Pracovisko.COM_Weidmuller.AB3_5_8DI.2;
	P3_Srobovanie.IN.NapajanieZasobnikaK40_OK := P3_Pracovisko.COM_Weidmuller.AB3_5_8DI.3;
	P3_Srobovanie.IN.NapajanieZasobnikaM5_OK := P3_Pracovisko.COM_Weidmuller.AB3_5_8DI.4;
	P3_Srobovanie.IN.NapajanieVibrolistyM5_OK := P3_Pracovisko.COM_Weidmuller.AB3_5_8DI.5;
	P3_LeakageTestA.IN.NapajanieTestera_OK := P3_Pracovisko.COM_Weidmuller.AB3_5_8DI.6;
	P3_LeakageTestB.IN.NapajanieTestera_OK := P3_Pracovisko.COM_Weidmuller.AB3_5_8DI.7;
	
	//************Karta AB 3.6 8DI**************//
	P3_Dopravniky.IN.StavRiadPredDopravBunky_READY := P3_Pracovisko.COM_Weidmuller.AB3_6_8DI.0;
	P3_Dopravniky.IN.StavRiadeniaPriecnDoprav1_READY := P3_Pracovisko.COM_Weidmuller.AB3_6_8DI.1;
	P3_Dopravniky.IN.StavRiadeniaPriecnDoprav2_READY := P3_Pracovisko.COM_Weidmuller.AB3_6_8DI.2;
	P3_Dopravniky.IN.StavRiadZadnDopravBunky_READY := P3_Pracovisko.COM_Weidmuller.AB3_6_8DI.3;
	P3_Dopravniky.IN.StavRiadeniaVratnehoDoprav_READY := P3_Pracovisko.COM_Weidmuller.AB3_6_8DI.4;
	P3_Dopravniky.IN.TeplotaMotoraPredDopravBunky_OK := P3_Pracovisko.COM_Weidmuller.AB3_6_8DI.5;
	P3_Dopravniky.IN.TeplotaMotoraPriecnDoprav1_OK := P3_Pracovisko.COM_Weidmuller.AB3_6_8DI.6;
	P3_Dopravniky.IN.TeplotaMotoraPriecnDoprav2_OK := P3_Pracovisko.COM_Weidmuller.AB3_6_8DI.7;
	
	
	
	
	//************Karta AB 3.7 8DI**************//
	P3_Dopravniky.IN.TeplotaMotoraZadnDopravBunky_OK := P3_Pracovisko.COM_Weidmuller.AB3_7_8DI.0;
	P3_Dopravniky.IN.TeplotaMotoraVratnehoDoprav_OK := P3_Pracovisko.COM_Weidmuller.AB3_7_8DI.1;
	P3_Pracovisko.COM_Weidmuller.AB3_7_8DI.2;
	P3_Pracovisko.COM_Weidmuller.AB3_7_8DI.3;
	Safety.IN.Linka_SV_ZonaCS := P3_Pracovisko.COM_Weidmuller.AB3_7_8DI.4;
	Safety.IN.P3_SV_ZonaBunky := P3_Pracovisko.COM_Weidmuller.AB3_7_8DI.5;
	Safety.IN.P3_SV_HV_test := P3_Pracovisko.COM_Weidmuller.AB3_7_8DI.6;
	P3_Pracovisko.COM_Weidmuller.AB3_7_8DI.7;
	
	
	
	
	//************Karta AB 3.8 8DI**************//
	P3_Pracovisko.COM_Weidmuller.AB3_8_8DI.0;
	P3_Pracovisko.COM_Weidmuller.AB3_8_8DI.1;
	P3_Pracovisko.COM_Weidmuller.AB3_8_8DI.2;
	P3_Pracovisko.COM_Weidmuller.AB3_8_8DI.3;
	P3_Pracovisko.COM_Weidmuller.AB3_8_8DI.4;
	P3_Pracovisko.COM_Weidmuller.AB3_8_8DI.5;
	P3_Pracovisko.COM_Weidmuller.AB3_8_8DI.6;
	P3_Pracovisko.COM_Weidmuller.AB3_8_8DI.7;
	
	
	
	//************Karta AB 3.9 8DO***************//
	P3_Pracovisko.COM_Weidmuller.AB3_9_8DO.0 := P3_Pracovisko.OUT.Majak_ZeleneSvetlo_ON;
	P3_Pracovisko.COM_Weidmuller.AB3_9_8DO.1 := P3_Pracovisko.OUT.Majak_OranzoveSvetlo_ON;
	P3_Pracovisko.COM_Weidmuller.AB3_9_8DO.2 := P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON;
	P3_Pracovisko.COM_Weidmuller.AB3_9_8DO.3 := P3_Pracovisko.OUT.Majak_Hukacka_ON;
	P3_Pracovisko.COM_Weidmuller.AB3_9_8DO.4 := P3_Srobovanie.SkrutSet_K40.OUT.VibracnyHrniec.ZapniVibromotor;
	P3_Pracovisko.COM_Weidmuller.AB3_9_8DO.5 := P3_Srobovanie.SkrutSet_M5.OUT.VibropohonZasobnika_RUN;
	P3_Pracovisko.COM_Weidmuller.AB3_9_8DO.6 := P3_Srobovanie.SkrutSet_M5.OUT.VibropohonListy_RUN;
	P3_Pracovisko.COM_Weidmuller.AB3_9_8DO.7 := P3_Pracovisko.OUT.OsvetlenieBunky_ON;
	
		
	//************Karta AB 3.10 8DO***************//
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.0;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.1;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.2;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.3;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.4;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.5;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.6;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.7;
	
	
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.0 := P3_Dopravniky.OUT.PrednyDopravnikBunky_ON;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.1 := P3_Dopravniky.OUT.PriecnyDopravnik1_VPRED;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.2 := P3_Dopravniky.OUT.PriecnyDopravnik2_VPRED;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.3 := P3_Dopravniky.OUT.ZadnyDopravnikBunky_ON;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.4 := P3_Dopravniky.OUT.VratnyDopravnik_ON;
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.5;   // Safety resety
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.6;    // Safety resety                                              
	P3_Pracovisko.COM_Weidmuller.AB3_10_8DO.7;    // Safety resety                                              
	
	
	
	
	
	
	//************Karta AB 3.12 8DO***************//
	P3_Pracovisko.COM_Weidmuller.AB3_12_8DO.0;
	P3_Pracovisko.COM_Weidmuller.AB3_12_8DO.1;
	P3_Pracovisko.COM_Weidmuller.AB3_12_8DO.2;
	P3_Pracovisko.COM_Weidmuller.AB3_12_8DO.3;
	P3_Pracovisko.COM_Weidmuller.AB3_12_8DO.4;
	P3_Pracovisko.COM_Weidmuller.AB3_12_8DO.5;
	P3_Pracovisko.COM_Weidmuller.AB3_12_8DO.6 := P3_Dopravniky.OUT.PriecnyDopravnik2_VZAD;
	P3_Pracovisko.COM_Weidmuller.AB3_12_8DO.7 := P3_Pracovisko.OUT.Ventilator_ON;
	
	
	
	
	
	//**************************************************************IO modul Festo**********************************************************************************//
	
	//**********Modul DM 3.1 4DI4DO**************//
	//Inputs//
	P3_Pracovisko.IN.PredneDvereLave_PritomnAdaptera := P3_Pracovisko.COM_Festo.DM3_1_4DI[0];
	P3_Pracovisko.IN.PredneDverePrave_PritomnAdaptera := P3_Pracovisko.COM_Festo.DM3_1_4DI[1];
	P3_Pracovisko.IN.ZadneDvereLave_PritomnAdaptera := P3_Pracovisko.COM_Festo.DM3_1_4DI[2];
	P3_Pracovisko.IN.ZadneDverePrave_PritomnAdaptera := P3_Pracovisko.COM_Festo.DM3_1_4DI[3];
	
	//Outputs//
	P3_Pracovisko.COM_Festo.DM3_1_4DO[0] := P3_Pracovisko.OUT.PredneDvereLave_ZAMKNI;
	P3_Pracovisko.COM_Festo.DM3_1_4DO[1] := P3_Pracovisko.OUT.PredneDverePrave_ZAMKNI;
	P3_Pracovisko.COM_Festo.DM3_1_4DO[2] := P3_Pracovisko.OUT.ZadneDvereLave_ZAMKNI;
	P3_Pracovisko.COM_Festo.DM3_1_4DO[3] := P3_Pracovisko.OUT.ZadneDverePrave_ZAMKNI;
	
	
	
	
	//***********Modul DI 3.1 8DI****************//
	P3_HV_Test.IN.HorneKontakty_VYSUNUTE := P3_Pracovisko.COM_Festo.DI3_1_8DI[0];
	P3_HV_Test.IN.HorneKontakty_ZASUNUTE := P3_Pracovisko.COM_Festo.DI3_1_8DI[1];
	P3_HV_Test.IN.Centrovanie_ZASUNUTE := P3_Pracovisko.COM_Festo.DI3_1_8DI[2];
	P3_HV_Test.IN.Centrovanie_VYSUNUTE := P3_Pracovisko.COM_Festo.DI3_1_8DI[3];
	P3_HV_Test.IN.SpodneKontakty_ZASUNUTE := P3_Pracovisko.COM_Festo.DI3_1_8DI[4];
	P3_HV_Test.IN.SpodneKontakty_VYSUNUTE := P3_Pracovisko.COM_Festo.DI3_1_8DI[5];
	P3_HV_Test.IN.TypKonektoru_5F_5H := P3_Pracovisko.COM_Festo.DI3_1_8DI[6];
	P3_HV_Test.IN.TypKonektoru_4F := P3_Pracovisko.COM_Festo.DI3_1_8DI[7];
	
	
	
	//***********Modul DI 3.2 8DI****************//
	P3_Pracovisko.COM_Festo.DI3_2_8DI[0];
	P3_ZdvizkaZaLeakTestA.IN.TlmicPaletky_ZASUNUTY := P3_Pracovisko.COM_Festo.DI3_2_8DI[1];
	P3_ZdvizkaZaLeakTestB.IN.TlmicPaletky_ZASUNUTY := P3_Pracovisko.COM_Festo.DI3_2_8DI[2];
	P3_Pracovisko.COM_Festo.DI3_2_8DI[3];
	P3_Pracovisko.COM_Festo.DI3_2_8DI[4];
	P3_Pracovisko.COM_Festo.DI3_2_8DI[5];
	P3_Pracovisko.COM_Festo.DI3_2_8DI[6];
	P3_Pracovisko.COM_Festo.DI3_2_8DI[7];
	
	
	//***********Modul DI 3.3 8DI****************//
	P3_LeakageTestA.IN.HornyPritlak_TlakOK := P3_Pracovisko.COM_Festo.DI3_4_8DI[0];
	P3_LeakageTestA.IN.HornyPritlak_PneuZamok_Odomknuty := P3_Pracovisko.COM_Festo.DI3_4_8DI[1];
	P3_LeakageTestB.IN.HornyPritlak_ZASUNUTY := P3_Pracovisko.COM_Festo.DI3_3_8DI[2];
	P3_LeakageTestB.IN.HornyPritlak_VYSUNUTY := P3_Pracovisko.COM_Festo.DI3_3_8DI[3];
	P3_LeakageTestB.IN.PritomnostKopita := P3_Pracovisko.COM_Festo.DI3_3_8DI[4];
	P3_LeakageTestB.IN.Kopito_ZASUNUTE := P3_Pracovisko.COM_Festo.DI3_3_8DI[5];
	P3_LeakageTestB.IN.Centrovanie_VYSUNUTE := P3_Pracovisko.COM_Festo.DI3_3_8DI[6];
	P3_LeakageTestB.IN.Centrovanie_ZASUNUTE := P3_Pracovisko.COM_Festo.DI3_3_8DI[7];
	
	
	
	
	
	//***********Modul DI 3.4 8DI****************//
	P3_LeakageTestB.IN.HornyPritlak_TlakOK:= P3_Pracovisko.COM_Festo.DI3_3_8DI[0];
	P3_LeakageTestB.IN.HornyPritlak_PneuZamok_Odomknuty := P3_Pracovisko.COM_Festo.DI3_3_8DI[1];
	P3_LeakageTestA.IN.HornyPritlak_VYSUNUTY := P3_Pracovisko.COM_Festo.DI3_4_8DI[2];
	P3_LeakageTestA.IN.HornyPritlak_ZASUNUTY := P3_Pracovisko.COM_Festo.DI3_4_8DI[3];
	P3_LeakageTestA.IN.PritomnostKopita := P3_Pracovisko.COM_Festo.DI3_4_8DI[4];
	P3_LeakageTestA.IN.Kopito_ZASUNUTE := P3_Pracovisko.COM_Festo.DI3_4_8DI[5];
	P3_LeakageTestA.IN.Centrovanie_VYSUNUTE := P3_Pracovisko.COM_Festo.DI3_4_8DI[6];
	P3_LeakageTestA.IN.Centrovanie_ZASUNUTE := P3_Pracovisko.COM_Festo.DI3_4_8DI[7];
	
	
	
	
	//***********Modul DI 3.5 8DI****************//
	P3_Srobovanie.SkrutSet_K40.IN.VibracnyHrniec.PritomnostSkrutiekVHrnci := P3_Pracovisko.COM_Festo.DI3_5_8DI[0];
	P3_Srobovanie.SkrutSet_K40.IN.VibracnyHrniec.VibracnaListaZaplnena := P3_Pracovisko.COM_Festo.DI3_5_8DI[1];
	P3_Srobovanie.SkrutSet_K40.IN.VibracnyHrniec.PreletovySnimac := P3_Pracovisko.COM_Festo.DI3_5_8DI[2];
	P3_Srobovanie.SkrutSet_K40.IN.Brzda.PodajSkrutku:= P3_Pracovisko.COM_Festo.DI3_5_8DI[3];
	P3_Srobovanie.SkrutSet_K40.IN.Brzda.ZakladnaPoloha  := P3_Pracovisko.COM_Festo.DI3_5_8DI[4];
	P3_Srobovanie.SkrutSet_K40.IN.Brzda.SkrutkaPritomnaVBrzde := P3_Pracovisko.COM_Festo.DI3_5_8DI[5];
	P3_Srobovanie.SkrutSet_K40.IN.Brzda.PreletSkrutky := P3_Pracovisko.COM_Festo.DI3_5_8DI[6];
	P3_Srobovanie.IN.Skrutkovacka_K40_ZASUNUTA := P3_Pracovisko.COM_Festo.DI3_5_8DI[7];
	
	
	
	//***********Modul DI 3.6 8DI****************//
	P3_Srobovanie.SkrutSet_M5.IN.ZasobnikSkrutiekPrazdny := P3_Pracovisko.COM_Festo.DI3_6_8DI[0];
	P3_Srobovanie.SkrutSet_M5.IN.ZaplnenieListyZasobnika := P3_Pracovisko.COM_Festo.DI3_6_8DI[1];
	P3_Srobovanie.SkrutSet_M5.IN.ZaplnenieVibrolisty_MAX := P3_Pracovisko.COM_Festo.DI3_6_8DI[2];
	P3_Srobovanie.SkrutSet_M5.IN.ZaplnenieVibrolisty_MIN := P3_Pracovisko.COM_Festo.DI3_6_8DI[3];
	P3_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVstupe := P3_Pracovisko.COM_Festo.DI3_6_8DI[4];
	P3_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe := P3_Pracovisko.COM_Festo.DI3_6_8DI[5];
	P3_Srobovanie.SkrutSet_M5.IN.PodavacOtoceny_VSTUP := P3_Pracovisko.COM_Festo.DI3_6_8DI[6];
	P3_Srobovanie.SkrutSet_M5.IN.PodavacOtoceny_VYSTUP := P3_Pracovisko.COM_Festo.DI3_6_8DI[7];
	
	
	
	
	//***********Modul DI 3.7 8DI****************//
	P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK := P3_Pracovisko.COM_Festo.DI3_7_8DI[0];
	P3_Pracovisko.IN.TlakVzduchu_OK := P3_Pracovisko.COM_Festo.DI3_7_8DI[1];
	Safety.IN.P3_SV_PrivodVzduchu_CH1 := P3_Pracovisko.COM_Festo.DI3_7_8DI[2];
	Safety.IN.P3_SV_PrivodVzduchu_CH2 := P3_Pracovisko.COM_Festo.DI3_7_8DI[3];
	P3_Pracovisko.COM_Festo.DI3_7_8DI[4];
	P3_Pracovisko.COM_Festo.DI3_7_8DI[5];
	P3_Pracovisko.COM_Festo.DI3_7_8DI[6];
	P3_Pracovisko.COM_Festo.DI3_7_8DI[7];
	
	
	
	
	//***********Modul DI 3.8 8DI****************//
	P3_ZdvizkaPredLeakTestA.IN.Zdvizka_HornaPoloha := P3_Pracovisko.COM_Festo.DI3_8_8DI[0];
	P3_ZdvizkaPredLeakTestA.IN.Zdvizka_SpodnaPoloha := P3_Pracovisko.COM_Festo.DI3_8_8DI[1];
	P3_ZdvizkaPredLeakTestA.IN.Zdvizka_StrednaPoloha := P3_Pracovisko.COM_Festo.DI3_8_8DI[2];
	P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky := P3_Pracovisko.COM_Festo.DI3_8_8DI[3];
	P3_ZdvizkaPredLeakTestB.IN.Zdvizka_SpodnaPoloha := P3_Pracovisko.COM_Festo.DI3_8_8DI[4];
	P3_ZdvizkaPredLeakTestB.IN.Zdvizka_HornaPoloha := P3_Pracovisko.COM_Festo.DI3_8_8DI[5];
	P3_ZdvizkaPredLeakTestB.IN.Zdvizka_StrednaPoloha := P3_Pracovisko.COM_Festo.DI3_8_8DI[6];
	P3_ZdvizkaPredLeakTestB.IN.PoziciaPaletky_OK := P3_Pracovisko.COM_Festo.DI3_8_8DI[7];
	
	 
	//***********Modul DI 3.9 8DI****************//
	P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky := P3_Pracovisko.COM_Festo.DI3_9_8DI[0];
	P3_ZdvizkaZaLeakTestA.IN.Zdvizka_SpodnaPoloha := P3_Pracovisko.COM_Festo.DI3_9_8DI[1];
	P3_ZdvizkaZaLeakTestA.IN.Zdvizka_HornaPoloha := P3_Pracovisko.COM_Festo.DI3_9_8DI[2];
	P3_ZdvizkaZaLeakTestA.IN.Zdvizka_StrednaPoloha := P3_Pracovisko.COM_Festo.DI3_9_8DI[3];
	P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky := P3_Pracovisko.COM_Festo.DI3_9_8DI[4];
	P3_ZdvizkaZaLeakTestA.IN.PoziciaPaletky_OK := P3_Pracovisko.COM_Festo.DI3_9_8DI[5];
	P3_SpodnyStoper.IN.ZaplnenieDopravnika := P3_Pracovisko.COM_Festo.DI3_9_8DI[6];
	P3_SpodnyStoper.IN.PritomnostPaletky := P3_Pracovisko.COM_Festo.DI3_9_8DI[7];
	
	
	//***********Modul DI 3.10 8DI****************//
	P3_ZdvizkaZaLeakTestB.IN.Zdvizka_SpodnaPoloha := P3_Pracovisko.COM_Festo.DI3_10_8DI[0];
	P3_ZdvizkaZaLeakTestB.IN.Zdvizka_HornaPoloha  := P3_Pracovisko.COM_Festo.DI3_10_8DI[1];
	P3_ZdvizkaZaLeakTestB.IN.Zdvizka_StrednaPoloha := P3_Pracovisko.COM_Festo.DI3_10_8DI[2];
	P3_ZdvizkaZaLeakTestB.IN.PritomnostPaletky := P3_Pracovisko.COM_Festo.DI3_10_8DI[3];
	P3_ZdvizkaZaLeakTestB.IN.PoziciaPaletky_OK := P3_Pracovisko.COM_Festo.DI3_10_8DI[4];
	P3_Pracovisko.COM_Festo.DI3_10_8DI[5];
	P3_StoperSrobovania.IN.Centrovanie_VYSUNUTE:= P3_Pracovisko.COM_Festo.DI3_10_8DI[6];
	P3_StoperSrobovania.IN.Centrovanie_ZASUNUTE := P3_Pracovisko.COM_Festo.DI3_10_8DI[7];
	
	
	
	
	
	//********Modul DS 3.1 IO link Port 0 - RFID snímaè paletky stoper skrutkovania**************//
	//Inputs//
	P3_StoperSrobovania.RFID_hlava.Mapping_IN[0]:= P3_Pracovisko.COM_Festo.DS3_1_Port0_IN[0];
	P3_StoperSrobovania.RFID_hlava.Mapping_IN[1]:= P3_Pracovisko.COM_Festo.DS3_1_Port0_IN[1];
	P3_StoperSrobovania.RFID_hlava.Mapping_IN[2]:= P3_Pracovisko.COM_Festo.DS3_1_Port0_IN[2];
	P3_StoperSrobovania.RFID_hlava.Mapping_IN[3]:= P3_Pracovisko.COM_Festo.DS3_1_Port0_IN[3];
	P3_StoperSrobovania.RFID_hlava.Mapping_IN[4]:= P3_Pracovisko.COM_Festo.DS3_1_Port0_IN[4];
	P3_StoperSrobovania.RFID_hlava.Mapping_IN[5]:= P3_Pracovisko.COM_Festo.DS3_1_Port0_IN[5];
	P3_StoperSrobovania.RFID_hlava.Mapping_IN[6]:= P3_Pracovisko.COM_Festo.DS3_1_Port0_IN[6];
	P3_StoperSrobovania.RFID_hlava.Mapping_IN[7]:= P3_Pracovisko.COM_Festo.DS3_1_Port0_IN[7];
	
	//Outputs//
	P3_Pracovisko.COM_Festo.DS3_1_Port0_OUT[0]:= P3_StoperSrobovania.RFID_hlava.Mapping_OUT[0];
	P3_Pracovisko.COM_Festo.DS3_1_Port0_OUT[1]:= P3_StoperSrobovania.RFID_hlava.Mapping_OUT[1];
	P3_Pracovisko.COM_Festo.DS3_1_Port0_OUT[2]:= P3_StoperSrobovania.RFID_hlava.Mapping_OUT[2];
	P3_Pracovisko.COM_Festo.DS3_1_Port0_OUT[3]:= P3_StoperSrobovania.RFID_hlava.Mapping_OUT[3];
	P3_Pracovisko.COM_Festo.DS3_1_Port0_OUT[4]:= P3_StoperSrobovania.RFID_hlava.Mapping_OUT[4];
	P3_Pracovisko.COM_Festo.DS3_1_Port0_OUT[5]:= P3_StoperSrobovania.RFID_hlava.Mapping_OUT[5];
	P3_Pracovisko.COM_Festo.DS3_1_Port0_OUT[6]:= P3_StoperSrobovania.RFID_hlava.Mapping_OUT[6];
	P3_Pracovisko.COM_Festo.DS3_1_Port0_OUT[7]:= P3_StoperSrobovania.RFID_hlava.Mapping_OUT[7];
	
	
	//********Modul DS 3.1 IO link Port 1 - RFID snímaè paletky HV test**************//
	//Inputs//
	P3_HV_Test.RFID_hlava.Mapping_IN[0]:= P3_Pracovisko.COM_Festo.DS3_1_Port1_IN[0];
	P3_HV_Test.RFID_hlava.Mapping_IN[1]:= P3_Pracovisko.COM_Festo.DS3_1_Port1_IN[1];
	P3_HV_Test.RFID_hlava.Mapping_IN[2]:= P3_Pracovisko.COM_Festo.DS3_1_Port1_IN[2];
	P3_HV_Test.RFID_hlava.Mapping_IN[3]:= P3_Pracovisko.COM_Festo.DS3_1_Port1_IN[3];
	P3_HV_Test.RFID_hlava.Mapping_IN[4]:= P3_Pracovisko.COM_Festo.DS3_1_Port1_IN[4];
	P3_HV_Test.RFID_hlava.Mapping_IN[5]:= P3_Pracovisko.COM_Festo.DS3_1_Port1_IN[5];
	P3_HV_Test.RFID_hlava.Mapping_IN[6]:= P3_Pracovisko.COM_Festo.DS3_1_Port1_IN[6];
	P3_HV_Test.RFID_hlava.Mapping_IN[7]:= P3_Pracovisko.COM_Festo.DS3_1_Port1_IN[7];
	
	//Outputs//
	P3_Pracovisko.COM_Festo.DS3_1_Port1_OUT[0]:= P3_HV_Test.RFID_hlava.Mapping_OUT[0];
	P3_Pracovisko.COM_Festo.DS3_1_Port1_OUT[1]:= P3_HV_Test.RFID_hlava.Mapping_OUT[1];
	P3_Pracovisko.COM_Festo.DS3_1_Port1_OUT[2]:= P3_HV_Test.RFID_hlava.Mapping_OUT[2];
	P3_Pracovisko.COM_Festo.DS3_1_Port1_OUT[3]:= P3_HV_Test.RFID_hlava.Mapping_OUT[3];
	P3_Pracovisko.COM_Festo.DS3_1_Port1_OUT[4]:= P3_HV_Test.RFID_hlava.Mapping_OUT[4];
	P3_Pracovisko.COM_Festo.DS3_1_Port1_OUT[5]:= P3_HV_Test.RFID_hlava.Mapping_OUT[5];
	P3_Pracovisko.COM_Festo.DS3_1_Port1_OUT[6]:= P3_HV_Test.RFID_hlava.Mapping_OUT[6];
	P3_Pracovisko.COM_Festo.DS3_1_Port1_OUT[7]:= P3_HV_Test.RFID_hlava.Mapping_OUT[7];
	
	
	//********Modul DS 3.1 IO link Port 2 - RFID snímaè paletky Leakage test B**************//
	//Inputs//
	P3_LeakageTestB.RFID_hlava.Mapping_IN[0]:= P3_Pracovisko.COM_Festo.DS3_1_Port2_IN[0];
	P3_LeakageTestB.RFID_hlava.Mapping_IN[1]:= P3_Pracovisko.COM_Festo.DS3_1_Port2_IN[1];
	P3_LeakageTestB.RFID_hlava.Mapping_IN[2]:= P3_Pracovisko.COM_Festo.DS3_1_Port2_IN[2];
	P3_LeakageTestB.RFID_hlava.Mapping_IN[3]:= P3_Pracovisko.COM_Festo.DS3_1_Port2_IN[3];
	P3_LeakageTestB.RFID_hlava.Mapping_IN[4]:= P3_Pracovisko.COM_Festo.DS3_1_Port2_IN[4];
	P3_LeakageTestB.RFID_hlava.Mapping_IN[5]:= P3_Pracovisko.COM_Festo.DS3_1_Port2_IN[5];
	P3_LeakageTestB.RFID_hlava.Mapping_IN[6]:= P3_Pracovisko.COM_Festo.DS3_1_Port2_IN[6];
	P3_LeakageTestB.RFID_hlava.Mapping_IN[7]:= P3_Pracovisko.COM_Festo.DS3_1_Port2_IN[7];
	
	//Outputs//
	P3_Pracovisko.COM_Festo.DS3_1_Port2_OUT[0]:= P3_LeakageTestB.RFID_hlava.Mapping_OUT[0];
	P3_Pracovisko.COM_Festo.DS3_1_Port2_OUT[1]:= P3_LeakageTestB.RFID_hlava.Mapping_OUT[1];
	P3_Pracovisko.COM_Festo.DS3_1_Port2_OUT[2]:= P3_LeakageTestB.RFID_hlava.Mapping_OUT[2];
	P3_Pracovisko.COM_Festo.DS3_1_Port2_OUT[3]:= P3_LeakageTestB.RFID_hlava.Mapping_OUT[3];
	P3_Pracovisko.COM_Festo.DS3_1_Port2_OUT[4]:= P3_LeakageTestB.RFID_hlava.Mapping_OUT[4];
	P3_Pracovisko.COM_Festo.DS3_1_Port2_OUT[5]:= P3_LeakageTestB.RFID_hlava.Mapping_OUT[5];
	P3_Pracovisko.COM_Festo.DS3_1_Port2_OUT[6]:= P3_LeakageTestB.RFID_hlava.Mapping_OUT[6];
	P3_Pracovisko.COM_Festo.DS3_1_Port2_OUT[7]:= P3_LeakageTestB.RFID_hlava.Mapping_OUT[7];
	
	
	
	//********Modul DS 3.1 IO link Port 3 - RFID snímaè paletky Leakage test A**************//
	//Inputs//
	P3_LeakageTestA.RFID_hlava.Mapping_IN[0]:= P3_Pracovisko.COM_Festo.DS3_1_Port3_IN[0];
	P3_LeakageTestA.RFID_hlava.Mapping_IN[1]:= P3_Pracovisko.COM_Festo.DS3_1_Port3_IN[1];
	P3_LeakageTestA.RFID_hlava.Mapping_IN[2]:= P3_Pracovisko.COM_Festo.DS3_1_Port3_IN[2];
	P3_LeakageTestA.RFID_hlava.Mapping_IN[3]:= P3_Pracovisko.COM_Festo.DS3_1_Port3_IN[3];
	P3_LeakageTestA.RFID_hlava.Mapping_IN[4]:= P3_Pracovisko.COM_Festo.DS3_1_Port3_IN[4];
	P3_LeakageTestA.RFID_hlava.Mapping_IN[5]:= P3_Pracovisko.COM_Festo.DS3_1_Port3_IN[5];
	P3_LeakageTestA.RFID_hlava.Mapping_IN[6]:= P3_Pracovisko.COM_Festo.DS3_1_Port3_IN[6];
	P3_LeakageTestA.RFID_hlava.Mapping_IN[7]:= P3_Pracovisko.COM_Festo.DS3_1_Port3_IN[7];
	
	//Outputs//
	P3_Pracovisko.COM_Festo.DS3_1_Port3_OUT[0]:= P3_LeakageTestA.RFID_hlava.Mapping_OUT[0];
	P3_Pracovisko.COM_Festo.DS3_1_Port3_OUT[1]:= P3_LeakageTestA.RFID_hlava.Mapping_OUT[1];
	P3_Pracovisko.COM_Festo.DS3_1_Port3_OUT[2]:= P3_LeakageTestA.RFID_hlava.Mapping_OUT[2];
	P3_Pracovisko.COM_Festo.DS3_1_Port3_OUT[3]:= P3_LeakageTestA.RFID_hlava.Mapping_OUT[3];
	P3_Pracovisko.COM_Festo.DS3_1_Port3_OUT[4]:= P3_LeakageTestA.RFID_hlava.Mapping_OUT[4];
	P3_Pracovisko.COM_Festo.DS3_1_Port3_OUT[5]:= P3_LeakageTestA.RFID_hlava.Mapping_OUT[5];
	P3_Pracovisko.COM_Festo.DS3_1_Port3_OUT[6]:= P3_LeakageTestA.RFID_hlava.Mapping_OUT[6];
	P3_Pracovisko.COM_Festo.DS3_1_Port3_OUT[7]:= P3_LeakageTestA.RFID_hlava.Mapping_OUT[7];
	
	
	//*********Modul DS 3.2 IO link Port 0 - Snímaè tlaku Leakage test B****************//
	//Inputs//
	P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[0];
	P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1];
	
	P3_LeakageTestB.IN.VyrovnavaciTlak_OK:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[0].0;
	
	
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.0:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[0].2;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.1:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[0].3;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.2:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[0].4;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.3:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[0].5;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.4:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[0].6;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.5:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[0].7;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.6:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1].0;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.7:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1].1;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.8:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1].2;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.9:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1].3;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.10:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1].4;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.11:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1].5;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.12:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1].6;
	P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak.13:= P3_Pracovisko.COM_Festo.DS3_2_Port0_IN[1].7;
	
	
	P3_LeakageTestB.PAR.PreratanyVyrovnavaciTlak_Bar:= P3_LeakageTestB.PAR.PrecitanyVyrovnavaciTlak*0.1;
	
	
	
	
	//*********Modul DS 3.2 IO link Port 1 - Snímaè tlaku Leakage test A****************//
	//Inputs//
	P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[0];
	P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1];
	
	P3_LeakageTestA.IN.VyrovnavaciTlak_OK:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[0].0;
	
	
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.0:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[0].2;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.1:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[0].3;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.2:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[0].4;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.3:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[0].5;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.4:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[0].6;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.5:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[0].7;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.6:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1].0;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.7:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1].1;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.8:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1].2;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.9:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1].3;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.10:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1].4;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.11:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1].5;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.12:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1].6;
	P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak.13:= P3_Pracovisko.COM_Festo.DS3_2_Port1_IN[1].7;
	
	
	P3_LeakageTestA.PAR.PreratanyVyrovnavaciTlak_Bar:= P3_LeakageTestA.PAR.PrecitanyVyrovnavaciTlak*0.1;
	
	
	
	//*********Modul DS 3.2 IO link Port 2 - Snímaè vysunutia skrutkovaèky K40****************//
	//Inputs//
	Convert_0.IN_Byte0:= P3_Pracovisko.COM_Festo.DS3_2_Port2_IN[0];
	Convert_0.IN_Byte1:= P3_Pracovisko.COM_Festo.DS3_2_Port2_IN[1];
	
	P3_Srobovanie.PAR.Skrutkov_K40_AktualHodnVysunutia:= Convert_0.OUT_UINT;
	Convert_0();
	
	
	
	
	
	//************************************Ventilový terminál*******************************************//
	
	//1-8
	P3_Pracovisko.COM_VentilovyTerminal[0].0 := P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON;
	P3_Pracovisko.COM_VentilovyTerminal[0].1 := P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF;
	P3_Pracovisko.COM_VentilovyTerminal[0].2 := P3_Srobovanie.OUT.Skrutkovacka_M5_Odvzdusn_ON;
	P3_Pracovisko.COM_VentilovyTerminal[0].3;
	P3_Pracovisko.COM_VentilovyTerminal[0].4;
	P3_Pracovisko.COM_VentilovyTerminal[0].5;
	P3_Pracovisko.COM_VentilovyTerminal[0].6 := P3_StoperSrobovania.OUT.ZasunStoper;
	P3_Pracovisko.COM_VentilovyTerminal[0].7 := P3_HV_Test.OUT.ZasunStoper;
	
	
	//9-16
	P3_Pracovisko.COM_VentilovyTerminal[1].0 := P3_ZdvizkaPredLeakTestA.OUT.Zdvizku_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[1].1 := P3_ZdvizkaPredLeakTestA.OUT.Zdvizku_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[1].2 := P3_ZdvizkaPredLeakTestA.OUT.TlmicPaletky_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[1].3;
	P3_Pracovisko.COM_VentilovyTerminal[1].4 := P3_ZdvizkaPredLeakTestB.OUT.Zdvizku_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[1].5 := P3_ZdvizkaPredLeakTestB.OUT.Zdvizku_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[1].6;
	P3_Pracovisko.COM_VentilovyTerminal[1].7;
	
	//17-24
	P3_Pracovisko.COM_VentilovyTerminal[2].0 := P3_LeakageTestA.OUT.ZasunStoper;
	P3_Pracovisko.COM_VentilovyTerminal[2].1 := P3_LeakageTestB.OUT.ZasunStoper;
	P3_Pracovisko.COM_VentilovyTerminal[2].2 := P3_ZdvizkaZaLeakTestA.OUT.Zdvizku_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[2].3 := P3_ZdvizkaZaLeakTestA.OUT.Zdvizku_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[2].4 := P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[2].5 := P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[2].6 := P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[2].7 := P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_ZASUN;
	
	
	//25-32
	P3_Pracovisko.COM_VentilovyTerminal[3].0 := P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[3].1 := P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[3].2 := P3_Pracovisko.OUT.ZdvizkyPneuZamok_ODOMKNI;
	P3_Pracovisko.COM_VentilovyTerminal[3].3;
	P3_Pracovisko.COM_VentilovyTerminal[3].4 := P3_Srobovanie.SkrutSet_K40.OUT.VibracnyHrniec.PrerusenieZasobovaniaSkrutiek;
	P3_Pracovisko.COM_VentilovyTerminal[3].5 := P3_Srobovanie.SkrutSet_K40.OUT.VibracnyHrniec.TiedenieSkrutiek;
	P3_Pracovisko.COM_VentilovyTerminal[3].6 := P3_Srobovanie.SkrutSet_K40.OUT.VibracnyHrniec.OddelovacVysunut;
	P3_Pracovisko.COM_VentilovyTerminal[3].7;
	
	
	//33-40
	P3_Pracovisko.COM_VentilovyTerminal[4].0 := P3_Srobovanie.SkrutSet_K40.OUT.VibracnyHrniec.VzduchNastreleniaSkrutky;
	P3_Pracovisko.COM_VentilovyTerminal[4].1;
	P3_Pracovisko.COM_VentilovyTerminal[4].2 := P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON;
	P3_Pracovisko.COM_VentilovyTerminal[4].3 := P3_Srobovanie.OUT.Skrutkovacka_K40_Odvzdusn_ON;
	P3_Pracovisko.COM_VentilovyTerminal[4].4 := P3_Srobovanie.SkrutSet_K40.OUT.Brzda.PodajSkrutku;
	P3_Pracovisko.COM_VentilovyTerminal[4].5 := P3_Srobovanie.SkrutSet_K40.OUT.Brzda.ZakladnaPoloha;
	P3_Pracovisko.COM_VentilovyTerminal[4].6 := P3_Srobovanie.SkrutSet_K40.OUT.Brzda.OdsavanieNecistot;
	P3_Pracovisko.COM_VentilovyTerminal[4].7 := P3_Srobovanie.SkrutSet_K40.OUT.Brzda.NastrelenieSkrutky;
	
	//41-48
	P3_Pracovisko.COM_VentilovyTerminal[5].0 := P3_Srobovanie.SkrutSet_M5.OUT.ZhadzovaciVzduch_RUN;
	P3_Pracovisko.COM_VentilovyTerminal[5].1 := P3_Srobovanie.SkrutSet_M5.OUT.TriediaciVzduch_RUN;
	P3_Pracovisko.COM_VentilovyTerminal[5].2 := P3_Srobovanie.SkrutSet_M5.OUT.OtocPodavac_NaVystup;
	P3_Pracovisko.COM_VentilovyTerminal[5].3 := P3_Srobovanie.SkrutSet_M5.OUT.OtocPodavac_NaVstup;
	P3_Pracovisko.COM_VentilovyTerminal[5].4 := P3_HV_Test.OUT.PritlacenieKontaktovTestera_ON;
	P3_Pracovisko.COM_VentilovyTerminal[5].5;
	P3_Pracovisko.COM_VentilovyTerminal[5].6 := P3_StoperSrobovania.OUT.Centrovanie_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[5].7 := P3_StoperSrobovania.OUT.Centrovanie_ZASUN;
	
	//49-56
	P3_Pracovisko.COM_VentilovyTerminal[6].0 := P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[6].1;
	P3_Pracovisko.COM_VentilovyTerminal[6].2 := P3_HV_Test.OUT.Centrovanie_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[6].3 := P3_HV_Test.OUT.Centrovanie_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[6].4 := P3_HV_Test.OUT.SpodneKontakty_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[6].5 := P3_HV_Test.OUT.SpodneKontakty_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[6].6 := P3_HV_Test.OUT.HorneKontakty_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[6].7 := P3_HV_Test.OUT.HorneKontakty_ZASUN;
	
	
	//57-64
	P3_Pracovisko.COM_VentilovyTerminal[7].0 := P3_HV_Test.OUT.PruzenieHornychKontaktov_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[7].1 := P3_HV_Test.OUT.PruzenieHornychKontaktov_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[7].2;
	P3_Pracovisko.COM_VentilovyTerminal[7].3;
	P3_Pracovisko.COM_VentilovyTerminal[7].4;
	P3_Pracovisko.COM_VentilovyTerminal[7].5;
	P3_Pracovisko.COM_VentilovyTerminal[7].6 := P3_LeakageTestA.OUT.Kopito_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[7].7 := P3_LeakageTestA.OUT.Kopito_ZASUN;
	
	
	//65-72
	P3_Pracovisko.COM_VentilovyTerminal[8].0 := P3_LeakageTestA.OUT.Centrovanie_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[8].1;
	P3_Pracovisko.COM_VentilovyTerminal[8].2 := P3_LeakageTestA.OUT.Centrovanie_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[8].3 := P3_LeakageTestA.OUT.PneuZamok_ODOMKNI;
	P3_Pracovisko.COM_VentilovyTerminal[8].4 := P3_LeakageTestA.OUT.HornyPritlak_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[8].5 := P3_LeakageTestA.OUT.HornyPritlak_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[8].6 := P3_LeakageTestB.OUT.Kopito_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[8].7 := P3_LeakageTestB.OUT.Kopito_ZASUN;
	
	
	//73-80
	P3_Pracovisko.COM_VentilovyTerminal[9].0 := P3_LeakageTestB.OUT.Centrovanie_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[9].1;
	P3_Pracovisko.COM_VentilovyTerminal[9].2 := P3_LeakageTestB.OUT.Centrovanie_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[9].3 := P3_LeakageTestB.OUT.PneuZamok_ODOMKNI;
	P3_Pracovisko.COM_VentilovyTerminal[9].4 := P3_LeakageTestB.OUT.HornyPritlak_VYSUN;
	P3_Pracovisko.COM_VentilovyTerminal[9].5 := P3_LeakageTestB.OUT.HornyPritlak_ZASUN;
	P3_Pracovisko.COM_VentilovyTerminal[9].6;
	P3_Pracovisko.COM_VentilovyTerminal[9].7;
	
	
	
	
	
	//Volanie knižníc//
	P3_Srobovanie.SkrutSet_K40(); 
	P3_Srobovanie.SkrutSet_M5(); 

	
	
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

