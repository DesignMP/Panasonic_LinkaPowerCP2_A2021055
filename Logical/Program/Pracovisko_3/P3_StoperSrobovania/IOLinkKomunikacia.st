
ACTION IOLinkKomunikacia: 

	//RFID sn�ma� paletky//
	P3_StoperSrobovania.RFID_hlava();
	
	
	//Sn�ma� vysunutia skrutkova�ky K40//
	Round_0.VstupnaHodnota:= P3_Srobovanie.PAR.Skrutkov_K40_AktualHodnVysunutia;
	P3_Srobovanie.PAR.Skrutkov_K40_RoundHodnotaREAL:= Round_0.VystupnaHodnota;  
	Round_0();
	
	
	
	
	
END_ACTION
