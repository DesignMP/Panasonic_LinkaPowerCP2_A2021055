
(* adresne rozobratie REAL do dvoch UINT (nie matematicky) *)
FUNCTION_BLOCK REALtoTwoUINT
	IF order=0 THEN
		NxtADR := brsmemcpy(ADR(OUT1),ADR(IN),2);
		NxtADR := brsmemcpy(ADR(OUT2),ADR(IN)+2,2);
	ELSE
		NxtADR := brsmemcpy(ADR(OUT1),ADR(IN)+2,2);
		NxtADR := brsmemcpy(ADR(OUT2),ADR(IN),2);
	END_IF
	
END_FUNCTION_BLOCK