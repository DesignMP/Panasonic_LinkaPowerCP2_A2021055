
(* Linearne skalovanie verzia 1.0 *)
(* Powered by ROCA systems, s.r.o. *)
FUNCTION_BLOCK Linear_scaling
	//osetrenie delenia nulov
	IF Setting.InputUpperLimit-Setting.InputLowerLimit <> 0 THEN
		Internal.ScaleFactor:=(Setting.OutputUpperLimit-Setting.OutputLowerLimit)/(Setting.InputUpperLimit-Setting.InputLowerLimit);
	END_IF	
	//vypocet offsetu
	Internal.Offset:=Setting.OutputLowerLimit-Internal.ScaleFactor*Setting.InputLowerLimit;	
	//vypocet vystupu
	Output:=(Internal.ScaleFactor*Input)+Internal.Offset;
	
	//osetrenie hlasok
	IF Setting.InputUpperLimit-Setting.InputLowerLimit = 0 THEN Info:='Horny a dolny limit vstupu je rovnaky';
	ELSIF Setting.OutputUpperLimit-Setting.OutputLowerLimit = 0 THEN Info:='Horny a dolny limit vystupu je rovnaky';
	ELSIF Input<Setting.InputLowerLimit THEN Info:='Vstup je mensi ako zadany dolny limit vstupu';
	ELSIF Input>Setting.InputUpperLimit THEN Info:='Vstup je vacsi ako zadany horny limit vstupu';
	ELSE Info:='OK';
	END_IF
	
END_FUNCTION_BLOCK
