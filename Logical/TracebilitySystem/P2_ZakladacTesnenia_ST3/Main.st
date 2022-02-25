
PROGRAM _INIT
	(* Insert code here *)
    SKTcpClientTrace_1.Params.IPportClient := 15000;
END_PROGRAM

PROGRAM _CYCLIC
		
	//Priradenie indexu paletky//
    a:= P2_StoperZaklTesnenia.PAR.CisloPaletky;
	
	
	
    //Parametre komunik�cie//
    memcpy(ADR(SKTcpClientTrace_1.Params.IPaddrServ),ADR('192.168.122.250'),SIZEOF('192.168.122.250'));

    SKTcpClientTrace_1.Params.IPportServ := 12000;
    SKTcpClientTrace_1.Params.RecvTimeout := 10000;
    SKTcpClientTrace_1();
	
    //Parametre komunik�cie//
    //Vstupy pre server//
    SKTcpClientTrace_1.Params.Packet.type := TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu;
    SKTcpClientTrace_1.Params.Packet.workplace := TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloStanice;
    TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloPaletky:= 'Pal';
    brsstrcat(ADR(TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloPaletky), ADR(P2_StoperZaklTesnenia.PAR.CisloPaletky_STRING));
    SKTcpClientTrace_1.Params.Packet.rfid := TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloPaletky;
    SKTcpClientTrace_1.Params.Packet.master := TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP;
    SKTcpClientTrace_1.Params.Packet.dps1:= TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodFiltra;
    SKTcpClientTrace_1.Params.Packet.dps2:= '';
    SKTcpClientTrace_1.Params.Packet.dps3:= '';
    SKTcpClientTrace_1.Params.Packet.dps4:= '';
    SKTcpClientTrace_1.Params.Packet.dps5:= '';
    SKTcpClientTrace_1.Params.Packet.operator_id := TRCB_P2_ZakladacTesnenia_ST3.INPUTS.ID_Operatora;
    SKTcpClientTrace_1.Params.Packet.data_report:= TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report;
    SKTcpClientTrace_1.Params.Packet.result := TRCB_P2_ZakladacTesnenia_ST3.INPUTS.StavPaletky;
	
	
    //V�stupy zo servera//
    TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.TYP_Prikazu:= SKTcpClientTrace_1.Internal.Splitter.out[1];
    TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.CisloStanice:= SKTcpClientTrace_1.Internal.Splitter.out[2];
    TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.CisloPaletky:= SKTcpClientTrace_1.Internal.Splitter.out[3];
    IF TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu = '0' THEN
        TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.CisloEtikety:= SKTcpClientTrace_1.Internal.Splitter.out[4];
    ELSE	
        TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.QRkodPowerCP:= SKTcpClientTrace_1.Internal.Splitter.out[4];
    END_IF	
    TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.QRkodFiltra:= SKTcpClientTrace_1.Internal.Splitter.out[5];
    TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.ID_Operatora:= SKTcpClientTrace_1.Internal.Splitter.out[10];
    TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.DruhCinnostiNaPaletke:= SKTcpClientTrace_1.Internal.Splitter.out[11];
    TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.PovolenieCinnostiNaPaletke:= SKTcpClientTrace_1.Internal.Splitter.out[12];
	
	
		
    //Volanie funkcie SequenceControl//
    SequenceControl(SC:= SC_KOM_Server);
	
    
   
    
	
    CASE SC_KOM_Server.Step OF
		
        0:
            SC_KOM_Server.StepName:= '0 - Nulovanie';
            SKTcpClientTrace_1.Cmd.Send:= FALSE;
            SKTcpClientTrace_1.Cmd.Close:= FALSE;
            TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajStavPaletky_TYP1:= FALSE;
            TRCB_P2_ZakladacTesnenia_ST3.CMD.PriradQRkodFiltra_TYP3:= FALSE;
            TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajCisloEtikety_TYP0:= FALSE;
			TRCB_P2_ZakladacTesnenia_ST3.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
            TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaUkoncena:= FALSE;
            TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaError:= FALSE;
            PocetDopytovNaServer:= 0;
            
            IF SKTcpClientTrace_1.Internal.Step = 0 THEN
                SKTcpClientTrace_1.Enable:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 1; 
            ELSIF SKTcpClientTrace_1.Internal.Step = 15 THEN
                SKTcpClientTrace_1.Enable:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 1;	
            ELSE
                SKTcpClientTrace_1.Enable:= FALSE;
            END_IF     
	
        1:
            SC_KOM_Server.StepName:= '1 - Rozhodnutie o cinnosti';
            IF TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajStavPaletky_TYP1 THEN
                SC_KOM_Server.Step:= 10;
            ELSIF TRCB_P2_ZakladacTesnenia_ST3.CMD.PriradQRkodFiltra_TYP3 THEN
                SC_KOM_Server.Step:= 20;
            ELSIF TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajCisloEtikety_TYP0 THEN
                SC_KOM_Server.Step:= 30;
            ELSIF TRCB_P2_ZakladacTesnenia_ST3.CMD.OdosliStavPaletky_TYP2 THEN
				SC_KOM_Server.Step:= 40;
			ELSIF TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajStavPanatrace_TYP4 THEN
				SC_KOM_Server.Step:= 50;	
            END_IF
		
        10:
            SC_KOM_Server.StepName:= '10 - Vyziadanie stavu paletky - odoslanie dat na server';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#10s;
		    SC_KOM_Server.AlarmTime.IN:= TRUE;
            
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu:= '1';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloStanice:= 'ST3';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloPaletky; //Z programu
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP:= Paletka[a].PAR.QRkodPowerCP;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodFiltra:= '';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.ID_Operatora:= Paletka[a].PAR.ID_Operatora;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report:= '';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.StavPaletky:= 'OK';
            SKTcpClientTrace_1.Cmd.Send:= TRUE;
			
						
			
            IF SKTcpClientTrace_1.Cmd.Send AND NOT SKTcpClientTrace_1.Status.staReceived AND NOT SKTcpClientTrace_1.Status.staError THEN
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 13;
            ELSIF SC_KOM_Server.AlarmTime.Q AND (SKTcpClientTrace_1.Status.staReceived OR SKTcpClientTrace_1.Status.staError) THEN
                PocetDopytovNaServer:= PocetDopytovNaServer + 1;
                SKTcpClientTrace_1.Cmd.Send:= FALSE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 14;
            END_IF	
			
			
		
        13:
            SC_KOM_Server.StepName:= '13 - Vyziadanie stavu paletky - odpoved servera';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#20s;
            SC_KOM_Server.AlarmTime.IN:= TRUE;
			
            IF SKTcpClientTrace_1.Status.staReceived AND 
                (TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.TYP_Prikazu = TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu) AND
                (TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.QRkodPowerCP = TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP) THEN
                TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 15;
            ELSIF SC_KOM_Server.AlarmTime.Q THEN
                PocetDopytovNaServer:= PocetDopytovNaServer + 1;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 14;
            END_IF			
		
        14:
            SC_KOM_Server.StepName:= '14 - Vyziadanie stavu paletky - cakam na opatovny dopyt na server';
            SC_KOM_Server.IdleTime.PT:= T#1s;
            SC_KOM_Server.AlarmTime.PT:= T#10s; 
            SC_KOM_Server.IdleTime.IN:= TRUE;
            
            
            IF PocetDopytovNaServer < 3 THEN
                IF SC_KOM_Server.IdleTime.Q THEN
                    SC_KOM_Server.ResetStep:= TRUE;
                    SC_KOM_Server.Step:= 10;
                END_IF
            ELSE
                TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaError:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 15;
            END_IF	
            
             
            
        15:
            SC_KOM_Server.StepName:= '15 - Vyziadanie stavu paletky - cakam na ukoncenie komunikacie';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#10s;
		
            IF NOT TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajStavPaletky_TYP1 THEN
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 0;
            END_IF
		
		
		
        20:
            SC_KOM_Server.StepName:= '20 - Priradenie QR kodu - odoslanie dat na server';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#20s;
            SC_KOM_Server.AlarmTime.IN:= TRUE;
		
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu:= '3';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloStanice:= 'ST3';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloPaletky;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP:= Paletka[a].PAR.QRkodPowerCP;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodFiltra:= Paletka[a].PAR.QRkodFiltra_5H;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.ID_Operatora:= Paletka[a].PAR.ID_Operatora;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report:= '';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.StavPaletky:= 'OK';
            SKTcpClientTrace_1.Cmd.Send:= TRUE;
			
				
			
            IF SKTcpClientTrace_1.Cmd.Send AND NOT SKTcpClientTrace_1.Status.staReceived AND NOT SKTcpClientTrace_1.Status.staError THEN
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 23;
            ELSIF SC_KOM_Server.AlarmTime.Q AND (SKTcpClientTrace_1.Status.staReceived OR SKTcpClientTrace_1.Status.staError) THEN
                PocetDopytovNaServer:= PocetDopytovNaServer + 1;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 24;     
            END_IF	
		
        23:
            SC_KOM_Server.StepName:= '23 - Priradenie QR kodu - odpoved servera';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#20s;
            SC_KOM_Server.AlarmTime.IN:= TRUE;
			
            IF SKTcpClientTrace_1.Status.staReceived AND 
                (TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.TYP_Prikazu = TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu) AND
                (TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.QRkodPowerCP = TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP) THEN
                TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 25;
            ELSIF SC_KOM_Server.AlarmTime.Q THEN
                PocetDopytovNaServer:= PocetDopytovNaServer + 1;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 24;   
            END_IF	
	
        24:
            SC_KOM_Server.StepName:= '24 - Priradenie QR kodu - cakam na opatovny dopyt na server';
            SC_KOM_Server.IdleTime.PT:= T#1s;
            SC_KOM_Server.AlarmTime.PT:= T#10s; 
            SC_KOM_Server.IdleTime.IN:= TRUE;
            SKTcpClientTrace_1.Cmd.Send:= FALSE;
            
            IF PocetDopytovNaServer < 3 THEN
                IF SC_KOM_Server.IdleTime.Q THEN
                    SC_KOM_Server.ResetStep:= TRUE;
                    SC_KOM_Server.Step:= 20;
                END_IF
            ELSE
                TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaError:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 25;
            END_IF	     
            
            
            
            
            
				
        25:
            SC_KOM_Server.StepName:= '25 - Priradenie QR kodu - cakam na ukoncenie komunikacie';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#10s;
		
            IF NOT TRCB_P2_ZakladacTesnenia_ST3.CMD.PriradQRkodFiltra_TYP3 THEN
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 0;
            END_IF
		
		
        30:
            SC_KOM_Server.StepName:= '30 - Vyziadanie serioveho cisla - odoslanie dat na server';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#10s;
		
			
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu:= '0';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloStanice:= 'ST3';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloPaletky;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP:= '';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodFiltra:= '';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.ID_Operatora:= 'E2';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report:= '';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.StavPaletky:= 'OK';
            SKTcpClientTrace_1.Cmd.Send:= TRUE;
			
			
					
            IF SKTcpClientTrace_1.Cmd.Send AND NOT SKTcpClientTrace_1.Status.staReceived AND NOT SKTcpClientTrace_1.Status.staError THEN
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 33;
            END_IF	
		
        33:
            SC_KOM_Server.StepName:= '33 - Vyziadanie serioveho cisla - odpoved servera';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#20s;
            SC_KOM_Server.AlarmTime.IN:= TRUE;
			
            IF SKTcpClientTrace_1.Status.staReceived AND 
                (TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.TYP_Prikazu = TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu) THEN
                TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 35;
            ELSIF SC_KOM_Server.AlarmTime.Q THEN
                TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaError:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 35;    
            END_IF	
			
			
				
        35:
            SC_KOM_Server.StepName:= '35 - Vyziadanie serioveho cisla - cakam na ukoncenie komunikacie';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#10s;
		
            IF NOT TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajCisloEtikety_TYP0 THEN
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 0;
            END_IF
		
		
		
        40:
            SC_KOM_Server.StepName:= '40 - Odoslanie stavu paletky - odoslanie dat na server';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#20s;
            SC_KOM_Server.AlarmTime.IN:= TRUE;
		
            //Vytvorenie spravy pre report//
            
            IF NOT SC_KOM_Server.Switch1 THEN
				brsmemset(ADR(Report),0,SIZEOF(Report));
				brsmemset(ADR(TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report), 0, SIZEOF(TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report));
				
				
				//Kamera 17 - kontrola paletky//
                Report[0].PoradoveCislo:= '1';
                Report[0].Popis:= 'KAM_17_KontrolaPaletky';
                Report[0].FormatHodnoty:= '2';
                Report[0].Tolerancia_MIN_Hodnota:= '';
                Report[0].Tolerancia_MAX_Hodnota:= '';
                Report[0].Nominal:= 'OK';
                Report[0].Tolerancia_MIN_Jednotky:= '';
                Report[0].Tolerancia_MAX_Jednotky:= '';
                IF Reports.Kamery.P2_CAM17_KontrolaPaletky = 'PASS' THEN
                    Report[0].NameranaHodnota:= 'OK'; 
                ELSE
                    Report[0].NameranaHodnota:= 'NG';
                END_IF    
                Report[0].NameranaHodnota_Jednotky:= '';
                Report[0].VyslednyResult:= Reports.Kamery.P2_CAM17_KontrolaPaletky;
                SKTcpClientNewCsvEntry(Report[0].PoradoveCislo,Report[0].Popis,Report[0].FormatHodnoty,Report[0].Tolerancia_MIN_Hodnota,Report[0].Tolerancia_MAX_Hodnota,Report[0].Nominal,Report[0].Tolerancia_MIN_Jednotky,Report[0].Tolerancia_MAX_Jednotky,Report[0].NameranaHodnota,Report[0].NameranaHodnota_Jednotky,Report[0].VyslednyResult, ADR(TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report));
                
                //Kamera 1 - kontrola tesnenia//
                Report[1].PoradoveCislo:= '2';
                Report[1].Popis:= 'KAM_1_KontrolaTesnenia';
                Report[1].FormatHodnoty:= '2';
                Report[1].Tolerancia_MIN_Hodnota:= '';
                Report[1].Tolerancia_MAX_Hodnota:= '';
                Report[1].Nominal:= 'OK';
                Report[1].Tolerancia_MIN_Jednotky:= '';
                Report[1].Tolerancia_MAX_Jednotky:= '';
                IF Reports.Kamery.P2_CAM1_KontrolaTesnenia = 'PASS' THEN
                    Report[1].NameranaHodnota:= 'OK'; 
                ELSE
                    Report[1].NameranaHodnota:= 'NG';
                END_IF    
                Report[1].NameranaHodnota_Jednotky:= '';
                Report[1].VyslednyResult:= Reports.Kamery.P2_CAM1_KontrolaTesnenia;
                SKTcpClientNewCsvEntry(Report[1].PoradoveCislo,Report[1].Popis,Report[1].FormatHodnoty,Report[1].Tolerancia_MIN_Hodnota,Report[1].Tolerancia_MAX_Hodnota,Report[1].Nominal,Report[1].Tolerancia_MIN_Jednotky,Report[1].Tolerancia_MAX_Jednotky,Report[1].NameranaHodnota,Report[1].NameranaHodnota_Jednotky,Report[1].VyslednyResult, ADR(TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report));
                SC_KOM_Server.Switch1:= TRUE;
            END_IF    
            
            
            
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu:= '2';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloStanice:= 'ST3';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloPaletky;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP:= Paletka[a].PAR.QRkodPowerCP;  
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodFiltra:= '';
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.ID_Operatora:= Paletka[a].PAR.ID_Operatora;
            TRCB_P2_ZakladacTesnenia_ST3.INPUTS.StavPaletky:= Paletka[a].PAR.StavPowerCP;
            SKTcpClientTrace_1.Cmd.Send:= TRUE;
			
						
            IF SKTcpClientTrace_1.Cmd.Send AND NOT SKTcpClientTrace_1.Status.staReceived AND NOT SKTcpClientTrace_1.Status.staError THEN
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 43;
            ELSIF SC_KOM_Server.AlarmTime.Q AND (SKTcpClientTrace_1.Status.staReceived OR SKTcpClientTrace_1.Status.staError) THEN
                PocetDopytovNaServer:= PocetDopytovNaServer + 1;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 44;    
            END_IF	
		
        43:
            SC_KOM_Server.StepName:= '43 - Odoslanie stavu paletky - odpoved servera';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#20s;
            SC_KOM_Server.AlarmTime.IN:= TRUE;
			
            IF SKTcpClientTrace_1.Status.staReceived AND 
                (TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.TYP_Prikazu = TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu) AND
                (TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.QRkodPowerCP = TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP) THEN
                TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 45;
            ELSIF SC_KOM_Server.AlarmTime.Q THEN
                PocetDopytovNaServer:= PocetDopytovNaServer + 1;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 44;   
            END_IF	
		
        44:
            SC_KOM_Server.StepName:= '44 - Odoslanie stavu paletky - cakam na opatovny dopyt na server';
            SC_KOM_Server.IdleTime.PT:= T#1s;
            SC_KOM_Server.AlarmTime.PT:= T#10s; 
            SC_KOM_Server.IdleTime.IN:= TRUE;
            SKTcpClientTrace_1.Cmd.Send:= FALSE;
            
            IF PocetDopytovNaServer < 3 THEN
                IF SC_KOM_Server.IdleTime.Q THEN
                    SC_KOM_Server.ResetStep:= TRUE;
                    SC_KOM_Server.Step:= 40;
                END_IF
            ELSE
                TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaError:= TRUE;
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 45;
            END_IF	      
            
            
            
            
		
		
        45:
            SC_KOM_Server.StepName:= '45 - Odoslanie stavu paletky - cakam na ukoncenie komunikacie';
            SC_KOM_Server.IdleTime.PT:= T#3s;
            SC_KOM_Server.AlarmTime.PT:= T#10s;
		
            IF NOT TRCB_P2_ZakladacTesnenia_ST3.CMD.OdosliStavPaletky_TYP2 THEN
                SC_KOM_Server.ResetStep:= TRUE;
                SC_KOM_Server.Step:= 0;
            END_IF
		
		
			
		50:
			SC_KOM_Server.StepName:= '50 - Vyziadanie stavu Panatrace - odoslanie dat na server';
			SC_KOM_Server.IdleTime.PT:= T#3s;
			SC_KOM_Server.AlarmTime.PT:= T#10s;
			SC_KOM_Server.AlarmTime.IN:= TRUE;
            
			TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu:= '4';
			TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloStanice:= 'ST2';
			TRCB_P2_ZakladacTesnenia_ST3.INPUTS.CisloPaletky:= '';
			TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodPowerCP:= '';
			TRCB_P2_ZakladacTesnenia_ST3.INPUTS.QRkodFiltra:= '';
			TRCB_P2_ZakladacTesnenia_ST3.INPUTS.ID_Operatora:= '';
			TRCB_P2_ZakladacTesnenia_ST3.INPUTS.Report:= '';
			TRCB_P2_ZakladacTesnenia_ST3.INPUTS.StavPaletky:= '';
			SKTcpClientTrace_1.Cmd.Send:= TRUE;

		

			IF SKTcpClientTrace_1.Cmd.Send AND NOT SKTcpClientTrace_1.Status.staReceived AND NOT SKTcpClientTrace_1.Status.staError THEN
				SC_KOM_Server.ResetStep:= TRUE;
				SC_KOM_Server.Step:= 53;
			ELSIF SC_KOM_Server.AlarmTime.Q AND (SKTcpClientTrace_1.Status.staReceived OR SKTcpClientTrace_1.Status.staError) THEN
				PocetDopytovNaServer:= PocetDopytovNaServer + 1;
				SKTcpClientTrace_1.Cmd.Send:= FALSE;
				SC_KOM_Server.ResetStep:= TRUE;
				SC_KOM_Server.Step:= 54;
			END_IF	



		53:
			SC_KOM_Server.StepName:= '53 - Vyziadanie stavu paletky - odpoved servera';
			SC_KOM_Server.IdleTime.PT:= T#30s;
			SC_KOM_Server.AlarmTime.PT:= T#20s;
			SC_KOM_Server.AlarmTime.IN:= TRUE;
            
			IF SKTcpClientTrace_1.Status.staReceived AND TRCB_P2_ZakladacTesnenia_ST3.OUTPUTS.TYP_Prikazu = TRCB_P2_ZakladacTesnenia_ST3.INPUTS.TYP_Prikazu THEN
				TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaUkoncena:= TRUE;
				SC_KOM_Server.ResetStep:= TRUE;
				SC_KOM_Server.Step:= 55;
			ELSIF SC_KOM_Server.AlarmTime.Q THEN
				PocetDopytovNaServer:= PocetDopytovNaServer + 1;
				SC_KOM_Server.ResetStep:= TRUE;
				SC_KOM_Server.Step:= 54;
			END_IF		

		54:
			SC_KOM_Server.StepName:= '54 - Vyziadanie stavu paletky - cakam na opatovny dopyt na server';
			SC_KOM_Server.IdleTime.PT:= T#1s;
			SC_KOM_Server.AlarmTime.PT:= T#10s; 
			SC_KOM_Server.IdleTime.IN:= TRUE;
            
            
			IF PocetDopytovNaServer < 3 THEN
				IF SC_KOM_Server.IdleTime.Q THEN
					SC_KOM_Server.ResetStep:= TRUE;
					SC_KOM_Server.Step:= 50;
				END_IF
			ELSE
				TRCB_P2_ZakladacTesnenia_ST3.STATUS.KomunikaciaError:= TRUE;
				SC_KOM_Server.ResetStep:= TRUE;
				SC_KOM_Server.Step:= 55;
			END_IF	
            
            

		55:
			SC_KOM_Server.StepName:= '55 - Vyziadanie stavu paletky - cakam na ukoncenie komunikacie';
			SC_KOM_Server.IdleTime.PT:= T#3s;
			SC_KOM_Server.AlarmTime.PT:= T#10s;
            
               
			IF NOT TRCB_P2_ZakladacTesnenia_ST3.CMD.VyziadajStavPanatrace_TYP4 THEN
				SC_KOM_Server.ResetStep:= TRUE;
				SC_KOM_Server.Step:= 0;
			END_IF
		
		
		
		
		
		
		
    END_CASE
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM
