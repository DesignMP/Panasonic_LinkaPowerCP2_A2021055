
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//************************************Filter alarmov**************************************************************//
	FilterVizu_P34:= '[{"logicalOperator":"and","value":300,"conditionType":">=","columnType":"cod","useAlarmState":false,"alarmState":0},{"value":500,"conditionType":"<=","columnType":"cod","useAlarmState":false,"alarmState":0}]';

	
	
	//***********************Prepnutie bootovacej obrazovky********************************//
	IF P34_Vizu.ActualPage <> 'PageBootP34' AND NOT Safety.STAV.Linka_SafetyPLC_Nabehlo THEN
		P34_Vizu.GoPage:= 'PageBootP34';
	ELSIF P34_Vizu.ActualPage = 'PageBootP34' AND Safety.STAV.Linka_SafetyPLC_Nabehlo THEN
		P34_Vizu.GoPage:= 'PageAutomatP34';
	END_IF	
	
	IF P34_Vizu.GoPage = 'PageBootP34' AND P34_Vizu.ActualPage = 'PageBootP34' THEN
		P34_Vizu.GoPage:= '';
	ELSIF P34_Vizu.GoPage = 'PageAutomatP34' AND P34_Vizu.ActualPage = 'PageAutomatP34' THEN
		P34_Vizu.GoPage:= '';
	END_IF	
	
	
	//********************************Blikanie tlaËÌtka Alarmy*******************************************************//
	IF (P3_Pracovisko.STAV.PORUCHA OR P4_Pracovisko.STAV.PORUCHA) AND P34_Vizu.ActualPage <> 'PageAlarmP34' THEN
		IF Blikac500ms THEN
			P34_AlarmyVizu.FarbaTlacitka_Alarmy:= "Button_Red";
		ELSE	
			P34_AlarmyVizu.FarbaTlacitka_Alarmy:= "default";
		END_IF
	ELSE
		P34_AlarmyVizu.FarbaTlacitka_Alarmy:= "default";
	END_IF	
	
	
	
	//*****************************************BUNKA 3*********************************************************//
	
	//********Zmeny farieb tlaËÌtok ovl·dania z·mkov bunky 3***************//
	//ZadnÈ dvere //
	IF P3_Pracovisko.STAV.ZadneDvereZamknute AND P3_Pracovisko.IN.ZadneDvereLave_PritomnAdaptera AND P3_Pracovisko.IN.ZadneDverePrave_PritomnAdaptera THEN
		P34_Vizu.TL_ZadnyZamok_Farba_P3:= "Button_Green";
	ELSIF P3_Pracovisko.IN.ZadneDvereLave_PritomnAdaptera AND P3_Pracovisko.IN.ZadneDverePrave_PritomnAdaptera THEN
		IF Blikac1s THEN
			P34_Vizu.TL_ZadnyZamok_Farba_P3:= "Button_Blue";
		ELSE
			P34_Vizu.TL_ZadnyZamok_Farba_P3:= "Operate";
		END_IF	
	ELSE	
		P34_Vizu.TL_ZadnyZamok_Farba_P3:= "Button_Red";
	END_IF	
	
		
	
	//PrednÈ dvere //
	IF P3_Pracovisko.STAV.PredneDvereZamknute AND P3_Pracovisko.IN.PredneDvereLave_PritomnAdaptera AND P3_Pracovisko.IN.PredneDverePrave_PritomnAdaptera THEN
		P34_Vizu.TL_PrednyZamok_Farba_P3:= "Button_Green";
	ELSIF P3_Pracovisko.IN.PredneDvereLave_PritomnAdaptera AND P3_Pracovisko.IN.PredneDverePrave_PritomnAdaptera THEN
		IF Blikac1s THEN
			P34_Vizu.TL_PrednyZamok_Farba_P3:= "Button_Blue";
		ELSE
			P34_Vizu.TL_PrednyZamok_Farba_P3:= "Operate";
		END_IF	
	ELSE	
		P34_Vizu.TL_PrednyZamok_Farba_P3:= "Button_Red";
	END_IF	
	
	
	//************Zobrazenie warningov bunky 3**********************//
	//0 - Pracovisko je vypnutÈ.
	//1 - Prebieha inicializ·cia pracoviska.
	//2 - Na pracovisku prebieha v˝roba.
	//3 - Prebieha ukonËenie pracovnÈho cyklu pracoviska.
	//4 - Prebieha reûim vypr·zdnenia linky.
	//5 - DoplÚ z·sobnÌk skrutiek K40 !!!
	//6 - DoplÚ z·sobnÌk skrutiek M5 !!!
	//7 - Niesu zaloûenÈ spr·vne kontakty na HV teste !!!
	//8 - Niesu zaloûenÈ spr·vne kontakty na Leakage teste stanica A !!!
	//9 - Niesu zaloûenÈ spr·vne kontakty na Leakage teste stanica B !!!
	
	IF Linka.PAR.ZvolenyModel = '4F' AND NOT P3_HV_Test.IN.TypKonektoru_4F THEN
		P34_Vizu.WarningsP3_Index:= 7;
	ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P3_HV_Test.IN.TypKonektoru_5F_5H THEN
		P34_Vizu.WarningsP3_Index:= 7;
	ELSIF Linka.PAR.ZvolenyModel = '5H' AND NOT P3_HV_Test.IN.TypKonektoru_5F_5H THEN
		P34_Vizu.WarningsP3_Index:= 7;	
	ELSIF Linka.PAR.ZvolenyModel = '4F' AND NOT P3_LeakageTestA.IN.Tester_TypKonektoru_4F THEN
		P34_Vizu.WarningsP3_Index:= 8;
	ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P3_LeakageTestA.IN.Tester_TypKonektoru_5F_5H THEN
		P34_Vizu.WarningsP3_Index:= 8;
	ELSIF Linka.PAR.ZvolenyModel = '5H' AND NOT P3_LeakageTestA.IN.Tester_TypKonektoru_5F_5H THEN
		P34_Vizu.WarningsP3_Index:= 8;	
	ELSIF Linka.PAR.ZvolenyModel = '4F' AND NOT P3_LeakageTestB.IN.Tester_TypKonektoru_4F THEN
		P34_Vizu.WarningsP3_Index:= 9;
	ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P3_LeakageTestB.IN.Tester_TypKonektoru_5F_5H THEN
		P34_Vizu.WarningsP3_Index:= 9;
	ELSIF Linka.PAR.ZvolenyModel = '5H' AND NOT P3_LeakageTestB.IN.Tester_TypKonektoru_5F_5H THEN
		P34_Vizu.WarningsP3_Index:= 9;	
	ELSIF P3_Pracovisko.STAV.Automat AND NOT P3_Pracovisko.STAV.PoINIT AND NOT P3_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.WarningsP3_Index:= 1;		
	ELSIF P3_Srobovanie.SkrutSet_K40.IN.VibracnyHrniec.PritomnostSkrutiekVHrnci THEN
		P34_Vizu.WarningsP3_Index:= 5;
	ELSIF P3_Srobovanie.SkrutSet_M5.IN.ZasobnikSkrutiekPrazdny THEN
		P34_Vizu.WarningsP3_Index:= 6;
	ELSIF Linka.PAR.TestovaciKus THEN
		P34_Vizu.WarningsP3_Index:= 11;
	ELSIF Linka.PAR.VyprazdnenieLinky THEN
		P34_Vizu.WarningsP3_Index:= 4;
	ELSIF P3_Pracovisko.STAV.PoINIT AND NOT P3_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.WarningsP3_Index:= 2;	
	ELSIF P3_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.WarningsP3_Index:= 3;	
	ELSIF NOT P3_Pracovisko.STAV.Automat THEN
		P34_Vizu.WarningsP3_Index:= 0;
	END_IF	
	
	
	
	
	//*************PrepÌnanie farby textovÈho pola warning bunky 3*****************//
	IF P34_Vizu.WarningsP3_Index = 0 THEN
		P34_Vizu.WarningsP3_Farba:= "TextOutput_Grey";
	ELSIF P34_Vizu.WarningsP3_Index = 1 THEN
		P34_Vizu.WarningsP3_Farba:= "TextOutput_Blue";
	ELSIF P34_Vizu.WarningsP3_Index = 2 THEN
		P34_Vizu.WarningsP3_Farba:= "TextOutput_Green";
	ELSIF P34_Vizu.WarningsP3_Index = 3 THEN
		P34_Vizu.WarningsP3_Farba:= "TextOutput_Blue";
	ELSIF P34_Vizu.WarningsP3_Index = 4 THEN
		P34_Vizu.WarningsP3_Farba:= "TextOutput_Green";
	ELSIF P34_Vizu.WarningsP3_Index = 11 THEN
		P34_Vizu.WarningsP3_Farba:= "TextOutput_Green";    
	ELSE
		IF Blikac1s THEN
			P34_Vizu.WarningsP3_Farba:= "TextOutput_Orange";
		ELSE	
			P34_Vizu.WarningsP3_Farba:= "TextOutput_Grey";
		END_IF
	END_IF	
	
	
	//*************Zamknutie tlaËÌtok bunky 3************************//
	//Zamknutie tlaËÌtok ovl·dania z·mkov//
	IF P3_Pracovisko.STAV.Automat THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= FALSE;
	ELSE
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= TRUE;
	END_IF	
	
	//TlaËÌtko ätat Automat//
	IF P3_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.TL_StartAutomat_ENABLE_P3:= FALSE;
	ELSIF P3_Pracovisko.STAV.PORUCHA THEN
		P34_Vizu.TL_StartAutomat_ENABLE_P3:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_StartAutomat_ENABLE_P3:= FALSE;
	ELSIF NOT P3_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.TL_StartAutomat_ENABLE_P3:= FALSE;	
	ELSE	
		P34_Vizu.TL_StartAutomat_ENABLE_P3:= TRUE;
	END_IF	
	
	
	//TlaËÌtko UkonËenie Cyklu//
	IF P3_Pracovisko.STAV.PoINIT THEN
		P34_Vizu.TL_KoniecCyklu_ENABLE_P3:= TRUE;
	ELSE	
		P34_Vizu.TL_KoniecCyklu_ENABLE_P3:= FALSE;
	END_IF	
	
	//TlaËÌtko STOP//
	IF P3_Pracovisko.STAV.PoINIT AND NOT P3_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.TL_STOP_ENABLE_P3:= FALSE;
	ELSE    
		P34_Vizu.TL_STOP_ENABLE_P3:= TRUE;
	END_IF    
    
    
    
    	
	
	//TlaËÌtko Reûim Manual//
	IF P3_Pracovisko.STAV.Automat THEN
		P34_Vizu.TL_RezimManual_ENABLE_P3:= FALSE;
	ELSIF NOT P3_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.TL_RezimManual_ENABLE_P3:= FALSE;
	ELSE
		P34_Vizu.TL_RezimManual_ENABLE_P3:= TRUE;
	END_IF	
	

	//TlaËÌtka vypnutia leakage testov//
	IF P3_Pracovisko.STAV.Automat THEN
		P34_Vizu.VolbaLeakageTestu_ENABLE:= FALSE;
	ELSE
		P34_Vizu.VolbaLeakageTestu_ENABLE:= TRUE;
	END_IF	
	
	
	//**************************Zamknutie edit·cie parametrov*********************************//
	IF P34_UrovenPrihlasenehoUzivatela >= 20 THEN
		P34_Vizu.EditaciaParametrov_ENABLE:= TRUE;
	ELSE     
		P34_Vizu.EditaciaParametrov_ENABLE:= FALSE;
	END_IF    
	
	
	//************************PrepÌnanie stavov pracovÌsk - Bunka 3***************************//
	//DopravnÌky//
	IF P3_Dopravniky.Automat AND NOT P3_Dopravniky.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_DopravnikP3:= 1;
	ELSIF P3_Dopravniky.Automat AND P3_Dopravniky.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_DopravnikP3:= 2;
	ELSE
		P34_Vizu.IndexStavu_DopravnikP3:= 0;
	END_IF	
	
	//Spodn˝ stoper//
	IF P3_SpodnyStoper.Automat AND NOT P3_SpodnyStoper.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SpodnyStoperP3:= 1;
	ELSIF P3_SpodnyStoper.Automat AND P3_SpodnyStoper.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SpodnyStoperP3:= 2;
	ELSE
		P34_Vizu.IndexStavu_SpodnyStoperP3:= 0;
	END_IF	
	
	    
    
	//Stoper örobovania//
	IF NOT P3_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.IndexStavu_StoperSrobovaniaP3:= 3;
	ELSIF P3_Pracovisko.STAV.Porucha_ST1 THEN
		P34_Vizu.IndexStavu_StoperSrobovaniaP3:= 3;
	ELSIF P3_StoperSrobovania.Automat AND NOT P3_StoperSrobovania.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperSrobovaniaP3:= 1;
	ELSIF P3_StoperSrobovania.Automat AND P3_StoperSrobovania.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperSrobovaniaP3:= 2;
	ELSE
		P34_Vizu.IndexStavu_StoperSrobovaniaP3:= 0;
	END_IF	
	
	
	
	//ärobovanie//
	IF NOT P3_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.IndexStavu_SrobovanieP3:= 3;
	ELSIF P3_Pracovisko.STAV.Porucha_ST1 THEN
		P34_Vizu.IndexStavu_SrobovanieP3:= 3;
	ELSIF P3_Srobovanie.Automat AND NOT P3_Srobovanie.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SrobovanieP3:= 1;
	ELSIF P3_Srobovanie.Automat AND P3_Srobovanie.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SrobovanieP3:= 2;
	ELSE
		P34_Vizu.IndexStavu_SrobovanieP3:= 0;
	END_IF	
	
	//HV test//
	IF NOT P3_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.IndexStavu_HV_Test:= 3;
	ELSIF P3_Pracovisko.STAV.Porucha_ST2 THEN
		P34_Vizu.IndexStavu_HV_Test:= 3;
	ELSIF P3_HV_Test.Automat AND NOT P3_HV_Test.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_HV_Test:= 1;
	ELSIF P3_HV_Test.Automat AND P3_HV_Test.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_HV_Test:= 2;
	ELSE
		P34_Vizu.IndexStavu_HV_Test:= 0;
	END_IF	
	
	
	//Zdviûka pred Leakage testom A//
	IF P3_Pracovisko.STAV.Porucha_ST3 THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomA:= 3;
	ELSIF P3_ZdvizkaPredLeakTestA.Automat AND NOT P3_ZdvizkaPredLeakTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomA:= 1;
	ELSIF P3_ZdvizkaPredLeakTestA.Automat AND P3_ZdvizkaPredLeakTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomA:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomA:= 0;
	END_IF	
	
	//Zdviûka pred Leakage testom B//
	IF P3_Pracovisko.STAV.Porucha_ST4 THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomB:= 3;
	ELSIF P3_ZdvizkaPredLeakTestB.Automat AND NOT P3_ZdvizkaPredLeakTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomB:= 1;
	ELSIF P3_ZdvizkaPredLeakTestB.Automat AND P3_ZdvizkaPredLeakTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomB:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomB:= 0;
	END_IF		
	
		
		
	//Stoper Leakage Test A//
	IF P3_Pracovisko.STAV.Porucha_ST5 THEN
		P34_Vizu.IndexStavu_StoperLeakageTestA:= 3;
	ELSIF P3_LeakageTestA.Automat AND NOT P3_LeakageTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperLeakageTestA:= 1;
	ELSIF P3_LeakageTestA.Automat AND P3_LeakageTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperLeakageTestA:= 2;
	ELSE
		P34_Vizu.IndexStavu_StoperLeakageTestA:= 0;
	END_IF	
	
	
	//Stoper Leakage Test B//
	IF P3_Pracovisko.STAV.Porucha_ST6 THEN
		P34_Vizu.IndexStavu_StoperLeakageTestB:= 3;
	ELSIF P3_LeakageTestB.Automat AND NOT P3_LeakageTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperLeakageTestB:= 1;
	ELSIF P3_LeakageTestB.Automat AND P3_LeakageTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperLeakageTestB:= 2;
	ELSE
		P34_Vizu.IndexStavu_StoperLeakageTestB:= 0;
	END_IF	
	
	
	//Zdviûka za Leakage testom A//
	IF P3_Pracovisko.STAV.Porucha_ST7 THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomA:= 3;
	ELSIF P3_ZdvizkaZaLeakTestA.Automat AND NOT P3_ZdvizkaZaLeakTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomA:= 1;
	ELSIF P3_ZdvizkaZaLeakTestA.Automat AND P3_ZdvizkaZaLeakTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomA:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomA:= 0;
	END_IF	
	
	
	
	//Zdviûka za Leakage testom B//
	IF P3_Pracovisko.STAV.Porucha_ST8 THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomB:= 3;
	ELSIF P3_ZdvizkaZaLeakTestB.Automat AND NOT P3_ZdvizkaZaLeakTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomB:= 1;
	ELSIF P3_ZdvizkaZaLeakTestB.Automat AND P3_ZdvizkaZaLeakTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomB:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomB:= 0;
	END_IF	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//*************************************************BUNKA 4**********************************************************//
	
	//**************Zmeny farieb tlaËÌtok ovl·dania z·mkov bunky 4*********************//
	//PrednÈ dvere //
	IF P4_Pracovisko.OUT.PredneDvere_ZAMKNI AND P4_Pracovisko.IN.PredneDvere_PritomnostAdaptera THEN
		P34_Vizu.TL_PrednyZamok_Farba_P4:= "Button_Green";
	ELSIF P4_Pracovisko.IN.PredneDvere_PritomnostAdaptera THEN
		IF Blikac1s THEN
			P34_Vizu.TL_PrednyZamok_Farba_P4:= "Button_Blue";
		ELSE
			P34_Vizu.TL_PrednyZamok_Farba_P4:= "Operate";
		END_IF	
	ELSE	
		P34_Vizu.TL_PrednyZamok_Farba_P4:= "Button_Red";
	END_IF	
	
	//ZadnÈ dvere//
	IF P4_Pracovisko.OUT.ZadneDvere_ZAMKNI AND P4_Pracovisko.IN.ZadneDvere_PritomnostAdaptera THEN
		P34_Vizu.TL_ZadnyZamok_Farba_P4:= "Button_Green";
	ELSIF P4_Pracovisko.IN.ZadneDvere_PritomnostAdaptera THEN
		IF Blikac1s THEN
			P34_Vizu.TL_ZadnyZamok_Farba_P4:= "Button_Blue";
		ELSE
			P34_Vizu.TL_ZadnyZamok_Farba_P4:= "Operate";
		END_IF	
	ELSE	
		P34_Vizu.TL_ZadnyZamok_Farba_P4:= "Button_Red";
	END_IF	
	
	
	//*****************Zobrazenie warningov bunky 4****************************//
	//0 - Pracovisko je vypnutÈ.
	//1 - Prebieha inicializ·cia pracoviska.
	//2 - Na pracovisku prebieha v˝roba.
	//3 - Prebieha ukonËenie pracovnÈho cyklu pracoviska.
	//4 - Prebieha reûim vypr·zdnenia linky.
	//5 - Niesu zaloûenÈ spr·vne kontakty na FunkËnom teste stanica A !!!
	//6 - Niesu zaloûenÈ spr·vne kontakty na FunkËnom teste stanica B !!!
	
	IF Linka.PAR.ZvolenyModel = '4F' AND NOT P4_FunkcnyTestA.IN.TypSpodnychKontaktov_4F THEN
		P34_Vizu.WarningsP4_Index:= 5;
	ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P4_FunkcnyTestA.IN.TypSpodnychKontaktov_5F_5H THEN
		P34_Vizu.WarningsP4_Index:= 5;
	ELSIF Linka.PAR.ZvolenyModel = '5H' AND NOT P4_FunkcnyTestA.IN.TypSpodnychKontaktov_5F_5H THEN
		P34_Vizu.WarningsP4_Index:= 5;	
	ELSIF Linka.PAR.ZvolenyModel = '4F' AND NOT P4_FunkcnyTestB.IN.TypSpodnychKontaktov_4F THEN
		P34_Vizu.WarningsP4_Index:= 6;
	ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P4_FunkcnyTestB.IN.TypSpodnychKontaktov_5F_5H THEN
		P34_Vizu.WarningsP4_Index:= 6;
	ELSIF Linka.PAR.ZvolenyModel = '5H' AND NOT P4_FunkcnyTestB.IN.TypSpodnychKontaktov_5F_5H THEN
		P34_Vizu.WarningsP4_Index:= 6;
	ELSIF P4_Pracovisko.STAV.Automat AND NOT P4_Pracovisko.STAV.PoINIT AND NOT P4_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.WarningsP4_Index:= 1;	
	ELSIF Linka.PAR.TestovaciKus THEN
		P34_Vizu.WarningsP4_Index:= 8;
	ELSIF Linka.PAR.VyprazdnenieLinky THEN
		P34_Vizu.WarningsP4_Index:= 4;
	ELSIF P4_Pracovisko.STAV.PoINIT AND NOT P4_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.WarningsP4_Index:= 2;	
	ELSIF P4_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.WarningsP4_Index:= 3;	
	ELSIF NOT P4_Pracovisko.STAV.Automat THEN
		P34_Vizu.WarningsP4_Index:= 0;
	END_IF	
	
	
	
	
	//****************PrepÌnanie farby textovÈho pola warning bunky 4************************//
	IF P34_Vizu.WarningsP4_Index = 0 THEN
		P34_Vizu.WarningsP4_Farba:= "TextOutput_Grey";
	ELSIF P34_Vizu.WarningsP4_Index = 1 THEN
		P34_Vizu.WarningsP4_Farba:= "TextOutput_Blue";	
	ELSIF P34_Vizu.WarningsP4_Index = 2 THEN
		P34_Vizu.WarningsP4_Farba:= "TextOutput_Green";	
	ELSIF P34_Vizu.WarningsP4_Index = 3 THEN
		P34_Vizu.WarningsP4_Farba:= "TextOutput_Blue";	
	ELSIF P34_Vizu.WarningsP4_Index = 4 THEN
		P34_Vizu.WarningsP4_Farba:= "TextOutput_Green";	
	ELSIF P34_Vizu.WarningsP4_Index = 8 THEN
		P34_Vizu.WarningsP4_Farba:= "TextOutput_Green";	    
	ELSE
		IF Blikac1s THEN
			P34_Vizu.WarningsP4_Farba:= "TextOutput_Orange";
		ELSE	
			P34_Vizu.WarningsP4_Farba:= "TextOutput_Grey";
		END_IF
	END_IF	
	
	
	
	//*************Zamknutie tlaËÌtok bunky 4************************//
	//Zamknutie tlaËÌtok ovl·dania z·mkov//
	IF P4_Pracovisko.STAV.Automat THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P4:= FALSE;
	ELSE
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P4:= TRUE;
	END_IF	
	
	//TlaËÌtko ätat Automat//
	IF P4_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.TL_StartAutomat_ENABLE_P4:= FALSE;
	ELSIF P4_Pracovisko.STAV.PORUCHA THEN
		P34_Vizu.TL_StartAutomat_ENABLE_P4:= FALSE;
	ELSIF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_StartAutomat_ENABLE_P4:= FALSE;
	ELSIF NOT P4_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.TL_StartAutomat_ENABLE_P4:= FALSE;	
	ELSE	
		P34_Vizu.TL_StartAutomat_ENABLE_P4:= TRUE;
	END_IF	
	
	
	//TlaËÌtko UkonËenie Cyklu//
	IF P4_Pracovisko.STAV.PoINIT THEN
		P34_Vizu.TL_KoniecCyklu_ENABLE_P4:= TRUE;
	ELSE	
		P34_Vizu.TL_KoniecCyklu_ENABLE_P4:= FALSE;
	END_IF	
	
	//TlaËÌtko STOP//
	IF P4_Pracovisko.STAV.PoINIT AND NOT P4_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.TL_STOP_ENABLE_P4:= FALSE;
	ELSE    
		P34_Vizu.TL_STOP_ENABLE_P4:= TRUE;
	END_IF    
    
        	
	
	//TlaËÌtko Reûim Manual//
	IF P4_Pracovisko.STAV.Automat THEN
		P34_Vizu.TL_RezimManual_ENABLE_P4:= FALSE;
	ELSIF NOT P4_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.TL_RezimManual_ENABLE_P4:= FALSE;
	ELSE
		P34_Vizu.TL_RezimManual_ENABLE_P4:= TRUE;
	END_IF	
	
	
	//TlaËÌtka vypnutia final testov//
	IF P3_Pracovisko.STAV.Automat THEN
		P34_Vizu.VolbaFunkcnehoTestu_ENABLE:= FALSE;
	ELSE
		P34_Vizu.VolbaFunkcnehoTestu_ENABLE:= TRUE;
	END_IF	
	
	
	
	
	
	
	
	
	
	
	//************PrepÌnanie stavov pracovÌsk - Bunka 4**************************//
	//DopravnÌky//
	IF P4_Dopravniky.Automat AND NOT P4_Dopravniky.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_DopravnikP4:= 1;
	ELSIF P4_Dopravniky.Automat AND P4_Dopravniky.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_DopravnikP4:= 2;
	ELSE
		P34_Vizu.IndexStavu_DopravnikP4:= 0;
	END_IF	
	

	//Spodn˝ stoper//
	IF P4_SpodnyStoper.Automat AND NOT P4_SpodnyStoper.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SpodnyStoperP4:= 1;
	ELSIF P4_SpodnyStoper.Automat AND P4_SpodnyStoper.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SpodnyStoperP4:= 2;
	ELSE
		P34_Vizu.IndexStavu_SpodnyStoperP4:= 0;
	END_IF	
	
	//Stoper FunkËn˝ Test A//
	IF P4_Pracovisko.STAV.Porucha_ST1 THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestA:= 3;
	ELSIF P4_FunkcnyTestA.Automat AND NOT P4_FunkcnyTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestA:= 1;
	ELSIF P4_FunkcnyTestA.Automat AND P4_FunkcnyTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestA:= 2;
	ELSE
		P34_Vizu.IndexStavu_StoperFunkcnyTestA:= 0;
	END_IF	
	
	
	
	//Stoper FunkËn˝ Test B//
	IF P4_Pracovisko.STAV.Porucha_ST2 THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestB:= 3;
	ELSIF P4_FunkcnyTestB.Automat AND NOT P4_FunkcnyTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestB:= 1;
	ELSIF P4_FunkcnyTestB.Automat AND P4_FunkcnyTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestB:= 2;
	ELSE
		P34_Vizu.IndexStavu_StoperFunkcnyTestB:= 0;
	END_IF	
	
	
	//Zdviûka za FunkËn˝m testom A//
	IF P4_Pracovisko.STAV.Porucha_ST3 THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomA:= 3;
	ELSIF P4_ZdvizkaZaFunkcTestA.Automat AND NOT P4_ZdvizkaZaFunkcTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomA:= 1;
	ELSIF P4_ZdvizkaZaFunkcTestA.Automat AND P4_ZdvizkaZaFunkcTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomA:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomA:= 0;
	END_IF	
	
	//Zdviûka za FunkËn˝m testom B//
	IF P4_Pracovisko.STAV.Porucha_ST4 THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomB:= 3;
	ELSIF P4_ZdvizkaZaFunkcTestB.Automat AND NOT P4_ZdvizkaZaFunkcTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomB:= 1;
	ELSIF P4_ZdvizkaZaFunkcTestB.Automat AND P4_ZdvizkaZaFunkcTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomB:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomB:= 0;
	END_IF	
	
	
	//Stoper EtiketovaËky//
	IF NOT P4_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.IndexStavu_StoperEtiketovackyP4:= 3;
	ELSIF P4_Pracovisko.STAV.Porucha_ST5 THEN
		P34_Vizu.IndexStavu_StoperEtiketovackyP4:= 3;
	ELSIF P4_Etiketovacka.Automat AND NOT P4_Etiketovacka.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperEtiketovackyP4:= 1;
	ELSIF P4_Etiketovacka.Automat AND P4_Etiketovacka.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperEtiketovackyP4:= 2;
	ELSE
		P34_Vizu.IndexStavu_StoperEtiketovackyP4:= 0;
	END_IF
	
		
	//V˝ùah//
	IF NOT P4_Pracovisko.STAV.HardwareVytahu_OK THEN
		P34_Vizu.IndexStavu_Vytah:= 3;
	ELSIF P4_Pracovisko.STAV.Porucha_ST6 THEN
		P34_Vizu.IndexStavu_Vytah:= 3;
	ELSIF P4_Vytah.Automat AND NOT P4_Vytah.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_Vytah:= 1;
	ELSIF P4_Vytah.Automat AND P4_Vytah.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_Vytah:= 2;
	ELSE
		P34_Vizu.IndexStavu_Vytah:= 0;
	END_IF	
	

	
	
	
	
	
	
	 
		END_PROGRAM

PROGRAM _EXIT
		(* Insert code here *)
	 
		END_PROGRAM

