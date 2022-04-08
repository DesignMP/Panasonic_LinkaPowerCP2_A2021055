(**************Ovládanie tlaèiarne**********************)

TYPE
	Client_typ : 	STRUCT  (*TCP Client Variables*)
		sStep : UINT; (*TCP Client Step Variable*)
		TcpOpen_0 : TcpOpen; (*AsTCP.TcpOpen FUB*)
		TcpClient_0 : TcpClient; (*AsTCP.TcpClient FUB*)
		TcpRecv_0 : TcpRecv; (*AsTCP.TcpRecv FUB*)
		TcpSend_0 : TcpSend; (*AsTCP.TcpSend FUB*)
		TcpIoctl_0 : TcpIoctl; (*AsTCP.TcpIoctl FUB*)
		TcpClose_0 : TcpClose; (*AsTCP.TcpClose FUB*)
		linger_opt : tcpLINGER_typ; (*AsTCP.tcpLINGER_typ*)
		recv_timeout : UDINT; (*receive timeout*)
		TcpOpen_timeout : UDINT;
		TcpClient_timeout : UDINT;
	END_STRUCT;
	Tlaciaren_typ : 	STRUCT 
		CMD : TlaciarenCommands_typ;
		STAV : TlaciarenStatus_typ;
		Data : TlaciarenData_typ;
	END_STRUCT;
	TlaciarenCommands_typ : 	STRUCT 
		VytlacEtiketu : BOOL;
	END_STRUCT;
	TlaciarenStatus_typ : 	STRUCT 
		PoruchaOtvoreniaKomunikacie : BOOL;
		PoruchaOdoslaniaDat : BOOL;
		PoruchaZatvoreniaKomunikacie : BOOL;
		PoruchaSpojenia_s_Tlaciarnou : BOOL;
		PoruchaPrijatiaDat : BOOL;
		PrislaSprava_s_Tlaciarne : BOOL;
		VytlacenieEtikety_OK : BOOL;
		VytlacenieEtikety_ERROR : BOOL;
		ERROR_Number : USINT; (*1 - Porucha otvorenia komunukácie; 2 - Porucha spojenia s tlaèiarnou; 3 - Porucha odoslania dat do tlaèiarne; 4 - Porucha zatvorenia komunikácie;5 - Porucha prijatia dát z tlaèiarne*)
	END_STRUCT;
	TlaciarenData_typ : 	STRUCT  (*Datatyp for global Variables*)
		Sprava_pre_Tlaciaren : STRING[4000]; (*Obsahuje posielane data pre tlaèiareò v textovej podobe*)
		Odpoved_s_Tlaciarne : STRING[400]; (*Obsahuje odpoveï s tlaèiarne*)
	END_STRUCT;
	EtiketaPanasonic_typ : 	STRUCT 
		IdentificationNumber : STRING[7];
		ChangeIndex : STRING[3];
		ModelType : STRING[8];
		SupplierNumber : STRING[6];
		PlantCode : STRING[2];
		Country : STRING[2];
		Date : STRING[8];
		Counter : STRING[5];
		DataMetrix : STRING[31];
	END_STRUCT;
	Etiketa_typ : 	STRUCT 
		LocationCode : STRING[2]; (*KK*)
		PartIdentNumber : STRING[7]; (*SSSSSSS*)
		ChangeIndex : STRING[2]; (*II*)
		ProductionYear : STRING[2]; (*JJ*)
		Manufactured : STRING[1]; (*H*)
		DayOfProduction : STRING[3]; (*TTT*)
		AssemblyLine : STRING[1]; (*M*)
		DayProductionCounter : STRING[5]; (*PPPPP*)
		SuplierNumber : STRING[6]; (*LLLLLL*)
		PlantCode : STRING[2]; (*NN*)
		DataMetrix : STRING[31]; (*Vytváram ho z kodu modelu na pracovisku etiketovania*)
		TypModelu : STRING[8];
		CountryCode : STRING[2];
		DatumVyroby : STRING[8]; (*02.03.20*)
	END_STRUCT;
END_TYPE
