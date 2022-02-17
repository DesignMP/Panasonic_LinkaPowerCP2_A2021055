
ACTION IOLinkKomunikacia: 

	//Snímaè vysunutia skrutkovaèky K30//
	Convert_0.IN_Byte0:= P1_Srobovanie.PAR.K30_Snimac_IOlink_Inputs[0];
	Convert_0.IN_Byte1:= P1_Srobovanie.PAR.K30_Snimac_IOlink_Inputs[1];
	P1_Srobovanie.PAR.Skrutkov_K30_AktualHodnVysunutia:= Convert_0.OUT_UINT;
	Convert_0();
	
	
	
	
	
	
	
	
END_ACTION
