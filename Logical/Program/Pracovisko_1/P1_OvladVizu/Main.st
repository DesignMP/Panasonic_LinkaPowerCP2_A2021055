
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//************************************Filter alarmov**************************************************************//
	FilterVizu_P1:= '[{"logicalOperator":"and","value":100,"conditionType":">=","columnType":"cod","useAlarmState":false,"alarmState":0},{"value":199,"conditionType":"<=","columnType":"cod","useAlarmState":false,"alarmState":0}]';

	
	
	//Zmeny farieb tlaËÌtok ovl·dania z·mkov//
	//PrednÈ dvere //
	IF P1_Pracovisko.OUT.PredneDvere_ZAMKNI AND P1_Pracovisko.IN.PredneDvere_PritomnostAdaptera THEN
		P1_Vizu.TL_PrednyZamok_Farba:= "Button_Green";
	ELSIF P1_Pracovisko.IN.PredneDvere_PritomnostAdaptera THEN
		IF Blikac1s THEN
			P1_Vizu.TL_PrednyZamok_Farba:= "Button_Blue";
		ELSE
			P1_Vizu.TL_PrednyZamok_Farba:= "Operate";
		END_IF	
	ELSE	
		P1_Vizu.TL_PrednyZamok_Farba:= "Button_Red";
	END_IF	
	
	//ZadnÈ dvere//
	IF P1_Pracovisko.OUT.ZadneDvere_ZAMKNI AND P1_Pracovisko.IN.ZadneDvere_PritomnostAdaptera THEN
		P1_Vizu.TL_ZadnyZamok_Farba:= "Button_Green";
	ELSIF P1_Pracovisko.IN.ZadneDvere_PritomnostAdaptera THEN
		IF Blikac1s THEN
			P1_Vizu.TL_ZadnyZamok_Farba:= "Button_Blue";
		ELSE
			P1_Vizu.TL_ZadnyZamok_Farba:= "Operate";
		END_IF	
	ELSE	
		P1_Vizu.TL_ZadnyZamok_Farba:= "Button_Red";
	END_IF	
	
	
	
	//***********************************Zobrazenie warningov pracoviska****************************************************//
	//0 - Pracovisko je vypnutÈ.
	//1 - Prebieha inicializ·cia pracoviska.
	//2 - Na pracovisku prebieha v˝roba.
	//3 - Prebieha ukonËenie pracovnÈho cyklu pracoviska.
	//4 - Prebieha reûim vypr·zdnenia linky.
	//5 - Robot nie je prepnuty do automatickÈho reûimu !!!
	//6 - DoplÚ z·sobnÌk skrutiek K30 !!!
	//7 - DoplÚ z·sobnÌk skrutiek M5 !!!
	//8 - DoplÚ z·sobnÌk skrutiek M4 !!!
	//10 - TestovacÌ kus 
	
	IF NOT P1_Robot.COM_IN.Stav_RezimAUTOMAT THEN
		P1_Vizu.Warnings_Index:= 5;
	ELSIF P1_Pracovisko.STAV.Automat AND NOT P1_Pracovisko.STAV.PoINIT AND NOT P1_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P1_Vizu.Warnings_Index:= 1;		
	ELSIF P1_Srobovanie.SkrutSet_K30.IN.VibracnyHrniec.PritomnostSkrutiekVHrnci THEN
		P1_Vizu.Warnings_Index:= 6;
	ELSIF P1_Srobovanie.SkrutSet_M5.IN.ZasobnikSkrutiekPrazdny THEN
		P1_Vizu.Warnings_Index:= 7;
	ELSIF P1_Srobovanie.SkrutSet_M4.IN.ZasobnikSkrutiekPrazdny THEN
		P1_Vizu.Warnings_Index:= 8;
	ELSIF Linka.PAR.TestovaciKus THEN
		P1_Vizu.Warnings_Index:= 10;
	ELSIF Linka.PAR.VyprazdnenieLinky THEN
		P1_Vizu.Warnings_Index:= 4;
	ELSIF P1_Pracovisko.STAV.PoINIT AND NOT P1_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P1_Vizu.Warnings_Index:= 2;	
	ELSIF P1_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P1_Vizu.Warnings_Index:= 3;	
	ELSIF NOT P1_Pracovisko.STAV.Automat THEN
		P1_Vizu.Warnings_Index:= 0;
	END_IF	
	
	//************************PrepÌnanie farby textovÈho pola warning zariadenia***********************************//
	IF P1_Vizu.Warnings_Index = 0 THEN
		P1_Vizu.Warnings_Farba:= "TextOutput_Grey";
	ELSIF P1_Vizu.Warnings_Index = 1 THEN
		P1_Vizu.Warnings_Farba:= "TextOutput_Blue";
	ELSIF P1_Vizu.Warnings_Index = 2 THEN
		P1_Vizu.Warnings_Farba:= "TextOutput_Green";
	ELSIF P1_Vizu.Warnings_Index = 3 THEN
		P1_Vizu.Warnings_Farba:= "TextOutput_Blue";
	ELSIF P1_Vizu.Warnings_Index = 4 THEN
		P1_Vizu.Warnings_Farba:= "TextOutput_Green";
	ELSIF P1_Vizu.Warnings_Index = 10 THEN
		P1_Vizu.Warnings_Farba:= "TextOutput_Green";    
	ELSE
		IF Blikac1s THEN
			P1_Vizu.Warnings_Farba:= "TextOutput_Orange";
		ELSE	
			P1_Vizu.Warnings_Farba:= "TextOutput_Grey";
		END_IF
	END_IF	

			
	//***********************Prepnutie bootovacej obrazovky********************************//
	IF P1_Vizu.ActualPage <> 'PageBootP1' AND NOT Safety.STAV.Linka_SafetyPLC_Nabehlo THEN
		P1_Vizu.GoPage:= 'PageBootP1';
	ELSIF P1_Vizu.ActualPage = 'PageBootP1' AND Safety.STAV.Linka_SafetyPLC_Nabehlo THEN
		P1_Vizu.GoPage:= 'PageAutomatP1';
	END_IF	
	
	IF P1_Vizu.GoPage = 'PageBootP1' AND P1_Vizu.ActualPage = 'PageBootP1' THEN
		P1_Vizu.GoPage:= '';
	ELSIF P1_Vizu.GoPage = 'PageAutomatP1' AND P1_Vizu.ActualPage = 'PageAutomatP1' THEN
		P1_Vizu.GoPage:= '';
	END_IF	
	
	

	//********************************Blikanie tlaËÌtka Alarmy*******************************************************//
	IF P1_Pracovisko.STAV.PORUCHA AND P1_Vizu.ActualPage <> 'PageAlarmP1' THEN
		IF Blikac500ms THEN
			P1_AlarmyVizu.FarbaTlacitka_Alarmy:= "Button_Red";
		ELSE	
			P1_AlarmyVizu.FarbaTlacitka_Alarmy:= "default";
		END_IF
	ELSE
		P1_AlarmyVizu.FarbaTlacitka_Alarmy:= "default";
	END_IF	
	
	
	
	
	
	
	
	//*************************************Zamknutie tlaËÌtok***************************************************************//
	//Zamknutie tlaËÌtok ovl·dania z·mkov//
	IF P1_Pracovisko.STAV.Automat THEN
		P1_Vizu.TL_OvladaniaZamkov_ENABLE:= FALSE;
	ELSE
		P1_Vizu.TL_OvladaniaZamkov_ENABLE:= TRUE;
	END_IF	
		
	
	//TlaËÌtko ätat Automat//
	IF P1_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P1_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF P1_Pracovisko.STAV.PORUCHA THEN
		P1_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF NOT P1_Robot.COM_IN.Stav_RezimAUTOMAT THEN
		P1_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P1_ZonaBunky_AKTIVNA THEN
		P1_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF NOT P1_Pracovisko.STAV.HardwareVytahu_OK THEN
		P1_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF NOT P1_Pracovisko.STAV.HardwareBunky_OK THEN
		P1_Vizu.TL_StartAutomat_ENABLE:= FALSE;	
	ELSE	
		P1_Vizu.TL_StartAutomat_ENABLE:= TRUE;
	END_IF	
	
	//TlaËÌtko UkonËenie Cyklu//
	IF P1_Pracovisko.STAV.PoINIT THEN
		P1_Vizu.TL_KoniecCyklu_ENABLE:= TRUE;
	ELSE	
		P1_Vizu.TL_KoniecCyklu_ENABLE:= FALSE;
	END_IF	
	
	//TlaËÌtko STOP//
	IF P1_Pracovisko.STAV.PoINIT AND NOT P1_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P1_Vizu.TL_STOP_ENABLE:= FALSE;
	ELSE    
		P1_Vizu.TL_STOP_ENABLE:= TRUE;
	END_IF    
    
    
    
	//TlaËÌtko Reûim Automat//
	
	P1_Vizu.TL_RezimAutomat_ENABLE:= TRUE;
    	
	
	//TlaËÌtko Reûim Manual//
	IF P1_Pracovisko.STAV.Automat THEN
		P1_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSIF NOT P1_Pracovisko.STAV.HardwareVytahu_OK THEN
		P1_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSIF NOT P1_Pracovisko.STAV.HardwareBunky_OK THEN	
		P1_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSE
		P1_Vizu.TL_RezimManual_ENABLE:= TRUE;
	END_IF	
	

	
	//TlaËÌtko zmena modelu//
	IF Linka.STAV.OFF THEN
		P1_Vizu.TL_VolbaModelu_ENABLE:= TRUE;
	ELSE
		P1_Vizu.TL_VolbaModelu_ENABLE:= FALSE;
	END_IF    
    
	//TlaËÌtko paletka prech·dza//
	IF NOT Linka.STAV.PoINIT THEN
		P1_Vizu.TL_PaletkaPrechadza_ENABLE:= FALSE;
	ELSIF NOT P1_Vytah.RFID_hlava.PritomnostPaletky THEN    
		P1_Vizu.TL_PaletkaPrechadza_ENABLE:= FALSE;
	ELSIF Linka.PAR.TestovaciKus THEN
		P1_Vizu.TL_PaletkaPrechadza_ENABLE:= FALSE;
	ELSIF Linka.PAR.RevorkovyKus THEN
		P1_Vizu.TL_PaletkaPrechadza_ENABLE:= FALSE;
	ELSIF Linka.PAR.PaletkaPrechadza THEN
		P1_Vizu.TL_PaletkaPrechadza_ENABLE:= FALSE;
	ELSE
		P1_Vizu.TL_PaletkaPrechadza_ENABLE:= TRUE;
	END_IF	
	
	
	//TlaËÌtko vypr·zdnenie linky//
	IF Linka.PAR.VyprazdnenieLinky THEN
		P1_Vizu.TL_VyprazdnenieLinky_ENABLE:= FALSE;
	ELSIF NOT P4_Pracovisko.STAV.Automat THEN
		P1_Vizu.TL_VyprazdnenieLinky_ENABLE:= FALSE;
	ELSIF Linka.PAR.TestovaciKus THEN
		P1_Vizu.TL_VyprazdnenieLinky_ENABLE:= FALSE;
	ELSE
		P1_Vizu.TL_VyprazdnenieLinky_ENABLE:= TRUE;
	END_IF	
	
	//TlaËÌtko testovacÌ kus//
	IF NOT Linka.STAV.PoINIT THEN
		P1_Vizu.TL_TestovaciKus_ENABLE:= FALSE;
	ELSIF Linka.PAR.RevorkovyKus THEN
		P1_Vizu.TL_TestovaciKus_ENABLE:= FALSE;
	ELSIF NOT P1_Vytah.RFID_hlava.PritomnostPaletky THEN
		P1_Vizu.TL_TestovaciKus_ENABLE:= FALSE;
	ELSIF Linka.PAR.PaletkaPrechadza THEN 
		P1_Vizu.TL_TestovaciKus_ENABLE:= FALSE;
	ELSE
		P1_Vizu.TL_TestovaciKus_ENABLE:= TRUE;
	END_IF    
    
	//TlaËÌtko revork//
	IF NOT Linka.STAV.PoINIT THEN
		P1_Vizu.TL_Revork_ENABLE:= FALSE;
	ELSIF NOT P1_Vytah.RFID_hlava.PritomnostPaletky THEN
		P1_Vizu.TL_Revork_ENABLE:= FALSE;
	ELSIF Linka.PAR.TestovaciKus THEN
		P1_Vizu.TL_Revork_ENABLE:= FALSE;
	ELSIF Linka.PAR.PaletkaPrechadza THEN 
		P1_Vizu.TL_Revork_ENABLE:= FALSE;
	ELSE
		P1_Vizu.TL_Revork_ENABLE:= TRUE;
	END_IF  
	
	
	//**************************Zamknutie edit·cie parametrov*********************************//
	IF P1_UrovenPrihlasenehoUzivatela >= 20 THEN
		P1_Vizu.EditaciaParametrov_ENABLE:= TRUE;
	ELSE     
		P1_Vizu.EditaciaParametrov_ENABLE:= FALSE;
	END_IF    
	
	
	
	
	
	//***********************************PrepÌnanie stavov pracovÌsk*******************************************************************//
	//V˝ùah//
	IF NOT P1_Pracovisko.STAV.HardwareVytahu_OK THEN
		P1_Vizu.IndexStavu_Vytah:= 3;
	ELSIF P1_Pracovisko.STAV.Porucha_ST1 THEN
		P1_Vizu.IndexStavu_Vytah:= 3;
	ELSIF P1_Vytah.Automat AND NOT P1_Vytah.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_Vytah:= 1;
	ELSIF P1_Vytah.Automat AND P1_Vytah.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_Vytah:= 2;
	ELSE
		P1_Vizu.IndexStavu_Vytah:= 0;
	END_IF	
		

	//DopravnÌky//
	IF P1_Dopravniky.Automat AND NOT P1_Dopravniky.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_Dopravnik:= 1;
	ELSIF P1_Dopravniky.Automat AND P1_Dopravniky.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_Dopravnik:= 2;
	ELSE
		P1_Vizu.IndexStavu_Dopravnik:= 0;
	END_IF	
	
	
	//Spodn˝ stoper//
	IF P1_SpodnyStoper.Automat AND NOT P1_SpodnyStoper.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_SpodnyStoper:= 1;
	ELSIF P1_SpodnyStoper.Automat AND P1_SpodnyStoper.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_SpodnyStoper:= 2;
	ELSE
		P1_Vizu.IndexStavu_SpodnyStoper:= 0;
	END_IF	
	
	//Stoper örobovania//
	IF NOT P1_Pracovisko.STAV.HardwareBunky_OK THEN
		P1_Vizu.IndexStavu_StoperSrobovania:= 3;
	ELSIF P1_Pracovisko.STAV.Porucha_ST2 THEN
		P1_Vizu.IndexStavu_StoperSrobovania:= 3;
	ELSIF P1_StoperSrobovania.Automat AND NOT P1_StoperSrobovania.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_StoperSrobovania:= 1;
	ELSIF P1_StoperSrobovania.Automat AND P1_StoperSrobovania.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_StoperSrobovania:= 2;
	ELSE
		P1_Vizu.IndexStavu_StoperSrobovania:= 0;
	END_IF	
	
	
	
	//ärobovanie//
	IF NOT P1_Pracovisko.STAV.HardwareBunky_OK THEN
		P1_Vizu.IndexStavu_Srobovanie:= 3;
	ELSIF P1_Pracovisko.STAV.Porucha_ST2 THEN
		P1_Vizu.IndexStavu_Srobovanie:= 3;
	ELSIF P1_Srobovanie.Automat AND NOT P1_Srobovanie.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_Srobovanie:= 1;
	ELSIF P1_Srobovanie.Automat AND P1_Srobovanie.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_Srobovanie:= 2;
	ELSE
		P1_Vizu.IndexStavu_Srobovanie:= 0;
	END_IF	
	
	
	
	//AkumulaËn˝ stoper//
	IF P1_Pracovisko.STAV.Porucha_ST3 THEN
		P1_Vizu.IndexStavu_AkumulacnyStoper:= 3;
	ELSIF P1_AkumulacnyStoper.Automat AND NOT P1_AkumulacnyStoper.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_AkumulacnyStoper:= 1;
	ELSIF P1_AkumulacnyStoper.Automat AND P1_AkumulacnyStoper.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_AkumulacnyStoper:= 2;
	ELSE
		P1_Vizu.IndexStavu_AkumulacnyStoper:= 0;
	END_IF	
	
	
	
	
	//Robot//
	IF P1_Robot.Automat AND NOT P1_Robot.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_Robot:= 1;
	ELSIF P1_Robot.Automat AND P1_Robot.STAV.PoINIT THEN
		P1_Vizu.IndexStavu_Robot:= 2;
	ELSE
		P1_Vizu.IndexStavu_Robot:= 0;
	END_IF	
	
	
	
	
	
	
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

