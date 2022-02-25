(********************************************************************
 * COPYRIGHT -- Microsoft
 ********************************************************************
 * File: Global.typ
 * Author: Martin
 * Created: February 11, 2016
 ********************************************************************
 * Global data types of project Zamazat_1
 ********************************************************************)
(*************Vizualizacia******************************)

TYPE
	P1_Vizu_typ : 	STRUCT 
		ActualPage : STRING[80];
		GoPage : STRING[80] := 'PageBootP1';
		TL_ResetCS : BOOL;
		TL_RezimAutomat : BOOL;
		ZobrazHL1_ST1 : BOOL; (*ST1 - Ch˝baj˙ci material na paletke 4F*)
		ZobrazHL2_ST1 : BOOL; (*ST1 - Ch˝baj˙ci material na paletke 5F*)
		ZobrazHL3_ST1 : BOOL; (*ST1 - Ch˝baj˙ci material na paletke 5H*)
		ZobrazHL4_ST1 : BOOL; (*ST1 - Zl˝ alebo nepreËÌtan˝ QR kÛd na Power CP*)
		ZobrazHL5_ST1 : BOOL; (*ST1 - Zle zacvaknutÈ alebo ch˝baj˙ce piny DPS*)
		ZobrazHL6_ST1 : BOOL; (*ST1 - Zl˝ alebo nepreËÌtan˝ QR kÛd DPS*)
		ZobrazHL7_ST1 : BOOL; (*ST1 - Nespr·vny QR kÛd Power CP*)
		ZobrazHL8_ST1 : BOOL; (*ST1 - Nespr·vny QR kÛd DPS*)
		ZobrazHL9_ST1 : BOOL; (*ST1 - Odpoved systemu tracebility je NG*)
		ZobrazHL10_ST1 : BOOL;
		ZobrazHL11_ST1 : BOOL;
		ZobrazHL12_ST1 : BOOL;
		ZobrazHL13_ST1 : BOOL;
		ZobrazHL14_ST1 : BOOL; (*ST1 - Nieje prihl·sen˝ oper·tor*)
		ZobrazHL1_ST2 : BOOL;
		ZobrazHL2_ST2 : BOOL;
		ZobrazHL3_ST2 : BOOL;
		ZobrazHL4_ST2 : BOOL;
		ZobrazHL5_ST2 : BOOL;
		ZobrazHL6_ST2 : BOOL;
		ZobrazHL7_ST2 : BOOL;
		ZobrazHL8_ST2 : BOOL;
		ZobrazHL9_ST2 : BOOL; (*ST2 - Odpoved panatrace NG*)
		TL_PrednyZamok_Farba : WSTRING[80];
		TL_ZadnyZamokPS_Farba : WSTRING[80];
		TL_ZadnyZamokLS_Farba : WSTRING[80];
		TL_ZamkniPrednyZamok : BOOL;
		TL_ZamkniZadnyZamokPS : BOOL;
		TL_ZamkniZadnyZamokLS : BOOL;
		TL_StartAutomat_ENABLE : BOOL;
		TL_KoniecCyklu_ENABLE : BOOL;
		TL_Uzivatelia_ENABLE : BOOL;
		TL_STOP_ENABLE : BOOL;
		TL_VyprazdnenieLinky_ENABLE : BOOL;
		TL_RezimAutomat_ENABLE : BOOL;
		TL_RezimManual_ENABLE : BOOL;
		TL_OvladaniaZamkov_ENABLE : BOOL;
		TL_VolbaModelu_ENABLE : BOOL;
		TL_PaletkaPrechadza_ENABLE : BOOL;
		TL_TestovaciKus_ENABLE : BOOL;
		TL_Revork_ENABLE : BOOL;
		TL_OvladanieVytahu_ENABLE : BOOL;
		TL_HomingVytahu_ENABLE : BOOL;
		TL_PrihlasenieOperatora_ENABLE : BOOL;
		TL_PrihlasovOperatora_AKTIVNE : BOOL;
		Srobovanie_OvlManipOsX_ENABLE : BOOL;
		Srobovanie_OvlManipOsY_ENABLE : BOOL;
		EditaciaParametrov_ENABLE : BOOL;
		RR_CistenieSkrutkovaciek_ENABLE : BOOL;
		RR_PozicieSkrutiek_ENABLE : BOOL;
		Warnings_Farba : WSTRING[80];
		Warnings_Index : USINT;
		IndexStavu_Dopravnik : USINT;
		IndexStavu_Vytah : USINT;
		IndexStavu_SpodnyStoper : USINT;
		IndexStavu_StoperSrobovania : USINT;
		IndexStavu_Srobovanie : USINT;
		IndexStavu_AkumulacnyStoper : USINT;
		IndexStavu_Robot : USINT;
	END_STRUCT;
	P2_Vizu_typ : 	STRUCT 
		ActualPage : STRING[80];
		GoPage : STRING[80] := 'PageBootP2';
		TL_RezimAutomat : BOOL;
		TL_PrednyZamokPS_Farba : WSTRING[80];
		TL_PrednyZamokLS_Farba : WSTRING[80];
		TL_ZadnyZamokPS_Farba : WSTRING[80];
		TL_ZadnyZamokLS_Farba : WSTRING[80];
		TL_ZamkniPrednyZamokPS : BOOL;
		TL_ZamkniPrednyZamokLS : BOOL;
		TL_ZamkniZadnyZamokPS : BOOL;
		TL_ZamkniZadnyZamokLS : BOOL;
		TL_StartAutomat_ENABLE : BOOL;
		TL_KoniecCyklu_ENABLE : BOOL;
		TL_STOP_ENABLE : BOOL;
		TL_RezimAutomat_ENABLE : BOOL;
		TL_RezimManual_ENABLE : BOOL;
		TL_RRZdvihZaklTesnenia_ENABLE : BOOL;
		TL_RRPojazdZaklTesnenia_ENABLE : BOOL;
		TL_OvladaniaZamkov_ENABLE : BOOL;
		EditaciaParametrov_ENABLE : BOOL;
		ZaklTesnenia_OvlZdvihu_ENABLE : BOOL;
		ZaklTesnenia_OvlZostupu_ENABLE : BOOL;
		ZaklTesnenia_OvlPojazdu_ENABLE : BOOL;
		Srobovanie_OvlManipOsX_ENABLE : BOOL;
		Srobovanie_OvlManipOsY_ENABLE : BOOL;
		Zvaranie_OvlZdvihu_ENABLE : BOOL;
		RR_CistenieSkrutkovaciek_ENABLE : BOOL;
		RR_PozicieSkrutiek_ENABLE : BOOL;
		TL_PrihlasenieOperatora_ENABLE : BOOL;
		TL_PrihlasovOperatora_AKTIVNE : BOOL;
		TL_ResetCS : BOOL;
		Warnings_Farba : WSTRING[80];
		Warnings_Index : USINT;
		StavPracoviska_Index : USINT;
		ZobrazPopUp_0 : BOOL;
		ZobrazPopUp_1 : BOOL;
		ZobrazPopUp_2 : BOOL;
		PopUpButtonYES : BOOL;
		PopUpButtonNO : BOOL;
		ZobrazHL1_ST3 : BOOL; (*ST3 - Ch˝baj˙ci material na paletke 4F *)
		ZobrazHL2_ST3 : BOOL; (*ST3 - Ch˝baj˙ci material na paletke 5F*)
		ZobrazHL3_ST3 : BOOL; (*ST3 - Ch˝baj˙ci material na paletke 5H*)
		ZobrazHL4_ST3 : BOOL; (*ST3 - Skontroluj prÌtomnosù alebo QR kÛd filtra 5H*)
		ZobrazHL5_ST3 : BOOL; (*ST3 - V zakladaËi ch˝ba Power CP !!!*)
		ZobrazHL6_ST3 : BOOL; (*ST3 - V zakladaËi ch˝ba tesnenie !!!*)
		ZobrazHL7_ST3 : BOOL; (*ST3 - Zle zaloûenÈ tesnenie na Power CP*)
		ZobrazHL8_ST3 : BOOL; (*ST3 - Zaloûenie tesnenia je OK, odober Power CP zo zakladaËa *)
		ZobrazHL9_ST3 : BOOL; (*ST3 - Nespr·vny QR kÛd filtra 5H*)
		ZobrazHL10_ST3 : BOOL; (*ST3 - Nespr·vny alebo nepreËÌtan˝ QR kÛd Power CP*)
		ZobrazHL11_ST3 : BOOL; (*ST3 - Odpoved systemu tracebility je NG*)
		ZobrazHL12_ST3 : BOOL; (*ST3 - Oper·tor nieje prihl·sen˝*)
		ZobrazHL13_ST3 : BOOL; (*ST3 - Odpoved panatrace je NG*)
		ZobrazHL14_ST3 : BOOL; (*ST3 - Odober PowerCP z paletky a vloû do öuplÌka*)
		ZobrazHL1_ST4 : BOOL;
		ZobrazHL2_ST4 : BOOL;
		ZobrazHL3_ST4 : BOOL; (*ST4 -Odpoved panatrace je NG*)
		ZobrazHL1_ST5 : BOOL;
		ZobrazHL2_ST5 : BOOL;
		ZobrazHL3_ST5 : BOOL;
		ZobrazHL4_ST5 : BOOL; (*ST5 - Odpoved panatrace je NG*)
		ZobrazHL1_ST6 : BOOL; (*ST3 - Ch˝baj˙ci material na paletke 4F *)
		ZobrazHL2_ST6 : BOOL; (*ST3 - Ch˝baj˙ci material na paletke 5F*)
		ZobrazHL3_ST6 : BOOL; (*ST3 - Ch˝baj˙ci material na paletke 5H*)
		ZobrazHL4_ST6 : BOOL; (*ST3 - Skontroluj prÌtomnosù alebo QR kÛd filtra 5H*)
		ZobrazHL5_ST6 : BOOL; (*ST3 - V zakladaËi ch˝ba Power CP !!!*)
		ZobrazHL6_ST6 : BOOL; (*ST3 - V zakladaËi ch˝ba tesnenie !!!*)
		ZobrazHL7_ST6 : BOOL; (*ST3 - Zle zaloûenÈ tesnenie na Power CP*)
		ZobrazHL8_ST6 : BOOL; (*ST6 - Odpoved panatrace je NG*)
		IndexStavu_Dopravnik : USINT;
		IndexStavu_StoperZakladacaTesn : USINT;
		IndexStavu_ZakladacaTesnenia : USINT;
		IndexStavu_StoperMaticovacky : USINT;
		IndexStavu_StoperSrobovania : USINT;
		IndexStavu_Srobovania : USINT;
		IndexStavu_Robot : USINT;
		IndexStavu_StoperZvarania : USINT;
		IndexStavu_Zvaranie : USINT;
		IndexStavu_Cistenie : USINT;
	END_STRUCT;
	P34_Vizu_typ : 	STRUCT 
		ActualPage : STRING[80];
		GoPage : STRING[80] := 'PageBootP34';
		TL_RezimAutomat : BOOL;
		ZobrazHL1_ST7 : BOOL; (*ST7 - Odpoved panatrace je NG*)
		ZobrazHL1_ST8 : BOOL; (*ST8A - Odpoved panatrace je NG*)
		ZobrazHL2_ST8 : BOOL; (*ST8B - Odpoved panatrace je NG*)
		ZobrazHL1_ST9 : BOOL;
		ZobrazHL2_ST9 : BOOL;
		ZobrazHL3_ST9 : BOOL; (*ST9 - Odpoved panatrace je NG*)
		ZobrazHL1_ST10 : BOOL; (*ST10 - Ch˝baj˙ci material na paletke 4F *)
		ZobrazHL2_ST10 : BOOL; (*ST10 - Ch˝baj˙ci material na paletke 5F*)
		ZobrazHL3_ST10 : BOOL; (*ST10 - Ch˝baj˙ci material na paletke 5H*)
		ZobrazHL4_ST10 : BOOL; (*ST10 - Paletka nieje pr·zdna*)
		ZobrazHL5_ST10 : BOOL; (*ST10 - Paletka nieje pr·zdna*)
		ZobrazHL6_ST10 : BOOL; (*ST10 - Paletka nieje pr·zdna*)
		ZobrazHL7_ST10 : BOOL; (*ST10 - Nieje prihlaseny operator*)
		ZobrazHL8_ST10 : BOOL;
		ZobrazHL9_ST10 : BOOL; (*ST10 - Odpoved panatrace je NG*)
		TL_ResetCS : BOOL;
		IndexStavu_DopravnikP3 : USINT;
		IndexStavu_SpodnyStoperP3 : USINT;
		IndexStavu_VstupnyStoper : USINT;
		IndexStavu_StoperSrobovaniaP3 : USINT;
		IndexStavu_SrobovanieP3 : USINT;
		IndexStavu_AkumulacnyStoperP3 : USINT;
		IndexStavu_StoperLeakageTestA : USINT;
		IndexStavu_StoperLeakageTestB : USINT;
		IndexStavu_DopravnikP4 : USINT;
		IndexStavu_Vytah : USINT;
		IndexStavu_StoperFunkcnyTestA : USINT;
		IndexStavu_StoperFunkcnyTestB : USINT;
		IndexStavu_StoperEtiketovackyP4 : USINT;
		TL_PrednyZamokPS_Farba_P3 : WSTRING[80];
		TL_PrednyZamokLS_Farba_P3 : WSTRING[80];
		TL_ZadnyZamok_Farba_P3 : WSTRING[80];
		TL_ZamkniPrednyZamokPS_P3 : BOOL;
		TL_ZamkniPrednyZamokLS_P3 : BOOL;
		TL_ZamkniZadnyZamok_P3 : BOOL;
		TL_StartAutomat_ENABLE_P3 : BOOL;
		TL_KoniecCyklu_ENABLE_P3 : BOOL;
		TL_STOP_ENABLE_P3 : BOOL;
		TL_RezimAutomat_ENABLE : BOOL;
		TL_RezimManual_ENABLE_P3 : BOOL;
		TL_RezimManual_ENABLE_P4 : BOOL;
		TL_OvladaniaZamkov_ENABLE_P3 : BOOL;
		TL_OvladaniaZamkov_ENABLE_P4 : BOOL;
		TL_StartAutomat_ENABLE_P4 : BOOL;
		TL_KoniecCyklu_ENABLE_P4 : BOOL;
		TL_STOP_ENABLE_P4 : BOOL;
		LeakageTestA_Testovanie_ENABLE : BOOL;
		LeakageTestB_Testovanie_ENABLE : BOOL;
		LeakageTestA_RR_ENABLE : BOOL;
		LeakageTestB_RR_ENABLE : BOOL;
		FunkcnyTestA_Testovanie_ENABLE : BOOL;
		FunkcnyTestB_Testovanie_ENABLE : BOOL;
		Etiketovacka_Testovanie_ENABLE : BOOL;
		Srobovanie_OvlManipOsY_ENABLE : BOOL;
		VolbaLeakageTestu_ENABLE : BOOL;
		VolbaFunkcnehoTestu_ENABLE : BOOL;
		EditaciaParametrov_ENABLE : BOOL;
		RR_CistenieSkrutkovaciek_ENABLE : BOOL;
		RR_PozicieSkrutiek_ENABLE : BOOL;
		TL_PrihlasenieOperatora_ENABLE : BOOL;
		TL_PrihlasovOperatora_AKTIVNE : BOOL;
		TL_PrednyZamok_Farba_P4 : WSTRING[80];
		TL_ZamkniPrednyZamok_P4 : BOOL;
		WarningsP3_Farba : WSTRING[80];
		WarningsP3_Index : USINT;
		WarningsP4_Farba : WSTRING[80];
		WarningsP4_Index : USINT;
		TL_OvladanieVytahu_ENABLE : BOOL;
		TL_HomingVytahu_ENABLE : BOOL;
		TL_OvlZdvihuAplikEtikety_ENABLE : BOOL;
		TL_VyprazdnenieLinky_ENABLE : BOOL;
	END_STRUCT;
	Vizu_typ : 	STRUCT 
		TL_ResetCS_Farba : WSTRING[80];
		ZadanyCasPLC : DATE_AND_TIME;
		NastavCasPLC : BOOL;
		AktualnyCasPLC : DATE_AND_TIME;
	END_STRUCT;
END_TYPE

(*************Parametre paletky*********************)

TYPE
	Paletka_typ : 	STRUCT 
		PAR : Paletka_PAR_typ; (*Parametre komunik·cie z Panatrace*)
		STAV : Paletka_STAV_typ;
	END_STRUCT;
	Paletka_PAR_typ : 	STRUCT 
		CisloPaletky : STRING[2]; (*Je pevne danÈ Ëipom RFID*)
		QRkodPowerCP : STRING[30]; (*NaËÌtam ho na prvom v˝ùahu a posielam ho na server ako master number *)
		QRkodFiltra_5H : STRING[32]; (*NaËÌtam ho na pracovisku zakladania tesnenia a p·rujem ho s QR kodom Power CP*)
		QRkodFiltra_4F5F : STRING[32]; (*NaËÌtam ho na prvom v˝tahu a p·rujem ho s QR kodom Power CP*)
		ID_Operatora : STRING[80]; (*»Ìslo karty oper·tora*)
		StavPowerCP : STRING[4]; (*Stav vyûiadan˝ zo servera  - PASS, FAIL,  ktor˝ sa menÌ v pribehu v˝roby *)
	END_STRUCT;
	Paletka_STAV_typ : 	STRUCT 
		StavPaletky : STRING[10]; (*OK - paletka OK , NG - paletka NG, REV - revork, TEST - testovacÌ kus, PRECH - paletka iba prech·dza*)
		TypModelu : STRING[5]; (*4F, 5F, 5H podla zvolenej receptury*)
		KodModelu : STRING[32]; (*Dostanem pridelene na pracovisku etiketovania*)
		CisloTestovacejStanice : STRING[20]; (*»Ìslo testovacej stanice*)
		CisloRevorkovejStanice : STRING[20]; (*»Ìslo revorkovej stanice*)
		Zvaranie_Ukoncene : BOOL;
		HV_Test_Ukonceny : BOOL;
		LeakageTest_Ukonceny : BOOL;
		FunkcnyTest_Ukonceny : BOOL;
		QRkodFiltraPriradeny : BOOL;
		VytlacenieEtikety_DONE : BOOL;
		OdoslanieFotiek_DONE : BOOL;
		Komunikacia_DONE : BOOL;
		CisloEtiketyVyziadane : BOOL;
	END_STRUCT;
END_TYPE

(*****************Remanentne premenne**********)

TYPE
	P1_RemPremenne_typ : 	STRUCT 
		P1_Srob45F_PozX_LavejSkrutkyK30 : REAL;
		P1_Srob45F_PozY_LavejSkrutkyK30 : REAL;
		P1_Srob45F_PozX_PravejSkrutkyK30 : REAL;
		P1_Srob45F_PozY_PravejSkrutkyK30 : REAL;
		P1_Srob4F_PozX_ZadnejSkrutkyM4 : REAL;
		P1_Srob4F_PozY_ZadnejSkrutkyM4 : REAL;
		P1_Srob5F_PozX_ZadnejSkrutkyM4 : REAL;
		P1_Srob5F_PozY_ZadnejSkrutkyM4 : REAL;
		P1_Srob45F_Mom_ZadnejSkrutkyM4 : REAL;
		P1_Srob45F_Rychl_ZadnejSkrutkyM4 : REAL;
		P1_Srob4F_PozX_PrednejSkrutkyM4 : REAL;
		P1_Srob4F_PozY_PrednejSkrutkyM4 : REAL;
		P1_Srob5F_PozX_PrednejSkrutkyM4 : REAL;
		P1_Srob5F_PozY_PrednejSkrutkyM4 : REAL;
		P1_Srob45F_Mom_PrednejSkrutkyM4 : REAL;
		P1_Srob45F_Rychl_PredneSkrutkyM4 : REAL;
		P1_Srob45F_PozX_SkrutkyDPS_M4 : REAL;
		P1_Srob45F_PozY_SkrutkyDPS_M4 : REAL;
		P1_Srob45F_Mom_SkrutkyDPS_M4 : REAL;
		P1_Srob45F_Rychl_SkrutkyDPS_M4 : REAL;
		P1_Srob5H_PozX_LavejSkrutkyK30 : REAL;
		P1_Srob5H_PozY_LavejSkrutkyK30 : REAL;
		P1_Srob5H_PozX_PravejSkrutkyK30 : REAL;
		P1_Srob5H_PozY_PravejSkrutkyK30 : REAL;
		P1_Srob5H_PozX_LavejSkrutkyM5 : REAL;
		P1_Srob5H_PozY_LavejSkrutkyM5 : REAL;
		P1_Srob5H_Mom_LavejSkrutkyM5 : REAL;
		P1_Srob5H_Rychl_LavejSkrutkyM5 : REAL;
		P1_Srob5H_PozX_StrednejSkrutkyM5 : REAL;
		P1_Srob5H_PozY_StrednejSkrutkyM5 : REAL;
		P1_Srob5H_Mom_StrednejSkrutkyM5 : REAL;
		P1_Srob5H_Rychl_StredneSkrutkyM5 : REAL;
		P1_Srob5H_PozX_PravejSkrutkyM5 : REAL;
		P1_Srob5H_PozY_PravejSkrutkyM5 : REAL;
		P1_Srob5H_Mom_PravejSkrutkyM5 : REAL;
		P1_Srob5H_Rychl_PravejSkrutkyM5 : REAL;
		P1_Srob_PozX_OdobratSkrutkyM5 : REAL;
		P1_Srob_PozY_OdobratSkrutkyM5 : REAL;
		P1_Srob_Mom_OdobratSkrutkyM5 : REAL;
		P1_Srob_Rychl_OdobratSkrutkyM5 : REAL;
		P1_Srob_PozX_OdobratSkrutkyM4 : REAL;
		P1_Srob_PozY_OdobratSkrutkyM4 : REAL;
		P1_Srob_Mom_OdobratSkrutkyM4 : REAL;
		P1_Srob_Rychl_OdobratSkrutkyM4 : REAL;
		P1_Vytah_RychlostZdvihu : REAL;
		P1_Vytah_PoziciaNakladania : REAL;
		P1_Vytah_PoziciaVykladania : REAL;
		P1_ManipSrob_OsX_Rychlost : REAL;
		P1_ManipSrob_OsY_Rychlost : REAL;
		P1_Srob45F_LavaK30_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob45F_LavaK30_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob45F_PravaK30_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob45F_PravaK30_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob45F_ZadnaM4_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob45F_ZadnaM4_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob45F_PrednaM4_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob45F_PrednaM4_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob45F_DPS_M4_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob45F_DPS_M4_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob5H_LavaK30_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob5H_LavaK30_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob5H_PravaK30_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob5H_PravaK30_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob5H_LavaM5_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob5H_LavaM5_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob5H_StrednaM5_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob5H_StrednaM5_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P1_Srob5H_PravaM5_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P1_Srob5H_PravaM5_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
	END_STRUCT;
	P2_RemPremenne_typ : 	STRUCT 
		P2_ZaklTesnenia_Zdvih_Rychlost : REAL;
		P2_ZaklTesn_Zdvih_PozZatlacenia : REAL;
		P2_ZaklTesn_Pojazd_RychlVysun : REAL;
		P2_ZaklTesn_Pojazd_RychlZasun : REAL;
		P2_ZaklTesn_Pojazd_PozZatlacenia : REAL;
		P2_ZaklTesn_Pojazd_PozVkladania : REAL;
		P2_ZaklTesnenia_PocetZatlaceni : USINT;
		P2_Srob4F_PozX_LavejSkrutkyM6 : REAL;
		P2_Srob4F_PozY_LavejSkrutkyM6 : REAL;
		P2_Srob4F_PozX_PravejSkrutkyM6 : REAL;
		P2_Srob4F_PozY_PravejSkrutkyM6 : REAL;
		P2_Srob4F_PozX_LavejSkrutkyM4 : REAL;
		P2_Srob4F_PozY_LavejSkrutkyM4 : REAL;
		P2_Srob45F_Mom_LavejSkrutkyM4 : REAL;
		P2_Srob45F_Rychl_LavejSkrutkyM4 : REAL;
		P2_Srob4F_PozX_PravejSkrutkyM4 : REAL;
		P2_Srob4F_PozY_PravejSkrutkyM4 : REAL;
		P2_Srob45F_Mom_PravejSkrutkyM4 : REAL;
		P2_Srob45F_Rychl_PravejSkrutkyM4 : REAL;
		P2_Srob5F_PozX_LavejSkrutkyM6 : REAL;
		P2_Srob5F_PozY_LavejSkrutkyM6 : REAL;
		P2_Srob5F_PozX_PravejSkrutkyM6 : REAL;
		P2_Srob5F_PozY_PravejSkrutkyM6 : REAL;
		P2_Srob5F_PozX_LavejSkrutkyM4 : REAL;
		P2_Srob5F_PozY_LavejSkrutkyM4 : REAL;
		P2_Srob5F_PozX_PravejSkrutkyM4 : REAL;
		P2_Srob5F_PozY_PravejSkrutkyM4 : REAL;
		P2_Srob5H_PozX_LavejSkrutkyM5 : REAL;
		P2_Srob5H_PozY_LavejSkrutkyM5 : REAL;
		P2_Srob5H_PozX_PravejSkrutkyM5 : REAL;
		P2_Srob5H_PozY_PravejSkrutkyM5 : REAL;
		P2_Srob5H_PozX_SkrutkyM4 : REAL;
		P2_Srob5H_PozY_SkrutkyM4 : REAL;
		P2_Srob5H_Mom_SkrutkyM4 : REAL;
		P2_Srob5H_Rychl_SkrutkyM4 : REAL;
		P2_Srob_PozX_OdobratSkrutkyM4 : REAL;
		P2_Srob_PozY_OdobratSkrutkyM4 : REAL;
		P2_Srob_Mom_OdobratSkrutkyM4 : REAL;
		P2_Srob_Rychl_OdobratSkrutkyM4 : REAL;
		P2_ManipSrob_OsX_Rychlost : REAL;
		P2_ManipSrob_OsY_Rychlost : REAL;
		P2_Zvaranie_MomentZvarania : REAL;
		P2_Zvaranie_RychlostZvarania : REAL;
		P2_Zvaranie_CasZvarania : TIME;
		P2_ZdvihZvarania_Rychlost : REAL;
		P2_ZaklTesnenia_MomentPritlaku : REAL;
		P2_ZaklTesnenia_RychlostPritlaku : REAL;
		P2_ZaklTesnenia_RychlVysunutia : REAL;
		P2_ZaklTesnenia_RychlZasunutia : REAL;
		P2_Srob45F_LavaM6_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P2_Srob45F_LavaM6_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P2_Srob45F_PravaM6_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P2_Srob45F_PravaM6_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P2_Srob45F_LavaM4_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P2_Srob45F_LavaM4_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P2_Srob45F_PravaM4_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P2_Srob45F_PravaM4_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P2_Srob5H_LavaM5_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P2_Srob5H_LavaM5_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P2_Srob5H_PravaM5_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P2_Srob5H_PravaM5_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P2_Srob5H_StrednaM4_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P2_Srob5H_StrednaM4_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P2_Maticovacka_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P2_Maticovacka_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P2_Zvaranie_MomentZatlacania : REAL;
		P2_Zvaranie_RychlostZatlacania : REAL;
		P2_Zvaranie_CasZatlacania : TIME;
	END_STRUCT;
	P34_RemPremenne_typ : 	STRUCT 
		P3_ManipSrob_OsY_Rychlost : REAL;
		P4_Vytah_RychlostZdvihu : REAL;
		P4_Vytah_PoziciaNakladania : REAL;
		P4_Vytah_PoziciaVykladania : REAL;
		P4_ZdvihEtiketovacky_Rychlost : REAL;
		P4_Etiketovacka_PozEtikety_4F : REAL;
		P4_Etiketovacka_PozEtikety_5F : REAL;
		P4_Etiketovacka_PozEtikety_5H : REAL;
		P4_Etiketovacka_PozOdoberEtikety : REAL;
		P4_Etiketov_RychlZdvihuAplikat : REAL;
		P3_Srob45F_PozY_Skrutkovania : REAL;
		P3_Srob5H_PozY_Skrutkovania : REAL;
		P3_Srob_PozY_HV_Test : REAL;
		P3_Srob_PozY_OdobratSkrutkyM5 : REAL;
		P3_Srob_Mom_OdobratSkrutkyM5 : REAL;
		P3_Srob_Rychl_OdobratSkrutkyM5 : REAL;
		P3_Srob45F_Mom_SkrutkyM5 : REAL;
		P3_Srob45F_Rychl_SkrutkyM5 : REAL;
		P3_Srob5H_Mom_SkrutkyM5 : REAL;
		P3_Srob5H_Rychl_SkrutkyM5 : REAL;
		P3_Srob45F_K40_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P3_Srob45F_K40_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P3_Srob45F_M5_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P3_Srob45F_M5_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
		P3_Srob5H_M5_Vysunutie_LO : REAL; (*Vysunutie skrutkovaËky - spodn· tolerancia*)
		P3_Srob5H_M5_Vysunutie_HI : REAL; (*Vysunutie skrutkovaËky - horn· tolerancia*)
	END_STRUCT;
END_TYPE

(************************************Safety***********************************************************)

TYPE
	Safety_typ : 	STRUCT 
		IN : Safety_IN_typ;
		OUT : Safety_OUT_typ;
		STAV : Safety_STAV_typ;
	END_STRUCT;
	Safety_IN_typ : 	STRUCT 
		Linka_SV_ZonaCS : BOOL;
		P1_SV_PrivodVzduchu_CH1 : BOOL;
		P1_SV_PrivodVzduchu_CH2 : BOOL;
		P1_SV_ZonaBunky : BOOL;
		P1_SV_ZonaVytahu : BOOL;
		P2_SV_PrivodVzduchu_CH1 : BOOL;
		P2_SV_PrivodVzduchu_CH2 : BOOL;
		P2_SV_ZonaBunky : BOOL;
		P3_SV_PrivodVzduchu_CH1 : BOOL;
		P3_SV_PrivodVzduchu_CH2 : BOOL;
		P3_SV_ZonaBunky : BOOL;
		P4_SV_PrivodVzduchu_CH1 : BOOL;
		P4_SV_PrivodVzduchu_CH2 : BOOL;
		P4_SV_ZonaBunky : BOOL;
		P4_SV_ZonaVytahu : BOOL;
	END_STRUCT;
	Safety_OUT_typ : 	STRUCT 
		Linka_ResetCS : BOOL;
		P1_ResetZonyVytahu : BOOL;
		P1_ResetZonyBunky : BOOL;
		P1_ResetDeadMan : BOOL;
		P2_ResetZonyZaklTesn_Pojazd : BOOL;
		P2_ResetZonyZaklTesn_Zdvih : BOOL;
		P2_ResetZonyBunky : BOOL;
		P2_ResetZonyMaticovacky : BOOL;
		P3_ResetZonyBunky : BOOL;
		P4_ResetZonyBunky : BOOL;
		P4_ResetZonyVytahu : BOOL;
	END_STRUCT;
	Safety_STAV_typ : 	STRUCT 
		Linka_SafetyPLC_Nabehlo : BOOL;
		Linka_ZonaCS_AKTIVNA : BOOL;
		Linka_TlacitkaCS_ODBLOKOVANE : BOOL;
		P1_Panel_TlacitkoCS_ODBLOK : BOOL;
		P1_Robot_TlacitkoCS_ODBLOK : BOOL;
		P1_Rozvadzac_TlacitkoCS_ODBLOK : BOOL;
		P1_VyblokovanieZamkov_AKTIVNE : BOOL;
		P1_Vytah_Bariera_AKTIVNA : BOOL;
		P1_Vytah_Muting_AKTIVNY : BOOL;
		P1_Bunka_Zamky_AKTIVNE : BOOL;
		P1_Bunka_VstupBariera_AKTIVNA : BOOL;
		P1_Bunka_VystupBariera_AKTIVNA : BOOL;
		P1_ZonaVytahu_AKTIVNA : BOOL;
		P1_ZonaBunky_AKTIVNA : BOOL;
		P1_DeadMan_AKTIVNY : BOOL;
		P2_Panel_TlacitkoCS_ODBLOK : BOOL;
		P2_Robot_TlacitkoCS_ODBLOK : BOOL;
		P2_DvojrucOvl_TlacitkoCS_ODBLOK : BOOL;
		P2_VyblokovanieZamkov_AKTIVNE : BOOL;
		P2_Rozvadzac_TlacitkoCS_ODBLOK : BOOL;
		P2_DeadMan_AKTIVNY : BOOL;
		P2_ZaklTesn_PojazdMuting_AKTIVNY : BOOL;
		P2_ZaklTesn_Bariera_AKTIVNA : BOOL;
		P2_ZaklTesn_Bumper_AKTIVNY : BOOL;
		P2_Bunka_VstupBariera_AKTIVNA : BOOL;
		P2_Bunka_Zamky_AKTIVNE : BOOL;
		P2_ZonaZakladacaPojazd_AKTIVNA : BOOL;
		P2_ZonaZakladacaZdvih_AKTIVNA : BOOL;
		P2_ZonaMaticovacky_AKTIVNA : BOOL;
		P2_DvojrucneOvladanie_AKTIVNE : BOOL;
		P2_ZonaBunky_AKTIVNA : BOOL;
		P3_VyblokovanieZamkov_AKTIVNE : BOOL;
		P3_Rozvadzac_TlacitkoCS_ODBLOK : BOOL;
		P3_DeadMan_AKTIVNY : BOOL;
		P3_Bunka_VstupBariera_AKTIVNA : BOOL;
		P3_Bunka_VystupBariera_AKTIVNA : BOOL;
		P3_Bunka_Zamky_AKTIVNE : BOOL;
		P3_ZonaBunky_AKTIVNA : BOOL;
		P4_Panel_TlacitkoCS_ODBLOK : BOOL;
		P4_Rozvadzac_TlacitkoCS_ODBLOK : BOOL;
		P4_VyblokovanieZamkov_AKTIVNE : BOOL;
		P4_DeadMan_AKTIVNY : BOOL;
		P4_ZonaVytahu_AKTIVNA : BOOL;
		P4_ZonaBunky_AKTIVNA : BOOL;
		P4_Vytah_Bariera_AKTIVNA : BOOL;
		P4_Vytah_Muting_AKTIVNY : BOOL;
		P4_Bunka_Zamky_AKTIVNE : BOOL;
		P4_Bunka_VstupBariera_AKTIVNA : BOOL;
		P4_Bunka_VystupBariera_AKTIVNA : BOOL;
	END_STRUCT;
END_TYPE

(*************************************Linka vöeobecne**********************************************)

TYPE
	Linka_typ : 	STRUCT 
		IN : Linka_IN_typ;
		OUT : Linka_OUT_typ;
		PAR : Linka_PAR_typ;
		STAV : Linka_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		KOM_Panatrace_OFF : BOOL;
		KOM_FTP_OFF : BOOL;
		P1_Kamery_OFF : BOOL;
		P2_Kamery_OFF : BOOL;
		P3_Kamery_OFF : BOOL;
		P4_Kamery_OFF : BOOL;
		P1_SkrutkovanieResult_OFF : BOOL;
		P2_SkrutkovanieResult_OFF : BOOL;
		P3_SkrutkovanieResult_OFF : BOOL;
	END_STRUCT;
	Linka_IN_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	Linka_OUT_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	Linka_PAR_typ : 	STRUCT 
		ZvolenyModel : STRING[2]; (*4F, 5F, 5H*)
		TestovaciKus : BOOL;
		RevorkovyKus : BOOL;
		PaletkaPrechadza : BOOL;
	END_STRUCT;
	Linka_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		VyprazdnenieLinky : BOOL;
	END_STRUCT;
END_TYPE

(*************************************Pracovisko P1**************************************************)

TYPE
	P1_Pracovisko_typ : 	STRUCT 
		IN : P1_Pracovisko_IN_typ;
		OUT : P1_Pracovisko_OUT_typ;
		PAR : P1_Pracovisko_PAR_typ;
		STAV : P1_Pracovisko_STAV_typ;
		COM_Weidmuller : P1_COM_Weidmuller_typ;
		COM_Festo : P1_COM_Festo_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P1_Pracovisko_IN_typ : 	STRUCT 
		TlakVzduchu_OK : BOOL; (*S1_5*)
		ModulWeidmuller_IO_KomOK : BOOL;
		VentilovyTerminal_KomOK : BOOL;
		Robot_KomOK : BOOL;
		Skrutkovacka_K30_KomOK : BOOL;
		Skrutkovacka_M5_KomOK : BOOL;
		Skrutkovacka_M4_KomOK : BOOL;
		ModulFesto_IO_KomOK : BOOL;
		SmartKamera3_KomOK : BOOL;
		SmartKamera5_KomOK : BOOL;
		ServoZdvihuVytahu_KomOK : BOOL;
		ServoManipulatorOsX_KomOK : BOOL;
		ServoManipulatorOsY_KomOK : BOOL;
		ServoManipulatorOsZ_M5_KomOK : BOOL;
		ServoManipulatorOsZ_M4_KomOK : BOOL;
		PredneDvere_PritomnostAdaptera : BOOL;
		ZadneDvere_PritomnostAdaptera : BOOL;
	END_STRUCT;
	P1_Pracovisko_OUT_typ : 	STRUCT 
		Majak_ZeleneSvetlo_ON : BOOL;
		Majak_OranzoveSvetlo_ON : BOOL;
		Majak_CerveneSvetlo_ON : BOOL;
		Majak_Hukacka_ON : BOOL;
		OsvetlenieBunky_ON : BOOL;
		Osvetlenie_CAM2_ON : BOOL;
		Osvetlenie_CAM4_ON : BOOL;
		Osvetlenie_CAM6_ON : BOOL;
		PredneDvere_ZAMKNI : BOOL;
		ZadneDvere_ZAMKNI : BOOL;
	END_STRUCT;
	P1_Pracovisko_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P1_Pracovisko_STAV_typ : 	STRUCT 
		Automat : BOOL;
		Manual : BOOL;
		PoINIT : BOOL;
		READY : BOOL;
		HardwareVytahu_OK : BOOL;
		HardwareBunky_OK : BOOL;
		SkrutkovackyZasunute : BOOL;
		Porucha_ST1 : BOOL; (*Vstupn˝ v˝ùah*)
		Porucha_ST2 : BOOL; (*ärobovanie*)
		Porucha_ST3 : BOOL; (*AkumulaËn˝ stoper*)
		UkoncenieCyklu_BUSY : BOOL;
	END_STRUCT;
	P1_COM_Weidmuller_typ : 	STRUCT 
		AB1_2_8DI : USINT;
		AB1_3_8DI : USINT;
		AB1_4_8DI : USINT;
		AB1_5_8DI : USINT;
		AB1_6_8DO : USINT;
		AB1_7_8DO : USINT;
		AB1_9_8DO : USINT;
		AB1_10_8DO : USINT;
	END_STRUCT;
	P1_COM_Festo_typ : 	STRUCT 
		DM1_1_4DI : ARRAY[0..3]OF BOOL;
		DM1_1_4DO : ARRAY[0..3]OF BOOL;
		DI1_1_8DI : ARRAY[0..7]OF BOOL;
		DI1_2_8DI : ARRAY[0..7]OF BOOL;
		DI1_3_8DI : ARRAY[0..7]OF BOOL;
		DI1_4_8DI : ARRAY[0..7]OF BOOL;
		DI1_5_8DI : ARRAY[0..7]OF BOOL;
		DS1_1_Port0_IN : ARRAY[0..1]OF USINT;
		DS1_1_Port0_OUT : ARRAY[0..1]OF USINT;
		DS1_1_Port1_IN : ARRAY[0..15]OF USINT;
		DS1_1_Port1_OUT : ARRAY[0..15]OF USINT;
		DS1_1_Port2_IN : ARRAY[0..31]OF USINT;
		DS1_1_Port2_OUT : ARRAY[0..31]OF USINT;
		DS1_1_Port3_IN : ARRAY[0..31]OF USINT;
		DS1_1_Port3_OUT : ARRAY[0..31]OF USINT;
		DS1_2_Port0_IN : ARRAY[0..1]OF USINT;
		DS1_2_Port0_OUT : ARRAY[0..1]OF USINT;
	END_STRUCT;
END_TYPE

(*//P1 - V˝ùah//*)

TYPE
	P1_Vytah_typ : 	STRUCT 
		CMD : P1_Vytah_CMD_typ;
		IN : P1_Vytah_IN_typ;
		OUT : P1_Vytah_OUT_typ;
		PAR : P1_Vytah_PAR_typ;
		STAV : P1_Vytah_STAV_typ;
		Banner : BannerIOlink;
		RFID_hlava : SickHeads; (*S_1.3*)
		ServoZdvihuVytahu : ServoDriver; (*M_1.1*)
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P1_Vytah_CMD_typ : 	STRUCT 
		RR_ChodDopravnika_VPRED : BOOL;
		RR_ChodDopravnika_VZAD : BOOL;
		RR_ZdvihVytahu_HORE : BOOL;
		RR_ZdvihVytahu_DOLE : BOOL;
		Banner_LED_OFF : BOOL;
	END_STRUCT;
	P1_Vytah_IN_typ : 	STRUCT 
		PrechodDopravnika : BOOL; (*OS1_8*)
		Zdvih_HornyLimSnimac : BOOL; (*IS1_17*)
		Zdvih_SpodnyLimSnimac : BOOL; (*IS1_16*)
		StavRiadeniaDopravVytahu_READY : BOOL; (*M1_11*)
		TeplotaMotoraDopravVytahu_NG : BOOL; (*M1_11*)
	END_STRUCT;
	P1_Vytah_OUT_typ : 	STRUCT 
		DopravnikChod_VPRED : BOOL; (*M1_11*)
		DopravnikChod_VZAD : BOOL; (*M1_11*)
	END_STRUCT;
	P1_Vytah_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		IndexFotky : USINT;
		StaryQRkod_PowerCP : STRING[30];
		StaryQRkod_DPS_4F5F : STRING[32];
		Zdvih_JoggRychlost : REAL;
	END_STRUCT;
	P1_Vytah_STAV_typ : 	STRUCT 
		PrebiehaVyvezeniePaletky : BOOL;
		PoINIT : BOOL;
	END_STRUCT;
END_TYPE

(*//P1 - Spodn˝ stoper//*)

TYPE
	P1_SpodnyStoper_typ : 	STRUCT 
		IN : P1_SpodnyStoper_IN_typ;
		OUT : P1_SpodnyStoper_OUT_typ;
		PAR : P1_SpodnyStoper_PAR_typ;
		STAV : P1_SpodnyStoper_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P1_SpodnyStoper_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS1_4*)
		ZaplnenieDopravnika : BOOL; (*IS1_22*)
	END_STRUCT;
	P1_SpodnyStoper_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV005_VT1*)
	END_STRUCT;
	P1_SpodnyStoper_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P1_SpodnyStoper_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P1 - DopravnÌky//*)

TYPE
	P1_Dopravniky_typ : 	STRUCT 
		IN : P1_Dopravniky_IN_typ;
		OUT : P1_Dopravniky_OUT_typ;
		PAR : P1_Dopravniky_PAR_typ;
		STAV : P1_Dopravniky_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P1_Dopravniky_IN_typ : 	STRUCT 
		StavRiadeniaVratnehoDoprav_READY : BOOL; (*M1_13*)
		StavRiadeniaDopravBunky_READY : BOOL; (*M1_12*)
		TeplotaMotoraVratnehoDoprav_NG : BOOL; (*M1_13*)
		TeplotaMotoraDopravBunky_NG : BOOL; (*M1_12*)
	END_STRUCT;
	P1_Dopravniky_OUT_typ : 	STRUCT 
		DopravnikBunky_ON : BOOL; (*M1_12*)
		VratnyDopravnik_ON : BOOL; (*M1_13*)
	END_STRUCT;
	P1_Dopravniky_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P1_Dopravniky_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
	END_STRUCT;
END_TYPE

(*//P1 - Stoper örobovania//*)

TYPE
	P1_StoperSrobovania_typ : 	STRUCT 
		CMD : P1_StoperSrobovania_CMD_typ;
		IN : P1_StoperSrobovania_IN_typ;
		OUT : P1_StoperSrobovania_OUT_typ;
		PAR : P1_StoperSrobovania_PAR_typ;
		STAV : P1_StoperSrobovania_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P1_StoperSrobovania_CMD_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P1_StoperSrobovania_IN_typ : 	STRUCT 
		Centrovanie_VYSUNUTE : BOOL; (*IS1_1*)
		Centrovanie_ZASUNUTE : BOOL; (*IS1_2*)
	END_STRUCT;
	P1_StoperSrobovania_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV001_VT1*)
		Centrovanie_VYSUN : BOOL; (*YV002_VT1*)
		Centrovanie_ZASUN : BOOL; (*YV003_VT1*)
	END_STRUCT;
	P1_StoperSrobovania_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		IndexFotky : USINT;
	END_STRUCT;
	P1_StoperSrobovania_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P1 - ärobovanie//*)

TYPE
	P1_Srobovanie_typ : 	STRUCT 
		CMD : P1_Srobovanie_CMD_typ;
		IN : P1_Srobovanie_IN_typ;
		OUT : P1_Srobovanie_OUT_typ;
		PAR : P1_Srobovanie_PAR_typ;
		STAV : P1_Srobovanie_STAV_typ;
		COM_IN : P1_Srobovanie_COM_IN_typ;
		COM_OUT : P1_Srobovanie_COM_OUT_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		ServoManipulOsX : ServoDriver; (*M1_2*)
		ServoManipulOsY : ServoDriver; (*M1_3*)
		ServoManipulOsZ_M4 : ServoDriver; (*M1_5*)
		ServoManipulOsZ_M5 : ServoDriver; (*M1_4*)
		Skrutkovacka_K30 : SkrutkovackaAtlasCopco_typ;
		Skrutkovacka_M4 : SkrutkovackaAtlasCopco_typ;
		Skrutkovacka_M5 : SkrutkovackaAtlasCopco_typ;
		SkrutSet_K30 : ScrewLoading;
		SkrutSet_M5 : PickAndPlace;
		SkrutSet_M4 : PickAndPlace;
	END_STRUCT;
	P1_Srobovanie_CMD_typ : 	STRUCT 
		RR_SkrutkovackuK30_VYSUN : BOOL;
		RR_Manipulator_OsX_VPRAVO : BOOL;
		RR_Manipulator_OsX_VLAVO : BOOL;
		RR_Manipulator_OsY_VPRED : BOOL;
		RR_Manipulator_OsY_VZAD : BOOL;
		RR_SkrutkovackaM4_OsZ_HORE : BOOL;
		RR_SkrutkovackaM4_OsZ_DOLE : BOOL;
		RR_SkrutkovackaM5_OsZ_HORE : BOOL;
		RR_SkrutkovackaM5_OsZ_DOLE : BOOL;
		RR_PrisavanieSkrutkyM5_ON : BOOL;
		RR_PrisavanieSkrutkyM4_ON : BOOL;
		RR_PrisavanieSkrutkyK30_ON : BOOL;
		RR_CistenieSkrutkovackyK30 : BOOL;
		RR_SkrutSetK30_Zasobnik_RUN : BOOL;
		RR_SkrutSetK30_PodajSkrutku : BOOL;
		RR_SkrutSetM4_Zasobnik_RUN : BOOL;
		RR_SkrutSetM4_Vibrolista_RUN : BOOL;
		RR_SkrutSetM4_PodajSkrutku : BOOL;
		RR_SkrutSetM5_Zasobnik_RUN : BOOL;
		RR_SkrutSetM5_Vibrolista_RUN : BOOL;
		RR_SkrutSetM5_PodajSkrutku : BOOL;
		RR_PolohujManipulator : BOOL;
	END_STRUCT;
	P1_Srobovanie_IN_typ : 	STRUCT 
		ManipulOsX_LimSnimac_POS : BOOL; (*IS1_21*)
		ManipulOsX_LimSnimac_NEG : BOOL; (*IS1_20*)
		ManipulOsY_LimSnimac_POS : BOOL; (*IS1_19*)
		ManipulOsY_LimSnimac_NEG : BOOL; (*IS1_18*)
		ManipulOsZ_M4_LimSnimacHorny : BOOL; (*IS1_24*)
		ManipulOsZ_M4_LimSnimacSpodny : BOOL; (*IS1_25*)
		ManipulOsZ_M5_LimSnimacHorny : BOOL; (*IS1_5*)
		ManipulOsZ_M5_LimSnimacSpodny : BOOL; (*IS1_6*)
		Skrutkovacka_K30_ZASUNUTA : BOOL; (*MS1_7*)
		Skrutkovacka_M5_Vakum_OK : BOOL; (*S1_6*)
		Skrutkovacka_M4_Vakum_OK : BOOL; (*S1_7*)
		NapajanieSkrutkovackyM4_OK : BOOL;
		NapajanieSkrutkovackyK30_OK : BOOL;
		NapajanieSkrutkovackyM5_OK : BOOL;
		NapajanieZasobnikaM5_OK : BOOL;
		NapajanieZasobnikaM4_OK : BOOL;
		NapajanieZasobnikaK30_OK : BOOL;
		NapajanieVibrolistyM5_OK : BOOL;
		NapajanieVibrolistyM4_OK : BOOL;
	END_STRUCT;
	P1_Srobovanie_OUT_typ : 	STRUCT 
		Skrutkovacku_K30_VYSUN : BOOL; (*YV018_VT1*)
		Skrutkovacka_K30_Prisavanie_ON : BOOL; (*YV016_VT1*)
		Skrutkovacka_K30_Odvzdusn_ON : BOOL; (*YV017_VT1*)
		Skrutkovacka_M4_Prisavanie_ON : BOOL; (*YV025_VT1*)
		Skrutkovacka_M4_Prisavanie_OFF : BOOL; (*YV026_VT1*)
		Skrutkovacka_M4_Odvzdusn_ON : BOOL; (*YV027_VT1*)
		Skrutkovacka_M5_Prisavanie_ON : BOOL; (*YV022_VT1*)
		Skrutkovacka_M5_Prisavanie_OFF : BOOL; (*YV023_VT1*)
		Skrutkovacka_M5_Odvzdusn_ON : BOOL; (*YV024_VT1*)
	END_STRUCT;
	P1_Srobovanie_PAR_typ : 	STRUCT 
		RR_IndexPolohovaniaManipulatora : USINT;
		RR_TypModelu : STRING[2];
		Skrutkov_K30_AktualHodnVysunutia : UINT; (*IO-Link snÌmaË*)
		ManipulOsX_AktualnaPozicia : REAL;
		ManipulOsY_AktualnaPozicia : REAL;
		ManipulOsZ_M5_AktualnaPozicia : REAL;
		ManipulOsZ_M4_AktualnaPozicia : REAL;
		ManipulOsX_JoggRychlost : REAL;
		ManipulOsY_JoggRychlost : REAL;
		ManipulOsZ_M5_JoggRychlost : REAL;
		ManipulOsZ_M4_JoggRychlost : REAL;
		K30_AtlasCopcoInputs : ARRAY[0..7]OF UDINT;
		K30_AllasCopcoOutputs : ARRAY[0..7]OF UDINT;
		M5_AtlasCopcoInputs : ARRAY[0..7]OF UDINT;
		M5_AllasCopcoOutputs : ARRAY[0..7]OF UDINT;
		M4_AtlasCopcoInputs : ARRAY[0..7]OF UDINT;
		M4_AllasCopcoOutputs : ARRAY[0..7]OF UDINT;
	END_STRUCT;
	P1_Srobovanie_STAV_typ : 	STRUCT 
		RR_Polohovanie_BUSY : BOOL;
		PoINIT : BOOL;
		Vysledok_Srobovania : STRING[2]; (*OK alebo NG*)
		K30_DosiahnutyMoment_REAL : REAL;
		K30_DosiahnutyMoment : UDINT;
		K30_Moment_ToleranciaMAX_REAL : REAL;
		K30_Moment_ToleranciaMAX : UDINT;
		K30_Moment_ToleranciaMIN_REAL : REAL;
		K30_Moment_ToleranciaMIN : UDINT;
		K30_DosiahnutyUhol : UINT;
		K30_Uhol_ToleranciaMAX_REAL : REAL;
		K30_Uhol_ToleranciaMAX : UDINT;
		K30_Uhol_ToleranciaMIN_REAL : REAL;
		K30_Uhol_ToleranciaMIN : UDINT;
		M5_DosiahnutyMoment_REAL : REAL;
		M5_DosiahnutyMoment : UDINT;
		M5_Moment_ToleranciaMAX_REAL : REAL;
		M5_Moment_ToleranciaMAX : UDINT;
		M5_Moment_ToleranciaMIN_REAL : REAL;
		M5_Moment_ToleranciaMIN : UDINT;
		M5_DosiahnutyUhol : UINT;
		M5_Uhol_ToleranciaMAX_REAL : REAL;
		M5_Uhol_ToleranciaMAX : UDINT;
		M5_Uhol_ToleranciaMIN_REAL : REAL;
		M5_Uhol_ToleranciaMIN : UDINT;
		M4_DosiahnutyMoment_REAL : REAL;
		M4_DosiahnutyMoment : UDINT;
		M4_Moment_ToleranciaMAX_REAL : REAL;
		M4_Moment_ToleranciaMAX : UDINT;
		M4_Moment_ToleranciaMIN_REAL : REAL;
		M4_Moment_ToleranciaMIN : UDINT;
		M4_DosiahnutyUhol : UINT;
		M4_Uhol_ToleranciaMAX_REAL : REAL;
		M4_Uhol_ToleranciaMAX : UDINT;
		M4_Uhol_ToleranciaMIN_REAL : REAL;
		M4_Uhol_ToleranciaMIN : UDINT;
	END_STRUCT;
	P1_Srobovanie_COM_IN_typ : 	STRUCT 
		PresunManipulatora_VPRED : BOOL;
		PresunManipulatora_VZAD : BOOL;
		Model45F_ZaskrutkujLavu_K30 : BOOL;
		Model45F_ZaskrutkujPravu_K30 : BOOL;
		Model5H_ZaskrutkujLavu_K30 : BOOL;
		Model5H_ZaskrutkujPravu_K30 : BOOL;
		Model45F_ZaskrutkujPrednu_M4 : BOOL;
		Model45F_ZaskrutkujZadnu_M4 : BOOL;
		Model45F_ZaskrutkujDPS_M4 : BOOL;
		Model5H_ZaskrutkujLavu_M5 : BOOL;
		Model5H_ZaskrutkujPravu_M5 : BOOL;
		Model5H_ZaskrutkujStrednu_M5 : BOOL;
	END_STRUCT;
	P1_Srobovanie_COM_OUT_typ : 	STRUCT 
		Stav_SkrutkovanieUkoncene : BOOL;
		Stav_PresunManipulUkonceny : BOOL;
		Stav_PoruchaSkrutkovania : BOOL;
	END_STRUCT;
END_TYPE

(*//P1 - AkumulaËn˝ stoper//*)

TYPE
	P1_AkumulacnyStoper_typ : 	STRUCT 
		IN : P1_AkumulacnyStoper_IN_typ;
		OUT : P1_AkumulacnyStoper_OUT_typ;
		PAR : P1_AkumulacnyStoper_PAR_typ;
		STAV : P1_AkumulacnyStoper_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P1_AkumulacnyStoper_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS1_3*)
	END_STRUCT;
	P1_AkumulacnyStoper_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV004_VT1*)
	END_STRUCT;
	P1_AkumulacnyStoper_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P1_AkumulacnyStoper_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P1 - Robot//*)

TYPE
	P1_Robot_typ : 	STRUCT 
		CMD : P1_Robot_CMD_typ;
		IN : P1_Robot_IN_typ;
		OUT : P1_Robot_OUT_typ;
		PAR : P1_Robot_PAR_typ;
		STAV : P1_Robot_STAV_typ;
		COM_IN : P1_Robot_COM_IN_typ;
		COM_OUT : P1_Robot_COM_OUT_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P1_Robot_CMD_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P1_Robot_IN_typ : 	STRUCT 
		Vakum_OK : BOOL; (*S1_4*)
		DokStanica_PritomnGripra45F : BOOL; (*IS1_23*)
		DokStanica_PritomnGripra5H : BOOL; (*IS1_13*)
		TypGripra_45F : BOOL;
		TypGripra_5H : BOOL;
		Griper45F_Otvoreny : BOOL; (*MS1_10*)
		Griper45F_Zatvoreny : BOOL; (*MS1_11*)
		KodGripra_Bit0 : BOOL;
		KodGripra_Bit1 : BOOL;
	END_STRUCT;
	P1_Robot_OUT_typ : 	STRUCT 
		Griper_OTVOR : BOOL; (*YV008_VT1*)
		Griper_ZATVOR : BOOL; (*YV009_VT1*)
		OdistiGriper : BOOL; (*YV007_VT1*)
		ZaistiGriper : BOOL; (*YV006_VT1*)
		Vakum_ON : BOOL; (*YV010_VT1*)
		Vakum_OFF : BOOL; (*YV011_VT1*)
	END_STRUCT;
	P1_Robot_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P1_Robot_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		DrziFoamy_45F : BOOL;
		DrziBusbar_45F : BOOL;
		DrziBusbar_5H : BOOL;
		DrziDPS_45F : BOOL;
	END_STRUCT;
	P1_Robot_COM_IN_typ : 	STRUCT 
		BYTE_IN : ARRAY[0..63]OF USINT; (*Z robota do PLC*)
		Stav_RobotOdparkovany : BOOL;
		Stav_RobotPoziciaCakania : BOOL;
		Stav_RobotBezpPozicia_Srobovanie : BOOL;
		Stav_MotoryON : BOOL;
		Stav_MotoryOFF : BOOL;
		Stav_ProgramRUN : BOOL;
		Stav_RezimAUTOMAT : BOOL;
		Stav_RobotCS : BOOL;
		Stav_VystupyZresetovane : BOOL;
		Stav_Foam4F_Odobraty : BOOL;
		Stav_Foam5F_Odobraty : BOOL;
		Stav_Foam4F_Polozeny : BOOL;
		Stav_Foam5F_Polozeny : BOOL;
		Stav_SpodnyBusbar4F_Odobraty : BOOL;
		Stav_SpodnyBusbar5F_Odobraty : BOOL;
		Stav_SpodnyBusbar4F_Polozeny : BOOL;
		Stav_SpodnyBusbar5F_Polozeny : BOOL;
		Stav_DPS_4F_Odobraty : BOOL;
		Stav_DPS_5F_Odobraty : BOOL;
		Stav_DPS_4F_Polozeny : BOOL;
		Stav_DPS_5F_Polozeny : BOOL;
		Stav_SpodnyBusbar5H_Odobraty : BOOL;
		Stav_SpodnyBusbar5H_Polozeny : BOOL;
		Stav_BusbaryUvolnene : BOOL;
		Stav_RobotOdoberaBusbary : BOOL;
		Stav_RobotOdoberaFoamy : BOOL;
	END_STRUCT;
	P1_Robot_COM_OUT_typ : 	STRUCT 
		BYTE_OUT : ARRAY[0..63]OF USINT; (*Z PLC do Robota*)
		ManipSrobovania_BezpecnaPozicia : BOOL;
		OdoberFoam4F_z_Paletky : BOOL;
		OdoberFoam5F_z_Paletky : BOOL;
		PolozFoam4F_na_PowerCP : BOOL;
		PolozFoam5F_na_PowerCP : BOOL;
		OdoberSpodnyBusbar4F_z_Paletky : BOOL;
		OdoberSpodnyBusbar5F_z_Paletky : BOOL;
		PolozSpodnyBusbar4F_na_PowerCP : BOOL;
		PolozSpodnyBusbar5F_na_PowerCP : BOOL;
		OdoberDPS_4F_z_Paletky : BOOL;
		OdoberDPS_5F_z_Paletky : BOOL;
		PolozDPS_4F_na_PowerCP : BOOL;
		PolozDPS_5F_na_PowerCP : BOOL;
		OdoberSpodnyBusbar5H_z_Paletky : BOOL;
		PolozSpodnyBusbar5H_na_PowerCP : BOOL;
		UvolniBusbary : BOOL;
		Presun_CakaciaPozicia : BOOL;
		Odparkovanie : BOOL;
		ZapniMotory : BOOL;
		VypniMotory : BOOL;
		PP_na_Main : BOOL;
		Reset_CS : BOOL;
		StartProgramu : BOOL;
		StartProgramuMain : BOOL;
		StopProgramu : BOOL;
		TypGripra_5H : BOOL;
		TypGripra_45F : BOOL;
		ZopakujOdoberanie : BOOL;
	END_STRUCT;
END_TYPE

(***********************************Pracovisko 2****************************************************************)

TYPE
	P2_Pracovisko_typ : 	STRUCT 
		IN : P2_Pracovisko_IN_typ;
		OUT : P2_Pracovisko_OUT_typ;
		PAR : P2_Pracovisko_PAR_typ;
		STAV : P2_Pracovisko_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_Pracovisko_IN_typ : 	STRUCT 
		TlakVzduchu_OK : BOOL; (*S2_10*)
		ModulWeidmuller_IO_KomOK : BOOL;
		VentilovyTerminal_KomOK : BOOL;
		Robot_KomOK : BOOL;
		Skrutkovacka_M6_KomOK : BOOL;
		Skrutkovacka_M5_KomOK : BOOL;
		Skrutkovacka_M4_KomOK : BOOL;
		Maticovacka_M4_KomOK : BOOL;
		ModulFesto_IO_KomOK : BOOL;
		SafetyModul_KomOK : BOOL;
		SmartKamera8_KomOK : BOOL;
		SmartKamera9_KomOK : BOOL;
		ServoManipulatorOsX_KomOK : BOOL;
		ServoManipulatorOsY_KomOK : BOOL;
		ServoManipulatorOsZ_M4_KomOK : BOOL;
		ServoZaklTesneniaPojazd_KomOK : BOOL;
		ServoZaklTesneniaZdvih_KomOK : BOOL;
		ServoZvaraniaOsZ_KomOK : BOOL;
		PredneDvereLS_PritomnostAdaptera : BOOL;
		PredneDverePS_PritomnostAdaptera : BOOL;
		ZadneDvereLS_PritomnostAdaptera : BOOL;
		ZadneDverePS_PritomnostAdaptera : BOOL;
	END_STRUCT;
	P2_Pracovisko_OUT_typ : 	STRUCT 
		Majak_ZeleneSvetlo_ON : BOOL;
		Majak_OranzoveSvetlo_ON : BOOL;
		Majak_CerveneSvetlo_ON : BOOL;
		Majak_Hukacka_ON : BOOL;
		OsvetlenieBunky_ON : BOOL;
		Osvetlenie_CAM7_CAM17 : BOOL; (*Stoper zakladania tesnenia*)
		Osvetlenie_CAM1 : BOOL; (*ZakladaË tesnenia*)
		Osvetlenie_CAM10 : BOOL; (*Stoper skrutkovania matic*)
		Osvetlenie_CAM11 : BOOL; (*Stoper zv·rania*)
		PredneDvereLS_ZAMKNI : BOOL;
		PredneDverePS_ZAMKNI : BOOL;
		ZadneDvereLS_ZAMKNI : BOOL;
		ZadneDverePS_ZAMKNI : BOOL;
	END_STRUCT;
	P2_Pracovisko_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_Pracovisko_STAV_typ : 	STRUCT 
		Automat : BOOL;
		Manual : BOOL;
		PoINIT : BOOL;
		READY : BOOL;
		Porucha_ST1 : BOOL; (*Zakladanie tesnenia*)
		Porucha_ST2 : BOOL; (*Skrutkovanie matice*)
		Porucha_ST3 : BOOL; (*AkumulaËn˝ stoper*)
		Porucha_ST4 : BOOL; (*ärobovanie*)
		Porucha_ST5 : BOOL; (*Zvaranie,»istenie*)
		HardwareBunky_OK : BOOL;
		HardwareZaklTesnenia_OK : BOOL;
		SkrutkovackyZasunute : BOOL;
		UkoncenieCyklu_BUSY : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - DopravnÌky//*)

TYPE
	P2_Dopravniky_typ : 	STRUCT 
		IN : P2_Dopravniky_IN_typ;
		OUT : P2_Dopravniky_OUT_typ;
		PAR : P2_Dopravniky_PAR_typ;
		STAV : P2_Dopravniky_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_Dopravniky_IN_typ : 	STRUCT 
		StavRiadeniaVratnehoDoprav_READY : BOOL; (*M2_13*)
		StavRiadeniaDopravBunky_READY : BOOL; (*M2_12*)
		TeplotaMotoraVratnehoDoprav_NG : BOOL; (*M2_13*)
		TeplotaMotoraDopravBunky_NG : BOOL; (*M2_12*)
	END_STRUCT;
	P2_Dopravniky_OUT_typ : 	STRUCT 
		DopravnikBunky_ON : BOOL; (*M2_12*)
		VratnyDopravnik_ON : BOOL; (*M2_13*)
	END_STRUCT;
	P2_Dopravniky_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_Dopravniky_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - Spodn˝ stoper//*)

TYPE
	P2_SpodnyStoper_typ : 	STRUCT 
		IN : P2_SpodnyStoper_IN_typ;
		OUT : P2_SpodnyStoper_OUT_typ;
		PAR : P2_SpodnyStoper_PAR_typ;
		STAV : P2_SpodnyStoper_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_SpodnyStoper_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS2_8*)
		ZaplnenieDopravnika : BOOL; (*IS2_9*)
	END_STRUCT;
	P2_SpodnyStoper_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV048_VT2*)
	END_STRUCT;
	P2_SpodnyStoper_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_SpodnyStoper_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - Stoper zakladaca tesnenia//*)

TYPE
	P2_StoperZaklTesnenia_typ : 	STRUCT 
		CMD : P2_StoperZaklTesnenia_CMD_typ;
		IN : P2_StoperZaklTesnenia_IN_typ;
		OUT : P2_StoperZaklTesnenia_OUT_typ;
		PAR : P2_StoperZaklTesnenia_PAR_typ;
		STAV : P2_StoperZaklTesnenia_STAV_typ;
		Banner : BannerIOlink;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_StoperZaklTesnenia_CMD_typ : 	STRUCT 
		Banner_LED_OFF : BOOL;
	END_STRUCT;
	P2_StoperZaklTesnenia_IN_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_StoperZaklTesnenia_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV037_VT2*)
	END_STRUCT;
	P2_StoperZaklTesnenia_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		IndexFotky : USINT;
		StaryQRkod_Filtra5H : STRING[32];
	END_STRUCT;
	P2_StoperZaklTesnenia_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
		ObsluhaOznacilaPaletku_NG : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - ZakladaË tesnenia//*)

TYPE
	P2_ZakladacTesnenia_typ : 	STRUCT 
		CMD : P2_ZakladacTesnenia_CMD_typ;
		IN : P2_ZakladacTesnenia_IN_typ;
		OUT : P2_ZakladacTesnenia_OUT_typ;
		PAR : P2_ZakladacTesnenia_PAR_typ;
		STAV : P2_ZakladacTesnenia_STAV_typ;
		COM_IN : P2_ZakladacTesnenia_COM_IN_typ;
		COM_OUT : P2_ZakladacTesnenia_COM_OUT_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		ServoZdvihuZakladaca : ServoDriver;
		ServoPojazduZakladaca : ServoDriver;
	END_STRUCT;
	P2_ZakladacTesnenia_CMD_typ : 	STRUCT 
		RR_PojazdZakladaca_VYSUN : BOOL;
		RR_PojazdZakladaca_ZASUN : BOOL;
		RR_ZdvihZakladaca_HORE : BOOL;
		RR_ZdvihZakladaca_DOLE : BOOL;
	END_STRUCT;
	P2_ZakladacTesnenia_IN_typ : 	STRUCT 
		ZdvihZakladaca_HornyLimSnimac : BOOL; (*IS2_35*)
		Kopito_ZakladPoloha : BOOL; (*IS2_34*)
		Pojazd_PritomPowerCP : BOOL; (*OS2_4*)
	END_STRUCT;
	P2_ZakladacTesnenia_OUT_typ : 	STRUCT 
		LED_DvojrucneOvladanie_ON : BOOL;
	END_STRUCT;
	P2_ZakladacTesnenia_PAR_typ : 	STRUCT 
		IndexPaletky : USINT;
		ZakladacPojazd_JoggRychlost : REAL;
		ZakladacZdvih_JoggRychlost : REAL;
	END_STRUCT;
	P2_ZakladacTesnenia_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
	END_STRUCT;
	P2_ZakladacTesnenia_COM_IN_typ : 	STRUCT 
		ZalozTesnenie : BOOL;
	END_STRUCT;
	P2_ZakladacTesnenia_COM_OUT_typ : 	STRUCT 
		Stav_ZalozenieTesneniaUkoncene : BOOL;
		VysledokZalozeniaTesnenia : STRING[2]; (*OK alebo NG*)
	END_STRUCT;
END_TYPE

(*//P2 - Stoper matÌcovaËky//*)

TYPE
	P2_StoperMaticovacky_typ : 	STRUCT 
		CMD : P2_StoperMaticovacky_CMD_typ;
		IN : P2_StoperMaticovacky_IN_typ;
		OUT : P2_StoperMaticovacky_OUT_typ;
		PAR : P2_StoperMaticovacky_PAR_typ;
		STAV : P2_StoperMaticovacky_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		RFID_hlava : SickHeads;
		Maticovacka_M4 : SkrutkovackaAtlasCopco_typ;
		SkrutSet_MaticaM4 : MaticaSet;
	END_STRUCT;
	P2_StoperMaticovacky_CMD_typ : 	STRUCT 
		RR_Maticovacku_VYSUN : BOOL;
		RR_Maticovacku_ZASUN : BOOL;
	END_STRUCT;
	P2_StoperMaticovacky_IN_typ : 	STRUCT 
		Centrovanie_VYSUNUTE : BOOL; (*IS2_1*)
		Centrovanie_ZASUNUTE : BOOL; (*IS2_2*)
		Maticovacka_M4_ZASUNUTA : BOOL; (*MS2_5*)
	END_STRUCT;
	P2_StoperMaticovacky_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV038_VT2*)
		Centrovanie_VYSUN : BOOL; (*YV039_VT2*)
		Centrovanie_ZASUN : BOOL; (*VY040_VT2*)
		Maticovacku_M4_VYSUN : BOOL; (*YV072_VT2*)
		Maticovacku_M4_ZASUN : BOOL; (*YV074_VT2*)
		Maticovacka_M4_Prisavanie_ON : BOOL; (*YV070_VT2*)
		Maticovacka_M4_Odvzdusn_ON : BOOL; (*YV071_VT2*)
	END_STRUCT;
	P2_StoperMaticovacky_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		IndexFotky : USINT;
		Maticov_M4_AktualHodnVysunutia : UINT; (*IO-Link snÌmaË*)
		MaticeM4_AtlasCopcoInputs : ARRAY[0..7]OF UDINT;
		MaticeM4_AtlasCopcoOutputs : ARRAY[0..7]OF UDINT;
	END_STRUCT;
	P2_StoperMaticovacky_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
		VysledokSkrutkovaniaMatice : STRING[2]; (*OK alebo NG*)
		DosiahnutyMoment_REAL : REAL;
		DosiahnutyMoment : UDINT;
		Moment_ToleranciaMAX_REAL : REAL;
		Moment_ToleranciaMAX : UDINT;
		Moment_ToleranciaMIN_REAL : REAL;
		Moment_ToleranciaMIN : UDINT;
		DosiahnutyUhol : UINT;
		Uhol_ToleranciaMAX_REAL : REAL;
		Uhol_ToleranciaMAX : UDINT;
		Uhol_ToleranciaMIN_REAL : REAL;
		Uhol_ToleranciaMIN : UDINT;
	END_STRUCT;
END_TYPE

(*//P2 - AkumulaËn˝ stoper//*)

TYPE
	P2_AkumulacnyStoper_typ : 	STRUCT 
		IN : P2_AkumulacnyStoper_IN_typ;
		OUT : P2_AkumulacnyStoper_OUT_typ;
		PAR : P2_AkumulacnyStoper_PAR_typ;
		STAV : P2_AkumulacnyStoper_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_AkumulacnyStoper_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS2_3*)
	END_STRUCT;
	P2_AkumulacnyStoper_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV041_VT2*)
	END_STRUCT;
	P2_AkumulacnyStoper_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_AkumulacnyStoper_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - Stoper örobovania//*)

TYPE
	P2_StoperSrobovania_typ : 	STRUCT 
		CMD : P2_StoperSrobovania_CMD_typ;
		IN : P2_StoperSrobovania_IN_typ;
		OUT : P2_StoperSrobovania_OUT_typ;
		PAR : P2_StoperSrobovania_PAR_typ;
		STAV : P2_StoperSrobovania_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_StoperSrobovania_CMD_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_StoperSrobovania_IN_typ : 	STRUCT 
		Centrovanie_VYSUNUTE : BOOL; (*IS2_4*)
		Centrovanie_ZASUNUTE : BOOL; (*IS2_5*)
	END_STRUCT;
	P2_StoperSrobovania_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV042_VT2*)
		Centrovanie_VYSUN : BOOL; (*YV043_VT2*)
		Centrovanie_ZASUN : BOOL; (*YV044_VT2*)
	END_STRUCT;
	P2_StoperSrobovania_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		IndexFotky : USINT;
	END_STRUCT;
	P2_StoperSrobovania_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - ärobovanie//*)

TYPE
	P2_Srobovanie_typ : 	STRUCT 
		CMD : P2_Srobovanie_CMD_typ;
		IN : P2_Srobovanie_IN_typ;
		OUT : P2_Srobovanie_OUT_typ;
		PAR : P2_Srobovanie_PAR_typ;
		STAV : P2_Srobovanie_STAV_typ;
		COM_IN : P2_Srobovanie_COM_IN_typ;
		COM_OUT : P2_Srobovanie_COM_OUT_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		ServoManipulOsX : ServoDriver;
		ServoManipulOsY : ServoDriver;
		ServoManipulOsZ_M4 : ServoDriver;
		Skrutkovacka_M4 : SkrutkovackaAtlasCopco_typ;
		Skrutkovacka_M5 : SkrutkovackaAtlasCopco_typ;
		Skrutkovacka_M6 : SkrutkovackaAtlasCopco_typ;
		SkrutSet_M4 : PickAndPlace;
		SkrutSet_M5 : ScrewLoading;
		SkrutSet_M6 : ScrewLoading;
	END_STRUCT;
	P2_Srobovanie_CMD_typ : 	STRUCT 
		RR_SkrutkovackuM6_VYSUN : BOOL;
		RR_SkrutkovackuM5_VYSUN : BOOL;
		RR_Manipulator_OsX_VPRAVO : BOOL;
		RR_Manipulator_OsX_VLAVO : BOOL;
		RR_Manipulator_OsY_VPRED : BOOL;
		RR_Manipulator_OsY_VZAD : BOOL;
		RR_SkrutkovackaM4_OsZ_HORE : BOOL;
		RR_SkrutkovackaM4_OsZ_DOLE : BOOL;
		RR_PrisavanieSkrutkyM6_ON : BOOL;
		RR_PrisavanieSkrutkyM5_ON : BOOL;
		RR_PrisavanieSkrutkyM4_ON : BOOL;
		RR_CistenieSkrutkovackyM6 : BOOL;
		RR_CistenieSkrutkovackyM5 : BOOL;
		RR_SkrutSetM6_Zasobnik_RUN : BOOL;
		RR_SkrutSetM6_PodajSkrutku : BOOL;
		RR_SkrutSetM5_Zasobnik_RUN : BOOL;
		RR_SkrutSetM5_PodajSkrutku : BOOL;
		RR_SkrutSetM4_Zasobnik_RUN : BOOL;
		RR_SkrutSetM4_Vibrolista_RUN : BOOL;
		RR_SkrutSetM4_PodajSkrutku : BOOL;
		RR_PolohujManipulator : BOOL;
	END_STRUCT;
	P2_Srobovanie_IN_typ : 	STRUCT 
		ManipulOsX_LimSnimac_POS : BOOL; (*IS2_14*)
		ManipulOsX_LimSnimac_NEG : BOOL; (*IS2_13*)
		ManipulOsY_LimSnimac_POS : BOOL; (*IS2_16*)
		ManipulOsY_LimSnimac_NEG : BOOL; (*IS2_15*)
		ManipulOsZ_M4_LimSnimacHorny : BOOL; (*IS2_17*)
		ManipulOsZ_M4_LimSnimacSpodny : BOOL; (*IS2_18*)
		Skrutkovacka_M6_ZASUNUTA : BOOL; (*MS2_11*)
		Skrutkovacka_M5_ZASUNUTA : BOOL; (*MS2_10*)
		Skrutkovacka_M4_Vakum_OK : BOOL; (*S2_9*)
		NapajanieSkrutkovackyM6_OK : BOOL;
		NapajanieSkrutkovackyM4_OK : BOOL;
		NapajanieSkrutkovackyM5_OK : BOOL;
		NapajanieZasobnikaM6_OK : BOOL;
		NapajanieZasobnikaM4_OK : BOOL;
		NapajanieZasobnikaM5_OK : BOOL;
		NapajanieVibrolistyM4_OK : BOOL;
	END_STRUCT;
	P2_Srobovanie_OUT_typ : 	STRUCT 
		Skrutkovacku_M6_VYSUN : BOOL; (*YV089_VT2*)
		Skrutkovacka_M6_Prisavanie_ON : BOOL; (*YV087_VT2*)
		Skrutkovacka_M6_Odvzdusn_ON : BOOL; (*YV088_VT2*)
		Skrutkovacku_M5_VYSUN : BOOL; (*YV096_VT2*)
		Skrutkovacka_M5_Prisavanie_ON : BOOL; (*YV094_VT2*)
		Skrutkovacka_M5_Odvzdusn_ON : BOOL; (*YV095_VT2*)
		Skrutkovacka_M4_Prisavanie_ON : BOOL; (*YV101_VT2*)
		Skrutkovacka_M4_Prisavanie_OFF : BOOL; (*YV102_VT2*)
		Skrutkovacka_M4_Odvzdusn_ON : BOOL; (*YV103_VT2*)
	END_STRUCT;
	P2_Srobovanie_PAR_typ : 	STRUCT 
		ManipulOsZ_M4_AktualnaPozicia : REAL;
		Skrutkov_M5_AktualHodnVysunutia : UINT; (*IO-Link snÌmaË*)
		Skrutkov_M6_AktualHodnVysunutia : UINT; (*IO-Link snÌmaË*)
		ManipulOsX_AktualnaPozicia : REAL;
		ManipulOsY_AktualnaPozicia : REAL;
		RR_IndexPolohovaniaManipulatora : USINT;
		RR_TypModelu : STRING[2];
		ManipulOsX_JoggRychlost : REAL;
		ManipulOsY_JoggRychlost : REAL;
		ManipulOsZ_M4_JoggRychlost : REAL;
	END_STRUCT;
	P2_Srobovanie_STAV_typ : 	STRUCT 
		RR_Polohovanie_BUSY : BOOL;
		PoINIT : BOOL;
		Vysledok_Srobovania : STRING[2]; (*OK alebo NG*)
		M6_DosiahnutyMoment_REAL : REAL;
		M6_DosiahnutyMoment : UDINT;
		M6_Moment_ToleranciaMAX_REAL : REAL;
		M6_Moment_ToleranciaMAX : UDINT;
		M6_Moment_ToleranciaMIN_REAL : REAL;
		M6_Moment_ToleranciaMIN : UDINT;
		M6_DosiahnutyUhol : UINT;
		M6_Uhol_ToleranciaMAX_REAL : REAL;
		M6_Uhol_ToleranciaMAX : UDINT;
		M6_Uhol_ToleranciaMIN_REAL : REAL;
		M6_Uhol_ToleranciaMIN : UDINT;
		M5_DosiahnutyMoment_REAL : REAL;
		M5_DosiahnutyMoment : UDINT;
		M5_Moment_ToleranciaMAX_REAL : REAL;
		M5_Moment_ToleranciaMAX : UDINT;
		M5_Moment_ToleranciaMIN_REAL : REAL;
		M5_Moment_ToleranciaMIN : UDINT;
		M5_DosiahnutyUhol : UINT;
		M5_Uhol_ToleranciaMAX_REAL : REAL;
		M5_Uhol_ToleranciaMAX : UDINT;
		M5_Uhol_ToleranciaMIN_REAL : REAL;
		M5_Uhol_ToleranciaMIN : UDINT;
		M4_DosiahnutyMoment_REAL : REAL;
		M4_DosiahnutyMoment : UDINT;
		M4_Moment_ToleranciaMAX_REAL : REAL;
		M4_Moment_ToleranciaMAX : UDINT;
		M4_Moment_ToleranciaMIN_REAL : REAL;
		M4_Moment_ToleranciaMIN : UDINT;
		M4_DosiahnutyUhol : UINT;
		M4_Uhol_ToleranciaMAX_REAL : REAL;
		M4_Uhol_ToleranciaMAX : UDINT;
		M4_Uhol_ToleranciaMIN_REAL : REAL;
		M4_Uhol_ToleranciaMIN : UDINT;
	END_STRUCT;
	P2_Srobovanie_COM_IN_typ : 	STRUCT 
		PresunManipulatora_VPRED : BOOL;
		PresunManipulatora_VZAD : BOOL;
		Model45F_ZaskrutkujLavuM6 : BOOL;
		Model45F_ZaskrutkujPravuM6 : BOOL;
		Model45F_ZaskrutkujLavuM4 : BOOL;
		Model45F_ZaskrutkujPravuM4 : BOOL;
		Model5H_ZaskrutkujLavuM5 : BOOL;
		Model5H_ZaskrutkujPravuM5 : BOOL;
		Model5H_ZaskrutkujStrednuM4 : BOOL;
	END_STRUCT;
	P2_Srobovanie_COM_OUT_typ : 	STRUCT 
		Stav_SkrutkovanieUkoncene : BOOL;
		Stav_PresunManipulUkonceny : BOOL;
		Stav_PoruchaSkrutkovania : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - Robot//*)

TYPE
	P2_Robot_typ : 	STRUCT 
		CMD : P2_Robot_CMD_typ;
		IN : P2_Robot_IN_typ;
		OUT : P2_Robot_OUT_typ;
		PAR : P2_Robot_PAR_typ;
		STAV : P2_Robot_STAV_typ;
		COM_IN : P2_Robot_COM_IN_typ;
		COM_OUT : P2_Robot_COM_OUT_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_Robot_CMD_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_Robot_IN_typ : 	STRUCT 
		TypGripra_MvCase : BOOL; (*ROBHLA_013*)
		TypGripra_45F : BOOL; (*GRMECH_035*)
		TypGripra_5H : BOOL; (*GRMECH_036*)
		KodGripra_Bit0 : BOOL;
		KodGripra_Bit1 : BOOL;
		Model45F_Vakum_OK : BOOL; (*S2_6*)
		Model5H_Vakum_OK : BOOL; (*S2_7*)
		DokStanica_PritomGripraMvCase : BOOL; (*IS2_10 - Griper pre TopCover a MvCase*)
		DokStanica_PritomGripraBusbar45F : BOOL; (*IS2_11*)
		DokStanica_PritomGripraBusbar5H : BOOL; (*IS2_12*)
		GriperMvCase_Otvoreny : BOOL; (*IS2_37*)
		GriperMvCase_DrziPowerCP : BOOL; (*IS2_36*)
		GriperMvCase_DrziMvCase : BOOL; (*IS2_38*)
		GriperMvCase_Zatvoreny : BOOL;
		Griper45F_Otvoreny : BOOL;
		Griper45F_Zatvoreny : BOOL;
		Griper45F_DrziBusbary : BOOL;
		Griper5H_Otvoreny : BOOL;
		Griper5H_Zatvoreny : BOOL;
		Griper5H_DrziBusbary : BOOL;
	END_STRUCT;
	P2_Robot_OUT_typ : 	STRUCT 
		OdistiGriper : BOOL; (*YV050_VT2*)
		ZaistiGriper : BOOL; (*YV049_VT2*)
		Griper_OTVOR : BOOL; (*YV051_VT2*)
		Griper_ZATVOR : BOOL; (*YV052_VT2*)
		Model45F_Vakum_ON : BOOL; (*YV054_VT2*)
		Model45F_Vakum_OFF : BOOL; (*YV055_VT2*)
		Model5H_Vakum_ON : BOOL; (*YV056_VT2*)
		Model5H_Vakum_OFF : BOOL; (*YV057_VT2*)
		PneuZamokUchopovaca_ODOMKNI : BOOL; (*YV053_VT2*)
	END_STRUCT;
	P2_Robot_PAR_typ : 	STRUCT 
		Griper_Busbary45F_HodnOtvorenia : UINT; (*GRMECH_035 - IO-Link snÌmaË*)
		Griper_Busbary5H_HodnOtvorenia : UINT; (*GRMECH_036 - IO-Link snÌmaË*)
	END_STRUCT;
	P2_Robot_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		DrziBusbar_4F : BOOL;
		DrziBusbar_5F : BOOL;
		DrziBusbar_5H : BOOL;
		Zvaranie_PrebiehaManipulacia : BOOL;
		Srobovanie_PrebiehaManipulacia : BOOL;
	END_STRUCT;
	P2_Robot_COM_IN_typ : 	STRUCT 
		BYTE_IN : ARRAY[0..63]OF USINT; (*Z robota do PLC*)
		Stav_Busbary4F_Odobrate : BOOL;
		Stav_Busbary4F_Polozene : BOOL;
		Stav_Busbary5F_Odobrate : BOOL;
		Stav_Busbary5F_Polozene : BOOL;
		Stav_Busbary5H_Odobrate : BOOL;
		Stav_Busbary5H_Polozene : BOOL;
		Stav_PravyMvCase4F_Odobraty : BOOL;
		Stav_PravyMvCase4F_Polozeny : BOOL;
		Stav_LavyMvCase4F_Odobraty : BOOL;
		Stav_LavyMvCase4F_Polozeny : BOOL;
		Stav_PravyMvCase5F_Odobraty : BOOL;
		Stav_PravyMvCase5F_Polozeny : BOOL;
		Stav_LavyMvCase5F_Odobraty : BOOL;
		Stav_LavyMvCase5F_Polozeny : BOOL;
		Stav_PravyMvCase5H_Odobraty : BOOL;
		Stav_PravyMvCase5H_Polozeny : BOOL;
		Stav_LavyMvCase5H_Odobraty : BOOL;
		Stav_LavyMvCase5H_Polozeny : BOOL;
		Stav_TopCover4F_Odobraty : BOOL;
		Stav_TopCover4F_Polozeny : BOOL;
		Stav_TopCover5F_Odobraty : BOOL;
		Stav_TopCover5F_Polozeny : BOOL;
		Stav_TopCover5H_Odobraty : BOOL;
		Stav_TopCover5H_Polozeny : BOOL;
		Stav_Filter5H_Dotlaceny : BOOL;
		Stav_RobotOdparkovany : BOOL;
		Stav_RobotPoziciaCakania : BOOL;
		Stav_RobotBezpPozicia_Srobovanie : BOOL;
		Stav_RobotBezpPozicia_Zvaranie : BOOL;
		Stav_BusbaryUvolnene : BOOL;
		Stav_MotoryON : BOOL;
		Stav_MotoryOFF : BOOL;
		Stav_ProgramRUN : BOOL;
		Stav_RezimAUTOMAT : BOOL;
		Stav_RobotCS : BOOL;
		Stav_VystupyZresetovane : BOOL;
		Stav_Cistenie_PowerCP_Odobrate : BOOL;
		Stav_Cistenie_PowerCP_Polozene : BOOL;
		Stav_Cistenie_PowerCP_v_Cisteni : BOOL;
		Stav_Cistenie_Otacanie_Ukoncene : BOOL;
		Stav_Griper4F5F_Vymeneny : BOOL;
		Stav_Griper5H_Vymeneny : BOOL;
		Stav_GriperCistenia_Vymeneny : BOOL;
		Stav_RobotOdoberaCover : BOOL;
	END_STRUCT;
	P2_Robot_COM_OUT_typ : 	STRUCT 
		BYTE_OUT : ARRAY[0..63]OF USINT; (*Z PLC do Robota*)
		ManipSrobovania_BezpecnaPozicia : BOOL;
		Zvaranie_BezpecnaPozicia : BOOL;
		Cistenie_BezpecnaPozicia : BOOL;
		Odober_Busbary4F : BOOL;
		Poloz_Busbary4F : BOOL;
		Odober_Busbary5F : BOOL;
		Poloz_Busbary5F : BOOL;
		Odober_Busbary5H : BOOL;
		Poloz_Busbary5H : BOOL;
		Odober_PravyMvCase4F : BOOL;
		Poloz_PravyMvCase4F : BOOL;
		Odober_LavyMvCase4F : BOOL;
		Poloz_LavyMvCase4F : BOOL;
		Odober_PravyMvCase5F : BOOL;
		Poloz_PravyMvCase5F : BOOL;
		Odober_LavyMvCase5F : BOOL;
		Poloz_LavyMvCase5F : BOOL;
		Odober_PravyMvCase5H : BOOL;
		Poloz_PravyMvCase5H : BOOL;
		Odober_LavyMvCase5H : BOOL;
		Poloz_LavyMvCase5H : BOOL;
		Odober_TopCover4F : BOOL;
		Poloz_TopCover4F : BOOL;
		Odober_TopCover5F : BOOL;
		Poloz_TopCover5F : BOOL;
		Odober_TopCover5H : BOOL;
		Poloz_TopCover5H : BOOL;
		Dotlac_Filter5H : BOOL;
		Cistenie_OdoberPowerCP_4F : BOOL;
		Cistenie_OdoberPowerCP_5F : BOOL;
		Cistenie_OdoberPowerCP_5H : BOOL;
		Cistenie_OtacajPowerCP : BOOL;
		Cistenie_PolozPowerCP_4F : BOOL;
		Cistenie_PolozPowerCP_5F : BOOL;
		Cistenie_PolozPowerCP_5H : BOOL;
		Presun_CakaciaPozicia : BOOL;
		UvolniBusbary : BOOL;
		Odparkovanie : BOOL;
		ZapniMotory : BOOL;
		VypniMotory : BOOL;
		PP_na_Main : BOOL;
		Reset_CS : BOOL;
		StartProgramu : BOOL;
		StartProgramuMain : BOOL;
		StopProgramu : BOOL;
		Griper4F_Otvoreny : BOOL;
		Griper4F_Zatvoreny : BOOL;
		Griper4F_DrziBusbary : BOOL;
		Griper5H_Otvoreny : BOOL;
		Griper5H_Zatvoreny : BOOL;
		Griper5H_DrziBusbary : BOOL;
		GriperMvCase_Zatvoreny : BOOL; (*Griper pre MV Case a Top Cover*)
		GriperMvCase_Otvoreny : BOOL; (*Griper pre MV Case a Top Cover*)
		GriperMvCase_DrziPowerCP : BOOL;
		GriperMvCase_DrziMVcase : BOOL;
		ZmenaGripra_4F5F : BOOL;
		ZmenaGripra_5H : BOOL;
		ZmenaGripra_Cistenie : BOOL;
		ZopakujOdoberanie : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - Stoper zvarania//*)

TYPE
	P2_StoperZvarania_typ : 	STRUCT 
		CMD : P2_StoperZvarania_CMD_typ;
		IN : P2_StoperZvarania_IN_typ;
		OUT : P2_StoperZvarania_OUT_typ;
		PAR : P2_StoperZvarania_PAR_typ;
		STAV : P2_StoperZvarania_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_StoperZvarania_CMD_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_StoperZvarania_IN_typ : 	STRUCT 
		Centrovanie_VYSUNUTE : BOOL; (*IS2_6*)
		Centrovanie_ZASUNUTE : BOOL; (*IS2_7*)
	END_STRUCT;
	P2_StoperZvarania_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV045_VT2*)
		Centrovanie_VYSUN : BOOL; (*YV046_VT2*)
		Centrovanie_ZASUN : BOOL; (*YV047_VT2*)
	END_STRUCT;
	P2_StoperZvarania_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		IndexFotky : USINT;
	END_STRUCT;
	P2_StoperZvarania_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - Zvaranie//*)

TYPE
	P2_Zvaranie_typ : 	STRUCT 
		CMD : P2_Zvaranie_CMD_typ;
		IN : P2_Zvaranie_IN_typ;
		OUT : P2_Zvaranie_OUT_typ;
		PAR : P2_Zvaranie_PAR_typ;
		STAV : P2_Zvaranie_STAV_typ;
		COM_IN : P2_Zvaranie_COM_IN_typ;
		COM_OUT : P2_Zvaranie_COM_OUT_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		ServoZdvihuZvarania : ServoDriver;
	END_STRUCT;
	P2_Zvaranie_CMD_typ : 	STRUCT 
		RR_ZdvihZvarania_HORE : BOOL;
		RR_ZdvihZvarania_DOLE : BOOL;
	END_STRUCT;
	P2_Zvaranie_IN_typ : 	STRUCT 
		ZdvihZvarania_HornyLimSnimac : BOOL; (*IS2_19*)
		ZvaraniePresunute_VPRAVO : BOOL; (*IS2_20*)
		ZvaraniePresunute_VLAVO : BOOL; (*IS2_21*)
		NapajanieZvaracky_OK : BOOL;
		ZvarackaStav_RUN : BOOL;
		ZvarackaStav_READY : BOOL;
	END_STRUCT;
	P2_Zvaranie_OUT_typ : 	STRUCT 
		PresunZvaranie_VPRAVO : BOOL; (*YV063_VT2*)
		PresunZvarania_VLAVO : BOOL; (*YV064_VT2*)
		Zvaracka_START : BOOL;
		Zvaracka_RESET : BOOL;
	END_STRUCT;
	P2_Zvaranie_PAR_typ : 	STRUCT 
		ZdvihZvarania_JoggRychlost : REAL;
	END_STRUCT;
	P2_Zvaranie_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		Vysledok_Zvarania : STRING[2]; (*OK alebo NG*)
	END_STRUCT;
	P2_Zvaranie_COM_IN_typ : 	STRUCT 
		Zvaranie_START : BOOL;
		Zatlacanie_START : BOOL;
	END_STRUCT;
	P2_Zvaranie_COM_OUT_typ : 	STRUCT 
		Stav_ZvaranieUkoncene : BOOL;
		Stav_ZatlacenieUkoncene : BOOL;
	END_STRUCT;
END_TYPE

(*//P2 - »istenie//*)

TYPE
	P2_Cistenie_typ : 	STRUCT 
		CMD : P2_Cistenie_CMD_typ;
		IN : P2_Cistenie_IN_typ;
		OUT : P2_Cistenie_OUT_typ;
		PAR : P2_Cistenie_PAR_typ;
		STAV : P2_Cistenie_STAV_typ;
		COM_IN : P2_Cistenie_COM_IN_typ;
		COM_OUT : P2_Cistenie_COM_OUT_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P2_Cistenie_CMD_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P2_Cistenie_IN_typ : 	STRUCT 
		Dvere_OTVORENE : BOOL; (*MS2_1*)
		Dvere_ZATVORENE : BOOL; (*MS2_2*)
		Vakum_OK : BOOL; (*S2_8*)
		Ionizator_Alarm1 : BOOL;
		Ionizator_Alarm2 : BOOL;
		Ionizator_Alarm3 : BOOL;
	END_STRUCT;
	P2_Cistenie_OUT_typ : 	STRUCT 
		Ionizator_ON : BOOL; (*YV060_VT2*)
		VzduchPreIonizator_ON : BOOL;
		Dvere_ZATVOR : BOOL;
		Dvere_OTVOR : BOOL;
		Odsavanie_ON : BOOL; (*YV061_VT2*)
		OdsavanieOfuk_ON : BOOL; (*YV062_VT2*)
	END_STRUCT;
	P2_Cistenie_PAR_typ : 	STRUCT 
		PAR_0 : USINT;
	END_STRUCT;
	P2_Cistenie_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
	END_STRUCT;
	P2_Cistenie_COM_IN_typ : 	STRUCT 
		Cistenie_START : BOOL;
	END_STRUCT;
	P2_Cistenie_COM_OUT_typ : 	STRUCT 
		Stav_CistenieUkoncene : BOOL;
	END_STRUCT;
END_TYPE

(***********************************Pracovisko 3****************************************************************)

TYPE
	P3_Pracovisko_typ : 	STRUCT 
		IN : P3_Pracovisko_IN_typ;
		OUT : P3_Pracovisko_OUT_typ;
		PAR : P3_Pracovisko_PAR_typ;
		STAV : P3_Pracovisko_STAV_typ;
		COM_Weidmuller : P3_COM_Weidmuller_typ;
		COM_Festo : P3_COM_Festo_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_Pracovisko_IN_typ : 	STRUCT 
		TlakVzduchu_OK : BOOL; (*S3_7*)
		ModulWeidmuller_IO_KomOK : BOOL;
		VentilovyTerminal_KomOK : BOOL;
		Skrutkovacka_K40_KomOK : BOOL;
		Skrutkovacka_M5_KomOK : BOOL;
		ModulFesto_IO_KomOK : BOOL;
		ServoManipulatorOsY_KomOK : BOOL;
		ServoManipulatorOsZ_M5_KomOK : BOOL;
		Kamery_ControlUnit_KomOK : BOOL;
		LeakageTesterA_KomOK : BOOL;
		LeakageTesterB_KomOK : BOOL;
	END_STRUCT;
	P3_Pracovisko_OUT_typ : 	STRUCT 
		Majak_ZeleneSvetlo_ON : BOOL;
		Majak_OranzoveSvetlo_ON : BOOL;
		Majak_CerveneSvetlo_ON : BOOL;
		Majak_Hukacka_ON : BOOL;
		OsvetlenieBunky_ON : BOOL;
		Osvetlenie_CAM13_ON : BOOL;
		ZdvizkyPneuZamok_ODOMKNI : BOOL; (*YV166_VT3*)
	END_STRUCT;
	P3_Pracovisko_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P3_Pracovisko_STAV_typ : 	STRUCT 
		Automat : BOOL;
		Manual : BOOL;
		PoINIT : BOOL;
		READY : BOOL;
		HardwareBunky_OK : BOOL;
		Porucha_ST1 : BOOL; (*ärobovanie*)
		Porucha_ST2 : BOOL; (*HV test*)
		Porucha_ST3 : BOOL; (*Zdvizka pred Leakage testom A*)
		Porucha_ST4 : BOOL; (*Zdvizka pred Leakage testom B*)
		Porucha_ST5 : BOOL; (*Leakage test A*)
		Porucha_ST6 : BOOL; (*Leakage test B*)
		Porucha_ST7 : BOOL; (*Zdvizka za Leakage testom A*)
		Porucha_ST8 : BOOL; (*Zdvizka za Leakage testom B*)
		SkrutkovackyZasunute : BOOL;
		UkoncenieCyklu_BUSY : BOOL;
		HVtest_Zasunuty : BOOL;
		LeakageTestA_Zasunuty : BOOL;
		LeakageTestB_Zasunuty : BOOL;
	END_STRUCT;
	P3_COM_Weidmuller_typ : 	STRUCT 
		AB3_5_8DI : USINT;
		AB3_6_8DI : USINT;
		AB3_7_8DI : USINT;
		AB3_8_8DI : USINT;
		AB3_9_8DO : USINT;
		AB3_10_8DO : USINT;
		AB3_12_8DO : USINT;
	END_STRUCT;
	P3_COM_Festo_typ : 	STRUCT 
		DM3_1_4DI : ARRAY[0..3]OF BOOL;
		DM3_1_4DO : ARRAY[0..3]OF BOOL;
		DI3_1_8DI : ARRAY[0..7]OF BOOL;
		DI3_2_8DI : ARRAY[0..7]OF BOOL;
		DI3_3_8DI : ARRAY[0..7]OF BOOL;
		DI3_4_8DI : ARRAY[0..7]OF BOOL;
		DI3_5_8DI : ARRAY[0..7]OF BOOL;
		DI3_6_8DI : ARRAY[0..7]OF BOOL;
		DI3_7_8DI : ARRAY[0..7]OF BOOL;
		DI3_8_8DI : ARRAY[0..7]OF BOOL;
		DI3_9_8DI : ARRAY[0..7]OF BOOL;
		DI3_10_8DI : ARRAY[0..7]OF BOOL;
		DS3_1_Port0_IN : ARRAY[0..31]OF USINT;
		DS3_1_Port0_OUT : ARRAY[0..31]OF USINT;
		DS3_1_Port1_IN : ARRAY[0..31]OF USINT;
		DS3_1_Port1_OUT : ARRAY[0..31]OF USINT;
		DS3_1_Port2_IN : ARRAY[0..31]OF USINT;
		DS3_1_Port2_OUT : ARRAY[0..31]OF USINT;
		DS3_1_Port3_IN : ARRAY[0..31]OF USINT;
		DS3_1_Port3_OUT : ARRAY[0..31]OF USINT;
		DS3_2_Port0_IN : ARRAY[0..1]OF USINT;
		DS3_2_Port0_OUT : ARRAY[0..1]OF USINT;
		DS3_2_Port1_IN : ARRAY[0..1]OF USINT;
		DS3_2_Port1_OUT : ARRAY[0..1]OF USINT;
		DS3_2_Port2_IN : ARRAY[0..1]OF USINT;
		DS3_2_Port2_OUT : ARRAY[0..1]OF USINT;
	END_STRUCT;
END_TYPE

(*//P3 - DopravnÌky//*)

TYPE
	P3_Dopravniky_typ : 	STRUCT 
		IN : P3_Dopravniky_IN_typ;
		OUT : P3_Dopravniky_OUT_typ;
		PAR : P3_Dopravniky_PAR_typ;
		STAV : P3_Dopravniky_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_Dopravniky_IN_typ : 	STRUCT 
		StavRiadeniaVratnehoDoprav_READY : BOOL; (*M3_12*)
		StavRiadPredDopravBunky_READY : BOOL; (*M3_8*)
		StavRiadZadnDopravBunky_READY : BOOL; (*M3_11*)
		StavRiadeniaPriecnDoprav1_READY : BOOL; (*M3_9*)
		StavRiadeniaPriecnDoprav2_READY : BOOL; (*M3_10*)
		TeplotaMotoraVratnehoDoprav_NG : BOOL; (*M3_12*)
		TeplotaMotoraPredDopravBunky_NG : BOOL; (*M3_8*)
		TeplotaMotoraZadnDopravBunky_NG : BOOL; (*M3_11*)
		TeplotaMotoraPriecnDoprav1_NG : BOOL; (*M3_9*)
		TeplotaMotoraPriecnDoprav2_NG : BOOL; (*M3_10*)
	END_STRUCT;
	P3_Dopravniky_OUT_typ : 	STRUCT 
		PrednyDopravnikBunky_ON : BOOL; (*M3_8*)
		ZadnyDopravnikBunky_ON : BOOL; (*M3_11*)
		VratnyDopravnik_ON : BOOL; (*M3_12*)
		PriecnyDopravnik1_VPRED : BOOL; (*M3_9 - Smerom na traù B*)
		PriecnyDopravnik2_VPRED : BOOL; (*M3_10 - Smerom na traù B*)
		PriecnyDopravnik2_VZAD : BOOL; (*M3_10 - Smerom na traù A*)
	END_STRUCT;
	P3_Dopravniky_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P3_Dopravniky_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - Spodn˝ stoper//*)

TYPE
	P3_SpodnyStoper_typ : 	STRUCT 
		IN : P3_SpodnyStoper_IN_typ;
		OUT : P3_SpodnyStoper_OUT_typ;
		PAR : P3_SpodnyStoper_PAR_typ;
		STAV : P3_SpodnyStoper_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_SpodnyStoper_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS3_26*)
		ZaplnenieDopravnika : BOOL; (*IS3_27*)
	END_STRUCT;
	P3_SpodnyStoper_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV125_VT3*)
	END_STRUCT;
	P3_SpodnyStoper_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P3_SpodnyStoper_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - Stoper örobovania//*)

TYPE
	P3_StoperSrobovania_typ : 	STRUCT 
		CMD : P3_StoperSrobovania_CMD_typ;
		IN : P3_StoperSrobovania_IN_typ;
		OUT : P3_StoperSrobovania_OUT_typ;
		PAR : P3_StoperSrobovania_PAR_typ;
		STAV : P3_StoperSrobovania_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_StoperSrobovania_CMD_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P3_StoperSrobovania_IN_typ : 	STRUCT 
		Centrovanie_VYSUNUTE : BOOL; (*IS3_5*)
		Centrovanie_ZASUNUTE : BOOL; (*IS3_6*)
	END_STRUCT;
	P3_StoperSrobovania_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV104_VT3*)
		Centrovanie_VYSUN : BOOL; (*YV105_VT3*)
		Centrovanie_ZASUN : BOOL; (*YV106_VT3*)
	END_STRUCT;
	P3_StoperSrobovania_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		IndexFotky : USINT;
	END_STRUCT;
	P3_StoperSrobovania_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - ärobovanie//*)

TYPE
	P3_Srobovanie_typ : 	STRUCT 
		CMD : P3_Srobovanie_CMD_typ;
		IN : P3_Srobovanie_IN_typ;
		OUT : P3_Srobovanie_OUT_typ;
		PAR : P3_Srobovanie_PAR_typ;
		STAV : P3_Srobovanie_STAV_typ;
		COM_IN : P3_Srobovanie_COM_IN_typ;
		COM_OUT : P3_Srobovanie_COM_OUT_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		ServoManipulOsY : ServoDriver;
		ServoManipulOsZ_M5 : ServoDriver;
		Skrutkovacka_K40 : SkrutkovackaAtlasCopco_typ;
		Skrutkovacka_M5 : SkrutkovackaAtlasCopco_typ;
		SkrutSet_K40 : ScrewLoading;
		SkrutSet_M5 : PickAndPlace;
	END_STRUCT;
	P3_Srobovanie_CMD_typ : 	STRUCT 
		RR_Manipulator_OsY_VPRED : BOOL;
		RR_Manipulator_OsY_VZAD : BOOL;
		RR_M45F_PresunNaPozSkrutkov : BOOL;
		RR_M5H_PresunNaPozSkrutkov : BOOL;
		RR_PrisavanieSkrutkyK40_ON : BOOL;
		RR_PrisavanieSkrutkyM5_ON : BOOL;
		RR_SkrutkovackuK40_VYSUN : BOOL;
		RR_SkrutkovackaM5_OsZ_HORE : BOOL;
		RR_SkrutkovackaM5_OsZ_DOLE : BOOL;
		RR_CistenieSkrutkovackyK40 : BOOL;
		RR_SkrutSetK40_Zasobnik_RUN : BOOL;
		RR_SkrutSetK40_PodajSkrutku : BOOL;
		RR_SkrutSetM5_Zasobnik_RUN : BOOL;
		RR_SkrutSetM5_Vibrolista_RUN : BOOL;
		RR_SkrutSetM5_PodajSkrutku : BOOL;
		RR_PolohujManipulator : BOOL;
	END_STRUCT;
	P3_Srobovanie_IN_typ : 	STRUCT 
		ManipulOsY_LimSnimac_POS : BOOL; (*IS3_2*)
		ManipulOsY_LimSnimac_NEG : BOOL; (*IS3_1*)
		ManipulOsZ_M5_LimSnimacHorny : BOOL; (*IS3_3*)
		ManipulOsZ_M5_LimSnimacSpodny : BOOL; (*IS3_4*)
		Skrutkovacka_K40_ZASUNUTA : BOOL; (*MS3_6*)
		Skrutkovacka_M5_Vakum_OK : BOOL; (*S3_6*)
		NapajanieSkrutkovackyK40_OK : BOOL;
		NapajanieSkrutkovackyM5_OK : BOOL;
		NapajanieZasobnikaM5_OK : BOOL;
		NapajanieZasobnikaK40_OK : BOOL;
		NapajanieVibrolistyM5_OK : BOOL;
	END_STRUCT;
	P3_Srobovanie_OUT_typ : 	STRUCT 
		Skrutkovacku_K40_VYSUN : BOOL; (*YV158_VT3*)
		Skrutkovacka_K40_Prisavanie_ON : BOOL; (*YV156_VT3*)
		Skrutkovacka_K40_Odvzdusn_ON : BOOL; (*YV157_VT3*)
		Skrutkovacka_M5_Prisavanie_ON : BOOL; (*YV163_VT3*)
		Skrutkovacka_M5_Prisavanie_OFF : BOOL; (*YV164_VT3*)
		Skrutkovacka_M5_Odvzdusn_ON : BOOL; (*YV165_VT3*)
	END_STRUCT;
	P3_Srobovanie_PAR_typ : 	STRUCT 
		Skrutkov_K40_AktualHodnVysunutia : UINT; (*IO-Link snÌmaË*)
		ManipulOsY_AktualnaPozicia : REAL;
		ManipulOsZ_M5_AktualnaPozicia : REAL;
		RR_IndexPolohovaniaManipulatora : USINT;
		ManipulOsY_JoggRychlost : REAL;
		ManipulOsZ_M5_JoggRychlost : REAL;
		K40_AtlasCopcoInputs : ARRAY[0..7]OF UDINT;
		K40_AllasCopcoOutputs : ARRAY[0..7]OF UDINT;
		M5_AtlasCopcoInputs : ARRAY[0..7]OF UDINT;
		M5_AllasCopcoOutputs : ARRAY[0..7]OF UDINT;
	END_STRUCT;
	P3_Srobovanie_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		Vysledok_Srobovania : STRING[2]; (*OK alebo NG*)
		RR_Polohovanie_BUSY : BOOL;
		K40_DosiahnutyMoment_REAL : REAL;
		K40_DosiahnutyMoment : UDINT;
		K40_Moment_ToleranciaMAX_REAL : REAL;
		K40_Moment_ToleranciaMAX : UDINT;
		K40_Moment_ToleranciaMIN_REAL : REAL;
		K40_Moment_ToleranciaMIN : UDINT;
		K40_DosiahnutyUhol : UINT;
		K40_Uhol_ToleranciaMAX_REAL : REAL;
		K40_Uhol_ToleranciaMAX : UDINT;
		K40_Uhol_ToleranciaMIN_REAL : REAL;
		K40_Uhol_ToleranciaMIN : UDINT;
		M5_DosiahnutyMoment_REAL : REAL;
		M5_DosiahnutyMoment : UDINT;
		M5_Moment_ToleranciaMAX_REAL : REAL;
		M5_Moment_ToleranciaMAX : UDINT;
		M5_Moment_ToleranciaMIN_REAL : REAL;
		M5_Moment_ToleranciaMIN : UDINT;
		M5_DosiahnutyUhol : UINT;
		M5_Uhol_ToleranciaMAX_REAL : REAL;
		M5_Uhol_ToleranciaMAX : UDINT;
		M5_Uhol_ToleranciaMIN_REAL : REAL;
		M5_Uhol_ToleranciaMIN : UDINT;
	END_STRUCT;
	P3_Srobovanie_COM_IN_typ : 	STRUCT 
		PresunManipulatora_VPRED : BOOL;
		PresunManipulatora_VZAD : BOOL;
		Model45F_ZaskrutkujSkrutky : BOOL;
		Model5H_ZaskrutkujSkrutky : BOOL;
	END_STRUCT;
	P3_Srobovanie_COM_OUT_typ : 	STRUCT 
		Stav_SkrutkovanieUkoncene : BOOL;
		Stav_PresunManipulUkonceny : BOOL;
		Stav_PoruchaSkrutkovania : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - HV test//*)

TYPE
	P3_HV_Test_typ : 	STRUCT 
		CMD : P3_HV_Test_CMD_typ;
		IN : P3_HV_Test_IN_typ;
		OUT : P3_HV_Test_OUT_typ;
		PAR : P3_HV_Test_PAR_typ;
		STAV : P3_HV_Test_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_HV_Test_CMD_typ : 	STRUCT 
		RR_OtvorTester : BOOL;
		RR_ZatvorTester : BOOL;
		StartTestovania : BOOL;
	END_STRUCT;
	P3_HV_Test_IN_typ : 	STRUCT 
		Centrovanie_VYSUNUTE : BOOL; (*MS3_12*)
		Centrovanie_ZASUNUTE : BOOL; (*MS3_11*)
		SpodneKontakty_ZASUNUTE : BOOL; (*MS3_13*)
		SpodneKontakty_VYSUNUTE : BOOL; (*MS3_14*)
		HorneKontakty_ZASUNUTE : BOOL; (*MS3_10*)
		HorneKontakty_VYSUNUTE : BOOL; (*MS3_9*)
		TypKonektoru_4F : BOOL;
		TypKonektoru_5F_5H : BOOL;
	END_STRUCT;
	P3_HV_Test_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV107_VT3*)
		Centrovanie_VYSUN : BOOL; (*YV138_VT3*)
		Centrovanie_ZASUN : BOOL; (*YV139_VT3*)
		SpodneKontakty_ZASUN : BOOL; (*YV140_VT3*)
		SpodneKontakty_VYSUN : BOOL; (*YV141_VT3*)
		HorneKontakty_ZASUN : BOOL; (*YV135_VT3*)
		HorneKontakty_VYSUN : BOOL; (*YV134_VT3*)
		PritlacenieKontaktovTestera_ON : BOOL; (*YV142_VT3*)
		PruzenieHornychKontaktov_VYSUN : BOOL;
		PruzenieHornychKontaktov_ZASUN : BOOL;
	END_STRUCT;
	P3_HV_Test_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
	END_STRUCT;
	P3_HV_Test_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
		TestovanieUkoncene : BOOL;
		Vysledok_HV_Testu : STRING[2]; (*OK alebo NG*)
		NameranyCas_InitTestera : TIME;
		NameranyCas_PoslanieQRkodu : TIME;
		NameranyCas_CelkovyCasTestovania : TIME;
	END_STRUCT;
END_TYPE

(*//P3 - Zdviûka pred Leakage Testom A//*)

TYPE
	P3_ZdvizkaPredLeakTestA_typ : 	STRUCT 
		IN : P3_ZdvizkaPredLeakTestA_IN_typ;
		OUT : P3_ZdvizkaPredLeakTestA_OUT_typ;
		PAR : P3_ZdvizkaPredLeakTestA_PAR_typ;
		STAV : P3_ZdvizkaPredLeakTestA_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_ZdvizkaPredLeakTestA_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS3_10*)
		Zdvizka_HornaPoloha : BOOL; (*IS3_8*)
		Zdvizka_SpodnaPoloha : BOOL; (*IS3_7*)
		Zdvizka_StrednaPoloha : BOOL; (*IS3_9*)
	END_STRUCT;
	P3_ZdvizkaPredLeakTestA_OUT_typ : 	STRUCT 
		Zdvizku_ZASUN : BOOL; (*YV108_VT3*)
		Zdvizku_VYSUN : BOOL; (*YV109_VT3*)
		TlmicPaletky_VYSUN : BOOL; (*YV110_VT3*)
	END_STRUCT;
	P3_ZdvizkaPredLeakTestA_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P3_ZdvizkaPredLeakTestA_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletkyNaTratA : BOOL;
		PrebiehaVyvezeniePaletkyNaTratB : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - Zdviûka pred Leakage Testom B//*)

TYPE
	P3_ZdvizkaPredLeakTestB_typ : 	STRUCT 
		IN : P3_ZdvizkaPredLeakTestB_IN_typ;
		OUT : P3_ZdvizkaPredLeakTestB_OUT_typ;
		PAR : P3_ZdvizkaPredLeakTestB_PAR_typ;
		STAV : P3_ZdvizkaPredLeakTestB_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_ZdvizkaPredLeakTestB_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS3_15*)
		PoziciaPaletky_OK : BOOL; (*IS3_14*)
		Zdvizka_HornaPoloha : BOOL; (*IS3_12*)
		Zdvizka_SpodnaPoloha : BOOL; (*IS3_11*)
		Zdvizka_StrednaPoloha : BOOL; (*IS3_13*)
	END_STRUCT;
	P3_ZdvizkaPredLeakTestB_OUT_typ : 	STRUCT 
		Zdvizku_ZASUN : BOOL; (*YV111_VT3*)
		Zdvizku_VYSUN : BOOL; (*YV112_VT3*)
	END_STRUCT;
	P3_ZdvizkaPredLeakTestB_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P3_ZdvizkaPredLeakTestB_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - Leakage Test A//*)

TYPE
	P3_LeakageTestA_typ : 	STRUCT 
		CMD : P3_LeakageTestA_CMD_typ;
		IN : P3_LeakageTestA_IN_typ;
		OUT : P3_LeakageTestA_OUT_typ;
		PAR : P3_LeakageTestA_PAR_typ;
		STAV : P3_LeakageTestA_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_LeakageTestA_CMD_typ : 	STRUCT 
		RR_OtvorTester : BOOL;
		RR_ZatvorTester : BOOL;
		RR_VysunSpodneKopito : BOOL;
		RR_TestovaciaSekvencia_START : BOOL;
	END_STRUCT;
	P3_LeakageTestA_IN_typ : 	STRUCT 
		NapajanieTestera_OK : BOOL;
		HornyPritlak_VYSUNUTY : BOOL; (*MS3_16*)
		HornyPritlak_ZASUNUTY : BOOL; (*MS3_15*)
		Centrovanie_VYSUNUTE : BOOL; (*IS3_36*)
		Centrovanie_ZASUNUTE : BOOL; (*IS3_37*)
		PritomnostKopita : BOOL; (*IS3_32*)
		Kopito_ZASUNUTE : BOOL; (*IS3_33*)
		VyrovnavaciTlak_OK : BOOL; (*S3_4 - IO-Link snÌmaË*)
		Tester_TypKonektoru_4F : BOOL;
		Tester_TypKonektoru_5F_5H : BOOL;
	END_STRUCT;
	P3_LeakageTestA_OUT_typ : 	STRUCT 
		HornyPritlak_VYSUN : BOOL; (*YV143_VT3*)
		HornyPritlak_ZASUN : BOOL; (*YV144_VT3*)
		PneuZamok_ODOMKNI : BOOL; (*YV145_VT3*)
		Kopito_VYSUN : BOOL; (*YV149_VT3*)
		Kopito_ZASUN : BOOL; (*YV150_VT3*)
		ZasunStoper : BOOL; (*YV115_VT3*)
		Centrovanie_VYSUN : BOOL; (*YV151_VT3*)
		Centrovanie_ZASUN : BOOL; (*YV168_VT3*)
	END_STRUCT;
	P3_LeakageTestA_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		PrecitanyVyrovnavaciTlak : UINT; (*IO-Link snÌmaË*)
		PreratanyVyrovnavaciTlak_Bar : REAL;
	END_STRUCT;
	P3_LeakageTestA_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
		Tester_ON : BOOL;
		RR_TestovaciaSekvencia_BUSY : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - Leakage Test B//*)

TYPE
	P3_LeakageTestB_typ : 	STRUCT 
		CMD : P3_LeakageTestB_CMD_typ;
		IN : P3_LeakageTestB_IN_typ;
		OUT : P3_LeakageTestB_OUT_typ;
		PAR : P3_LeakageTestB_PAR_typ;
		STAV : P3_LeakageTestB_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_LeakageTestB_CMD_typ : 	STRUCT 
		RR_OtvorTester : BOOL;
		RR_ZatvorTester : BOOL;
		RR_VysunSpodneKopito : BOOL;
		RR_TestovaciaSekvencia_START : BOOL;
	END_STRUCT;
	P3_LeakageTestB_IN_typ : 	STRUCT 
		NapajanieTestera_OK : BOOL;
		HornyPritlak_VYSUNUTY : BOOL; (*MS3_18*)
		HornyPritlak_ZASUNUTY : BOOL; (*MS3_17*)
		Centrovanie_VYSUNUTE : BOOL; (*IS3_38*)
		Centrovanie_ZASUNUTE : BOOL; (*IS3_39*)
		PritomnostKopita : BOOL; (*IS3_34*)
		Kopito_ZASUNUTE : BOOL; (*IS3_35*)
		VyrovnavaciTlak_OK : BOOL; (*S3_5 - IO-Link snÌmaË*)
		Tester_TypKonektoru_4F : BOOL;
		Tester_TypKonektoru_5F_5H : BOOL;
	END_STRUCT;
	P3_LeakageTestB_OUT_typ : 	STRUCT 
		HornyPritlak_VYSUN : BOOL; (*YV146_VT3*)
		HornyPritlak_ZASUN : BOOL; (*YV147_VT3*)
		PneuZamok_ODOMKNI : BOOL; (*YV148_VT3*)
		Kopito_VYSUN : BOOL; (*YV153_VT3*)
		Kopito_ZASUN : BOOL; (*YV167_VT3*)
		ZasunStoper : BOOL; (*YV116_VT3*)
		Centrovanie_VYSUN : BOOL; (*YV154_VT3*)
		Centrovanie_ZASUN : BOOL; (*YV169_VT3*)
	END_STRUCT;
	P3_LeakageTestB_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		PrecitanyVyrovnavaciTlak : UINT; (*IO-Link snÌmaË*)
		PreratanyVyrovnavaciTlak_Bar : REAL;
	END_STRUCT;
	P3_LeakageTestB_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
		Tester_ON : BOOL;
		RR_TestovaciaSekvencia_BUSY : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - Zdviûka za Leakage Testom A//*)

TYPE
	P3_ZdvizkaZaLeakTestA_typ : 	STRUCT 
		IN : P3_ZdvizkaZaLeakTestA_IN_typ;
		OUT : P3_ZdvizkaZaLeakTestA_OUT_typ;
		PAR : P3_ZdvizkaZaLeakTestA_PAR_typ;
		STAV : P3_ZdvizkaZaLeakTestA_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_ZdvizkaZaLeakTestA_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS3_20*)
		PoziciaPaletky_OK : BOOL; (*IS3_19*)
		Zdvizka_HornaPoloha : BOOL; (*IS3_17*)
		Zdvizka_SpodnaPoloha : BOOL; (*IS3_16*)
		Zdvizka_StrednaPoloha : BOOL; (*IS3_18*)
		TlmicPaletky_ZASUNUTY : BOOL; (*MS3_2*)
	END_STRUCT;
	P3_ZdvizkaZaLeakTestA_OUT_typ : 	STRUCT 
		Zdvizku_ZASUN : BOOL; (*YV117_VT3*)
		Zdvizku_VYSUN : BOOL; (*YV118_VT3*)
		TlmicPaletky_VYSUN : BOOL; (*YV119_VT3*)
		TlmicPaletky_ZASUN : BOOL; (*YV120_VT3*)
	END_STRUCT;
	P3_ZdvizkaZaLeakTestA_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P3_ZdvizkaZaLeakTestA_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletkyNaTratA : BOOL;
		PrebiehaVyvezeniePaletkyNaTratB : BOOL;
	END_STRUCT;
END_TYPE

(*//P3 - Zdviûka za Leakage Testom B//*)

TYPE
	P3_ZdvizkaZaLeakTestB_typ : 	STRUCT 
		IN : P3_ZdvizkaZaLeakTestB_IN_typ;
		OUT : P3_ZdvizkaZaLeakTestB_OUT_typ;
		PAR : P3_ZdvizkaZaLeakTestB_PAR_typ;
		STAV : P3_ZdvizkaZaLeakTestB_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P3_ZdvizkaZaLeakTestB_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS3_25*)
		PoziciaPaletky_OK : BOOL; (*IS3_24*)
		Zdvizka_HornaPoloha : BOOL; (*IS3_22*)
		Zdvizka_SpodnaPoloha : BOOL; (*IS3_21*)
		Zdvizka_StrednaPoloha : BOOL; (*IS3_23*)
		TlmicPaletky_ZASUNUTY : BOOL; (*MS3_3*)
	END_STRUCT;
	P3_ZdvizkaZaLeakTestB_OUT_typ : 	STRUCT 
		Zdvizku_ZASUN : BOOL; (*YV121_VT3*)
		Zdvizku_VYSUN : BOOL; (*YV122_VT3*)
		TlmicPaletky_VYSUN : BOOL; (*YV123_VT3*)
		TlmicPaletky_ZASUN : BOOL; (*YV124_VT3*)
	END_STRUCT;
	P3_ZdvizkaZaLeakTestB_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P3_ZdvizkaZaLeakTestB_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletkyNaTratA : BOOL;
		PrebiehaVyvezeniePaletkyNaTratB : BOOL;
	END_STRUCT;
END_TYPE

(***********************************Pracovisko 4****************************************************************)

TYPE
	P4_Pracovisko_typ : 	STRUCT 
		IN : P4_PracoviskoIN_typ;
		OUT : P4_PracoviskoOUT_typ;
		PAR : P4_PracoviskoPAR_typ;
		STAV : P4_PracoviskoSTAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		KoniecVyroby : BOOL;
	END_STRUCT;
	P4_PracoviskoIN_typ : 	STRUCT 
		TlakVzduchu_OK : BOOL; (*S4_5*)
		ModulWeidmuller_IO_KomOK : BOOL;
		VentilovyTerminal_KomOK : BOOL;
		ModulFesto_IO_KomOK : BOOL;
		ServoZdvihuVytahu_KomOK : BOOL;
		ServoZdvihuAplikEtikiet_KomOK : BOOL;
		SmartKamera14_KomOK : BOOL;
	END_STRUCT;
	P4_PracoviskoOUT_typ : 	STRUCT 
		Majak_ZeleneSvetlo_ON : BOOL;
		Majak_OranzoveSvetlo_ON : BOOL;
		Majak_CerveneSvetlo_ON : BOOL;
		Majak_Hukacka_ON : BOOL;
		OsvetlenieBunky_ON : BOOL;
		Osvetlenie_CAM16_ON : BOOL;
		Osvetlenie_CAM15_ON : BOOL;
		ZdvizkyPneuZamok_ODOMKNI : BOOL; (*YV174_VT4*)
	END_STRUCT;
	P4_PracoviskoPAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P4_PracoviskoSTAV_typ : 	STRUCT 
		Automat : BOOL;
		Manual : BOOL;
		PoINIT : BOOL;
		READY : BOOL;
		HardwareBunky_OK : BOOL;
		HardwareVytahu_OK : BOOL;
		UkoncenieCyklu_BUSY : BOOL;
		Porucha_ST1 : BOOL; (*Final test A*)
		Porucha_ST2 : BOOL; (*Final test B*)
		Porucha_ST3 : BOOL; (*Zdvizka za Final testom A*)
		Porucha_ST4 : BOOL; (*Zdvizka za Final testom B*)
		Porucha_ST5 : BOOL; (*Etiketovanie*)
		Porucha_ST6 : BOOL; (*V˝stupn˝ v˝ùah*)
		FunkcnyTestA_Zasunuty : BOOL;
		FunkcnyTestB_Zasunuty : BOOL;
	END_STRUCT;
END_TYPE

(*//P4 - DopravnÌky//*)

TYPE
	P4_Dopravniky_typ : 	STRUCT 
		IN : P4_Dopravniky_IN_typ;
		OUT : P4_Dopravniky_OUT_typ;
		PAR : P4_Dopravniky_PAR_typ;
		STAV : P4_Dopravniky_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P4_Dopravniky_IN_typ : 	STRUCT 
		StavRiadPredDopravBunky_READY : BOOL; (*M4_4*)
		StavRiadZadnDopravBunky_READY : BOOL; (*M4_6*)
		StavRiadeniaPriecnDoprav_READY : BOOL; (*M4_5*)
		StavRiadeniaVratnehoDoprav_READY : BOOL; (*M4_7*)
		TeplotaMotoraPredDopravBunky_NG : BOOL; (*M4_4*)
		TeplotaMotoraZadnDopravBunky_NG : BOOL; (*M4_6*)
		TeplotaMotoraPriecnDoprav_NG : BOOL; (*M4_5*)
		TeplotaMotoraVratnehoDoprav_NG : BOOL; (*M4_7*)
	END_STRUCT;
	P4_Dopravniky_OUT_typ : 	STRUCT 
		VratnyDopravnik_ON : BOOL; (*M4_7*)
		PrednyDopravnikBunky_ON : BOOL; (*M4_4*)
		ZadnyDopravnikBunky_ON : BOOL; (*M4_6*)
		PriecnyDopravnik_VPRED : BOOL; (*M4_5 - Smerom na traù A*)
	END_STRUCT;
	P4_Dopravniky_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P4_Dopravniky_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
	END_STRUCT;
END_TYPE

(*//P4 - Spodn˝ stoper//*)

TYPE
	P4_SpodnyStoper_typ : 	STRUCT 
		IN : P4_SpodnyStoper_IN_typ;
		OUT : P4_SpodnyStoper_OUT_typ;
		PAR : P4_SpodnyStoper_PAR_typ;
		STAV : P4_SpodnyStoper_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P4_SpodnyStoper_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS4_15*)
		ZaplnenieDopravnika : BOOL; (*IS4_16*)
	END_STRUCT;
	P4_SpodnyStoper_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV182_VT4*)
	END_STRUCT;
	P4_SpodnyStoper_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P4_SpodnyStoper_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P4 - FunkËn˝ test A//*)

TYPE
	P4_FunkcnyTestA_typ : 	STRUCT 
		CMD : P4_FunkcnyTestA_CMD_typ;
		IN : P4_FunkcnyTestA_IN_typ;
		OUT : P4_FunkcnyTestA_OUT_typ;
		PAR : P4_FunkcnyTestA_PAR_typ;
		STAV : P4_FunkcnyTestA_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P4_FunkcnyTestA_CMD_typ : 	STRUCT 
		RR_ZatvorTester : BOOL;
		RR_OtvorTester : BOOL;
		StartTestovania : BOOL;
	END_STRUCT;
	P4_FunkcnyTestA_IN_typ : 	STRUCT 
		HorneKontakty_VYSUNUTE : BOOL; (*MS4_2*)
		HorneKontakty_ZASUNUTE : BOOL; (*MS4_3*)
		SpodneKontakty_VYSUNUTE : BOOL; (*MS4_7*)
		SpodneKontakty_ZASUNUTE : BOOL; (*MS4_6*)
		Centrovanie_VYSUNUTE : BOOL; (*MS4_5*)
		Centrovanie_ZASUNUTE : BOOL; (*MS4_4*)
		TypSpodnychKontaktov_4F : BOOL;
		TypSpodnychKontaktov_5F_5H : BOOL;
	END_STRUCT;
	P4_FunkcnyTestA_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV170_VT4*)
		HorneKontakty_VYSUN : BOOL; (*YV193_VT4*)
		HorneKontakty_ZASUN : BOOL; (*YV192_VT4*)
		OdpruzHornychKontaktov_VYSUN : BOOL; (*YV194_VT4*)
		OdpruzHornychKontaktov_ZASUN : BOOL; (*YV195_VT4*)
		PritlakPowerCP_VYSUN : BOOL; (*YV196_VT4*)
		SpodneKontakty_VYSUN : BOOL; (*YV200_VT4*)
		SpodneKontakty_ZASUN : BOOL; (*YV199_VT4*)
		Centrovanie_VYSUN : BOOL; (*YV197_VT4*)
		Centrovanie_ZASUN : BOOL; (*YV198_VT4*)
		KontaktyTestera_VYSUN : BOOL;
	END_STRUCT;
	P4_FunkcnyTestA_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
	END_STRUCT;
	P4_FunkcnyTestA_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		Vysledok_FV_Testu : STRING[2]; (*OK alebo NG*)
		PrebiehaVyvezeniePaletky : BOOL;
		Tester_ON : BOOL;
		TestovanieUkoncene : BOOL;
	END_STRUCT;
END_TYPE

(*//P4 - FunkËn˝ test B//*)

TYPE
	P4_FunkcnyTestB_typ : 	STRUCT 
		CMD : P4_FunkcnyTestB_CMD_typ;
		IN : P4_FunkcnyTestB_IN_typ;
		OUT : P4_FunkcnyTestB_OUT_typ;
		PAR : P4_FunkcnyTestB_PAR_typ;
		STAV : P4_FunkcnyTestB_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P4_FunkcnyTestB_CMD_typ : 	STRUCT 
		RR_ZatvorTester : BOOL;
		RR_OtvorTester : BOOL;
		StartTestovania : BOOL;
	END_STRUCT;
	P4_FunkcnyTestB_IN_typ : 	STRUCT 
		HorneKontakty_VYSUNUTE : BOOL; (*MS4_8*)
		HorneKontakty_ZASUNUTE : BOOL; (*MS4_9*)
		SpodneKontakty_VYSUNUTE : BOOL; (*MS4_13*)
		SpodneKontakty_ZASUNUTE : BOOL; (*MS4_12*)
		Centrovanie_VYSUNUTE : BOOL; (*MS4_11*)
		Centrovanie_ZASUNUTE : BOOL; (*MS4_10*)
		TypSpodnychKontaktov_4F : BOOL;
		TypSpodnychKontaktov_5F_5H : BOOL;
	END_STRUCT;
	P4_FunkcnyTestB_OUT_typ : 	STRUCT 
		ZasunStoper : BOOL; (*YV171_VT4*)
		HorneKontakty_VYSUN : BOOL; (*YV202_VT4*)
		HorneKontakty_ZASUN : BOOL; (*YV201_VT4*)
		OdpruzHornychKontaktov_VYSUN : BOOL; (*YV203_VT4*)
		OdpruzHornychKontaktov_ZASUN : BOOL; (*YV204_VT4*)
		PritlakPowerCP_VYSUN : BOOL; (*YV205_VT4*)
		SpodneKontakty_VYSUN : BOOL; (*YV209_VT4*)
		SpodneKontakty_ZASUN : BOOL; (*YV208_VT4*)
		Centrovanie_VYSUN : BOOL; (*YV206_VT4*)
		Centrovanie_ZASUN : BOOL; (*YV207_VT4*)
		KontaktyTestera_VYSUN : BOOL;
	END_STRUCT;
	P4_FunkcnyTestB_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
	END_STRUCT;
	P4_FunkcnyTestB_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		Vysledok_FV_Testu : STRING[2]; (*OK alebo NG*)
		PrebiehaVyvezeniePaletky : BOOL;
		Tester_ON : BOOL;
		TestovanieUkoncene : BOOL;
	END_STRUCT;
END_TYPE

(*//P4 - Zdviûka za FunkËn˝m Testom A//*)

TYPE
	P4_ZdvizkaZaFunkcTestA_typ : 	STRUCT 
		IN : P4_ZdvizkaZaFunkTestA_IN_typ;
		OUT : P4_ZdvizkaZaFunkTestA_OUT_typ;
		PAR : P4_ZdvizkaZaFunkTestA_PAR_typ;
		STAV : P4_ZdvizkaZaFunkTestA_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P4_ZdvizkaZaFunkTestA_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS4_10*)
		PoziciaPaletky_OK : BOOL; (*IS4_9*)
		Zdvizka_HornaPoloha : BOOL; (*IS4_6*)
		Zdvizka_SpodnaPoloha : BOOL; (*IS4_5*)
		Zdvizka_StrednaPoloha : BOOL; (*IS4_7*)
		TlmicPaletky_ZASUNUTY : BOOL; (*MS4_1*)
	END_STRUCT;
	P4_ZdvizkaZaFunkTestA_OUT_typ : 	STRUCT 
		Zdvizku_ZASUN : BOOL; (*YV173_VT4*)
		Zdvizku_VYSUN : BOOL; (*YV172_VT4*)
		TlmicPaletky_VYSUN : BOOL; (*YV175_VT4*)
		TlmicPaletky_ZASUN : BOOL; (*YV176_VT4*)
	END_STRUCT;
	P4_ZdvizkaZaFunkTestA_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P4_ZdvizkaZaFunkTestA_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P4 - Zdviûka za FunkËn˝m Testom B//*)

TYPE
	P4_ZdvizkaZaFunkcTestB_typ : 	STRUCT 
		IN : P4_ZdvizkaZaFunkTestB_IN_typ;
		OUT : P4_ZdvizkaZaFunkTestB_OUT_typ;
		PAR : P4_ZdvizkaZaFunkTestB_PAR_typ;
		STAV : P4_ZdvizkaZaFunkTestB_STAV_typ;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P4_ZdvizkaZaFunkTestB_IN_typ : 	STRUCT 
		PritomnostPaletky : BOOL; (*IS4_8*)
		Zdvizka_HornaPoloha : BOOL; (*IS4_11*)
		Zdvizka_StrednaPoloha : BOOL; (*IS4_12*)
	END_STRUCT;
	P4_ZdvizkaZaFunkTestB_OUT_typ : 	STRUCT 
		Zdvizku_VYSUN : BOOL; (*YV177_VT4*)
		TlmicPaletky_VYSUN : BOOL; (*YV178_VT4*)
	END_STRUCT;
	P4_ZdvizkaZaFunkTestB_PAR_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P4_ZdvizkaZaFunkTestB_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
	END_STRUCT;
END_TYPE

(*//P4 - Etiketovanie//*)

TYPE
	P4_Etiketovacka_typ : 	STRUCT 
		CMD : P4_Etiketovacka_CMD_typ;
		IN : P4_Etiketovacka_IN_typ;
		OUT : P4_Etiketovacka_OUT_typ;
		PAR : P4_Etiketovacka_PAR_typ;
		STAV : P4_Etiketovacka_STAV_typ;
		RFID_hlava : SickHeads;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
		ServoZdvihuAplikatora : ServoDriver;
	END_STRUCT;
	P4_Etiketovacka_CMD_typ : 	STRUCT 
		RR_ZdvihAplikatora_HORE : BOOL;
		RR_ZdvihAplikatora_DOLE : BOOL;
		RR_NalepEtiketu : BOOL;
	END_STRUCT;
	P4_Etiketovacka_IN_typ : 	STRUCT 
		Centrovanie_VYSUNUTE : BOOL; (*IS4_13*)
		Centrovanie_ZASUNUTE : BOOL; (*IS4_14*)
		ZdvihAplikatora_HornyLimSnimac : BOOL; (*IS4_3*)
		ZdvihAplikatora_SpodnyLimSnimac : BOOL; (*IS4_4*)
		Aplikator_OtocenyVPRED : BOOL; (*MS4_15*)
		Aplikator_OtocenyVZAD : BOOL; (*MS4_14*)
		Aplikator_VYSUNUTY : BOOL; (*MS4_17*)
		Aplikator_ZASUNUTY : BOOL; (*MS4_16*)
		PrisavanieEtikety_Vakum_OK : BOOL; (*S4_6*)
		NapajanieTlaciarne_OK : BOOL;
		PritlakPowerCP_ZASUNUTY : BOOL; (*MS4_18*)
		PritlakPowerCP_VYSUNUTY : BOOL; (*MS4_19*)
	END_STRUCT;
	P4_Etiketovacka_OUT_typ : 	STRUCT 
		OfukEtikety_ON : BOOL; (*YV185_VT4*)
		PrisavanieEtikety_ON : BOOL; (*YV210_VT4*)
		PrisavanieEtikety_OFF : BOOL; (*YV211_VT4*)
		Aplikator_OtocVPRED : BOOL; (*YV187_VT4*)
		Aplikator_OtocVZAD : BOOL; (*YV186_VT4*)
		Aplikator_VYSUN : BOOL; (*YV188_VT4*)
		ZasunStoper : BOOL; (*YV179_VT4*)
		Centrovanie_VYSUN : BOOL; (*YV180_VT4*)
		Centrovanie_ZASUN : BOOL; (*YV181_VT4*)
		PritlakPowerCP_VYSUN : BOOL; (*YV191_VT4*)
	END_STRUCT;
	P4_Etiketovacka_PAR_typ : 	STRUCT 
		IndexFotky : USINT;
		CisloPaletky_STRING : STRING[2];
		ZdvihAplikatora_JoggRychlost : REAL;
	END_STRUCT;
	P4_Etiketovacka_STAV_typ : 	STRUCT 
		PoINIT : BOOL;
		PrebiehaVyvezeniePaletky : BOOL;
		PowerCP_ZhodaQRkodu_OK : BOOL;
		Etiketa_ZhodaQRkodu_OK : BOOL;
	END_STRUCT;
END_TYPE

(*//P4 - V˝ùah*)

TYPE
	P4_Vytah_typ : 	STRUCT 
		CMD : P4_Vytah_CMD_typ;
		IN : P4_Vytah_IN_typ;
		OUT : P4_Vytah_OUT_typ;
		PAR : P4_Vytah_PAR_typ;
		STAV : P4_Vytah_STAV_typ;
		Banner : BannerIOlink;
		RFID_hlava : SickHeads;
		ServoZdvihuVytahu : ServoDriver;
		Automat : BOOL;
		Manual : BOOL;
		Reset : BOOL;
		KoniecCyklu : BOOL;
	END_STRUCT;
	P4_Vytah_CMD_typ : 	STRUCT 
		RR_ChodDopravnika_VPRED : BOOL;
		RR_ChodDopravnika_VZAD : BOOL;
		Banner_LED_OFF : BOOL;
		RR_ZdvihVytahu_HORE : BOOL;
		RR_ZdvihVytahu_DOLE : BOOL;
	END_STRUCT;
	P4_Vytah_IN_typ : 	STRUCT 
		PrechodDopravnika : BOOL; (*OS4_1*)
		ZdvihVytahu_HornyLimitnySnimac : BOOL; (*IS4_2*)
		ZdvihVytahu_SpodnyLimitnySnimac : BOOL; (*IS4_1*)
		StavRiadeniaDopravVytahu_READY : BOOL; (*M4_3*)
		TeplotaMotoraDopravVytahu_NG : BOOL; (*M4_3*)
	END_STRUCT;
	P4_Vytah_OUT_typ : 	STRUCT 
		DopravnikChod_VPRED : BOOL; (*M4_3*)
		DopravnikChod_VZAD : BOOL; (*M4_3*)
	END_STRUCT;
	P4_Vytah_PAR_typ : 	STRUCT 
		CisloPaletky_STRING : STRING[2];
		IndexFotky : USINT;
		Zdvih_JoggRychlost : REAL;
	END_STRUCT;
	P4_Vytah_STAV_typ : 	STRUCT 
		PrebiehaVyvezeniePaletky : BOOL;
		PoINIT : BOOL;
	END_STRUCT;
END_TYPE

(**************Skrutkovacky AtlasCopco***************************)

TYPE
	SkrutkovackaAtlasCopco_typ : 	STRUCT 
		RESET_Poruchy : BOOL;
		RESET_Vysledkov : BOOL;
		START_Skrutkovania : BOOL;
		START_Utahovania : BOOL;
		Stav_VysledokPotvrdeny : BOOL;
		Stav_EmergencyStop : BOOL;
		Stav_READY_to_START : BOOL;
		Stav_MANUAL : BOOL;
		Stav_UtahovanieUkoncene : BOOL;
		Stav_VysledokUtahovania_OK : BOOL;
		Stav_VysledokUtahovania_NG : BOOL;
		Stav_SmerOtacania_VPRED : BOOL;
		Stav_BUSY : BOOL;
		Stav_ControlerSwitch_ON : BOOL;
		Stav_Station_READY : BOOL;
		Stav_NastrojPripojeny : BOOL;
		Stav_NastrojUtahuje : BOOL;
		Stav_CisloAktualnehoProgramu : USINT;
		CisloZadanehoProgramu : USINT;
		VyslednyReport : STRING[5];
	END_STRUCT;
END_TYPE

(**************Ateq Leakage Testery******************)

TYPE
	AteqTester_typ : 	STRUCT 
		START_Testovania : BOOL;
		RESET_Vysledkov : BOOL;
		ZMEN_Program : BOOL;
		CitajParametreTestera : BOOL;
		Stav_RESET_DONE : BOOL;
		Stav_START_DONE : BOOL;
		Stav_ZmenaProgramu_DONE : BOOL;
		Stav_ERROR : BOOL;
		Stav_READY : BOOL;
		Stav_BUSY : BOOL;
		Stav_CitanieParametrov_OK : BOOL;
		Stav_CitanieParametrov_ERROR : BOOL;
		CisloZadanehoProgramu : UINT;
		CisloAktualnehoProgramu : UINT;
		VysledokTestovania_OK : BOOL;
		VysledokTestovania_NG : BOOL;
		Profinet_PLC_INPUTS : ARRAY[1..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[1..100]OF USINT;
		ReadParameter_1 : UINT;
		ReadParameter_2 : UINT;
		ReadParameter_3 : UINT;
		ReadParameter_4 : UINT;
		ReadParameter_5 : DINT;
		PocetCitanychParametrov : USINT;
		IdentifikaciaParametra_1 : USINT;
		IdentifikaciaParametra_2 : USINT;
		IdentifikaciaParametra_3 : USINT;
		IdentifikaciaParametra_4 : USINT;
		CasPnenia : REAL;
		CasStabilizacie : REAL;
		TlakPlnenia : REAL;
		Tolerancia : REAL;
		TlakUniku : REAL;
	END_STRUCT;
END_TYPE

(***************Komunik·cia zo serverom********************)

TYPE
	KOM_Server_typ : 	STRUCT 
		CMD : KOM_Server_CMD_typ;
		INPUTS : KOM_Server_INPUTS_typ;
		OUTPUTS : KOM_Server_OUTPUTS_typ;
		STATUS : KOM_Server_STATUS_typ;
	END_STRUCT;
	KOM_Server_CMD_typ : 	STRUCT 
		VyziadajStavPaletky_TYP1 : BOOL;
		PriradQRkodFiltra_TYP3 : BOOL;
		VyziadajCisloEtikety_TYP0 : BOOL;
		OdosliStavPaletky_TYP2 : BOOL;
		VyziadajStavPanatrace_TYP4 : BOOL;
	END_STRUCT;
	KOM_Server_INPUTS_typ : 	STRUCT 
		TYP_Prikazu : STRING[1]; (*Typ*)
		CisloStanice : STRING[5]; (*Stanica*)
		CisloPaletky : STRING[10]; (*RFID paletky*)
		QRkodPowerCP : STRING[30]; (*Master number*)
		QRkodFiltra : STRING[30]; (*DPS1*)
		ID_Operatora : STRING[80]; (*Operator*)
		Report : STRING[4000]; (*DATA  - OddelenÈ bodkoËiarkou*)
		StavPaletky : STRING[4]; (*PASS alebo FAIL*)
		IndexPaletky : USINT;
	END_STRUCT;
	KOM_Server_OUTPUTS_typ : 	STRUCT 
		TYP_Prikazu : STRING[1]; (*Typ*)
		CisloStanice : STRING[5]; (*Stanica*)
		CisloPaletky : STRING[10]; (*RFID paletky*)
		QRkodPowerCP : STRING[30]; (*Master number*)
		QRkodFiltra : STRING[30]; (*DPS1*)
		ID_Operatora : STRING[8]; (*Operator*)
		CisloEtikety : STRING[31];
		DruhCinnostiNaPaletke : STRING[20]; (*PRD;ST1 alebo SMP;CAL;ST1 alebo RST;HVT;ST1*)
		PovolenieCinnostiNaPaletke : STRING[2]; (*OK alebo NG*)
	END_STRUCT;
	KOM_Server_STATUS_typ : 	STRUCT 
		KomunikaciaUkoncena : BOOL;
		KomunikaciaError : BOOL;
	END_STRUCT;
END_TYPE

(***************VyslednÈ reporty***************************)

TYPE
	Reports_typ : 	STRUCT 
		Kamery : ReportKamery_typ;
		Skrutkovacky : ReportSkrutkovacky_typ;
		Zvaranie : ReportZvarania_typ;
		LeakageTest : ReportLeakageTest_typ;
	END_STRUCT;
	ReportKamery_typ : 	STRUCT 
		P1_CAM2_KontrolaPaletky : STRING[5]; (*V˝tah*)
		P1_CAM4_KontrolaPinovDPS : STRING[5]; (*V˝tah*)
		P1_CAM6_KontrolaPaletky : STRING[5]; (*Srobovanie*)
		P2_CAM1_KontrolaTesnenia : STRING[5];
		P2_CAM17_KontrolaPaletky : STRING[5]; (*Zakladanie tesnenia*)
		P2_CAM9_KontrolaPaletky : STRING[5]; (*Srobovanie matice*)
		P2_CAM10_KontrolaPaletky : STRING[5]; (*Srobovanie*)
		P2_CAM11_KontrolaZvaru : STRING[5]; (*Zvaranie*)
		P2_CAM11_KontrolaPowerCP : STRING[5]; (*Zvaranie*)
		P2_CAM12_KontrolaPaletky : STRING[5];
		P3_CAM13_KontrolaPaletky : STRING[5]; (*Srobovanie*)
		P4_CAM15_KontrolaPaletky : STRING[5]; (*EtiketovaËka*)
		P4_CAM16_KontrolaPaletky : STRING[5]; (*V˝tah*)
	END_STRUCT;
	ReportSkrutkovacky_typ : 	STRUCT 
		Moment_ToleranciaMAX : ReportSrobov_MomentTolerMAX_typ;
		Moment_ToleranciaMIN : ReportSrobov_MomentTolerMIN_typ;
		Moment_NameranaHodnota : ReportSrobov_NameranyMoment_typ;
		Uhol_ToleranciaMAX : ReportSrobov_UholTolerMAX_typ;
		Uhol_ToleranciaMIN : ReportSrobov_UholTolerMIN_typ;
		Uhol_NameranaHodnota : ReportSrobov_NameranyUhol_typ;
		VyskaSkrutkovania : ReportSrobov_VyskaSkrutkov_typ;
		CasSkrutkovania : ReportSrobov_CasSkrutkov_typ;
		VyslednyReport : ReportSrobov_VyslednyReport_typ;
	END_STRUCT;
	ReportZvarania_typ : 	STRUCT 
		Vyska : ReportZvarania_Vyska_typ;
		Moment : ReportZvarania_Moment_typ;
		Frekvencia : STRING[10];
		VyslednyReport : STRING[5];
	END_STRUCT;
	ReportZvarania_Vyska_typ : 	STRUCT 
		LavyZvar : STRING[10];
		PravyZvar : STRING[10];
	END_STRUCT;
	ReportZvarania_Moment_typ : 	STRUCT 
		LavyZvar : STRING[4];
		PravyZvar : STRING[4];
	END_STRUCT;
	ReportSrobov_MomentTolerMAX_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[10];
		P1_PravaSkrutkaK30 : STRING[10];
		P1_ZadnaSkrutkaM4 : STRING[10];
		P1_PrednaSkrutkaM4 : STRING[10];
		P1_SkrutkaDPS_M4 : STRING[10];
		P1_LavaSkrutkaM5 : STRING[10];
		P1_PravaSkrutkaM5 : STRING[10];
		P1_StrednaSkrutkaM5 : STRING[10];
		P2_MaticaM4 : STRING[10];
		P2_LavaSkrutkaM6 : STRING[10];
		P2_PravaSkrutkaM6 : STRING[10];
		P2_LavaSkrutkaM4 : STRING[10];
		P2_PravaSkrutkaM4 : STRING[10];
		P2_LavaSkrutkaM5 : STRING[10];
		P2_PravaSkrutkaM5 : STRING[10];
		P2_StrednaSkrutkaM4 : STRING[10];
		P3_SkrutkaK40 : STRING[10];
		P3_SkrutkaM5 : STRING[10];
	END_STRUCT;
	ReportSrobov_MomentTolerMIN_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[10];
		P1_PravaSkrutkaK30 : STRING[10];
		P1_ZadnaSkrutkaM4 : STRING[10];
		P1_PrednaSkrutkaM4 : STRING[10];
		P1_SkrutkaDPS_M4 : STRING[10];
		P1_LavaSkrutkaM5 : STRING[10];
		P1_PravaSkrutkaM5 : STRING[10];
		P1_StrednaSkrutkaM5 : STRING[10];
		P2_MaticaM4 : STRING[10];
		P2_LavaSkrutkaM6 : STRING[10];
		P2_PravaSkrutkaM6 : STRING[10];
		P2_LavaSkrutkaM4 : STRING[10];
		P2_PravaSkrutkaM4 : STRING[10];
		P2_LavaSkrutkaM5 : STRING[10];
		P2_PravaSkrutkaM5 : STRING[10];
		P2_StrednaSkrutkaM4 : STRING[10];
		P3_SkrutkaK40 : STRING[10];
		P3_SkrutkaM5 : STRING[10];
	END_STRUCT;
	ReportSrobov_NameranyMoment_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[10];
		P1_PravaSkrutkaK30 : STRING[10];
		P1_ZadnaSkrutkaM4 : STRING[10];
		P1_PrednaSkrutkaM4 : STRING[10];
		P1_SkrutkaDPS_M4 : STRING[10];
		P1_LavaSkrutkaM5 : STRING[10];
		P1_PravaSkrutkaM5 : STRING[10];
		P1_StrednaSkrutkaM5 : STRING[10];
		P2_MaticaM4 : STRING[10];
		P2_LavaSkrutkaM6 : STRING[10];
		P2_PravaSkrutkaM6 : STRING[10];
		P2_LavaSkrutkaM4 : STRING[10];
		P2_PravaSkrutkaM4 : STRING[10];
		P2_LavaSkrutkaM5 : STRING[10];
		P2_PravaSkrutkaM5 : STRING[10];
		P2_StrednaSkrutkaM4 : STRING[10];
		P3_SkrutkaK40 : STRING[10];
		P3_SkrutkaM5 : STRING[10];
	END_STRUCT;
	ReportSrobov_UholTolerMAX_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[10];
		P1_PravaSkrutkaK30 : STRING[10];
		P1_ZadnaSkrutkaM4 : STRING[10];
		P1_PrednaSkrutkaM4 : STRING[10];
		P1_SkrutkaDPS_M4 : STRING[10];
		P1_LavaSkrutkaM5 : STRING[10];
		P1_PravaSkrutkaM5 : STRING[10];
		P1_StrednaSkrutkaM5 : STRING[10];
		P2_MaticaM4 : STRING[10];
		P2_LavaSkrutkaM6 : STRING[10];
		P2_PravaSkrutkaM6 : STRING[10];
		P2_LavaSkrutkaM4 : STRING[10];
		P2_PravaSkrutkaM4 : STRING[10];
		P2_LavaSkrutkaM5 : STRING[10];
		P2_PravaSkrutkaM5 : STRING[10];
		P2_StrednaSkrutkaM4 : STRING[10];
		P3_SkrutkaK40 : STRING[10];
		P3_SkrutkaM5 : STRING[10];
	END_STRUCT;
	ReportSrobov_UholTolerMIN_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[10];
		P1_PravaSkrutkaK30 : STRING[10];
		P1_ZadnaSkrutkaM4 : STRING[10];
		P1_PrednaSkrutkaM4 : STRING[10];
		P1_SkrutkaDPS_M4 : STRING[10];
		P1_LavaSkrutkaM5 : STRING[10];
		P1_PravaSkrutkaM5 : STRING[10];
		P1_StrednaSkrutkaM5 : STRING[10];
		P2_MaticaM4 : STRING[10];
		P2_LavaSkrutkaM6 : STRING[10];
		P2_PravaSkrutkaM6 : STRING[10];
		P2_LavaSkrutkaM4 : STRING[10];
		P2_PravaSkrutkaM4 : STRING[10];
		P2_LavaSkrutkaM5 : STRING[10];
		P2_PravaSkrutkaM5 : STRING[10];
		P2_StrednaSkrutkaM4 : STRING[10];
		P3_SkrutkaK40 : STRING[10];
		P3_SkrutkaM5 : STRING[10];
	END_STRUCT;
	ReportSrobov_NameranyUhol_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[10];
		P1_PravaSkrutkaK30 : STRING[10];
		P1_ZadnaSkrutkaM4 : STRING[10];
		P1_PrednaSkrutkaM4 : STRING[10];
		P1_SkrutkaDPS_M4 : STRING[10];
		P1_LavaSkrutkaM5 : STRING[10];
		P1_PravaSkrutkaM5 : STRING[10];
		P1_StrednaSkrutkaM5 : STRING[10];
		P2_MaticaM4 : STRING[10];
		P2_LavaSkrutkaM6 : STRING[10];
		P2_PravaSkrutkaM6 : STRING[10];
		P2_LavaSkrutkaM4 : STRING[10];
		P2_PravaSkrutkaM4 : STRING[10];
		P2_LavaSkrutkaM5 : STRING[10];
		P2_PravaSkrutkaM5 : STRING[10];
		P2_StrednaSkrutkaM4 : STRING[10];
		P3_SkrutkaK40 : STRING[10];
		P3_SkrutkaM5 : STRING[10];
	END_STRUCT;
	ReportSrobov_VyskaSkrutkov_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[10];
		P1_PravaSkrutkaK30 : STRING[10];
		P1_ZadnaSkrutkaM4 : STRING[10];
		P1_PrednaSkrutkaM4 : STRING[10];
		P1_SkrutkaDPS_M4 : STRING[10];
		P1_LavaSkrutkaM5 : STRING[10];
		P1_PravaSkrutkaM5 : STRING[10];
		P1_StrednaSkrutkaM5 : STRING[10];
		P2_MaticaM4 : STRING[10];
		P2_LavaSkrutkaM6 : STRING[10];
		P2_PravaSkrutkaM6 : STRING[10];
		P2_LavaSkrutkaM4 : STRING[10];
		P2_PravaSkrutkaM4 : STRING[10];
		P2_LavaSkrutkaM5 : STRING[10];
		P2_PravaSkrutkaM5 : STRING[10];
		P2_StrednaSkrutkaM4 : STRING[10];
		P3_SkrutkaK40 : STRING[10];
		P3_SkrutkaM5 : STRING[10];
	END_STRUCT;
	ReportSrobov_CasSkrutkov_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[10];
		P1_PravaSkrutkaK30 : STRING[10];
		P1_ZadnaSkrutkaM4 : STRING[10];
		P1_PrednaSkrutkaM4 : STRING[10];
		P1_SkrutkaDPS_M4 : STRING[10];
		P1_LavaSkrutkaM5 : STRING[10];
		P1_PravaSkrutkaM5 : STRING[10];
		P1_StrednaSkrutkaM5 : STRING[10];
		P2_MaticaM4 : STRING[10];
		P2_LavaSkrutkaM6 : STRING[10];
		P2_PravaSkrutkaM6 : STRING[10];
		P2_LavaSkrutkaM4 : STRING[10];
		P2_PravaSkrutkaM4 : STRING[10];
		P2_LavaSkrutkaM5 : STRING[10];
		P2_PravaSkrutkaM5 : STRING[10];
		P2_StrednaSkrutkaM4 : STRING[10];
		P3_SkrutkaK40 : STRING[10];
		P3_SkrutkaM5 : STRING[10];
	END_STRUCT;
	ReportSrobov_VyslednyReport_typ : 	STRUCT 
		P1_LavaSkrutkaK30 : STRING[5];
		P1_PravaSkrutkaK30 : STRING[5];
		P1_ZadnaSkrutkaM4 : STRING[5];
		P1_PrednaSkrutkaM4 : STRING[5];
		P1_SkrutkaDPS_M4 : STRING[5];
		P1_LavaSkrutkaM5 : STRING[5];
		P1_PravaSkrutkaM5 : STRING[5];
		P1_StrednaSkrutkaM5 : STRING[5];
		P2_MaticaM4 : STRING[5];
		P2_LavaSkrutkaM6 : STRING[5];
		P2_PravaSkrutkaM6 : STRING[5];
		P2_LavaSkrutkaM4 : STRING[5];
		P2_PravaSkrutkaM4 : STRING[5];
		P2_LavaSkrutkaM5 : STRING[5];
		P2_PravaSkrutkaM5 : STRING[5];
		P2_StrednaSkrutkaM4 : STRING[5];
		P3_SkrutkaK40 : STRING[5];
		P3_SkrutkaM5 : STRING[5];
	END_STRUCT;
	ReportLeakageTest_typ : 	STRUCT 
		CasPlnenia : RepLeakTest_CasPlnenia_typ;
		CasStabilizacie : RepLeakTest_CasStabilizacie_typ;
		TlakPlnenia : RepLeakTest_TlakPlnenia_typ;
		TlakPritlaku : RepLeakTest_TlakPritlaku_typ;
		ToleranciaPritlaku_MIN : RepLeakTest_TolPritlakuMIN_typ;
		ToleranciaPritlaku_MAX : RepLeakTest_TolPritlakuMAX_typ;
		ToleranciaTlakUniku_MIN : RepLeakTest_TolTlakUnikuMIN_typ;
		ToleranciaTlakUniku_MAX : RepLeakTest_TolTlakUnikuMAX_typ;
		TlakUniku : RepLeakTest_TlakUniku_typ;
		Tolerancia : RepLeakTest_Tolerancia_typ;
		VyslednyReport : RepLeakTest_VyslednyReport_typ;
	END_STRUCT;
	RepLeakTest_CasPlnenia_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_CasStabilizacie_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_TlakPlnenia_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_TlakPritlaku_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_TolPritlakuMIN_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_TolPritlakuMAX_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_TlakUniku_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_TolTlakUnikuMIN_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_TolTlakUnikuMAX_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_Tolerancia_typ : 	STRUCT 
		StanicaA : STRING[10];
		StanicaB : STRING[10];
	END_STRUCT;
	RepLeakTest_VyslednyReport_typ : 	STRUCT 
		StanicaA : STRING[5];
		StanicaB : STRING[5];
	END_STRUCT;
END_TYPE

(***************Posielanie fotiek na server**********************)

TYPE
	FTP_Kamery_typ : 	STRUCT 
		CMD : FTP_Kamery_CMD_typ;
		INPUTS : FTP_Kamery_INPUTS_typ;
		STATUS : FTP_Kamery_STATUS_typ;
	END_STRUCT;
	FTP_Kamery_CMD_typ : 	STRUCT 
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	FTP_Kamery_INPUTS_typ : 	STRUCT 
		QRkodPowerCP : STRING[30]; (*Master number*)
		Result : STRING[5]; (*PASS alebo FAIL*)
		IndexFotky : STRING[2];
	END_STRUCT;
	FTP_Kamery_STATUS_typ : 	STRUCT 
		KomunikaciaUkoncena : BOOL;
		KomunikaciaError : BOOL;
		CisloPoruchy : USINT;
		AdresarPrazdny : BOOL;
	END_STRUCT;
END_TYPE

(****************Kamerove kontroly**************************)

TYPE
	CAM1_typ : 	STRUCT  (*P2_ST1_ZaklTesnenia - Kontrola tesnenia a QR kÛdu Power CP*)
		CMD : CAM1_Commands_typ;
		PAR : CAM1_Parametre_typ;
		STAV : CAM1_Status_typ;
		RESULT : CAM1_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM1_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM1_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM1_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM1_Results_typ : 	STRUCT 
		PritomnTesnenia_OK : BOOL;
		ZalozenieTesnenia_OK : BOOL;
		PritomnPowerCP_5H5F : BOOL;
		PritomnPowerCP_4F : BOOL;
	END_STRUCT;
	CAM2_typ : 	STRUCT  (*P1_ST1_Vytah - kontrola kusov na paletke*)
		CMD : CAM2_Commands_typ;
		PAR : CAM2_Parametre_typ;
		STAV : CAM2_Status_typ;
		RESULT : CAM2_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM2_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM2_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM2_Status_typ : 	STRUCT 
		READY : BOOL;
		BUSY : BOOL;
		SWITCH : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM2_Results_typ : 	STRUCT 
		Paletka : CAM2_Paletka_typ;
		PowerCP : CAM2_PowerCP_typ;
	END_STRUCT;
	CAM2_PowerCP_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM2_Paletka_typ : 	STRUCT 
		Pritom_PowerCP_5F : BOOL;
		Pritom_PowerCP_4F : BOOL;
		Pritom_PowerCP_5H : BOOL;
		Pritom_Busbar_SpodnyLavy_5H : BOOL;
		Pritom_Busbar_SpodnyPravy_5H : BOOL;
		Pritom_KrytuBusbarov_5H : BOOL;
		Pritom_DPS_4F5F : BOOL;
		Pritom_Busbaru_Spodny_5F : BOOL;
		Pritom_Busbaru_Spodny_4F : BOOL;
		Pritom_Foamu_4F5F : BOOL;
		Pritomn_Skeletonu_4F5F : BOOL;
		Pritomn_Skeletonu_5H : BOOL;
		Nepritomn_TopCoveru_4F : BOOL;
		Nepritomn_TopCoveru_5F5H : BOOL;
		Pritomn_LavyMVcase : BOOL;
		Pritomn_PravyMVcase : BOOL;
		OsadeniePlastuDPS_OK : BOOL;
		KompletSpodneBusbary_OK : BOOL;
	END_STRUCT;
	CAM3_typ : 	STRUCT  (*P1_ST1_Vytah - kontrola QR kÛdu DPS*)
		CMD : CAM3_Commands_typ;
		PAR : CAM3_Parametre_typ;
		STAV : CAM3_Status_typ;
		RESULT : CAM3_Results_typ;
		Profinet_QRkod_Znaky : ARRAY[0..31]OF USINT;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM3_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM3_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM3_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
	END_STRUCT;
	CAM3_Results_typ : 	STRUCT 
		Paletka : CAM3_Paletka_typ;
		PowerCP : CAM3_PowerCP_typ;
	END_STRUCT;
	CAM3_PowerCP_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM3_Paletka_typ : 	STRUCT 
		CitanieQRkodu_DPS_OK : BOOL;
		PrecitanyQRkod_DPS : STRING[32];
	END_STRUCT;
	CAM4_typ : 	STRUCT  (*P1_ST1_Vytah - kontrola klipov krytu DPS*)
		CMD : CAM4_Commands_typ;
		PAR : CAM4_Parametre_typ;
		STAV : CAM4_Status_typ;
		RESULT : CAM4_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM4_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM4_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM4_Status_typ : 	STRUCT 
		READY : BOOL;
		BUSY : BOOL;
		SWITCH : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM4_Results_typ : 	STRUCT 
		Paletka : CAM4_Paletka_typ;
		PowerCP : CAM4_PowerCP_typ;
	END_STRUCT;
	CAM4_PowerCP_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM4_Paletka_typ : 	STRUCT 
		Pritomn_Pinu1_KrytDPS_4F5F : BOOL;
		Pritomn_Pinu2_KrytDPS_4F5F : BOOL;
		Pritomn_Pinu3_KrytDPS_4F5F : BOOL;
		Pritomn_Pinu4_KrytDPS_4F5F : BOOL;
		Pritomn_Pinu5_KrytDPS_4F5F : BOOL;
		Pritomn_Pinu6_KrytDPS_4F5F : BOOL;
		Pritom_DPS_4F5F : BOOL;
	END_STRUCT;
	CAM5_typ : 	STRUCT  (*P1_ST1_Vytah - kontrola QR kÛdu PowerCP*)
		CMD : CAM5_Commands_typ;
		PAR : CAM5_Parametre_typ;
		STAV : CAM5_Status_typ;
		RESULT : CAM5_Results_typ;
		Profinet_QRkod_Znaky : ARRAY[0..31]OF USINT;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM5_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM5_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM5_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
	END_STRUCT;
	CAM5_Results_typ : 	STRUCT 
		Paletka : CAM5_Paletka_typ;
		PowerCP : CAM5_PowerCP_typ;
	END_STRUCT;
	CAM5_PowerCP_typ : 	STRUCT 
		CitanieQRkodu_PowerCP_OK : BOOL;
		PrecitanyQRkod_PowerCP : STRING[32];
	END_STRUCT;
	CAM5_Paletka_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM6_typ : 	STRUCT  (*P1_ST2_StoperSkrutkovania - Kontrola paletky*)
		CMD : CAM6_Commands_typ;
		PAR : CAM6_Parametre_typ;
		STAV : CAM6_Status_typ;
		RESULT : CAM6_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM6_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM6_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM6_Status_typ : 	STRUCT 
		READY : BOOL;
		BUSY : BOOL;
		SWITCH : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM6_Results_typ : 	STRUCT 
		Paletka : CAM6_Paletka_typ;
		PowerCP : CAM6_PowerCP_typ;
	END_STRUCT;
	CAM6_PowerCP_typ : 	STRUCT 
		Nepritom_LavyFoam_4F5F : BOOL;
		Nepritom_PravyFoam_4F5F : BOOL;
		Pritom_LavejSkrutkyK30 : BOOL;
		Pritom_PravejSkrutkyK30 : BOOL;
		Pritom_SkrutkyDPS_4F5F : BOOL;
		Nepritom_ZadnejSkrutkyM4_4F : BOOL;
		Nepritom_ZadnejSkrutkyM4_5F : BOOL;
		Nepritom_PrednejSkrutkyM4_4F : BOOL;
		Nepritom_PrednejSkrutkyM4_5F : BOOL;
		Pritom_LavejSkrutkyM5_5H : BOOL;
		Pritom_PravejSkrutkyM5_5H : BOOL;
		Pritom_StrednejSkrutkyM5_5H : BOOL;
	END_STRUCT;
	CAM6_Paletka_typ : 	STRUCT 
		Pritom_SpodnychBusbarov_5H : BOOL;
		Pritom_KrytuBusbarov_5H : BOOL;
		Pritom_SpodnyBusbar_5F : BOOL;
		Pritom_SpodnyBusbar_4F : BOOL;
		Pritom_LavyFoam_4F5F : BOOL;
		Pritom_PravyFoam_4F5F : BOOL;
	END_STRUCT;
	CAM7_typ : 	STRUCT  (*P2_ST1_StoperZaklTesnenia - Kontrola Power CP a QR kÛdu filtra*)
		CMD : CAM7_Commands_typ;
		PAR : CAM7_Parametre_typ;
		STAV : CAM7_Status_typ;
		RESULT : CAM7_Results_typ;
		Profinet_QRkod_Znaky : ARRAY[0..31]OF USINT;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM7_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM7_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM7_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM7_Results_typ : 	STRUCT 
		CitanieQRkodu_Filtra5H_OK : BOOL;
		PrecitanyQRkod_Filtra5H : STRING[32];
	END_STRUCT;
	CAM8_typ : 	STRUCT  (*P2_ST1_StoperZaklTesnenia - Kontrola spodnÈho QR kÛdu Power CP*)
		CMD : CAM8_Commands_typ;
		PAR : CAM8_Parametre_typ;
		STAV : CAM8_Status_typ;
		RESULT : CAM8_Results_typ;
		Profinet_QRkod_Znaky : ARRAY[0..31]OF USINT;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM8_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM8_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM8_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
	END_STRUCT;
	CAM8_Results_typ : 	STRUCT 
		Paletka : CAM8_Paletka_typ;
		PowerCP : CAM8_PowerCP_typ;
	END_STRUCT;
	CAM8_PowerCP_typ : 	STRUCT 
		CitanieQRkodu_PowerCP_OK : BOOL;
		PrecitanyQRkod_PowerCP : STRING[30];
	END_STRUCT;
	CAM8_Paletka_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM9_typ : 	STRUCT  (*P2_ST2_StoperMaticovacky - Kontrola paletky*)
		CMD : CAM9_Commands_typ;
		PAR : CAM9_Parametre_typ;
		STAV : CAM9_Status_typ;
		RESULT : CAM9_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM9_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM9_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM9_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
	END_STRUCT;
	CAM9_Results_typ : 	STRUCT 
		Paletka : CAM9_Paletka_typ;
		PowerCP : CAM9_PowerCP_typ;
	END_STRUCT;
	CAM9_PowerCP_typ : 	STRUCT 
		NepritomMatice : BOOL;
		PritomnBusbaru_5H : BOOL;
	END_STRUCT;
	CAM9_Paletka_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM10_typ : 	STRUCT  (*P2_ST3_StoperSkrutkovania - Kontrola paletky*)
		CMD : CAM10_Commands_typ;
		PAR : CAM10_Parametre_typ;
		STAV : CAM10_Status_typ;
		RESULT : CAM10_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM10_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM10_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM10_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM10_Results_typ : 	STRUCT 
		Paletka : CAM10_Paletka_typ;
		PowerCP : CAM10_PowerCP_typ;
	END_STRUCT;
	CAM10_PowerCP_typ : 	STRUCT 
		Pritomn_LavejSkrutkyM6_4F5F : BOOL;
		Pritomn_PravejSkrutkyM6_4F5F : BOOL;
		Pritomn_LavejM4_4F5F : BOOL;
		Pritomn_PravejM4_4F5F : BOOL;
		Pritomn_SkrutkyM4_Filtra_5H : BOOL;
		Pritomn_LavejSkrutkyM5_5H : BOOL;
		Pritomn_PravejSkrutkyM5_5H : BOOL;
	END_STRUCT;
	CAM10_Paletka_typ : 	STRUCT 
		Pritomn_Busbarov_5F : BOOL;
		Pritomn_Busbarov_4F : BOOL;
		Pritomn_Busbarov_5H : BOOL;
		Pritomn_PowerCP_5H : BOOL;
		Pritomn_PowerCP_4F : BOOL;
		Pritomn_PowerCP_5F : BOOL;
	END_STRUCT;
	CAM11_typ : 	STRUCT  (*P2_ST4_StoperZvarania - Kontrola pravÈho MV case*)
		CMD : CAM11_Commands_typ;
		PAR : CAM11_Parametre_typ;
		STAV : CAM11_Status_typ;
		RESULT : CAM11_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM11_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM11_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM11_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM11_Results_typ : 	STRUCT 
		Paletka : CAM11_Paletka_typ;
		PowerCP : CAM11_PowerCP_typ;
	END_STRUCT;
	CAM11_Paletka_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM11_PowerCP_typ : 	STRUCT 
		Pritomn_PowerCP_4F : BOOL;
		Pritomn_PowerCP_5F : BOOL;
		Pritomn_PowerCP_5H : BOOL;
		Pritomn_LavyMVcase : BOOL;
		Pritomn_PravyMVcase : BOOL;
		LavyBusbar_Zvaranie_OK : BOOL;
		PravyBusbar_Zvaranie_OK : BOOL;
		Pritomn_TopCover_4F : BOOL;
		Pritomn_TopCover_5F : BOOL;
		Pritomn_TopCover_5H : BOOL;
	END_STRUCT;
	CAM12_typ : 	STRUCT  (*P2_ST4_StoperZvarania - Kontrola lavÈho MV case a Power CP*)
		CMD : CAM12_Commands_typ;
		PAR : CAM12_Parametre_typ;
		STAV : CAM12_Status_typ;
		RESULT : CAM12_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM12_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM12_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM12_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM12_Results_typ : 	STRUCT 
		Paletka : CAM12_Paletka_typ;
		PowerCP : CAM12_PowerCP_typ;
	END_STRUCT;
	CAM12_Paletka_typ : 	STRUCT 
		Pritomn_TopCover_5H5F : BOOL;
		Pritomn_TopCover_4F : BOOL;
		Pritomn_LavyMVcase : BOOL;
		Pritomn_PravyMVcase : BOOL;
	END_STRUCT;
	CAM12_PowerCP_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM13_typ : 	STRUCT  (*P3_ST1_StoperSkrutkovania - Kontrola paletky*)
		CMD : CAM13_Commands_typ;
		PAR : CAM13_Parametre_typ;
		STAV : CAM13_Status_typ;
		RESULT : CAM13_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM13_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM13_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM13_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM13_Results_typ : 	STRUCT 
		Pritomn_SkrutkyK40_TopCover_4F5F : BOOL;
		Pritomn_SkrutkyM5_TopCover : BOOL;
	END_STRUCT;
	CAM14_typ : 	STRUCT  (*P4_ST3_StoperEtiketovania - kontrola QR kodu na Power CP*)
		CMD : CAM14_Commands_typ;
		PAR : CAM14_Parametre_typ;
		STAV : CAM14_Status_typ;
		RESULT : CAM14_Results_typ;
		Profinet_QRkod_Znaky : ARRAY[0..31]OF USINT;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM14_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM14_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM14_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
	END_STRUCT;
	CAM14_Results_typ : 	STRUCT 
		Paletka : CAM14_Paletka_typ;
		PowerCP : CAM14_PowerCP_typ;
	END_STRUCT;
	CAM14_PowerCP_typ : 	STRUCT 
		CitanieQRkodu_PowerCP_OK : BOOL;
		PrecitanyQRkod_PowerCP : STRING[32];
	END_STRUCT;
	CAM14_Paletka_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM15_typ : 	STRUCT  (*P4_ST3_StoperEtiketovania - kontrola nalepenej etikety*)
		CMD : CAM15_Commands_typ;
		PAR : CAM15_Parametre_typ;
		STAV : CAM15_Status_typ;
		RESULT : CAM15_Results_typ;
		Profinet_QRkod_Znaky : ARRAY[0..31]OF USINT;
		Profinet_OCR_Znaky : ARRAY[0..31]OF USINT;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM15_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM15_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM15_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM15_Results_typ : 	STRUCT 
		Pritomn_Etikety : BOOL;
		Pritomn_LogoBMV : BOOL;
		Pritomn_Textu_PowerCP : BOOL;
		Pritomn_Textu_Panasonic : BOOL;
		Pritomn_Textu_SK : BOOL;
		CitanieQRkodu_Etikety_OK : BOOL;
		PrecitanyQRkod_Etikety : STRING[31];
		PrecitaneOCR_Etikety : STRING[32];
	END_STRUCT;
	CAM16_typ : 	STRUCT  (*P4_ST4_Vytah - kontrola paletky*)
		CMD : CAM16_Commands_typ;
		PAR : CAM16_Parametre_typ;
		STAV : CAM16_Status_typ;
		RESULT : CAM16_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM16_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM16_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM16_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM16_Results_typ : 	STRUCT 
		New_Member : USINT;
		Paletka : CAM16_Paletka_typ;
		PowerCP : CAM16_PowerCP_typ;
	END_STRUCT;
	CAM16_Paletka_typ : 	STRUCT 
		Pritomn_Busbarov_4F : BOOL;
		Pritomn_Busbarov_5F : BOOL;
		Pritomn_Busbarov_5H : BOOL;
		Pritomn_LavyMVcase : BOOL;
		Pritomn_PravyMVcase : BOOL;
		Pritomn_PowerCP : BOOL;
		PrazdnaPaletka : BOOL;
	END_STRUCT;
	CAM16_PowerCP_typ : 	STRUCT 
		PritomnostSkrutky_K40 : BOOL;
		PritomnostSkrutky_M5 : BOOL;
	END_STRUCT;
	CAM17_typ : 	STRUCT  (*P2_ST1_StoperZaklTesnenia - Kontrola paletky*)
		CMD : CAM17_Commands_typ;
		PAR : CAM17_Parametre_typ;
		STAV : CAM17_Status_typ;
		RESULT : CAM17_Results_typ;
		Profinet_PLC_INPUTS : ARRAY[0..100]OF USINT;
		Profinet_PLC_OUTPUTS : ARRAY[0..3]OF USINT;
	END_STRUCT;
	CAM17_Commands_typ : 	STRUCT 
		Triger : BOOL;
		OdosliFotku : BOOL;
		VymazFotku : BOOL;
	END_STRUCT;
	CAM17_Parametre_typ : 	STRUCT 
		ResultFotky : STRING[5];
	END_STRUCT;
	CAM17_Status_typ : 	STRUCT 
		BUSY : BOOL;
		SWITCH : BOOL;
		READY : BOOL;
		OLD_SWITCH : BOOL;
		Results_READY : BOOL;
		Command_READY : BOOL;
		Command_ERROR : BOOL;
		Command_AKCEPTOVANY : BOOL;
	END_STRUCT;
	CAM17_Results_typ : 	STRUCT 
		Paletka : CAM17_Paletka_typ;
		PowerCP : CAM17_PowerCP_typ;
	END_STRUCT;
	CAM17_PowerCP_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	CAM17_Paletka_typ : 	STRUCT 
		Pritomn_TopCoveru_4F : BOOL;
		Pritomn_TopCoveru_5F : BOOL;
		Pritomn_TopCoveru_5H : BOOL;
		Pritomn_Busbary_5H : BOOL;
		Pritomn_Busbary_5F : BOOL;
		Pritomn_Busbary_4F : BOOL;
		Pritomn_LavyMVcase : BOOL;
		Pritomn_PravyMVcase : BOOL;
		Pritomn_PowerCP_4F : BOOL;
		Pritomn_PowerCP_5F : BOOL;
		Pritomn_PowerCP_5H : BOOL;
		PoziciaBusbarov4F5F_OK : BOOL;
		PoziciaBusbarov5H_OK : BOOL;
	END_STRUCT;
	ControlUnit_typ : 	STRUCT  (*Riadiaci systÈm pre kamery*)
		Profinet_PLC_INPUTS : ARRAY[0..1]OF USINT;
		Stav_READY : BOOL;
	END_STRUCT;
END_TYPE
