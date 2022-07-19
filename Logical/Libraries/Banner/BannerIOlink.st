
(* Banner na IO linku *)
FUNCTION_BLOCK BannerIOlink
	
		
	//*****************Banner stlaèený********************//
	OUT.Stlaceny:= Mapping_IN[1].0;
	
	
	
	
	//*******************Banner zmena farieb******************//
	IF IN.CervenaLED_ON THEN
		Mapping_OUT[2]:= 161;
		Mapping_OUT[3]:= 161;
		Mapping_OUT[4]:= 161;
		Mapping_OUT[5]:= 161;
		Mapping_OUT[6]:= 161;
		Mapping_OUT[7]:= 161;
		Mapping_OUT[8]:= 161;
		Mapping_OUT[9]:= 161;
	ELSIF IN.ZelenaLED_ON THEN
		Mapping_OUT[2]:= 160;
		Mapping_OUT[3]:= 160;
		Mapping_OUT[4]:= 160;
		Mapping_OUT[5]:= 160;
		Mapping_OUT[6]:= 160;
		Mapping_OUT[7]:= 160;
		Mapping_OUT[8]:= 160;
		Mapping_OUT[9]:= 160;
	ELSIF IN.ModraLED_ON THEN
		Mapping_OUT[2]:= 169;
		Mapping_OUT[3]:= 169;
		Mapping_OUT[4]:= 169;
		Mapping_OUT[5]:= 169;
		Mapping_OUT[6]:= 169;
		Mapping_OUT[7]:= 169;
		Mapping_OUT[8]:= 169;
		Mapping_OUT[9]:= 169;
	ELSIF IN.OranzovaLED_ON THEN
		Mapping_OUT[2]:= 162;
		Mapping_OUT[3]:= 162;
		Mapping_OUT[4]:= 162;
		Mapping_OUT[5]:= 162;
		Mapping_OUT[6]:= 162;
		Mapping_OUT[7]:= 162;
		Mapping_OUT[8]:= 162;
		Mapping_OUT[9]:= 162;
	ELSIF IN.ZltaLED_ON THEN
		Mapping_OUT[2]:= 164;
		Mapping_OUT[3]:= 164;
		Mapping_OUT[4]:= 164;
		Mapping_OUT[5]:= 164;
		Mapping_OUT[6]:= 164;
		Mapping_OUT[7]:= 164;
		Mapping_OUT[8]:= 164;
		Mapping_OUT[9]:= 164;
	ELSIF IN.CyanLED_ON THEN
		Mapping_OUT[2]:= 167;
		Mapping_OUT[3]:= 167;
		Mapping_OUT[4]:= 167;
		Mapping_OUT[5]:= 167;
		Mapping_OUT[6]:= 167;
		Mapping_OUT[7]:= 167;
		Mapping_OUT[8]:= 167;
		Mapping_OUT[9]:= 167;
	ELSIF IN.ModraRotujucaLED_ON THEN
		IF EDGEPOS(IN.Blikac100ms)THEN
			IF Mapping_OUT[5] = 160 THEN
				Mapping_OUT[2]:= 160;
				Mapping_OUT[6]:= 160;
				Mapping_OUT[3]:= 160;
				Mapping_OUT[7]:= 160;
				Mapping_OUT[4]:= 169;
				Mapping_OUT[8]:= 169;
				Mapping_OUT[5]:= 169;
				Mapping_OUT[9]:= 169;
			ELSIF Mapping_OUT[2] = 160 THEN
				Mapping_OUT[2]:= 169;
				Mapping_OUT[6]:= 169;
				Mapping_OUT[3]:= 160;
				Mapping_OUT[7]:= 160;
				Mapping_OUT[4]:= 160;
				Mapping_OUT[8]:= 160;
				Mapping_OUT[5]:= 169;
				Mapping_OUT[9]:= 169;
			ELSIF Mapping_OUT[8] = 160 THEN
				Mapping_OUT[2]:= 169;
				Mapping_OUT[6]:= 169;
				Mapping_OUT[3]:= 169;
				Mapping_OUT[7]:= 169;
				Mapping_OUT[4]:= 160;
				Mapping_OUT[8]:= 160;
				Mapping_OUT[5]:= 160;
				Mapping_OUT[9]:= 160;	
			ELSIF Mapping_OUT[9] = 160 THEN
				Mapping_OUT[2]:= 160;
				Mapping_OUT[6]:= 160;
				Mapping_OUT[3]:= 169;
				Mapping_OUT[7]:= 169;
				Mapping_OUT[4]:= 169;
				Mapping_OUT[8]:= 169;
				Mapping_OUT[5]:= 160;
				Mapping_OUT[9]:= 160;
			ELSE
				Mapping_OUT[5]:= 160;
			END_IF	
		END_IF		
	ELSE
		Mapping_OUT[2]:= 0;
		Mapping_OUT[3]:= 0;
		Mapping_OUT[4]:= 0;
		Mapping_OUT[5]:= 0;
		Mapping_OUT[6]:= 0;
		Mapping_OUT[7]:= 0;
		Mapping_OUT[8]:= 0;
		Mapping_OUT[9]:= 0;
	END_IF	
	
	
	
	
	
END_FUNCTION_BLOCK
