
ACTION COM_Tlaciaren: 

	//��slo chyby pri tla�i etikety//
	//1 - Porucha otvorenia komunuk�cie//
	//2 - Porucha spojenia s tla�iarnou//
	//3 - Porucha odoslania dat do tla�iarne//
	//4 - Porucha zatvorenia komunik�cie//
	//5 - Porucha prijatia d�t z tla�iarne//
	
	
	
			
	CASE Client.sStep OF
 	
		0://�akanie na spustenie komunik�cie z tla�iar�ou//
			Tlaciaren.STAV.VytlacenieEtikety_OK:= FALSE;
			Tlaciaren.STAV.VytlacenieEtikety_ERROR:= FALSE;
			Tlaciaren.STAV.ERROR_Number:= 0;
			Tlaciaren.STAV.PrislaSprava_s_Tlaciarne:= FALSE;
			IF Tlaciaren.CMD.VytlacEtiketu THEN
				(*strcpy(ADR(Tlaciaren.Data.Sprava_pre_Tlaciaren),ADR(''));*)
				strcpy(ADR(Tlaciaren.Data.Odpoved_s_Tlaciarne),ADR('')); //Vynulovanie premennej typu string
				Client.sStep := 1;
			END_IF
		
		
		
		1: //Otvorenie ethernetovej komunik�cie//
			Client.TcpOpen_0.enable := 1;	
			Client.TcpOpen_0.pIfAddr := 0;  (* Which Interface to open *)
			Client.TcpOpen_0.port := 9100;  (* Port komunik�cie s tla�iar�ou *)
			Client.TcpOpen_0.options := 0;	
			Client.TcpOpen_0;  (* Call the Function *)
			
						
			IF Client.TcpOpen_0.status = 0 THEN  (* TCP port je otvoren� *)
				Client.TcpOpen_timeout := 0;
				Client.sStep := 5;											
			ELSIF Client.TcpOpen_0.status = ERR_FUB_BUSY THEN  (* TCP port sa otv�ra *)				
				Client.TcpOpen_timeout := Client.TcpOpen_timeout + 1;
				IF Client.TcpOpen_timeout > 50 THEN
					Tlaciaren.STAV.ERROR_Number:= 1;
					Tlaciaren.STAV.VytlacenieEtikety_ERROR:= TRUE;
					Client.TcpOpen_timeout := 0;
					Client.sStep := 40;
				END_IF
				(* Busy *)
			ELSE  (* Goto Error Step *)
				Client.TcpOpen_timeout := 0;
				Tlaciaren.STAV.ERROR_Number:= 1;
				Tlaciaren.STAV.VytlacenieEtikety_ERROR:= TRUE;
				Client.sStep := 100;
			END_IF
		
		5: 		 
			Client.linger_opt.lLinger := 0; (* linger Time = 0 *)
			Client.linger_opt.lOnOff := 1; (* linger Option ON *)
			Client.TcpIoctl_0.enable := 1;
			Client.TcpIoctl_0.ident := Client.TcpOpen_0.ident; (* Connection Ident from AsTP.TCP_Open *)
			Client.TcpIoctl_0.ioctl := tcpSO_LINGER_SET; (* Set Linger Options *)
			Client.TcpIoctl_0.pData := ADR(Client.linger_opt);
			Client.TcpIoctl_0.datalen := SIZEOF(Client.linger_opt);
			Client.TcpIoctl_0;	    
		
			IF Client.TcpIoctl_0.status = 0 THEN  (* TcpIoctl successfull *)
				Client.sStep := 10;											
			ELSIF Client.TcpIoctl_0.status = ERR_FUB_BUSY THEN  (* TcpIoctl not finished -> redo *)				
				(* Busy *)
			ELSE  (* Goto Error Step *)
				Tlaciaren.STAV.VytlacenieEtikety_ERROR:= TRUE;
				Client.sStep := 100;
			END_IF
		
		
		10: //Spojenie s tla�iar�ou//					
			Client.TcpClient_0.enable := 1;
			Client.TcpClient_0.ident := Client.TcpOpen_0.ident;  (* Connection Ident from AsTCP.TCP_Open *)
			Client.TcpClient_0.portserv := 9100;  (* Port komunik�cie s tla�iar�ou *)
			Client.TcpClient_0.pServer := ADR('192.168.122.41');  (* Adresa tla�iarne *)
			Client.TcpClient_0;  (* Call the Function*)
			
			
			IF Client.TcpClient_0.status = 0 THEN  (* Open ok -> Send Data *)
				Client.TcpClient_timeout := 0;
				Client.sStep := 20;	
			ELSIF Client.TcpClient_0.status = ERR_FUB_BUSY THEN  (* TcpClient not finished -> redo *)	
				Client.TcpClient_timeout := Client.TcpClient_timeout + 1;
				IF Client.TcpClient_timeout > 50 THEN
					Tlaciaren.STAV.ERROR_Number:= 2;
					Tlaciaren.STAV.VytlacenieEtikety_ERROR:= TRUE;
					Client.TcpClient_timeout := 0;
					Client.sStep := 40;
				END_IF
				
				(* Busy *)
			ELSIF Client.TcpClient_0.status = tcpERR_INVALID THEN  (* Port error -> Close actual connection, and reopen a new one *)
				Client.TcpClient_timeout := 0;
				Client.sStep := 40;
			ELSE  (* Goto Error Step *)
				Client.TcpClient_timeout := 0;
				Tlaciaren.STAV.ERROR_Number:= 2;
				Tlaciaren.STAV.VytlacenieEtikety_ERROR:= TRUE;
				Client.sStep := 100;
			END_IF
		
		
		20: //Poslanie d�t do tla�iarne//
			Client.TcpSend_0.enable := 1;				
			Client.TcpSend_0.ident := Client.TcpOpen_0.ident;  (* Connection Ident from AsTCP.TCP_Open *)
			Client.TcpSend_0.pData := ADR(Tlaciaren.Data.Sprava_pre_Tlaciaren);  (* D�ta poslan� do tla�iarne *)
			Client.TcpSend_0.datalen := SIZEOF(Tlaciaren.Data.Sprava_pre_Tlaciaren);  (* Lenght of data to send *)											
			Client.TcpSend_0.flags := 0;
			Client.TcpSend_0;  (* Call the Function*)
			
			
			IF Client.TcpSend_0.status = 0 THEN  (* Data was sent sucessfully -> receive data *)
				Client.sStep := 40;
			ELSIF Client.TcpSend_0.status = ERR_FUB_BUSY THEN  (* TcpSend not finished -> redo *)	
				(* Busy *)
			ELSIF (Client.TcpSend_0.status = tcpERR_SENTLEN) OR (Client.TcpSend_0.status = tcpERR_NOT_CONNECTED) THEN (* Connection Lost *)
				Client.sStep := 40;
			ELSE  (* Goto Error Step *)
				Tlaciaren.STAV.ERROR_Number:= 3;
				Tlaciaren.STAV.VytlacenieEtikety_ERROR:= TRUE;
				Client.sStep := 100;
			END_IF				
		
			
		30: //Prijatie odpovede s tla�iarne//
			Client.TcpRecv_0.enable := 1;
			Client.TcpRecv_0.ident := Client.TcpOpen_0.ident;  (* Connection Ident from AsTCP.TCP_Open *)
			Client.TcpRecv_0.pData	:= ADR(Tlaciaren.Data.Odpoved_s_Tlaciarne);  (* D�ta poslan� z tla�iarne *)
			Client.TcpRecv_0.datamax := SIZEOF(Tlaciaren.Data.Odpoved_s_Tlaciarne);  (* Lenght of data buffer *)
			Client.TcpRecv_0.flags := 0;
			Client.TcpRecv_0;  (* Call the Function*)
		
			IF Client.TcpRecv_0.status = 0 THEN  (* Data was received sucessfully -> Send next packet *)
				Tlaciaren.STAV.PrislaSprava_s_Tlaciarne:= TRUE;
				Client.recv_timeout := 0;
				Client.sStep := 40;
			ELSIF Client.TcpRecv_0.status = tcpERR_NO_DATA THEN  (* No data received - wait *)
				Client.recv_timeout := Client.recv_timeout + 1;
				IF Client.recv_timeout > 50 THEN
					Client.recv_timeout := 0;
					Client.sStep := 40;
				END_IF
				(* No Data received *)
			ELSIF Client.TcpRecv_0.status = ERR_FUB_BUSY THEN  (* TcpRecv not finished -> redo *)		
				(* Busy *)
			ELSIF Client.TcpRecv_0.status = tcpERR_NOT_CONNECTED THEN (* Connection Lost *)			
				Client.recv_timeout := 0;
				Client.sStep := 40;
			ELSE  (* Goto Error Step *)
				Tlaciaren.STAV.ERROR_Number:= 5;
				Tlaciaren.STAV.VytlacenieEtikety_ERROR:= TRUE;
				Client.recv_timeout := 0;
				Client.sStep := 100;
			END_IF	
			
			
		40: //Zatvorenie ethernetovej komunik�cie//
			Client.TcpClose_0.enable := 1;
			Client.TcpClose_0.ident := Client.TcpOpen_0.ident;  (* Connection Ident from AsTCP.TCP_Open *)
			Client.TcpClose_0.how := 0;
			Client.TcpClose_0;  (* Call the Function*)
	
			IF Client.TcpClose_0.status = 0 THEN  (* Close sucessfull -> Reopen the interface *)
				IF NOT Tlaciaren.STAV.VytlacenieEtikety_ERROR THEN
					Tlaciaren.STAV.VytlacenieEtikety_OK:= TRUE;
				END_IF	
				Client.sStep := 100;
			ELSIF Client.TcpClose_0.status = ERR_FUB_BUSY THEN  (* TcpClose not finished -> redo *)	
				(* Busy *)
			ELSE  (* Goto Error Step *)
				Tlaciaren.STAV.ERROR_Number:= 4;
				Tlaciaren.STAV.VytlacenieEtikety_ERROR:= TRUE;
				Client.sStep := 100;
			END_IF
		
		100: //Ukon�enie komunik�cie s tla�iar�ou//
			IF NOT Tlaciaren.CMD.VytlacEtiketu THEN
				Client.sStep := 0;
			END_IF
		
	END_CASE	
	
	
	
END_ACTION