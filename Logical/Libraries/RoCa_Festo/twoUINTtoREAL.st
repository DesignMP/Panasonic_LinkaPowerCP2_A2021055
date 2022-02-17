
(* Poskladanie REAL z dvoch UINT *)
FUNCTION_BLOCK twoUINTtoREAL
	IF order = 0 THEN
		NxtADR := brsmemcpy(ADR(Out),ADR(IN1),2);
		NxtADR := brsmemcpy(ADR(Out)+2,ADR(IN2),2);
	ELSE
		NxtADR := brsmemcpy(ADR(Out),ADR(IN2),2);
		NxtADR := brsmemcpy(ADR(Out)+2,ADR(IN1),2);
	END_IF
	
END_FUNCTION_BLOCK