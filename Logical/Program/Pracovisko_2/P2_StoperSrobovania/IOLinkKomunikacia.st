
ACTION IOLinkKomunikacia: 

	//RFID snímaè paletky//
	P2_StoperSrobovania.RFID_hlava();
	
	
	//Snímaè vysunutia skrutkovaèky M6//
	Round_0.VstupnaHodnota:= P2_Srobovanie.PAR.Skrutkov_M6_AktualHodnVysunutia;
	P2_Srobovanie.PAR.Skrutkov_M6_RoundHodnotaREAL:= Round_0.VystupnaHodnota;  
	Round_0();
	
	//Snímaè vysunutia skrutkovaèky M5//
	Round_1.VstupnaHodnota:= P2_Srobovanie.PAR.Skrutkov_M5_AktualHodnVysunutia;
	P2_Srobovanie.PAR.Skrutkov_M5_RoundHodnotaREAL:= Round_1.VystupnaHodnota;  
	Round_1();
	
	
	
END_ACTION
