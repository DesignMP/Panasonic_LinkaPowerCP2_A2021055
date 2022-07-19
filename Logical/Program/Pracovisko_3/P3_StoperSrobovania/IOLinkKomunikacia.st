
ACTION IOLinkKomunikacia: 

	//RFID snímaè paletky//
	P3_StoperSrobovania.RFID_hlava();
	
	
	//Snímaè vysunutia skrutkovaèky K40//
	Round_0.VstupnaHodnota:= P3_Srobovanie.PAR.Skrutkov_K40_AktualHodnVysunutia;
	P3_Srobovanie.PAR.Skrutkov_K40_RoundHodnotaREAL:= Round_0.VystupnaHodnota;  
	Round_0();
	
	
	
	
	
END_ACTION
