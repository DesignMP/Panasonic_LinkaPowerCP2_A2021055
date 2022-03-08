
(* RFID hlavy SICK *)
FUNCTION_BLOCK SickHeads
	
	//Mapovanie//
	Stav_CitaciaHlava_ON:= Mapping_IN[0].4;
	PritomnostPaletky:= Mapping_IN[0].5;
	Mapping_OUT[0].4:= CitaciuHlavu_VYPNI;
	Mapping_OUT[1].0:= TRUE;
	Mapping_OUT[3].0:= TRUE;
	
	
	AlarmTime.PT:= T#3s;
	AlarmTime();
	
	
	CASE Step OF
		
		0: //Nulovanie//
			Stav_CitanieZapis_OK:= FALSE;
			Stav_CitanieZapis_NG:= FALSE;
			Mapping_OUT[0].0:= 	FALSE;
			Mapping_OUT[0].1:= 	FALSE;
			Mapping_OUT[0].2:= 	FALSE;
			Mapping_OUT[0].7:= 	FALSE;
			PrecitaneCisloPaletky:= 0;
			AlarmTime.IN:= FALSE;
			IF NOT PrecitajChipRFID AND NOT ZapisNaChipRFID THEN
				Step:= 1;
			END_IF	
				
		1: //Èakam na kommand//		
			IF PrecitajChipRFID THEN
				Step:= 10;
			ELSIF ZapisNaChipRFID THEN
				Step:= 20;
			END_IF	
		
		10: //Èítanie// 
			Mapping_OUT[0].0:= 	TRUE;
			Mapping_OUT[0].1:= 	TRUE;
			Mapping_OUT[0].2:= 	FALSE;
			Mapping_OUT[0].7:= 	TRUE;
			AlarmTime.IN:= TRUE;
			
			IF Mapping_IN[0].0 AND Mapping_IN[0].1 AND NOT Mapping_IN[0].2 AND Mapping_IN[0].7 THEN
				PrecitaneCisloPaletky:= Mapping_IN[4];
				Stav_CitanieZapis_OK:= TRUE;
				Step:= 11;
			ELSIF AlarmTime.Q THEN
				Stav_CitanieZapis_NG:= TRUE;
				Step:= 11;
			END_IF	
			
		11: //Èakám na ukonèenie èítania//
			IF NOT PrecitajChipRFID THEN
				Step:= 0;
			END_IF	
		
		
		20: //Zápis//
			Mapping_OUT[0].0:= 	FALSE;
			Mapping_OUT[0].1:= 	FALSE;
			Mapping_OUT[0].2:= 	TRUE;
			Mapping_OUT[4]:= ZadaneCisloPaletky;
			Mapping_OUT[0].7:= 	TRUE;
			AlarmTime.IN:= TRUE;
		
			IF NOT Mapping_IN[0].0 AND NOT Mapping_IN[0].1 AND Mapping_IN[0].2 AND Mapping_IN[0].7 THEN
				Stav_CitanieZapis_OK:= TRUE;
				Step:= 21;
			ELSIF AlarmTime.Q THEN 
				Stav_CitanieZapis_NG:= TRUE;
				Step:= 21;
			END_IF	
		
		21: //Èakám na ukonèenie zápisu//
			IF NOT ZapisNaChipRFID THEN
				Step:= 0;
			END_IF	
		
		
		
		
		
	END_CASE		
	
	
	
	
	
END_FUNCTION_BLOCK
