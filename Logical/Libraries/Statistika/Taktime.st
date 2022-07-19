
(* Meranie taktime *)
FUNCTION_BLOCK Taktime
       
//*********************************************************************Meranie taktime**************************************************************************//
	
	
    //Vynulovanie èasovaèa//
	IF NOT IN.START_MeraniaCasu THEN
		IntVAR.Milisekundy:= 0;
		IntVAR.Sekundy:= 0;
		IntVAR.Minuty:= 0;
		IntVAR.Hodiny:= 0;
		IntVAR.CelkoveSekundy:= 0;
		IntVAR.CelkoveMinuty:= 0;
		IntVAR.CelkoveHodiny:= 0;
		IntVAR.NameraneSekundy_REAL:= 0;
	END_IF	
    
    
	//Zapnutie èasovaèa//
	IF IN.START_MeraniaCasu THEN
        
		IntVAR.Milisekundy:= IntVAR.Milisekundy + IN.TaskovaTrieda_ms;//Ak je v taskovej triede 2ms tak prirátaváme + 2//
        
		IF IntVAR.Milisekundy >= 1000 THEN
			IntVAR.Sekundy:= IntVAR.Sekundy + 1;
			IntVAR.NameraneSekundy_REAL:= IntVAR.NameraneSekundy_REAL + 1;
			IntVAR.Milisekundy:= 0;
		END_IF
        
		IF IntVAR.Sekundy >= 60 THEN
			IntVAR.Minuty:= IntVAR.Minuty + 1;
			IntVAR.Sekundy:= 0;
		END_IF	
        
		IF IntVAR.Minuty >= 60 THEN
			IntVAR.Hodiny:= IntVAR.Hodiny + 1;
			IntVAR.Minuty:= 0;
		END_IF
          
	END_IF	
	
    	
	//Ulozenie nameraného èasu a resetovanie èasovaèa//
	IF IN.ZAPIS_MeraniaCasu THEN
		IntVAR.NameraneMilisekundy_REAL:= UINT_TO_REAL(IntVAR.Milisekundy);
		//Zobrazenie celkového èasu v sekundách//
		OUT.NameranyCas_v_Sekundach:= IntVAR.NameraneSekundy_REAL + (IntVAR.NameraneMilisekundy_REAL / 1000);
		//Zobrazenie celkového èasu v minútach//
		OUT.NameranyCas_v_Minutach:= OUT.NameranyCas_v_Sekundach / 60;
		//Zobrazenie celkového èasu v hodinách//
		OUT.NameranyCas_v_Hodinach:= OUT.NameranyCas_v_Minutach / 60;
		//Zápis do historie meraní//
		OUT.HistoriaMerani_v_Sekundach[IntVAR.i]:= OUT.NameranyCas_v_Sekundach;
		OUT.HistoriaMerani_v_Minutach[IntVAR.i]:= OUT.NameranyCas_v_Minutach;
		IntVAR.i:= IntVAR.i + 1;
		IF IntVAR.i > 14 THEN
			IntVAR.i:= 0;
		END_IF   
		OUT.CelkovyPocetNameranychSekund:= OUT.CelkovyPocetNameranychSekund + OUT.NameranyCas_v_Sekundach;
		OUT.CelkovyPocetNameranychMinut:= OUT.CelkovyPocetNameranychMinut + OUT.NameranyCas_v_Minutach;
		OUT.CelkovyPocetNameranychHodin:= OUT.CelkovyPocetNameranychHodin + OUT.NameranyCas_v_Hodinach;
		IntVAR.Milisekundy:= 0;
		IntVAR.Sekundy:= 0;
		IntVAR.Minuty:= 0;
		IntVAR.Hodiny:= 0;	
		IntVAR.CelkoveSekundy:= 0;
		IntVAR.CelkoveMinuty:= 0;
		IntVAR.CelkoveHodiny:= 0;
		IntVAR.NameraneSekundy_REAL:= 0;
		IN.ZAPIS_MeraniaCasu:= FALSE;
	END_IF	
   
        
    
	//Vyrátanie priemernej hodnoty v sekundách//
	IntVAR.a:= 0;
	IntVAR.b:= 0;
	IntVAR.Priemer_SucetSekund_REAL:= 0;
	OUT.PriemernyCas_v_Sekundach:= 0;
	FOR IntVAR.a:= 0 TO 14 BY 1 DO
		IntVAR.Priemer_SucetSekund_REAL:= IntVAR.Priemer_SucetSekund_REAL + OUT.HistoriaMerani_v_Sekundach[IntVAR.a];
		IF OUT.HistoriaMerani_v_Sekundach[IntVAR.a] <> 0 THEN
			IntVAR.b:= IntVAR.b + 1;
		END_IF 
		IF IntVAR.b <> 0 THEN
			OUT.PriemernyCas_v_Sekundach:= IntVAR.Priemer_SucetSekund_REAL / IntVAR.b;
		ELSE
			OUT.PriemernyCas_v_Sekundach:= 0;
		END_IF    
	END_FOR
    
	//Vyrátanie priemernej hodnoty v minutách//
	IntVAR.c:= 0;
	IntVAR.d:= 0;
	IntVAR.Priemer_SucetMinut_REAL:= 0;
	OUT.PriemernyCas_v_Minutach:= 0;
	FOR IntVAR.c:= 0 TO 14 BY 1 DO
		IntVAR.Priemer_SucetMinut_REAL:= IntVAR.Priemer_SucetMinut_REAL + OUT.HistoriaMerani_v_Minutach[IntVAR.c];
		IF OUT.HistoriaMerani_v_Minutach[IntVAR.c] <> 0 THEN
			IntVAR.d:= IntVAR.d + 1;
		END_IF 
		IF IntVAR.d <> 0 THEN
			OUT.PriemernyCas_v_Minutach:= IntVAR.Priemer_SucetMinut_REAL / IntVAR.d;
		ELSE
			OUT.PriemernyCas_v_Minutach:= 0;
		END_IF    
	END_FOR
    
	//Reset celkových poèítadiel èasu//
	IF IN.RESET_CelkovehoCasu THEN
		OUT.CelkovyPocetNameranychSekund:= 0;
		OUT.CelkovyPocetNameranychMinut:= 0;
		OUT.CelkovyPocetNameranychHodin:= 0;
		IN.RESET_CelkovehoCasu:= FALSE;
	END_IF    
   
	//Reset historie merani//
	IF IN.RESET_HistorieMeraniCasu THEN
		brsmemset(ADR(OUT.HistoriaMerani_v_Sekundach),0,SIZEOF(OUT.HistoriaMerani_v_Sekundach));
		brsmemset(ADR(OUT.HistoriaMerani_v_Minutach),0,SIZEOF(OUT.HistoriaMerani_v_Minutach));
		IN.RESET_HistorieMeraniCasu:= FALSE;
	END_IF    
    

    
	//***************************************************************************Rátanie kusov****************************************************************************//
    
	//Rátanie kusov OK//
	IF IN.PriratajKus_OK THEN
		OUT.CelkovyPocetKusov:= OUT.CelkovyPocetKusov + 1;
		OUT.PocetKusov_OK:= OUT.PocetKusov_OK + 1;
		IN.PriratajKus_OK:= FALSE;
	END_IF
    
    
	//Rátanie kusov NG//
	IF IN.PriratajKus_NG THEN
		OUT.CelkovyPocetKusov:= OUT.CelkovyPocetKusov + 1;
		OUT.PocetKusov_NG:= OUT.PocetKusov_NG + 1;
		IN.PriratajKus_NG:= FALSE;
	END_IF
  
	
	
	
	//Reset poètu kusov //
	IF IN.RESET_PoctuKusov THEN
		OUT.PocetKusov_OK:= 0;
		OUT.PocetKusov_NG:= 0;
		IN.RESET_PoctuKusov:= FALSE;
	END_IF
       
    
    
	//Reset celkového poètu kusov//
	IF IN.RESET_CelkovehoPoctuKusov THEN
		OUT.CelkovyPocetKusov:= 0;
		IN.RESET_CelkovehoPoctuKusov:= FALSE;
	END_IF
    
  

	
  //*********************************************Meranie stratoveho èasu*****************************************//
    
	//Spustenie merania//
	IF IN.START_MeraniaStratovehoCasu THEN
        
		IntVAR.StratoveMilisekundy:= IntVAR.StratoveMilisekundy + IN.TaskovaTrieda_ms;//Ak je v taskovej triede 2ms tak prirátaváme + 2//
        
		IF IntVAR.StratoveMilisekundy >= 1000 THEN
			IntVAR.StratoveSekundy:= IntVAR.StratoveSekundy + 1;
			IntVAR.CelkoveStratoveSekundy_REAL:= IntVAR.CelkoveStratoveSekundy_REAL + 1;
			IntVAR.StratoveMilisekundy:= 0;
		END_IF
        
		IF IntVAR.StratoveSekundy >= 60 THEN
			IntVAR.StratoveMinuty:= IntVAR.StratoveMinuty + 1;
			IntVAR.StratoveSekundy:= 0;
		END_IF	
        
		IF IntVAR.StratoveMinuty >= 60 THEN
			IntVAR.StratoveHodiny:= IntVAR.StratoveHodiny + 1;
			IntVAR.StratoveMinuty:= 0;
		END_IF
          
	END_IF	
	
	
	
	
	//Zapísanie stratového èasu//
	IF IN.ZAPIS_StratovyCas THEN
		//Zobrazenie celkového èasu v sekundách//
		IntVAR.CelkoveStratoveMilisekundy_REAL:= UINT_TO_REAL(IntVAR.StratoveMilisekundy);
		OUT.StratoveSekundy:= IntVAR.CelkoveStratoveSekundy_REAL + (IntVAR.CelkoveStratoveMilisekundy_REAL / 1000);
		//Zobrazenie celkového èasu v minútach//
		OUT.StratoveMinuty:= OUT.StratoveSekundy / 60;
		//Zobrazenie celkového èasu v hodinách//
		OUT.StratoveHodiny:= OUT.StratoveMinuty / 60;
		IntVAR.StratoveMilisekundy:= 0;
		IntVAR.CelkoveStratoveSekundy_REAL:= 0;
		IN.ZAPIS_StratovyCas:= FALSE;
	END_IF	
	
	
	
	//Reset merania//
	
	IF IN.RESET_StratovehoCasu THEN
		IntVAR.StratoveMilisekundy:= 0;
		IntVAR.CelkoveStratoveSekundy_REAL:= 0;
		OUT.StratoveSekundy:= 0;
		IN.RESET_StratovehoCasu:= FALSE;
	END_IF	
	
	
	
END_FUNCTION_BLOCK
