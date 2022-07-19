
PROGRAM _INIT
	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	P1_Vytah_Taktime.IN.TaskovaTrieda_ms:= 4;
	P1_Skrutkovanie_Taktime.IN.TaskovaTrieda_ms:= 4;
	P2_ZakladanieTesnenia_Taktime.IN.TaskovaTrieda_ms:= 4;
	P2_Maticovacka_Taktime.IN.TaskovaTrieda_ms:= 4;
	P2_Skrutkovanie_Taktime.IN.TaskovaTrieda_ms:= 4;
	P2_Zvaranie_Taktime.IN.TaskovaTrieda_ms:= 4;
	P3_Skrutkovanie_Taktime.IN.TaskovaTrieda_ms:= 4;
	P3_HVtest_Taktime.IN.TaskovaTrieda_ms:= 4;
	P3_LeakageTestA_Taktime.IN.TaskovaTrieda_ms:= 4;
	P3_LeakageTestB_Taktime.IN.TaskovaTrieda_ms:= 4;
	P4_FinalTestA_Taktime.IN.TaskovaTrieda_ms:= 4;
	P4_FinalTestB_Taktime.IN.TaskovaTrieda_ms:= 4;
	P4_Etiketovanie_Taktime.IN.TaskovaTrieda_ms:= 4;
	P4_Vytah_Taktime.IN.TaskovaTrieda_ms:= 4;
	
		
	P1_Vytah_Taktime();
	P1_Skrutkovanie_Taktime();
	P2_ZakladanieTesnenia_Taktime();
	P2_Maticovacka_Taktime();
	P2_Skrutkovanie_Taktime();
	P2_Zvaranie_Taktime();
	P3_Skrutkovanie_Taktime();
	P3_HVtest_Taktime();
	P3_LeakageTestA_Taktime();
	P3_LeakageTestB_Taktime();
	P4_FinalTestA_Taktime();
	P4_FinalTestB_Taktime();
	P4_Etiketovanie_Taktime();
	P4_Vytah_Taktime();
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

