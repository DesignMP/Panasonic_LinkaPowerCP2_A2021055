
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_DevlinkFTP);
	
	
	
	CASE SC_DevlinkFTP.Step OF
		
		0: 
			SC_DevlinkFTP.StepName:= '0 - Nulovanie';
			SC_DevlinkFTP.IdleTime.PT:= T#3s;
			SC_DevlinkFTP.AlarmTime.PT:= T#3s;
            
			DevLink_0.enable:= FALSE;
			DevUnlink_0.enable:= FALSE;
			Stav_PripojenieFTP_OK:= FALSE;
			OdpojServerFTP:= FALSE;	
			
			SC_DevlinkFTP.ResetStep:= TRUE;
			SC_DevlinkFTP.Step:= 1;
			
			
		1:
			SC_DevlinkFTP.StepName:= '1 - Pripojenie na FTP server Panasonic';
			SC_DevlinkFTP.IdleTime.PT:= T#3s;
			SC_DevlinkFTP.AlarmTime.PT:= T#3s;
			
			       
			DevLink_0.enable:= TRUE;
			DevLink_0.pDevice:= ADR('Panasonic');
			DevLink_0.pParam:= ADR('/SIP=192.168.100.164 /PROTOCOL=ftp /USER=designMP /PASSWORD=Ftp4PAN2020');  
			(*DevLink_0.pParam:= ADR('/SIP=10.128.149.2 /PROTOCOL=ftp /USER=designMP /PASSWORD=Ftp4PAN2020');*)
			DevLink_0();
		
			IF DevLink_0.status = 0 THEN
				ID_Adresara:= DevLink_0.handle;
				Stav_PripojenieFTP_OK:= TRUE;
				SC_DevlinkFTP.ResetStep:= TRUE;
				SC_DevlinkFTP.Step:= 10;
			ELSIF DevLink_0.status = 20730 THEN	
				ID_Adresara:= DevLink_0.handle;
				Stav_PripojenieFTP_OK:= TRUE;
				SC_DevlinkFTP.ResetStep:= TRUE;
				SC_DevlinkFTP.Step:= 10;
			ELSIF DevLink_0.status = 65535 THEN		
				//BUSY//
			END_IF	
		
			
		10:
			SC_DevlinkFTP.StepName:= '10 - Cakam na odpojenie od FTP servera Panasonic';
			SC_DevlinkFTP.IdleTime.PT:= T#3s;
			SC_DevlinkFTP.AlarmTime.PT:= T#3s;
			
			IF OdpojServerFTP THEN
				SC_DevlinkFTP.ResetStep:= TRUE;
				SC_DevlinkFTP.Step:= 15;
			END_IF	
			
			
			
			
			
		15: SC_DevlinkFTP.StepName:= '15 - Odpojenie od FTP servera Panasonic';
			SC_DevlinkFTP.IdleTime.PT:= T#3s;
			SC_DevlinkFTP.AlarmTime.PT:= T#3s;	
			
			DevUnlink_0.enable:= TRUE;
			DevUnlink_0.handle:= ID_Adresara;
			DevUnlink_0();
			
			IF DevUnlink_0.status = 0 THEN
				SC_DevlinkFTP.ResetStep:= TRUE;
				SC_DevlinkFTP.Step:= 0;
			ELSIF DevUnlink_0.status = 20798 THEN
				SC_DevlinkFTP.ResetStep:= TRUE;
				SC_DevlinkFTP.Step:= 0;	
			ELSIF DevUnlink_0.status = 20731 THEN
				SC_DevlinkFTP.ResetStep:= TRUE;
				SC_DevlinkFTP.Step:= 0;
			ELSIF DevUnlink_0.status = 65535 THEN		
				//BUSY//
			END_IF	
		
	
	
	END_CASE
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

