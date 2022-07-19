
ACTION IOLinkKomunikacia: 

	//RFID snímaè paletky//
	P1_StoperSrobovania.RFID_hlava();
	
	
	//Snímaè vysunutia skrutkovaèky K30//
	Round_0.VstupnaHodnota:= P1_Srobovanie.PAR.Skrutkov_K30_AktualHodnVysunutia;
	P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL:= Round_0.VystupnaHodnota;  
	Round_0();
	
	
	
	
END_ACTION
