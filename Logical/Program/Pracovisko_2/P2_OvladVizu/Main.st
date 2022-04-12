
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//************************************Filter alarmov**************************************************************//
	FilterVizu_P2:= '[{"logicalOperator":"and","value":200,"conditionType":">=","columnType":"cod","useAlarmState":false,"alarmState":0},{"value":299,"conditionType":"<=","columnType":"cod","useAlarmState":false,"alarmState":0}]';

	
	
	
	//Zmeny farieb tlaèítok ovládania zámkov//
	//Zadné dvere //
	IF P2_Pracovisko.STAV.ZadneDvereZamknute AND P2_Pracovisko.IN.ZadneDvereLS_PritomnostAdaptera AND P2_Pracovisko.IN.ZadneDverePS_PritomnostAdaptera THEN
		P2_Vizu.TL_ZadnyZamok_Farba:= "Button_Green";
	ELSIF P2_Pracovisko.IN.ZadneDvereLS_PritomnostAdaptera AND P2_Pracovisko.IN.ZadneDverePS_PritomnostAdaptera THEN
		IF Blikac1s THEN
			P2_Vizu.TL_ZadnyZamok_Farba:= "Button_Blue";
		ELSE
			P2_Vizu.TL_ZadnyZamok_Farba:= "Operate";
		END_IF	
	ELSE	
		P2_Vizu.TL_ZadnyZamok_Farba:= "Button_Red";
	END_IF	
	
		
	
	//Predné dvere //
	IF P2_Pracovisko.STAV.PredneDvereZamknute AND P2_Pracovisko.IN.PredneDvereLS_PritomnostAdaptera AND P2_Pracovisko.IN.PredneDverePS_PritomnostAdaptera THEN
		P2_Vizu.TL_PrednyZamok_Farba:= "Button_Green";
	ELSIF P2_Pracovisko.IN.PredneDvereLS_PritomnostAdaptera AND P2_Pracovisko.IN.PredneDverePS_PritomnostAdaptera THEN
		IF Blikac1s THEN
			P2_Vizu.TL_PrednyZamok_Farba:= "Button_Blue";
		ELSE
			P2_Vizu.TL_PrednyZamok_Farba:= "Operate";
		END_IF	
	ELSE	
		P2_Vizu.TL_PrednyZamok_Farba:= "Button_Red";
	END_IF	
	
	
	
	
	//***********************************Zobrazenie warningov pracoviska****************************************************//
	//0 - Pracovisko je vypnuté.
	//1 - Prebieha inicializácia pracoviska.
	//2 - Na pracovisku prebieha výroba.
	//3 - Prebieha ukonèenie pracovného cyklu pracoviska.
	//4 - Prebieha režim vyprázdnenia linky.
	//5 - Robot nie je prepnuty do automatického režimu !!!
	//6 - Doplò zásobník matíc M4 !!!
	//7 - Doplò zásobník skrutiek M4 !!!
	//8 - Doplò zásobník skrutiek M5 !!!
	//9 - Doplò zásobník skrutiek M6 !!!
	
	
	IF NOT P2_Robot.COM_IN.Stav_RezimAUTOMAT THEN
		P2_Vizu.Warnings_Index:= 5;
	ELSIF P2_Pracovisko.STAV.Automat AND NOT P2_Pracovisko.STAV.PoINIT AND NOT P2_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P2_Vizu.Warnings_Index:= 1;		
	ELSIF P2_StoperMaticovacky.SkrutSet_MaticaM4.IN.ZasobnikMaticPrazdny THEN
		P2_Vizu.Warnings_Index:= 6;
	ELSIF P2_Srobovanie.SkrutSet_M4.IN.ZasobnikSkrutiekPrazdny THEN
		P2_Vizu.Warnings_Index:= 7;
	ELSIF P2_Srobovanie.SkrutSet_M5.IN.VibracnyHrniec.PritomnostSkrutiekVHrnci THEN
		P2_Vizu.Warnings_Index:= 8;
	ELSIF P2_Srobovanie.SkrutSet_M6.IN.VibracnyHrniec.PritomnostSkrutiekVHrnci THEN
		P2_Vizu.Warnings_Index:= 9;	
	ELSIF Linka.PAR.TestovaciKus THEN
		P2_Vizu.Warnings_Index:= 11;	
	ELSIF Linka.PAR.VyprazdnenieLinky THEN
		P2_Vizu.Warnings_Index:= 4;
	ELSIF P2_Pracovisko.STAV.PoINIT AND NOT P2_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P2_Vizu.Warnings_Index:= 2;	
	ELSIF P2_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P2_Vizu.Warnings_Index:= 3;	
	ELSIF NOT P2_Pracovisko.STAV.Automat THEN
		P2_Vizu.Warnings_Index:= 0;
	END_IF	
	
	

	
	//************************Prepínanie farby textového pola warning zariadenia***********************************//
	IF P2_Vizu.Warnings_Index = 0 THEN
		P2_Vizu.Warnings_Farba:= "TextOutput_Grey";
	ELSIF P2_Vizu.Warnings_Index = 1 THEN
		P2_Vizu.Warnings_Farba:= "TextOutput_Blue";
	ELSIF P2_Vizu.Warnings_Index = 2 THEN
		P2_Vizu.Warnings_Farba:= "TextOutput_Green";
	ELSIF P2_Vizu.Warnings_Index = 3 THEN
		P2_Vizu.Warnings_Farba:= "TextOutput_Blue";
	ELSIF P2_Vizu.Warnings_Index = 4 THEN
		P2_Vizu.Warnings_Farba:= "TextOutput_Green";
	ELSIF P2_Vizu.Warnings_Index = 11 THEN
		P2_Vizu.Warnings_Farba:= "TextOutput_Green";    
	ELSE
		IF Blikac1s THEN
			P2_Vizu.Warnings_Farba:= "TextOutput_Orange";
		ELSE	
			P2_Vizu.Warnings_Farba:= "TextOutput_Grey";
		END_IF
	END_IF	
	
	
	//***********************Prepnutie bootovacej obrazovky********************************//
	IF P2_Vizu.ActualPage <> 'PageBootP2' AND NOT Safety.STAV.Linka_SafetyPLC_Nabehlo THEN
		P2_Vizu.GoPage:= 'PageBootP2';
	ELSIF P2_Vizu.ActualPage = 'PageBootP2' AND Safety.STAV.Linka_SafetyPLC_Nabehlo THEN
		P2_Vizu.GoPage:= 'PageAutomatP2';
	END_IF	
	
	IF P2_Vizu.GoPage = 'PageBootP2' AND P2_Vizu.ActualPage = 'PageBootP2' THEN
		P2_Vizu.GoPage:= '';
	ELSIF P2_Vizu.GoPage = 'PageAutomatP2' AND P2_Vizu.ActualPage = 'PageAutomatP2' THEN
		P2_Vizu.GoPage:= '';
	END_IF	
	
	
	//********************************Blikanie tlaèítka Alarmy*******************************************************//
	IF P2_Pracovisko.STAV.PORUCHA AND P2_Vizu.ActualPage <> 'PageAlarmP2' THEN
		IF Blikac500ms THEN
			P2_AlarmyVizu.FarbaTlacitka_Alarmy:= "Button_Red";
		ELSE	
			P2_AlarmyVizu.FarbaTlacitka_Alarmy:= "default";
		END_IF
	ELSE
		P2_AlarmyVizu.FarbaTlacitka_Alarmy:= "default";
	END_IF	
	
	
	//*************************************Zamknutie tlaèítok***************************************************************//
	//Zamknutie tlaèítok ovládania zámkov//
	IF P2_Pracovisko.STAV.Automat THEN
		P2_Vizu.TL_OvladaniaZamkov_ENABLE:= FALSE;
	ELSE
		P2_Vizu.TL_OvladaniaZamkov_ENABLE:= TRUE;
	END_IF	
		
	
	//Tlaèítko Štat Automat//
	IF P2_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P2_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF P2_Pracovisko.STAV.PORUCHA THEN
		P2_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF NOT P2_Robot.COM_IN.Stav_RezimAUTOMAT THEN
		P2_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF NOT P2_Pracovisko.STAV.HardwareZaklTesnenia_OK THEN
		P2_Vizu.TL_StartAutomat_ENABLE:= FALSE;
	ELSIF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.TL_StartAutomat_ENABLE:= FALSE;	
	ELSE	
		P2_Vizu.TL_StartAutomat_ENABLE:= TRUE;
	END_IF	
	
	
	//Tlaèítko Ukonèenie Cyklu//
	IF P2_Pracovisko.STAV.PoINIT THEN
		P2_Vizu.TL_KoniecCyklu_ENABLE:= TRUE;
	ELSE	
		P2_Vizu.TL_KoniecCyklu_ENABLE:= FALSE;
	END_IF	
	
	//Tlaèítko STOP//
	IF P2_Pracovisko.STAV.PoINIT AND NOT P2_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P2_Vizu.TL_STOP_ENABLE:= FALSE;
	ELSE    
		P2_Vizu.TL_STOP_ENABLE:= TRUE;
	END_IF    
    
    
    
	//Tlaèítko Režim Automat//
	
	P2_Vizu.TL_RezimAutomat_ENABLE:= TRUE;
    	
	
	//Tlaèítko Režim Manual//
	IF P2_Pracovisko.STAV.Automat THEN
		P2_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSIF NOT P2_Pracovisko.STAV.HardwareZaklTesnenia_OK THEN
		P2_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSIF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSE
		P2_Vizu.TL_RezimManual_ENABLE:= TRUE;
	END_IF	
	
	
	//**************************Zamknutie editácie parametrov*********************************//
	IF P2_UrovenPrihlasenehoUzivatela >= 20 THEN
		P2_Vizu.EditaciaParametrov_ENABLE:= TRUE;
	ELSE     
		P2_Vizu.EditaciaParametrov_ENABLE:= FALSE;
	END_IF    
	
	
	//***********************************Prepínanie stavov pracovísk*******************************************************************//
	//Dopravníky//
	IF P2_Dopravniky.Automat AND NOT P2_Dopravniky.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Dopravnik:= 1;
	ELSIF P2_Dopravniky.Automat AND P2_Dopravniky.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Dopravnik:= 2;
	ELSE
		P2_Vizu.IndexStavu_Dopravnik:= 0;
	END_IF	
	

	//Stoper zakladania tesnenia//
	IF NOT P2_Pracovisko.STAV.HardwareZaklTesnenia_OK THEN
		P2_Vizu.IndexStavu_StoperZakladacaTesn:= 3;
	ELSIF P2_Pracovisko.STAV.Porucha_ST1 THEN
		P2_Vizu.IndexStavu_StoperZakladacaTesn:= 3;
	ELSIF P2_StoperZaklTesnenia.Automat AND NOT P2_StoperZaklTesnenia.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_StoperZakladacaTesn:= 1;
	ELSIF P2_StoperZaklTesnenia.Automat AND P2_StoperZaklTesnenia.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_StoperZakladacaTesn:= 2;
	ELSE
		P2_Vizu.IndexStavu_StoperZakladacaTesn:= 0;
	END_IF		
	
	//Zakladaè tesnenia//
	IF NOT P2_Pracovisko.STAV.HardwareZaklTesnenia_OK THEN
		P2_Vizu.IndexStavu_ZakladacaTesnenia:= 3;
	ELSIF P2_Pracovisko.STAV.Porucha_ST1 THEN
		P2_Vizu.IndexStavu_ZakladacaTesnenia:= 3;
	ELSIF P2_ZakladacTesnenia.Automat AND NOT P2_ZakladacTesnenia.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_ZakladacaTesnenia:= 1;
	ELSIF P2_ZakladacTesnenia.Automat AND P2_ZakladacTesnenia.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_ZakladacaTesnenia:= 2;
	ELSE
		P2_Vizu.IndexStavu_ZakladacaTesnenia:= 0;
	END_IF	
	
	//Stoper maticovaèky//
	IF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.IndexStavu_StoperMaticovacky:= 3;
	ELSIF P2_Pracovisko.STAV.Porucha_ST2 THEN
		P2_Vizu.IndexStavu_StoperMaticovacky:= 3;
	ELSIF P2_StoperMaticovacky.Automat AND NOT P2_StoperMaticovacky.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_StoperMaticovacky:= 1;
	ELSIF P2_StoperMaticovacky.Automat AND P2_StoperMaticovacky.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_StoperMaticovacky:= 2;
	ELSE
		P2_Vizu.IndexStavu_StoperMaticovacky:= 0;
	END_IF	
	
	
	//Akumulaèný stoper//
	IF P2_Pracovisko.STAV.Porucha_ST3 THEN
		P2_Vizu.IndexStavu_AkumulacnyStoper:= 3;
	ELSIF P2_AkumulacnyStoper.Automat AND NOT P2_AkumulacnyStoper.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_AkumulacnyStoper:= 1;
	ELSIF P2_AkumulacnyStoper.Automat AND P2_AkumulacnyStoper.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_AkumulacnyStoper:= 2;
	ELSE
		P2_Vizu.IndexStavu_AkumulacnyStoper:= 0;
	END_IF	
	
		
	
	//Stoper šrobovania//
	IF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.IndexStavu_StoperSrobovania:= 3;
	ELSIF P2_Pracovisko.STAV.Porucha_ST4 THEN
		P2_Vizu.IndexStavu_StoperSrobovania:= 3;
	ELSIF P2_StoperSrobovania.Automat AND NOT P2_StoperSrobovania.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_StoperSrobovania:= 1;
	ELSIF P2_StoperSrobovania.Automat AND P2_StoperSrobovania.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_StoperSrobovania:= 2;
	ELSE
		P2_Vizu.IndexStavu_StoperSrobovania:= 0;
	END_IF	
	
	
	
	//Šrobovanie//
	IF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.IndexStavu_Srobovania:= 3;
	ELSIF P2_Pracovisko.STAV.Porucha_ST4 THEN
		P2_Vizu.IndexStavu_Srobovania:= 3;
	ELSIF P2_Srobovanie.Automat AND NOT P2_Srobovanie.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Srobovania:= 1;
	ELSIF P2_Srobovanie.Automat AND P2_Srobovanie.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Srobovania:= 2;
	ELSE
		P2_Vizu.IndexStavu_Srobovania:= 0;
	END_IF	
	
	
	//Robot//
	IF P2_Robot.Automat AND NOT P2_Robot.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Robot:= 1;
	ELSIF P2_Robot.Automat AND P2_Robot.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Robot:= 2;
	ELSE
		P2_Vizu.IndexStavu_Robot:= 0;
	END_IF	
	
	
	//Stoper zvárania//
	IF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.IndexStavu_StoperZvarania:= 3;
	ELSIF P2_Pracovisko.STAV.Porucha_ST5 THEN
		P2_Vizu.IndexStavu_StoperZvarania:= 3;
	ELSIF P2_StoperZvarania.Automat AND NOT P2_StoperZvarania.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_StoperZvarania:= 1;
	ELSIF P2_StoperZvarania.Automat AND P2_StoperZvarania.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_StoperZvarania:= 2;
	ELSE
		P2_Vizu.IndexStavu_StoperZvarania:= 0;
	END_IF	
	
	
	//Zváranie//
	IF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.IndexStavu_Zvaranie:= 3;
	ELSIF P2_Pracovisko.STAV.Porucha_ST5 THEN
		P2_Vizu.IndexStavu_Zvaranie:= 3;
	ELSIF P2_Zvaranie.Automat AND NOT P2_Zvaranie.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Zvaranie:= 1;
	ELSIF P2_Zvaranie.Automat AND P2_Zvaranie.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Zvaranie:= 2;
	ELSE
		P2_Vizu.IndexStavu_Zvaranie:= 0;
	END_IF	
	
	//Èistenie//
	IF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.IndexStavu_Cistenie:= 3;
	ELSIF P2_Pracovisko.STAV.Porucha_ST5 THEN
		P2_Vizu.IndexStavu_Cistenie:= 3;
	ELSIF P2_Cistenie.Automat AND NOT P2_Cistenie.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Cistenie:= 1;
	ELSIF P2_Cistenie.Automat AND P2_Cistenie.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_Cistenie:= 2;
	ELSE
		P2_Vizu.IndexStavu_Cistenie:= 0;
	END_IF	
	
	//Spodný stoper//
	IF P2_SpodnyStoper.Automat AND NOT P2_SpodnyStoper.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_SpodnyStoper:= 1;
	ELSIF P2_SpodnyStoper.Automat AND P2_SpodnyStoper.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_SpodnyStoper:= 2;
	ELSE
		P2_Vizu.IndexStavu_SpodnyStoper:= 0;
	END_IF	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

