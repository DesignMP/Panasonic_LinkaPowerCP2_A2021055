
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//*************************************Prepnutie obrazovky pri stla�en� tla��tka CS*********************************//
	IF EDGEPOS(P3_Pracovisko.STAV.Manual AND NOT Safety.STAV.Linka_ZonaCS_AKTIVNA) THEN
		P34_Vizu.GoPage:= 'PageAutomatP34';
	ELSIF EDGEPOS(P4_Pracovisko.STAV.Manual AND NOT Safety.STAV.Linka_ZonaCS_AKTIVNA) THEN
		P34_Vizu.GoPage:= 'PageAutomatP34';	
	END_IF	
	
	
	
	
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
	
	
	//********************************Blikanie tla��tka Alarmy*******************************************************//
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
	
	//********Zmeny farieb tla��tok ovl�dania z�mkov bunky 3***************//
	//Zadn� dvere //
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
	
		
	
	//Predn� dvere //
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
	//0 - Pracovisko je vypnut�.
	//1 - Prebieha inicializ�cia pracoviska.
	//2 - Na pracovisku prebieha v�roba.
	//3 - Prebieha ukon�enie pracovn�ho cyklu pracoviska.
	//4 - Prebieha re�im vypr�zdnenia linky.
	//5 - Dopl� z�sobn�k skrutiek K40 !!!
	//6 - Dopl� z�sobn�k skrutiek M5 !!!
	//7 - Niesu zalo�en� spr�vne kontakty na HV teste !!!
	//8 - Niesu zalo�en� spr�vne kontakty na Leakage teste stanica A !!!
	//9 - Niesu zalo�en� spr�vne kontakty na Leakage teste stanica B !!!
	
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
	
	
	
	
	//*************Prep�nanie farby textov�ho pola warning bunky 3*****************//
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
	
	
	//*************Zamknutie tla��tok bunky 3************************//
	//Zamknutie tla��tok ovl�dania z�mkov//
	IF P3_Pracovisko.STAV.Automat THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= FALSE;
	ELSIF P3_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= FALSE;
	ELSIF P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY THEN	
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= FALSE;
	ELSIF P3_HV_Test.STAV.RR_SekvenciaTestera_BUSY THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= FALSE;
	ELSIF P3_LeakageTestA.STAV.RR_TestovaciaSekvencia_BUSY THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= FALSE;
	ELSIF P3_LeakageTestB.STAV.RR_TestovaciaSekvencia_BUSY THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= FALSE;	
	ELSE
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P3:= TRUE;
	END_IF	
	
	//Tla��tko �tat Automat//
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
	
	
	//Tla��tko Ukon�enie Cyklu//
	IF P3_Pracovisko.STAV.PoINIT THEN
		P34_Vizu.TL_KoniecCyklu_ENABLE_P3:= TRUE;
	ELSE	
		P34_Vizu.TL_KoniecCyklu_ENABLE_P3:= FALSE;
	END_IF	
	
	//Tla��tko STOP//
	IF P3_Pracovisko.STAV.PoINIT AND NOT P3_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.TL_STOP_ENABLE_P3:= FALSE;
	ELSE    
		P34_Vizu.TL_STOP_ENABLE_P3:= TRUE;
	END_IF    
    
    
    
    	
	
	//Tla��tko Re�im Manual//
	IF P3_Pracovisko.STAV.Automat THEN
		P34_Vizu.TL_RezimManual_ENABLE_P3:= FALSE;
	ELSIF NOT P3_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.TL_RezimManual_ENABLE_P3:= FALSE;
	ELSE
		P34_Vizu.TL_RezimManual_ENABLE_P3:= TRUE;
	END_IF	
	

	//Tla��tka vypnutia leakage testov//
//	IF P3_Pracovisko.STAV.Automat THEN
//		P34_Vizu.VolbaLeakageTestu_ENABLE:= FALSE;
//	ELSE
		P34_Vizu.VolbaLeakageTestu_ENABLE:= TRUE;
//	END_IF	
	
	
	//RR - Tla��tko �istenia skrutkova�ky K40//
	IF P3_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P34_Vizu.TL_VycistiSkrutkovackuK40_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_VycistiSkrutkovackuK40_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_VycistiSkrutkovackuK40_ENABLE:= FALSE;
	ELSIF P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY THEN
		P34_Vizu.TL_VycistiSkrutkovackuK40_ENABLE:= FALSE;
	ELSIF NOT P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
		P34_Vizu.TL_VycistiSkrutkovackuK40_ENABLE:= FALSE;
	ELSIF P3_Srobovanie.CMD.RR_SkrutSetK40_VysunBrzdu THEN
		P34_Vizu.TL_VycistiSkrutkovackuK40_ENABLE:= FALSE;
	ELSIF P3_Srobovanie.CMD.RR_SkrutSetK40_Zasobnik_RUN THEN
		P34_Vizu.TL_VycistiSkrutkovackuK40_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_VycistiSkrutkovackuK40_ENABLE:= TRUE;
	END_IF
	
	
	//RR - Tla��tko polohovania aplik�tora//
	IF P3_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P34_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSIF P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY THEN
		P34_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSIF NOT P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
		P34_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_PolohujManipulator_ENABLE:= TRUE;
	END_IF
	
	
	
	//RR - Tla��tko vysunutia skrutkova�ky K40//
	IF P3_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P34_Vizu.Tl_VysunutieSkrutkovK40_ENABLE:= FALSE;
	ELSIF P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY THEN
		P34_Vizu.Tl_VysunutieSkrutkovK40_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P34_Vizu.Tl_VysunutieSkrutkovK40_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.Tl_VysunutieSkrutkovK40_ENABLE:= FALSE;
	ELSE
		P34_Vizu.Tl_VysunutieSkrutkovK40_ENABLE:= TRUE;
	END_IF	
	
	
	
	//RR - Tla��tko vysunutia skrutkova�ky M5//
	IF P3_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P34_Vizu.TL_OvladaniaVysunSkrutkovM5:= FALSE;
	ELSIF P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY THEN
		P34_Vizu.TL_OvladaniaVysunSkrutkovM5:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_OvladaniaVysunSkrutkovM5:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_OvladaniaVysunSkrutkovM5:= FALSE;
	ELSE	
		P34_Vizu.TL_OvladaniaVysunSkrutkovM5:= TRUE;
	END_IF
	
	
	//RR - Ovl�danie skrutkovacieho setu K40//
	IF P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY THEN
		P34_Vizu.TL_OvladSkrutkovSetuK40_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_OvladSkrutkovSetuK40_ENABLE:= TRUE;
	END_IF	

	//RR - Ovl�danie manipulatora Y//
	IF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_OvladManipulatoraY_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_OvladManipulatoraY_ENABLE:= TRUE;
	END_IF	
	
	
	

	//RR - Ovl�danie HV Testu//
	IF P3_HV_Test.STAV.RR_SekvenciaTestera_BUSY THEN
		P34_Vizu.TL_OvladaniaHV_Testu_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_OvladaniaHV_Testu_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_OvladaniaHV_Testu_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_OvladaniaHV_Testu_ENABLE:= TRUE;
	END_IF
	
	//RR - Ovl�danie sekvencie HV Testu//
	IF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_SekvencieHV_Testu_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_SekvencieHV_Testu_ENABLE:= FALSE;
	ELSIF NOT P3_HV_Test.RFID_hlava.PritomnostPaletky THEN
		P34_Vizu.TL_SekvencieHV_Testu_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_SekvencieHV_Testu_ENABLE:= TRUE;
	END_IF
	
	
	//RR - Ovl�danie Leakage Testu A//
	IF P3_LeakageTestA.STAV.RR_TestovaciaSekvencia_BUSY THEN
		P34_Vizu.TL_OvladaniaLeakTestuA_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_OvladaniaLeakTestuA_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_OvladaniaLeakTestuA_ENABLE:= FALSE;
	ELSE
		P34_Vizu.TL_OvladaniaLeakTestuA_ENABLE:= TRUE;
	END_IF	
	
	
	//RR - Testovacia sekvencia Leakage Testu A//
	IF NOT P3_LeakageTestA.IN.HornyPritlak_ZASUNUTY OR NOT P3_LeakageTestA.IN.Centrovanie_ZASUNUTE THEN
		P34_Vizu.TL_SekvencieLeakTestuA_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_SekvencieLeakTestuA_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_SekvencieLeakTestuA_ENABLE:= FALSE;
	ELSIF P3_LeakageTestA.STAV.RR_TestovaciaSekvencia_BUSY THEN
		P34_Vizu.TL_SekvencieLeakTestuA_ENABLE:= FALSE;
	ELSIF NOT P3_LeakageTestA.RFID_hlava.PritomnostPaletky THEN
		P34_Vizu.TL_SekvencieLeakTestuA_ENABLE:= FALSE;
	ELSE
		P34_Vizu.TL_SekvencieLeakTestuA_ENABLE:= TRUE;
	END_IF	
	
	
	
	//RR - Ovl�danie Leakage Testu B//
	IF P3_LeakageTestB.STAV.RR_TestovaciaSekvencia_BUSY THEN
		P34_Vizu.TL_OvladaniaLeakTestuB_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_OvladaniaLeakTestuB_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_OvladaniaLeakTestuB_ENABLE:= FALSE;
	ELSE
		P34_Vizu.TL_OvladaniaLeakTestuB_ENABLE:= TRUE;
	END_IF	
	
	
	//RR - Testovacia sekvencia Leakage Testu B//
	IF NOT P3_LeakageTestB.IN.HornyPritlak_ZASUNUTY OR NOT P3_LeakageTestB.IN.Centrovanie_ZASUNUTE THEN
		P34_Vizu.TL_SekvencieLeakTestuB_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_SekvencieLeakTestuB_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_SekvencieLeakTestuB_ENABLE:= FALSE;
	ELSIF P3_LeakageTestB.STAV.RR_TestovaciaSekvencia_BUSY THEN
		P34_Vizu.TL_SekvencieLeakTestuB_ENABLE:= FALSE;
	ELSIF NOT P3_LeakageTestB.RFID_hlava.PritomnostPaletky THEN
		P34_Vizu.TL_SekvencieLeakTestuB_ENABLE:= FALSE;
	ELSE
		P34_Vizu.TL_SekvencieLeakTestuB_ENABLE:= TRUE;
	END_IF	
	
	
	

	
	
	
	
	
	
	//**************************Zamknutie edit�cie parametrov*********************************//
	IF P34_UrovenPrihlasenehoUzivatela >= 20 THEN
		P34_Vizu.EditaciaParametrov_ENABLE:= TRUE;
	ELSE     
		P34_Vizu.EditaciaParametrov_ENABLE:= FALSE;
	END_IF    
	
	
	//************************Prep�nanie stavov pracov�sk - Bunka 3***************************//
	//Dopravn�ky//
	IF P3_Dopravniky.Automat AND NOT P3_Dopravniky.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_DopravnikP3:= 1;
	ELSIF P3_Dopravniky.Automat AND P3_Dopravniky.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_DopravnikP3:= 2;
	ELSE
		P34_Vizu.IndexStavu_DopravnikP3:= 0;
	END_IF	
	
	//Spodn� stoper//
	IF P3_SpodnyStoper.Automat AND NOT P3_SpodnyStoper.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SpodnyStoperP3:= 1;
	ELSIF P3_SpodnyStoper.Automat AND P3_SpodnyStoper.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SpodnyStoperP3:= 2;
	ELSE
		P34_Vizu.IndexStavu_SpodnyStoperP3:= 0;
	END_IF	
	
	    
    
	//Stoper �robovania//
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
	
	
	
	//�robovanie//
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
	
		
	
	
	
	//Zdvi�ka pred Leakage testom A//
	IF P3_Pracovisko.STAV.Porucha_ST3 THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomA:= 3;
	ELSIF P3_ZdvizkaPredLeakTestA.Automat AND NOT P3_ZdvizkaPredLeakTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomA:= 1;
	ELSIF P3_ZdvizkaPredLeakTestA.Automat AND P3_ZdvizkaPredLeakTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomA:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkPredLeakTestomA:= 0;
	END_IF	
	
	//Zdvi�ka pred Leakage testom B//
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
	
	
	//Zdvi�ka za Leakage testom A//
	IF P3_Pracovisko.STAV.Porucha_ST7 THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomA:= 3;
	ELSIF P3_ZdvizkaZaLeakTestA.Automat AND NOT P3_ZdvizkaZaLeakTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomA:= 1;
	ELSIF P3_ZdvizkaZaLeakTestA.Automat AND P3_ZdvizkaZaLeakTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomA:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkaZaLeakTestomA:= 0;
	END_IF	
	
	
	
	//Zdvi�ka za Leakage testom B//
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
	
	//**************Zmeny farieb tla��tok ovl�dania z�mkov bunky 4*********************//
	//Predn� dvere //
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
	
	//Zadn� dvere//
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
	//0 - Pracovisko je vypnut�.
	//1 - Prebieha inicializ�cia pracoviska.
	//2 - Na pracovisku prebieha v�roba.
	//3 - Prebieha ukon�enie pracovn�ho cyklu pracoviska.
	//4 - Prebieha re�im vypr�zdnenia linky.
	//5 - Niesu zalo�en� spr�vne kontakty na Funk�nom teste stanica A !!!
	//6 - Niesu zalo�en� spr�vne kontakty na Funk�nom teste stanica B !!!
	
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
	
	
	
	
	//****************Prep�nanie farby textov�ho pola warning bunky 4************************//
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
	
	
	
	//*************Zamknutie tla��tok bunky 4************************//
	//Zamknutie tla��tok ovl�dania z�mkov//
	IF P4_Pracovisko.STAV.Automat THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P4:= FALSE;
	ELSIF P4_FunkcnyTestA.STAV.RR_SekvenciaTestera_BUSY THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P4:= FALSE;
	ELSIF P4_FunkcnyTestB.STAV.RR_SekvenciaTestera_BUSY THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P4:= FALSE;
	ELSIF P4_Etiketovacka.STAV.RR_SekvenciaEtiketovania_BUSY THEN
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P4:= FALSE;
	ELSE
		P34_Vizu.TL_OvladaniaZamkov_ENABLE_P4:= TRUE;
	END_IF	
	
	//Tla��tko �tat Automat//
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
	
	
	//Tla��tko Ukon�enie Cyklu//
	IF P4_Pracovisko.STAV.PoINIT THEN
		P34_Vizu.TL_KoniecCyklu_ENABLE_P4:= TRUE;
	ELSE	
		P34_Vizu.TL_KoniecCyklu_ENABLE_P4:= FALSE;
	END_IF	
	
	//Tla��tko STOP//
	IF P4_Pracovisko.STAV.PoINIT AND NOT P4_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P34_Vizu.TL_STOP_ENABLE_P4:= FALSE;
	ELSE    
		P34_Vizu.TL_STOP_ENABLE_P4:= TRUE;
	END_IF    
    
        	
	
	//Tla��tko Re�im Manual//
	IF P4_Pracovisko.STAV.Automat THEN
		P34_Vizu.TL_RezimManual_ENABLE_P4:= FALSE;
	ELSIF NOT P4_Pracovisko.STAV.HardwareBunky_OK THEN
		P34_Vizu.TL_RezimManual_ENABLE_P4:= FALSE;
	ELSE
		P34_Vizu.TL_RezimManual_ENABLE_P4:= TRUE;
	END_IF	
	
	
	//Tla��tka vypnutia final testov//
//	IF P4_Pracovisko.STAV.Automat THEN
//		P34_Vizu.VolbaFunkcnehoTestu_ENABLE:= FALSE;
//	ELSE
		P34_Vizu.VolbaFunkcnehoTestu_ENABLE:= TRUE;
//	END_IF	
	
	
	//RR - Ovl�danie Funk�n�ho testu A//
	IF P4_FunkcnyTestA.STAV.RR_SekvenciaTestera_BUSY THEN
		P34_Vizu.TL_OvladaniaFunkcTestuA_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_OvladaniaFunkcTestuA_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_OvladaniaFunkcTestuA_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_OvladaniaFunkcTestuA_ENABLE:= TRUE;
	END_IF
	
	//RR - Ovl�danie sekvencie Funk�n�ho Testu A//
	IF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_SekvencieFunkcTestuA_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_SekvencieFunkcTestuA_ENABLE:= FALSE;
	ELSIF NOT P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky THEN
		P34_Vizu.TL_SekvencieFunkcTestuA_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_SekvencieFunkcTestuA_ENABLE:= TRUE;
	END_IF
	
	
	//RR - Ovl�danie Funk�n�ho testu B//
	IF P4_FunkcnyTestB.STAV.RR_SekvenciaTestera_BUSY THEN
		P34_Vizu.TL_OvladaniaFunkcTestuB_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_OvladaniaFunkcTestuB_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_OvladaniaFunkcTestuB_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_OvladaniaFunkcTestuB_ENABLE:= TRUE;
	END_IF
	
	//RR - Ovl�danie sekvencie Funk�n�ho Testu B//
	IF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_SekvencieFunkcTestuB_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_SekvencieFunkcTestuB_ENABLE:= FALSE;
	ELSIF NOT P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky THEN
		P34_Vizu.TL_SekvencieFunkcTestuB_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_SekvencieFunkcTestuB_ENABLE:= TRUE;
	END_IF
	
	
	//RR - Ovl�danie etiketovania//
	IF P4_Etiketovacka.STAV.RR_SekvenciaEtiketovania_BUSY THEN
		P34_Vizu.TL_OvladaniaEtiketovania_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_OvladaniaEtiketovania_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN	
		P34_Vizu.TL_OvladaniaEtiketovania_ENABLE:= FALSE;
	ELSE
		P34_Vizu.TL_OvladaniaEtiketovania_ENABLE:= TRUE;
	END_IF	
	
	
	//RR - Ovl�danie sekvencie etiketovania//
	IF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN	
		P34_Vizu.TL_SekvencieEtiketovania_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P34_Vizu.TL_SekvencieEtiketovania_ENABLE:= FALSE;
	ELSIF P4_Etiketovacka.STAV.RR_SekvenciaEtiketovania_BUSY THEN
		P34_Vizu.TL_SekvencieEtiketovania_ENABLE:= FALSE;
	ELSIF P4_Etiketovacka.ServoZdvihuAplikatora.Status.ActPosition > 5 THEN
		P34_Vizu.TL_SekvencieEtiketovania_ENABLE:= FALSE;
	ELSIF NOT P4_Etiketovacka.RFID_hlava.PritomnostPaletky THEN
		P34_Vizu.TL_SekvencieEtiketovania_ENABLE:= FALSE;
	ELSIF NOT P4_Etiketovacka.IN.Aplikator_OtocenyVZAD THEN
		P34_Vizu.TL_SekvencieEtiketovania_ENABLE:= FALSE;
	ELSIF NOT P4_Etiketovacka.IN.Aplikator_ZASUNUTY THEN
		P34_Vizu.TL_SekvencieEtiketovania_ENABLE:= FALSE;	
	ELSE
		P34_Vizu.TL_SekvencieEtiketovania_ENABLE:= TRUE;
	END_IF	
	
	
	//RR - Tla��tka ovl�dania zdvihu aplik�tora//
	IF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN
		P34_Vizu.TL_ZdvihAplikEtiketovania_ENABLE:= FALSE;
	ELSE	
		P34_Vizu.TL_ZdvihAplikEtiketovania_ENABLE:= TRUE;
	END_IF	
	
	//RR - Tla��tko v�tah ��tanie paletky//
	IF P4_Vytah.RFID_hlava.PritomnostPaletky THEN
		P34_Vizu.Vytah_CitaniePaletky_ENABLE:= TRUE;
	ELSE	
		P34_Vizu.Vytah_CitaniePaletky_ENABLE:= FALSE;
	END_IF	
	
	//RR - Tla��tko v��ah z�pis paletky//
	IF P4_Vytah.RFID_hlava.PritomnostPaletky THEN
		P34_Vizu.Vytah_ZapisPaletky_ENABLE:= TRUE;
	ELSE
		P34_Vizu.Vytah_ZapisPaletky_ENABLE:= FALSE;
	END_IF	
	
	
	
	
	
	
	
	//************Prep�nanie stavov pracov�sk - Bunka 4**************************//
	//Dopravn�ky//
	IF P4_Dopravniky.Automat AND NOT P4_Dopravniky.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_DopravnikP4:= 1;
	ELSIF P4_Dopravniky.Automat AND P4_Dopravniky.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_DopravnikP4:= 2;
	ELSE
		P34_Vizu.IndexStavu_DopravnikP4:= 0;
	END_IF	
	

	//Spodn� stoper//
	IF P4_SpodnyStoper.Automat AND NOT P4_SpodnyStoper.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SpodnyStoperP4:= 1;
	ELSIF P4_SpodnyStoper.Automat AND P4_SpodnyStoper.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_SpodnyStoperP4:= 2;
	ELSE
		P34_Vizu.IndexStavu_SpodnyStoperP4:= 0;
	END_IF	
	
	//Stoper Funk�n� Test A//
	IF P4_Pracovisko.STAV.Porucha_ST1 THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestA:= 3;
	ELSIF P4_FunkcnyTestA.Automat AND NOT P4_FunkcnyTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestA:= 1;
	ELSIF P4_FunkcnyTestA.Automat AND P4_FunkcnyTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestA:= 2;
	ELSE
		P34_Vizu.IndexStavu_StoperFunkcnyTestA:= 0;
	END_IF	
	
	
	
	//Stoper Funk�n� Test B//
	IF P4_Pracovisko.STAV.Porucha_ST2 THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestB:= 3;
	ELSIF P4_FunkcnyTestB.Automat AND NOT P4_FunkcnyTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestB:= 1;
	ELSIF P4_FunkcnyTestB.Automat AND P4_FunkcnyTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_StoperFunkcnyTestB:= 2;
	ELSE
		P34_Vizu.IndexStavu_StoperFunkcnyTestB:= 0;
	END_IF	
	
	
	//Zdvi�ka za Funk�n�m testom A//
	IF P4_Pracovisko.STAV.Porucha_ST3 THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomA:= 3;
	ELSIF P4_ZdvizkaZaFunkcTestA.Automat AND NOT P4_ZdvizkaZaFunkcTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomA:= 1;
	ELSIF P4_ZdvizkaZaFunkcTestA.Automat AND P4_ZdvizkaZaFunkcTestA.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomA:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomA:= 0;
	END_IF	
	
	//Zdvi�ka za Funk�n�m testom B//
	IF P4_Pracovisko.STAV.Porucha_ST4 THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomB:= 3;
	ELSIF P4_ZdvizkaZaFunkcTestB.Automat AND NOT P4_ZdvizkaZaFunkcTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomB:= 1;
	ELSIF P4_ZdvizkaZaFunkcTestB.Automat AND P4_ZdvizkaZaFunkcTestB.STAV.PoINIT THEN
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomB:= 2;
	ELSE
		P34_Vizu.IndexStavu_ZdvizkaZaFunkTestomB:= 0;
	END_IF	
	
	
	//Stoper Etiketova�ky//
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
	
		
	//V��ah//
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

