
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//*************************************Prepnutie obrazovky pri stla�en� tla��tka CS*********************************//
	IF EDGEPOS(P2_Pracovisko.STAV.Manual AND NOT Safety.STAV.Linka_ZonaCS_AKTIVNA) THEN
		P2_Vizu.GoPage:= 'PageAutomatP2';
	END_IF	
	
	
	
	
	
	//************************************Filter alarmov**************************************************************//
	FilterVizu_P2:= '[{"logicalOperator":"and","value":200,"conditionType":">=","columnType":"cod","useAlarmState":false,"alarmState":0},{"value":299,"conditionType":"<=","columnType":"cod","useAlarmState":false,"alarmState":0}]';

	
	
	
	//**********************************Zobrazenie upozornenia na kontrolu skrutiek na stanici 5 skrutkovania***********************************//
	IF EDGEPOS(Linka.PAR.ZvolenyModel = '4F')THEN
		P2_Vizu.ZobrazHL5_ST5:= TRUE;
		P2_Vizu.ZobrazHL6_ST5:= FALSE;
		P2_Vizu.ZobrazHL7_ST5:= FALSE;
	END_IF
	
	IF EDGEPOS(Linka.PAR.ZvolenyModel = '5F')THEN
		P2_Vizu.ZobrazHL5_ST5:= FALSE;
		P2_Vizu.ZobrazHL6_ST5:= TRUE;
		P2_Vizu.ZobrazHL7_ST5:= FALSE;
	END_IF
	
	IF EDGEPOS(Linka.PAR.ZvolenyModel = '5H')THEN
		P2_Vizu.ZobrazHL5_ST5:= FALSE;
		P2_Vizu.ZobrazHL6_ST5:= FALSE;
		P2_Vizu.ZobrazHL7_ST5:= TRUE;
	END_IF
	
	
	
	//Zmeny farieb tla��tok ovl�dania z�mkov//
	//Zadn� dvere //
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
	
		
	
	//Predn� dvere //
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
	//0 - Pracovisko je vypnut�.
	//1 - Prebieha inicializ�cia pracoviska.
	//2 - Na pracovisku prebieha v�roba.
	//3 - Prebieha ukon�enie pracovn�ho cyklu pracoviska.
	//4 - Prebieha re�im vypr�zdnenia linky.
	//5 - Robot nie je prepnuty do automatick�ho re�imu !!!
	//6 - Dopl� z�sobn�k mat�c M4 !!!
	//7 - Dopl� z�sobn�k skrutiek M4 !!!
	//8 - Dopl� z�sobn�k skrutiek M5 !!!
	//9 - Dopl� z�sobn�k skrutiek M6 !!!
	
	
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
	
	

	
	//************************Prep�nanie farby textov�ho pola warning zariadenia***********************************//
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
	
	
	//********************************Blikanie tla��tka Alarmy*******************************************************//
	IF P2_Pracovisko.STAV.PORUCHA AND P2_Vizu.ActualPage <> 'PageAlarmP2' THEN
		IF Blikac500ms THEN
			P2_AlarmyVizu.FarbaTlacitka_Alarmy:= "Button_Red";
		ELSE	
			P2_AlarmyVizu.FarbaTlacitka_Alarmy:= "default";
		END_IF
	ELSE
		P2_AlarmyVizu.FarbaTlacitka_Alarmy:= "default";
	END_IF	
	
	
	//*************************************Zamknutie tla��tok***************************************************************//
	//Zamknutie tla��tok ovl�dania z�mkov//
	IF P2_Pracovisko.STAV.Automat THEN
		P2_Vizu.TL_OvladaniaZamkov_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P2_Vizu.TL_OvladaniaZamkov_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM5_BUSY THEN	
		P2_Vizu.TL_OvladaniaZamkov_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM6_BUSY THEN	
		P2_Vizu.TL_OvladaniaZamkov_ENABLE:= FALSE;	
	ELSIF P2_Zvaranie.STAV.RR_SekvenciaZvarania_BUSY THEN
		P2_Vizu.TL_OvladaniaZamkov_ENABLE:= FALSE;
	ELSE
		P2_Vizu.TL_OvladaniaZamkov_ENABLE:= TRUE;
	END_IF	
		
	
	//Tla��tko �tat Automat//
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
	
	
	//Tla��tko Ukon�enie Cyklu//
	IF P2_Pracovisko.STAV.PoINIT THEN
		P2_Vizu.TL_KoniecCyklu_ENABLE:= TRUE;
	ELSE	
		P2_Vizu.TL_KoniecCyklu_ENABLE:= FALSE;
	END_IF	
	
	//Tla��tko STOP//
	IF P2_Pracovisko.STAV.PoINIT AND NOT P2_Pracovisko.STAV.UkoncenieCyklu_BUSY THEN
		P2_Vizu.TL_STOP_ENABLE:= FALSE;
	ELSE    
		P2_Vizu.TL_STOP_ENABLE:= TRUE;
	END_IF    
    
    
    
	//Tla��tko Re�im Automat//
	P2_Vizu.TL_RezimAutomat_ENABLE:= TRUE;
    	
	
	//Tla��tko Re�im Manual//
	IF P2_Pracovisko.STAV.Automat THEN
		P2_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSIF NOT P2_Pracovisko.STAV.HardwareZaklTesnenia_OK THEN
		P2_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSIF NOT P2_Pracovisko.STAV.HardwareBunky_OK THEN
		P2_Vizu.TL_RezimManual_ENABLE:= FALSE;
	ELSE
		P2_Vizu.TL_RezimManual_ENABLE:= TRUE;
	END_IF	
	
	//RR - Tla��tko vysunutia maticova�ky//
	IF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_VysunutiaMaticovacM4_ENABLE:= FALSE;
	ELSE	
		P2_Vizu.TL_VysunutiaMaticovacM4_ENABLE:= TRUE;
	END_IF	
	
	//RR - Tla��tko �istenia skrutkova�ky M6//
	IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM6_BUSY THEN
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM5_BUSY THEN
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= FALSE;	
	ELSIF NOT P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.CMD.RR_SkrutSetM6_VysunBrzdu THEN
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.CMD.RR_SkrutSetM6_Zasobnik_RUN THEN
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= FALSE;
	ELSE	
		P2_Vizu.TL_VycistiSkrutkovackuM6_ENABLE:= TRUE;
	END_IF
	
	
	//RR - Tla��tko �istenia skrutkova�ky M5//
	IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM6_BUSY THEN
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM5_BUSY THEN
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= FALSE;	
	ELSIF NOT P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.CMD.RR_SkrutSetM5_VysunBrzdu THEN
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN THEN
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= FALSE;
	ELSE	
		P2_Vizu.TL_VycistiSkrutkovackuM5_ENABLE:= TRUE;
	END_IF
	
	
	//RR - Tla��tko polohovania aplik�tora//
	IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P2_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P2_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM6_BUSY THEN
		P2_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM5_BUSY THEN
		P2_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;	
	ELSIF NOT P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
		P2_Vizu.TL_PolohujManipulator_ENABLE:= FALSE;
	ELSE	
		P2_Vizu.TL_PolohujManipulator_ENABLE:= TRUE;
	END_IF
	
	
	//RR - Tla��tko vysunutia skrutkova�ky M6//
	IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P2_Vizu.Tl_VysunutieSkrutkovM6_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM6_BUSY THEN
		P2_Vizu.Tl_VysunutieSkrutkovM6_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM5_BUSY THEN
		P2_Vizu.Tl_VysunutieSkrutkovM6_ENABLE:= FALSE;	
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.Tl_VysunutieSkrutkovM6_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P2_Vizu.Tl_VysunutieSkrutkovM6_ENABLE:= FALSE;
	ELSE
		P2_Vizu.Tl_VysunutieSkrutkovM6_ENABLE:= TRUE;
	END_IF	
	
	
	
	//RR - Tla��tko vysunutia skrutkova�ky M5//
	IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P2_Vizu.Tl_VysunutieSkrutkovM5_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM6_BUSY THEN
		P2_Vizu.Tl_VysunutieSkrutkovM5_ENABLE:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM5_BUSY THEN
		P2_Vizu.Tl_VysunutieSkrutkovM5_ENABLE:= FALSE;	
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.Tl_VysunutieSkrutkovM5_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P2_Vizu.Tl_VysunutieSkrutkovM5_ENABLE:= FALSE;
	ELSE
		P2_Vizu.Tl_VysunutieSkrutkovM5_ENABLE:= TRUE;
	END_IF	
	
	
	//RR - Tla��tko vysunutia skrutkova�ky M4//
	IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
		P2_Vizu.TL_OvladaniaVysunSkrutkovM4:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM6_BUSY THEN
		P2_Vizu.TL_OvladaniaVysunSkrutkovM4:= FALSE;
	ELSIF P2_Srobovanie.STAV.CistenieSkrutkovackyM5_BUSY THEN
		P2_Vizu.TL_OvladaniaVysunSkrutkovM4:= FALSE;	
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_OvladaniaVysunSkrutkovM4:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P2_Vizu.TL_OvladaniaVysunSkrutkovM4:= FALSE;
	ELSE	
		P2_Vizu.TL_OvladaniaVysunSkrutkovM4:= TRUE;
	END_IF
	
	
	//RR - Ovl�danie skrutkovacieho setu M6//
	IF P2_Srobovanie.STAV.CistenieSkrutkovackyM6_BUSY THEN
		P2_Vizu.TL_OvladSkrutkovSetuM6_ENABLE:= FALSE;
	ELSE	
		P2_Vizu.TL_OvladSkrutkovSetuM6_ENABLE:= TRUE;
	END_IF	
	
	//RR - Ovl�danie skrutkovacieho setu M5//
	IF P2_Srobovanie.STAV.CistenieSkrutkovackyM5_BUSY THEN
		P2_Vizu.TL_OvladSkrutkovSetuM5_ENABLE:= FALSE;
	ELSE	
		P2_Vizu.TL_OvladSkrutkovSetuM5_ENABLE:= TRUE;
	END_IF	
	
	//RR - Ovl�danie manipulatora XY//
	IF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_OvladManipulatoraXY_ENABLE:= FALSE;
	ELSE	
		P2_Vizu.TL_OvladManipulatoraXY_ENABLE:= TRUE;
	END_IF	
	
	
	
	
	
	//RR - Ovl�danie presunu zv�rania//
	IF P2_Zvaranie.STAV.RR_SekvenciaZvarania_BUSY THEN
		P2_Vizu.TL_PresunZvarania_ENABLE:= FALSE;
	ELSIF P2_Zvaranie.ServoZdvihuZvarania.Status.ActPosition > 200 THEN
		P2_Vizu.TL_PresunZvarania_ENABLE:= FALSE;
	ELSE
		P2_Vizu.TL_PresunZvarania_ENABLE:= TRUE;
	END_IF	
	
	//RR - Spustenie sekvencie zv�rania//
	IF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_StartSekvencieZvarania_ENABLE:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P2_Vizu.TL_StartSekvencieZvarania_ENABLE:= FALSE;
	ELSE	
		P2_Vizu.TL_StartSekvencieZvarania_ENABLE:= TRUE;
	END_IF
	
	
	//RR - Ovl�danie zdvihu zv�rania//
	IF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		P2_Vizu.TL_ZdvihZvarania_ENABLE:= FALSE;
	ELSIF NOT P2_StoperZvarania.RFID_hlava.PritomnostPaletky THEN
		P2_Vizu.TL_ZdvihZvarania_ENABLE:= FALSE;
	ELSE
		P2_Vizu.TL_ZdvihZvarania_ENABLE:= TRUE;
	END_IF	
	
	
	
	
	//**************************Zamknutie edit�cie parametrov*********************************//
	IF P2_UrovenPrihlasenehoUzivatela >= 20 THEN
		P2_Vizu.EditaciaParametrov_ENABLE:= TRUE;
	ELSE     
		P2_Vizu.EditaciaParametrov_ENABLE:= FALSE;
	END_IF    
	
	
	//***********************************Prep�nanie stavov pracov�sk*******************************************************************//
	//Dopravn�ky//
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
	
	//Zaklada� tesnenia//
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
	
	//Stoper maticova�ky//
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
	
	
	//Akumula�n� stoper//
	IF P2_Pracovisko.STAV.Porucha_ST3 THEN
		P2_Vizu.IndexStavu_AkumulacnyStoper:= 3;
	ELSIF P2_AkumulacnyStoper.Automat AND NOT P2_AkumulacnyStoper.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_AkumulacnyStoper:= 1;
	ELSIF P2_AkumulacnyStoper.Automat AND P2_AkumulacnyStoper.STAV.PoINIT THEN
		P2_Vizu.IndexStavu_AkumulacnyStoper:= 2;
	ELSE
		P2_Vizu.IndexStavu_AkumulacnyStoper:= 0;
	END_IF	
	
		
	
	//Stoper �robovania//
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
	
	
	
	//�robovanie//
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
	
	
	//Stoper zv�rania//
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
	
	
	//Zv�ranie//
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
	
	//�istenie//
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
	
	//Spodn� stoper//
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

