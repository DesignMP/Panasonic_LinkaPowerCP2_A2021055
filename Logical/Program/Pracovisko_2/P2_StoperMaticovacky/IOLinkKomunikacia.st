
ACTION IOLinkKomunikacia: 

	
	//RFID snímaè paletky//
	P2_StoperMaticovacky.RFID_hlava();
	
		
	//Snímaè vysunutia maticovaèky M4//
	Round_0.VstupnaHodnota:= P2_StoperMaticovacky.PAR.Maticov_M4_AktualHodnVysunutia;
	P2_StoperMaticovacky.PAR.Maticov_M4_RoundHodnotaREAL:= Round_0.VystupnaHodnota;  
	Round_0();
	
	
	
END_ACTION
