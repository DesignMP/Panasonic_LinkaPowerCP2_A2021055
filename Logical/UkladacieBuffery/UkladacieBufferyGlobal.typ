
TYPE
	UkladaciBuffer_typ : 	STRUCT 
		Pole : ARRAY[0..100]OF REAL;
		Index : UINT;
		ZapisHodnotu : BOOL;
		ResetBufferu : BOOL;
		Hodnota : REAL;
	END_STRUCT;
END_TYPE
