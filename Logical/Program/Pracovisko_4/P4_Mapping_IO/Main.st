
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//**********************************************************IO modul Wedmuller**********************************************************************//
	//************Karta AB 4.2 8DI**************//
	P4_Etiketovacka.IN.NapajanieTlaciarne_OK := P4_Pracovisko.COM_Weidmuller.AB4_2_8DI.0;
	P4_Vytah.IN.StavRiadeniaDopravVytahu_READY := P4_Pracovisko.COM_Weidmuller.AB4_2_8DI.1;
	P4_Dopravniky.IN.StavRiadPredDopravBunky_READY := P4_Pracovisko.COM_Weidmuller.AB4_2_8DI.2;
	P4_Dopravniky.IN.StavRiadeniaPriecnDoprav_READY := P4_Pracovisko.COM_Weidmuller.AB4_2_8DI.3;
	P4_Dopravniky.IN.StavRiadZadnDopravBunky_READY := P4_Pracovisko.COM_Weidmuller.AB4_2_8DI.4;
	P4_Dopravniky.IN.StavRiadeniaVratnehoDoprav_READY := P4_Pracovisko.COM_Weidmuller.AB4_2_8DI.5;
	P4_Vytah.IN.TeplotaMotoraDopravVytahu_OK := P4_Pracovisko.COM_Weidmuller.AB4_2_8DI.6;
	P4_Dopravniky.IN.TeplotaMotoraPredDopravBunky_OK := P4_Pracovisko.COM_Weidmuller.AB4_2_8DI.7;
	
	
	
	//************Karta AB 4.3 8DI**************//
	P4_Dopravniky.IN.TeplotaMotoraPriecnDoprav_OK := P4_Pracovisko.COM_Weidmuller.AB4_3_8DI.0;
	P4_Dopravniky.IN.TeplotaMotoraZadnDopravBunky_OK := P4_Pracovisko.COM_Weidmuller.AB4_3_8DI.1;
	P4_Dopravniky.IN.TeplotaMotoraVratnehoDoprav_OK :=  P4_Pracovisko.COM_Weidmuller.AB4_3_8DI.2;
	P4_Pracovisko.COM_Weidmuller.AB4_3_8DI.3;
	P4_Pracovisko.COM_Weidmuller.AB4_3_8DI.4;
	P4_Pracovisko.COM_Weidmuller.AB4_3_8DI.5;
	Safety.IN.Linka_SV_ZonaCS := P4_Pracovisko.COM_Weidmuller.AB4_3_8DI.6;
	Safety.IN.P4_SV_ZonaBunky := P4_Pracovisko.COM_Weidmuller.AB4_3_8DI.7;
	
	
	//************Karta AB 4.4 8DI**************//
	Safety.IN.P4_SV_ZonaVytahu := P4_Pracovisko.COM_Weidmuller.AB4_4_8DI.0;
	Safety.IN.P4_SV_PrivodVzduchu_CH1 := P4_Pracovisko.COM_Weidmuller.AB4_4_8DI.1;
	Safety.IN.P4_SV_PrivodVzduchu_CH2 := P4_Pracovisko.COM_Weidmuller.AB4_4_8DI.2;
	P4_Pracovisko.IN.TlakVzduchu_OK := P4_Pracovisko.COM_Weidmuller.AB4_4_8DI.3;
	P4_Pracovisko.COM_Weidmuller.AB4_4_8DI.4;
	P4_Pracovisko.COM_Weidmuller.AB4_4_8DI.5;
	P4_Pracovisko.COM_Weidmuller.AB4_4_8DI.6;
	P4_Pracovisko.COM_Weidmuller.AB4_4_8DI.7;
	
	
	//************Karta AB 4.5 8DO**************//
	P4_Pracovisko.COM_Weidmuller.AB4_5_8DO.0 := P4_Pracovisko.OUT.Majak_ZeleneSvetlo_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_5_8DO.1 := P4_Pracovisko.OUT.Majak_OranzoveSvetlo_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_5_8DO.2 := P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_5_8DO.3 := P4_Pracovisko.OUT.Majak_Hukacka_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_5_8DO.4;
	P4_Pracovisko.COM_Weidmuller.AB4_5_8DO.5;
	P4_Pracovisko.COM_Weidmuller.AB4_5_8DO.6 := P4_Pracovisko.OUT.Osvetlenie_CAM16_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_5_8DO.7 := P4_Pracovisko.OUT.OsvetlenieBunky_ON;
	
	
	//************Karta AB 4.6 8DO**************//
	P4_Pracovisko.COM_Weidmuller.AB4_6_8DO.0 := P4_Pracovisko.OUT.Osvetlenie_CAM15_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_6_8DO.1 := P4_Vytah.OUT.DopravnikChod_VZAD;
	P4_Pracovisko.COM_Weidmuller.AB4_6_8DO.2 := P4_Vytah.OUT.DopravnikChod_VPRED;
	P4_Pracovisko.COM_Weidmuller.AB4_6_8DO.3 := P4_Dopravniky.OUT.PrednyDopravnikBunky_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_6_8DO.4 := P4_Dopravniky.OUT.PriecnyDopravnik_VPRED;
	P4_Pracovisko.COM_Weidmuller.AB4_6_8DO.5 := P4_Dopravniky.OUT.ZadnyDopravnikBunky_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_6_8DO.6 := P4_Dopravniky.OUT.VratnyDopravnik_ON;
	P4_Pracovisko.COM_Weidmuller.AB4_6_8DO.7 := Safety.OUT.Linka_ResetCS;
	
	
	//************Karta AB 4.8 8DO**************//
	P4_Pracovisko.COM_Weidmuller.AB4_8_8DO.0:= Safety.OUT.P4_ResetZonyBunky;
	P4_Pracovisko.COM_Weidmuller.AB4_8_8DO.1:= Safety.OUT.P4_ResetZonyVytahu;
	P4_Pracovisko.COM_Weidmuller.AB4_8_8DO.2;
	P4_Pracovisko.COM_Weidmuller.AB4_8_8DO.3;
	P4_Pracovisko.COM_Weidmuller.AB4_8_8DO.4;
	P4_Pracovisko.COM_Weidmuller.AB4_8_8DO.5;
	P4_Pracovisko.COM_Weidmuller.AB4_8_8DO.6;
	P4_Pracovisko.COM_Weidmuller.AB4_8_8DO.7;
	
	
	
	
	//**************************************************************IO modul Festo**********************************************************************************//
	
	//**********Modul DM 4.1 4DI4DO**************//
	//Inputs//
	P4_Pracovisko.IN.PredneDvere_PritomnostAdaptera := P4_Pracovisko.COM_Festo.DM4_1_4DI[0];
	P4_Pracovisko.IN.ZadneDvere_PritomnostAdaptera := P4_Pracovisko.COM_Festo.DM4_1_4DI[1];
	P4_ZdvizkaZaFunkcTestA.IN.TlmicPaletky_ZASUNUTY := P4_Pracovisko.COM_Festo.DM4_1_4DI[2];
	P4_Vytah.IN.PrechodDopravnika := P4_Pracovisko.COM_Festo.DM4_1_4DI[3];
	
	//Outputs//
	P4_Pracovisko.COM_Festo.DM4_1_4DO[0] := P4_Pracovisko.OUT.PredneDvere_ZAMKNI;
	P4_Pracovisko.COM_Festo.DM4_1_4DO[1] := P4_Pracovisko.OUT.ZadneDvere_ZAMKNI;
	P4_Pracovisko.COM_Festo.DM4_1_4DO[2];
	P4_Pracovisko.COM_Festo.DM4_1_4DO[3];
	
	
	
	//***********Modul DI 4.1 8DI****************//
	P4_FunkcnyTestA.IN.TypSpodnychKontaktov_5F_5H:= P4_Pracovisko.COM_Festo.DI4_1_8DI[0];
	P4_FunkcnyTestA.IN.TypSpodnychKontaktov_4F:= P4_Pracovisko.COM_Festo.DI4_1_8DI[1];
	P4_FunkcnyTestB.IN.TypSpodnychKontaktov_5F_5H:= P4_Pracovisko.COM_Festo.DI4_1_8DI[2];
	P4_FunkcnyTestB.IN.TypSpodnychKontaktov_4F:= P4_Pracovisko.COM_Festo.DI4_1_8DI[3];
	P4_Etiketovacka.IN.Centrovanie_ZASUNUTE := P4_Pracovisko.COM_Festo.DI4_1_8DI[4];
	P4_Etiketovacka.IN.Centrovanie_VYSUNUTE := P4_Pracovisko.COM_Festo.DI4_1_8DI[5];
	P4_SpodnyStoper.IN.ZaplnenieDopravnika := P4_Pracovisko.COM_Festo.DI4_1_8DI[6];
	P4_SpodnyStoper.IN.PritomnostPaletky := P4_Pracovisko.COM_Festo.DI4_1_8DI[7];
	
	
	
	//***********Modul DI 4.2 8DI****************//
	P4_Etiketovacka.IN.Aplikator_OtocenyVPRED := P4_Pracovisko.COM_Festo.DI4_2_8DI[0];
	P4_Etiketovacka.IN.Aplikator_OtocenyVZAD := P4_Pracovisko.COM_Festo.DI4_2_8DI[1];
	P4_Etiketovacka.IN.Aplikator_ZASUNUTY := P4_Pracovisko.COM_Festo.DI4_2_8DI[2];
	P4_Etiketovacka.IN.Aplikator_VYSUNUTY := P4_Pracovisko.COM_Festo.DI4_2_8DI[3];
	P4_Etiketovacka.IN.PritlakPowerCP_ZASUNUTY := P4_Pracovisko.COM_Festo.DI4_2_8DI[4];
	P4_Etiketovacka.IN.PritlakPowerCP_VYSUNUTY_45F := P4_Pracovisko.COM_Festo.DI4_2_8DI[5];
	P4_Etiketovacka.IN.PrisavanieEtikety_Vakum_OK := P4_Pracovisko.COM_Festo.DI4_2_8DI[6];
	P4_Etiketovacka.IN.PritlakPowerCP_VYSUNUTY_5H := P4_Pracovisko.COM_Festo.DI4_2_8DI[7];
	
	
	//***********Modul DI 4.3 8DI****************//
	P4_FunkcnyTestA.IN.HorneKontakty_VYSUNUTE := P4_Pracovisko.COM_Festo.DI4_3_8DI[0];
	P4_FunkcnyTestA.IN.HorneKontakty_ZASUNUTE := P4_Pracovisko.COM_Festo.DI4_3_8DI[1];
	P4_FunkcnyTestA.IN.Centrovanie_ZASUNUTE := P4_Pracovisko.COM_Festo.DI4_3_8DI[2];
	P4_FunkcnyTestA.IN.Centrovanie_VYSUNUTE := P4_Pracovisko.COM_Festo.DI4_3_8DI[3];
	P4_FunkcnyTestA.IN.SpodneKontakty_ZASUNUTE := P4_Pracovisko.COM_Festo.DI4_3_8DI[4];
	P4_FunkcnyTestA.IN.SpodneKontakty_VYSUNUTE := P4_Pracovisko.COM_Festo.DI4_3_8DI[5];
	P4_Pracovisko.COM_Festo.DI4_3_8DI[6];
	P4_Pracovisko.COM_Festo.DI4_3_8DI[7];
	
	//***********Modul DI 4.4 8DI****************//
	P4_FunkcnyTestB.IN.HorneKontakty_VYSUNUTE := P4_Pracovisko.COM_Festo.DI4_4_8DI[0];
	P4_FunkcnyTestB.IN.HorneKontakty_ZASUNUTE := P4_Pracovisko.COM_Festo.DI4_4_8DI[1];
	P4_FunkcnyTestB.IN.Centrovanie_ZASUNUTE := P4_Pracovisko.COM_Festo.DI4_4_8DI[2];
	P4_FunkcnyTestB.IN.Centrovanie_VYSUNUTE := P4_Pracovisko.COM_Festo.DI4_4_8DI[3];
	P4_FunkcnyTestB.IN.SpodneKontakty_ZASUNUTE := P4_Pracovisko.COM_Festo.DI4_4_8DI[4];
	P4_FunkcnyTestB.IN.SpodneKontakty_VYSUNUTE := P4_Pracovisko.COM_Festo.DI4_4_8DI[5];
	P4_Pracovisko.COM_Festo.DI4_4_8DI[6];
	P4_Pracovisko.COM_Festo.DI4_4_8DI[7];
	
	
	
	//***********Modul DI 4.5 8DI****************//
	P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_HornaPoloha := P4_Pracovisko.COM_Festo.DI4_5_8DI[0];
	P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_SpodnaPoloha := P4_Pracovisko.COM_Festo.DI4_5_8DI[1];
	P4_ZdvizkaZaFunkcTestA.IN.PoziciaPaletky_OK := P4_Pracovisko.COM_Festo.DI4_5_8DI[2];
	P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_StrednaPoloha := P4_Pracovisko.COM_Festo.DI4_5_8DI[3];
	P4_ZdvizkaZaFunkcTestB.IN.PritomnostPaletky := P4_Pracovisko.COM_Festo.DI4_5_8DI[4];
	P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky := P4_Pracovisko.COM_Festo.DI4_5_8DI[5];
	P4_ZdvizkaZaFunkcTestB.IN.Zdvizka_StrednaPoloha := P4_Pracovisko.COM_Festo.DI4_5_8DI[6];
	P4_ZdvizkaZaFunkcTestB.IN.Zdvizka_HornaPoloha := P4_Pracovisko.COM_Festo.DI4_5_8DI[7];
	
	
	
	
	//********Modul DS 4.1 IO link Port 0 - RFID snÌmaË paletky funkËn˝ test A**************//
	//Inputs//
	P4_FunkcnyTestA.RFID_hlava.Mapping_IN[0]:= P4_Pracovisko.COM_Festo.DS4_1_Port0_IN[0];
	P4_FunkcnyTestA.RFID_hlava.Mapping_IN[1]:= P4_Pracovisko.COM_Festo.DS4_1_Port0_IN[1];
	P4_FunkcnyTestA.RFID_hlava.Mapping_IN[2]:= P4_Pracovisko.COM_Festo.DS4_1_Port0_IN[2];
	P4_FunkcnyTestA.RFID_hlava.Mapping_IN[3]:= P4_Pracovisko.COM_Festo.DS4_1_Port0_IN[3];
	P4_FunkcnyTestA.RFID_hlava.Mapping_IN[4]:= P4_Pracovisko.COM_Festo.DS4_1_Port0_IN[4];
	P4_FunkcnyTestA.RFID_hlava.Mapping_IN[5]:= P4_Pracovisko.COM_Festo.DS4_1_Port0_IN[5];
	P4_FunkcnyTestA.RFID_hlava.Mapping_IN[6]:= P4_Pracovisko.COM_Festo.DS4_1_Port0_IN[6];
	P4_FunkcnyTestA.RFID_hlava.Mapping_IN[7]:= P4_Pracovisko.COM_Festo.DS4_1_Port0_IN[7];
	
	//Outputs//
	P4_Pracovisko.COM_Festo.DS4_1_Port0_OUT[0]:= P4_FunkcnyTestA.RFID_hlava.Mapping_OUT[0];
	P4_Pracovisko.COM_Festo.DS4_1_Port0_OUT[1]:= P4_FunkcnyTestA.RFID_hlava.Mapping_OUT[1];
	P4_Pracovisko.COM_Festo.DS4_1_Port0_OUT[2]:= P4_FunkcnyTestA.RFID_hlava.Mapping_OUT[2];
	P4_Pracovisko.COM_Festo.DS4_1_Port0_OUT[3]:= P4_FunkcnyTestA.RFID_hlava.Mapping_OUT[3];
	P4_Pracovisko.COM_Festo.DS4_1_Port0_OUT[4]:= P4_FunkcnyTestA.RFID_hlava.Mapping_OUT[4];
	P4_Pracovisko.COM_Festo.DS4_1_Port0_OUT[5]:= P4_FunkcnyTestA.RFID_hlava.Mapping_OUT[5];
	P4_Pracovisko.COM_Festo.DS4_1_Port0_OUT[6]:= P4_FunkcnyTestA.RFID_hlava.Mapping_OUT[6];
	P4_Pracovisko.COM_Festo.DS4_1_Port0_OUT[7]:= P4_FunkcnyTestA.RFID_hlava.Mapping_OUT[7];
	
	
	//********Modul DS 4.1 IO link Port 1 - RFID snÌmaË paletky funkËn˝ test B**************//
	//Inputs//
	P4_FunkcnyTestB.RFID_hlava.Mapping_IN[0]:= P4_Pracovisko.COM_Festo.DS4_1_Port1_IN[0];
	P4_FunkcnyTestB.RFID_hlava.Mapping_IN[1]:= P4_Pracovisko.COM_Festo.DS4_1_Port1_IN[1];
	P4_FunkcnyTestB.RFID_hlava.Mapping_IN[2]:= P4_Pracovisko.COM_Festo.DS4_1_Port1_IN[2];
	P4_FunkcnyTestB.RFID_hlava.Mapping_IN[3]:= P4_Pracovisko.COM_Festo.DS4_1_Port1_IN[3];
	P4_FunkcnyTestB.RFID_hlava.Mapping_IN[4]:= P4_Pracovisko.COM_Festo.DS4_1_Port1_IN[4];
	P4_FunkcnyTestB.RFID_hlava.Mapping_IN[5]:= P4_Pracovisko.COM_Festo.DS4_1_Port1_IN[5];
	P4_FunkcnyTestB.RFID_hlava.Mapping_IN[6]:= P4_Pracovisko.COM_Festo.DS4_1_Port1_IN[6];
	P4_FunkcnyTestB.RFID_hlava.Mapping_IN[7]:= P4_Pracovisko.COM_Festo.DS4_1_Port1_IN[7];
	
	//Outputs//
	P4_Pracovisko.COM_Festo.DS4_1_Port1_OUT[0]:= P4_FunkcnyTestB.RFID_hlava.Mapping_OUT[0];
	P4_Pracovisko.COM_Festo.DS4_1_Port1_OUT[1]:= P4_FunkcnyTestB.RFID_hlava.Mapping_OUT[1];
	P4_Pracovisko.COM_Festo.DS4_1_Port1_OUT[2]:= P4_FunkcnyTestB.RFID_hlava.Mapping_OUT[2];
	P4_Pracovisko.COM_Festo.DS4_1_Port1_OUT[3]:= P4_FunkcnyTestB.RFID_hlava.Mapping_OUT[3];
	P4_Pracovisko.COM_Festo.DS4_1_Port1_OUT[4]:= P4_FunkcnyTestB.RFID_hlava.Mapping_OUT[4];
	P4_Pracovisko.COM_Festo.DS4_1_Port1_OUT[5]:= P4_FunkcnyTestB.RFID_hlava.Mapping_OUT[5];
	P4_Pracovisko.COM_Festo.DS4_1_Port1_OUT[6]:= P4_FunkcnyTestB.RFID_hlava.Mapping_OUT[6];
	P4_Pracovisko.COM_Festo.DS4_1_Port1_OUT[7]:= P4_FunkcnyTestB.RFID_hlava.Mapping_OUT[7];
	
	
	//********Modul DS 4.1 IO link Port 2 - RFID snÌmaË paletky etiketovanie**************//
	//Inputs//
	P4_Etiketovacka.RFID_hlava.Mapping_IN[0]:= P4_Pracovisko.COM_Festo.DS4_1_Port2_IN[0];
	P4_Etiketovacka.RFID_hlava.Mapping_IN[1]:= P4_Pracovisko.COM_Festo.DS4_1_Port2_IN[1];
	P4_Etiketovacka.RFID_hlava.Mapping_IN[2]:= P4_Pracovisko.COM_Festo.DS4_1_Port2_IN[2];
	P4_Etiketovacka.RFID_hlava.Mapping_IN[3]:= P4_Pracovisko.COM_Festo.DS4_1_Port2_IN[3];
	P4_Etiketovacka.RFID_hlava.Mapping_IN[4]:= P4_Pracovisko.COM_Festo.DS4_1_Port2_IN[4];
	P4_Etiketovacka.RFID_hlava.Mapping_IN[5]:= P4_Pracovisko.COM_Festo.DS4_1_Port2_IN[5];
	P4_Etiketovacka.RFID_hlava.Mapping_IN[6]:= P4_Pracovisko.COM_Festo.DS4_1_Port2_IN[6];
	P4_Etiketovacka.RFID_hlava.Mapping_IN[7]:= P4_Pracovisko.COM_Festo.DS4_1_Port2_IN[7];
	
	//Outputs//
	P4_Pracovisko.COM_Festo.DS4_1_Port2_OUT[0]:= P4_Etiketovacka.RFID_hlava.Mapping_OUT[0];
	P4_Pracovisko.COM_Festo.DS4_1_Port2_OUT[1]:= P4_Etiketovacka.RFID_hlava.Mapping_OUT[1];
	P4_Pracovisko.COM_Festo.DS4_1_Port2_OUT[2]:= P4_Etiketovacka.RFID_hlava.Mapping_OUT[2];
	P4_Pracovisko.COM_Festo.DS4_1_Port2_OUT[3]:= P4_Etiketovacka.RFID_hlava.Mapping_OUT[3];
	P4_Pracovisko.COM_Festo.DS4_1_Port2_OUT[4]:= P4_Etiketovacka.RFID_hlava.Mapping_OUT[4];
	P4_Pracovisko.COM_Festo.DS4_1_Port2_OUT[5]:= P4_Etiketovacka.RFID_hlava.Mapping_OUT[5];
	P4_Pracovisko.COM_Festo.DS4_1_Port2_OUT[6]:= P4_Etiketovacka.RFID_hlava.Mapping_OUT[6];
	P4_Pracovisko.COM_Festo.DS4_1_Port2_OUT[7]:= P4_Etiketovacka.RFID_hlava.Mapping_OUT[7];
	
	
	
	//*************Modul DS 4.2 IO link Port 0 - Banner*********************//
	//Inputs//
	P4_Vytah.Banner.Mapping_IN[0]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[0];
	P4_Vytah.Banner.Mapping_IN[1]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[1];
	P4_Vytah.Banner.Mapping_IN[2]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[2];
	P4_Vytah.Banner.Mapping_IN[3]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[3];
	P4_Vytah.Banner.Mapping_IN[4]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[4];
	P4_Vytah.Banner.Mapping_IN[5]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[5];
	P4_Vytah.Banner.Mapping_IN[6]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[6];
	P4_Vytah.Banner.Mapping_IN[7]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[7];
	P4_Vytah.Banner.Mapping_IN[8]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[8];
	P4_Vytah.Banner.Mapping_IN[9]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[9];
	P4_Vytah.Banner.Mapping_IN[10]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[10];
	P4_Vytah.Banner.Mapping_IN[11]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[11];
	P4_Vytah.Banner.Mapping_IN[12]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[12];
	P4_Vytah.Banner.Mapping_IN[13]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[13];
	P4_Vytah.Banner.Mapping_IN[14]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[14];
	P4_Vytah.Banner.Mapping_IN[15]:= P4_Pracovisko.COM_Festo.DS4_2_Port0_IN[15];
	
	//Outputs//
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[0]:= P4_Vytah.Banner.Mapping_OUT[0];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[1]:= P4_Vytah.Banner.Mapping_OUT[1];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[2]:= P4_Vytah.Banner.Mapping_OUT[2];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[3]:= P4_Vytah.Banner.Mapping_OUT[3];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[4]:= P4_Vytah.Banner.Mapping_OUT[4];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[5]:= P4_Vytah.Banner.Mapping_OUT[5];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[6]:= P4_Vytah.Banner.Mapping_OUT[6];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[7]:= P4_Vytah.Banner.Mapping_OUT[7];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[8]:= P4_Vytah.Banner.Mapping_OUT[8];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[9]:= P4_Vytah.Banner.Mapping_OUT[9];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[10]:= P4_Vytah.Banner.Mapping_OUT[10];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[11]:= P4_Vytah.Banner.Mapping_OUT[11];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[12]:= P4_Vytah.Banner.Mapping_OUT[12];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[13]:= P4_Vytah.Banner.Mapping_OUT[13];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[14]:= P4_Vytah.Banner.Mapping_OUT[14];
	P4_Pracovisko.COM_Festo.DS4_2_Port0_OUT[15]:= P4_Vytah.Banner.Mapping_OUT[15];
	
	
	//********Modul DS 4.2 IO link Port 1 - RFID snÌmaË paletky v˝stupn˝ v˝ùah**************//
	//Inputs//
	P4_Vytah.RFID_hlava.Mapping_IN[0]:= P4_Pracovisko.COM_Festo.DS4_2_Port1_IN[0];
	P4_Vytah.RFID_hlava.Mapping_IN[1]:= P4_Pracovisko.COM_Festo.DS4_2_Port1_IN[1];
	P4_Vytah.RFID_hlava.Mapping_IN[2]:= P4_Pracovisko.COM_Festo.DS4_2_Port1_IN[2];
	P4_Vytah.RFID_hlava.Mapping_IN[3]:= P4_Pracovisko.COM_Festo.DS4_2_Port1_IN[3];
	P4_Vytah.RFID_hlava.Mapping_IN[4]:= P4_Pracovisko.COM_Festo.DS4_2_Port1_IN[4];
	P4_Vytah.RFID_hlava.Mapping_IN[5]:= P4_Pracovisko.COM_Festo.DS4_2_Port1_IN[5];
	P4_Vytah.RFID_hlava.Mapping_IN[6]:= P4_Pracovisko.COM_Festo.DS4_2_Port1_IN[6];
	P4_Vytah.RFID_hlava.Mapping_IN[7]:= P4_Pracovisko.COM_Festo.DS4_2_Port1_IN[7];
	
	//Outputs//
	P4_Pracovisko.COM_Festo.DS4_2_Port1_OUT[0]:= P4_Vytah.RFID_hlava.Mapping_OUT[0];
	P4_Pracovisko.COM_Festo.DS4_2_Port1_OUT[1]:= P4_Vytah.RFID_hlava.Mapping_OUT[1];
	P4_Pracovisko.COM_Festo.DS4_2_Port1_OUT[2]:= P4_Vytah.RFID_hlava.Mapping_OUT[2];
	P4_Pracovisko.COM_Festo.DS4_2_Port1_OUT[3]:= P4_Vytah.RFID_hlava.Mapping_OUT[3];
	P4_Pracovisko.COM_Festo.DS4_2_Port1_OUT[4]:= P4_Vytah.RFID_hlava.Mapping_OUT[4];
	P4_Pracovisko.COM_Festo.DS4_2_Port1_OUT[5]:= P4_Vytah.RFID_hlava.Mapping_OUT[5];
	P4_Pracovisko.COM_Festo.DS4_2_Port1_OUT[6]:= P4_Vytah.RFID_hlava.Mapping_OUT[6];
	P4_Pracovisko.COM_Festo.DS4_2_Port1_OUT[7]:= P4_Vytah.RFID_hlava.Mapping_OUT[7];
	
	
	//************************************Ventilov˝ termin·l*******************************************//
	//0-7
	P4_Pracovisko.COM_VentilovyTerminal[0].0 := P4_Etiketovacka.OUT.PrisavanieEtikety_ON;
	P4_Pracovisko.COM_VentilovyTerminal[0].1 := P4_Etiketovacka.OUT.PrisavanieEtikety_OFF;
	P4_Pracovisko.COM_VentilovyTerminal[0].2 := P4_FunkcnyTestA.OUT.ZasunStoper;
	P4_Pracovisko.COM_VentilovyTerminal[0].3 := P4_FunkcnyTestB.OUT.ZasunStoper;
	P4_Pracovisko.COM_VentilovyTerminal[0].4 := P4_ZdvizkaZaFunkcTestA.OUT.Zdvizku_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[0].5 := P4_ZdvizkaZaFunkcTestA.OUT.Zdvizku_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[0].6 := P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[0].7 := P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN;
	
	//8-15
	P4_Pracovisko.COM_VentilovyTerminal[1].0 := P4_ZdvizkaZaFunkcTestB.OUT.Zdvizku_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[1].1 := P4_Pracovisko.OUT.ZdvizkyPneuZamok_ODOMKNI;
	P4_Pracovisko.COM_VentilovyTerminal[1].2 := P4_ZdvizkaZaFunkcTestB.OUT.TlmicPaletky_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[1].3 := P4_Etiketovacka.OUT.ZasunStoper;
	P4_Pracovisko.COM_VentilovyTerminal[1].4 := P4_SpodnyStoper.OUT.ZasunStoper;
	P4_Pracovisko.COM_VentilovyTerminal[1].5;
	P4_Pracovisko.COM_VentilovyTerminal[1].6 := P4_FunkcnyTestA.OUT.PritlakPowerCP_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[1].7;
	
	//16-23
	P4_Pracovisko.COM_VentilovyTerminal[2].0 := P4_FunkcnyTestB.OUT.PritlakPowerCP_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[2].1;
	P4_Pracovisko.COM_VentilovyTerminal[2].2 := P4_FunkcnyTestA.OUT.KontaktyTestera_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[2].3 := P4_FunkcnyTestB.OUT.KontaktyTestera_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[2].4 := P4_Etiketovacka.OUT.OfukEtikety_ON;
	P4_Pracovisko.COM_VentilovyTerminal[2].5;
	P4_Pracovisko.COM_VentilovyTerminal[2].6 := P4_Etiketovacka.OUT.Aplikator_OtocVPRED;
	P4_Pracovisko.COM_VentilovyTerminal[2].7 := P4_Etiketovacka.OUT.Aplikator_OtocVZAD;
	
	//24-31
	P4_Pracovisko.COM_VentilovyTerminal[3].0 := P4_Etiketovacka.OUT.Aplikator_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[3].1;
	P4_Pracovisko.COM_VentilovyTerminal[3].2 := P4_Etiketovacka.OUT.PritlakPowerCP_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[3].3;
	P4_Pracovisko.COM_VentilovyTerminal[3].4;
	P4_Pracovisko.COM_VentilovyTerminal[3].5;
	P4_Pracovisko.COM_VentilovyTerminal[3].6 := P4_FunkcnyTestA.OUT.HorneKontakty_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[3].7 := P4_FunkcnyTestA.OUT.HorneKontakty_VYSUN;
	
	//32-39
	P4_Pracovisko.COM_VentilovyTerminal[4].0 := P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[4].1 := P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[4].2 := P4_FunkcnyTestA.OUT.Centrovanie_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[4].3 := P4_FunkcnyTestA.OUT.Centrovanie_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[4].4 := P4_FunkcnyTestA.OUT.SpodneKontakty_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[4].5 := P4_FunkcnyTestA.OUT.SpodneKontakty_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[4].6 := P4_FunkcnyTestB.OUT.HorneKontakty_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[4].7 := P4_FunkcnyTestB.OUT.HorneKontakty_VYSUN;
	
	//40-47
	P4_Pracovisko.COM_VentilovyTerminal[5].0 := P4_FunkcnyTestB.OUT.OdpruzHornychKontaktov_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[5].1 := P4_FunkcnyTestB.OUT.OdpruzHornychKontaktov_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[5].2 := P4_FunkcnyTestB.OUT.Centrovanie_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[5].3 := P4_FunkcnyTestB.OUT.Centrovanie_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[5].4 := P4_FunkcnyTestB.OUT.SpodneKontakty_ZASUN;
	P4_Pracovisko.COM_VentilovyTerminal[5].5 := P4_FunkcnyTestB.OUT.SpodneKontakty_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[5].6 := P4_Etiketovacka.OUT.Centrovanie_VYSUN;
	P4_Pracovisko.COM_VentilovyTerminal[5].7 := P4_Etiketovacka.OUT.Centrovanie_ZASUN;
	
	//48-55
	P4_Pracovisko.COM_VentilovyTerminal[6].0;
	P4_Pracovisko.COM_VentilovyTerminal[6].1;
	P4_Pracovisko.COM_VentilovyTerminal[6].2;
	P4_Pracovisko.COM_VentilovyTerminal[6].3;
	P4_Pracovisko.COM_VentilovyTerminal[6].4;
	P4_Pracovisko.COM_VentilovyTerminal[6].5;
	P4_Pracovisko.COM_VentilovyTerminal[6].6;
	P4_Pracovisko.COM_VentilovyTerminal[6].7;
	
	
	
	
	
	
	
	//Volanie kniûnÌc//
	P4_Etiketovacka.ServoZdvihuAplikatora();
	P4_Vytah.ServoZdvihuVytahu();
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

