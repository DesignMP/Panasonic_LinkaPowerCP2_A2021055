
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

	
	//********************************************Vstupy zo Safety do PLC****************************************************//
	Safety.STAV.P2_Bunka_VstupBariera_AKTIVNA:= Safety.Mapping_BYTE_IN[0].0;
	Safety.Mapping_BYTE_IN[0].1;
	Safety.STAV.P2_Bunka_Zamky_AKTIVNE:= Safety.Mapping_BYTE_IN[0].2;
	Safety.Mapping_BYTE_IN[0].3;
	Safety.STAV.P2_DvojrucOvl_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[0].4;
	Safety.Mapping_BYTE_IN[0].5;
	(*Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE:= Safety.Mapping_BYTE_IN[0].6;*)
	Safety.Mapping_BYTE_IN[0].7;
	
	Safety.STAV.P1_Robot_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[1].0;
	Safety.Mapping_BYTE_IN[1].1;
	Safety.STAV.P1_Panel_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[1].2;
	Safety.Mapping_BYTE_IN[1].3;
	Safety.STAV.P1_VyblokovanieZamkov_AKTIVNE:= Safety.Mapping_BYTE_IN[1].4;
	Safety.Mapping_BYTE_IN[1].5;
	Safety.STAV.P1_Rozvadzac_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[1].6;
	Safety.Mapping_BYTE_IN[1].7;
	
	Safety.STAV.P1_Vytah_Muting_AKTIVNY:= Safety.Mapping_BYTE_IN[2].0;
	Safety.Mapping_BYTE_IN[2].1;
	Safety.STAV.P1_Bunka_Zamky_AKTIVNE:= Safety.Mapping_BYTE_IN[2].2;
	Safety.Mapping_BYTE_IN[2].3;
	Safety.STAV.P1_DeadMan_AKTIVNY:= Safety.Mapping_BYTE_IN[2].4;
	Safety.Mapping_BYTE_IN[2].5;
	Safety.STAV.P1_Vytah_Bariera_AKTIVNA:= Safety.Mapping_BYTE_IN[2].6;
	Safety.Mapping_BYTE_IN[2].7;
	
	Safety.STAV.P2_Robot_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[3].0;
	Safety.Mapping_BYTE_IN[3].1;
	Safety.STAV.P2_Panel_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[3].2;
	Safety.Mapping_BYTE_IN[3].3;
	Safety.STAV.P2_VyblokovanieZamkov_AKTIVNE:= Safety.Mapping_BYTE_IN[3].4;
	Safety.Mapping_BYTE_IN[3].5;
	Safety.STAV.P2_Rozvadzac_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[3].6;
	Safety.Mapping_BYTE_IN[3].7;
	
	Safety.STAV.P2_ZaklTesn_PojazdMuting_AKTIVNY:= Safety.Mapping_BYTE_IN[4].0;
	Safety.Mapping_BYTE_IN[4].1;
	Safety.STAV.P2_DeadMan_AKTIVNY:= Safety.Mapping_BYTE_IN[4].2;
	Safety.Mapping_BYTE_IN[4].3;
	Safety.STAV.P2_ZaklTesn_Bumper_AKTIVNY:= Safety.Mapping_BYTE_IN[4].4;
	Safety.Mapping_BYTE_IN[4].5;
	Safety.STAV.P2_ZaklTesn_Bariera_AKTIVNA:= Safety.Mapping_BYTE_IN[4].6;
	Safety.Mapping_BYTE_IN[4].7;
	
	
	Safety.Mapping_BYTE_IN[5].0;
	Safety.Mapping_BYTE_IN[5].1;
	Safety.STAV.P3_DeadMan_AKTIVNY:= Safety.Mapping_BYTE_IN[5].2;
	Safety.Mapping_BYTE_IN[5].3;
	Safety.STAV.P3_VyblokovanieZamkov_AKTIVNE:= Safety.Mapping_BYTE_IN[5].4;
	Safety.Mapping_BYTE_IN[5].5;
	Safety.STAV.P3_Rozvadzac_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[5].6;
	Safety.Mapping_BYTE_IN[5].7;
	
	Safety.STAV.P3_Bunka_Zamky_AKTIVNE:= Safety.Mapping_BYTE_IN[6].0;
	Safety.Mapping_BYTE_IN[6].1;
	Safety.STAV.P3_Bunka_VstupBariera_AKTIVNA:= Safety.Mapping_BYTE_IN[6].2;
	Safety.Mapping_BYTE_IN[6].3;
	Safety.STAV.P4_Bunka_VstupBariera_AKTIVNA:= Safety.Mapping_BYTE_IN[6].4;
	Safety.Mapping_BYTE_IN[6].5;
	Safety.Mapping_BYTE_IN[6].6;
	Safety.Mapping_BYTE_IN[6].7;
	
	Safety.STAV.P4_Panel_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[7].0;
	Safety.Mapping_BYTE_IN[7].1;
	Safety.STAV.P4_DeadMan_AKTIVNY:= Safety.Mapping_BYTE_IN[7].2;
	Safety.Mapping_BYTE_IN[7].3;
	Safety.STAV.P4_VyblokovanieZamkov_AKTIVNE:= Safety.Mapping_BYTE_IN[7].4;
	Safety.Mapping_BYTE_IN[7].5;
	Safety.STAV.P4_Rozvadzac_TlacitkoCS_ODBLOK:= Safety.Mapping_BYTE_IN[7].6;
	Safety.Mapping_BYTE_IN[7].7;
	
	Safety.STAV.P4_Bunka_Zamky_AKTIVNE:= Safety.Mapping_BYTE_IN[8].0;
	Safety.Mapping_BYTE_IN[8].1;
	Safety.STAV.P4_Vytah_Bariera_AKTIVNA:= Safety.Mapping_BYTE_IN[8].2;
	Safety.Mapping_BYTE_IN[8].3;
	Safety.STAV.P4_VystupBunky_VstupBar_AKTIVNA:= Safety.Mapping_BYTE_IN[8].4;
	Safety.Mapping_BYTE_IN[8].5;
	Safety.STAV.P4_VystupBunky_VystupBar_AKTIVNA:= Safety.Mapping_BYTE_IN[8].6;
	Safety.Mapping_BYTE_IN[8].7;
	
	Safety.STAV.P1_VstupBunky_VstupBar_AKTIVNA:= Safety.Mapping_BYTE_IN[9].0;
	Safety.Mapping_BYTE_IN[9].1;
	Safety.STAV.P1_VystupBunky_VstupBar_AKTIVNA:= Safety.Mapping_BYTE_IN[9].2;
	Safety.Mapping_BYTE_IN[9].3;
	Safety.STAV.P1_VstupBunky_VystupBar_AKTIVNA:= Safety.Mapping_BYTE_IN[9].4;
	Safety.Mapping_BYTE_IN[9].5;
	Safety.STAV.P1_VystupBunky_VystupBar_AKTIVNA:= Safety.Mapping_BYTE_IN[9].6;
	Safety.Mapping_BYTE_IN[9].7;
	
	Safety.STAV.P4_Vytah_Muting_AKTIVNY:= Safety.Mapping_BYTE_IN[13].0;
	Safety.Mapping_BYTE_IN[13].1;
	Safety.Mapping_BYTE_IN[13].2;
	Safety.Mapping_BYTE_IN[13].3;
	Safety.Mapping_BYTE_IN[13].4;
	Safety.Mapping_BYTE_IN[13].5;
	Safety.Mapping_BYTE_IN[13].6;
	Safety.Mapping_BYTE_IN[13].7;
	
	
	Safety.STAV.Linka_ZonaCS_AKTIVNA:= Safety.Mapping_BYTE_IN[16].0;
	Safety.STAV.P1_ZonaBunky_AKTIVNA:= Safety.Mapping_BYTE_IN[16].1;
	Safety.STAV.P1_ZonaVytahu_AKTIVNA:= Safety.Mapping_BYTE_IN[16].2;
	Safety.STAV.P2_ZonaBunky_AKTIVNA:= Safety.Mapping_BYTE_IN[16].3;
	Safety.STAV.P3_ZonaBunky_AKTIVNA:= Safety.Mapping_BYTE_IN[16].4;
	Safety.STAV.P3_ZonaHVtest_AKTIVNA:= Safety.Mapping_BYTE_IN[16].5;
	Safety.STAV.P4_ZonaBunky_AKTIVNA:= Safety.Mapping_BYTE_IN[16].6;
	Safety.STAV.P4_ZonaVytahu_AKTIVNA:= Safety.Mapping_BYTE_IN[16].7;
	
	IF Safety.STAV.P2_ZaklTesn_Bariera_AKTIVNA AND Safety.STAV.P2_ZaklTesn_PojazdMuting_AKTIVNY THEN
		Safety.STAV.P2_ZonaZakladacaZdvih_AKTIVNA:= TRUE;
	ELSE	
		Safety.STAV.P2_ZonaZakladacaZdvih_AKTIVNA:= FALSE;
	END_IF	
		
	
	IF Safety.Mapping_BYTE_IN[17].2 AND Safety.Mapping_BYTE_IN[17].3 THEN
		Safety.STAV.P2_ZonaMaticovacky_AKTIVNA:= TRUE;
	ELSE	
		Safety.STAV.P2_ZonaMaticovacky_AKTIVNA:= FALSE;
	END_IF
	
	IF Safety.STAV.P2_ZaklTesn_Bumper_AKTIVNY THEN
		Safety.STAV.P2_ZonaZakladacaPojazd_AKTIVNA:= TRUE;
	ELSE	
		Safety.STAV.P2_ZonaZakladacaPojazd_AKTIVNA:= FALSE;
	END_IF	
	
	//***************************************************Výstupy pre Safety z PLC***********************************************************//
	Safety.Mapping_BYTE_OUT[0];
	
	
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

