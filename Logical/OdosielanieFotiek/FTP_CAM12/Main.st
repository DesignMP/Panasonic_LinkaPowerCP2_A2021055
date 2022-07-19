
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

        	
    	
	//Volanie funkcie SequenceControl//
    SequenceControl(SC:= SC_Devlink);
	
    //******************************************Štruktura nazvu adresára na serveri Panasonic************************************************//
    //Názov linky//
    StruktNovehoNazvuAdresara.LINKA:= 'PowerCP_CP4';
	
    //Názov pracoviska//
    StruktNovehoNazvuAdresara.PRACOVISKO:= 'ST6';
    
    //Rok//
    brsstrcpy(ADR(StruktNovehoNazvuAdresara.ROK),ADR(Rok_STR_4_Znaky));

    //Dátum//
    StruktNovehoNazvuAdresara.DATUM:= '';
    brsstrcat(ADR(StruktNovehoNazvuAdresara.DATUM),ADR(Rok_STR_4_Znaky));
    brsstrcat(ADR(StruktNovehoNazvuAdresara.DATUM),ADR('_'));
    brsstrcat(ADR(StruktNovehoNazvuAdresara.DATUM),ADR(Mesiac_STR));
    brsstrcat(ADR(StruktNovehoNazvuAdresara.DATUM),ADR('_'));
    brsstrcat(ADR(StruktNovehoNazvuAdresara.DATUM),ADR(Den_STR));
    
    
    
    //*********************************************Štruktura názvu premenovaného súboru v PLC***************************************************//
    //Datum//
    StruktNovehoNazvuSuboru.DATUM:= '';
    brsstrcat(ADR(StruktNovehoNazvuSuboru.DATUM),ADR(Rok_STR_4_Znaky));
    brsstrcat(ADR(StruktNovehoNazvuSuboru.DATUM),ADR('_'));
    brsstrcat(ADR(StruktNovehoNazvuSuboru.DATUM),ADR(Mesiac_STR));
    brsstrcat(ADR(StruktNovehoNazvuSuboru.DATUM),ADR('_'));
    brsstrcat(ADR(StruktNovehoNazvuSuboru.DATUM),ADR(Den_STR));
	
    
    //Èas//
    StruktNovehoNazvuSuboru.CAS:= '';
    brsstrcat(ADR(StruktNovehoNazvuSuboru.CAS),ADR(Hodina_STR));
    brsstrcat(ADR(StruktNovehoNazvuSuboru.CAS),ADR('_'));
    brsstrcat(ADR(StruktNovehoNazvuSuboru.CAS),ADR(Minuta_STR));
    brsstrcat(ADR(StruktNovehoNazvuSuboru.CAS),ADR('_'));
    brsstrcat(ADR(StruktNovehoNazvuSuboru.CAS),ADR(Sekunda_STR));
	
    
    
    //Kód modelu//
    StruktNovehoNazvuSuboru.SERIAL:= FTP_CAM12.INPUTS.QRkodPowerCP;
	
    //Index fotky//
    StruktNovehoNazvuSuboru.INDEX:= FTP_CAM12.INPUTS.IndexFotky;
	
    //Result fotky//
    StruktNovehoNazvuSuboru.RESULT:= FTP_CAM12.INPUTS.Result;
	
	//Prípona súboru//
	IF TypFotky_BMP THEN
		StruktNovehoNazvuSuboru.Pripona:= '.bmp';
	ELSE
		StruktNovehoNazvuSuboru.Pripona:= '.jpg';
	END_IF	
	
    
    //Mapovanie premenných//
    FTP_CAM12.STATUS.AdresarPrazdny:= AdresarPrazdny;
    
       
	CASE SC_Devlink.Step OF
		
		0: 
			SC_Devlink.StepName:= '0 - Nulovanie';
			FTP_CAM12.STATUS.KomunikaciaError:= FALSE;
			FTP_CAM12.STATUS.KomunikaciaUkoncena:= FALSE;
			PocetHladaniFotky:= 0;
            AdresarPrazdny:= FALSE;
            PocetNajdenychSuborov:= 0;
            PocetNajdenychAdresarov:= 0;
            PocetPremenovanychSuborov:= 0;
            PocetSkopirovanychSuborov:= 0;
            PocetVymazanychSuborov:= 0;
            i:= 0;
            PocetPokusov_FTP_KOM:= 0;
			PoruchaKomunikacie:= FALSE;
			DirInfo_0.enable:= FALSE;
			DirRead_0.enable:= FALSE;
			FileRename_0.enable:= FALSE;
			DirCreate_0.enable:= FALSE;
			DirInfo_0.enable:= FALSE;
			DirRead_0.enable:= FALSE;
			FileCopy_0.enable:= FALSE;
			FileDelete_0.enable:= FALSE;
			SC_Devlink.Step:= 1;
		
		
        1: 
            SC_Devlink.StepName:= '1 - Rozhodnutie o cinnosti';
            IF FTP_CAM12.CMD.OdosliFotku THEN
                FTP_CAM12.STATUS.PopisPoruchy:= '';
                SC_Devlink.Step:= 15;
            ELSIF FTP_CAM12.CMD.VymazFotku THEN
                FTP_CAM12.STATUS.PopisPoruchy:= '';
                SC_Devlink.Step:= 153;
            END_IF
		
                  
                       
            
		15:
			SC_Devlink.StepName:= '15 - Odoslanie fotky, kontrola pripojenia na FTP server Panasonic';
			SC_Devlink.IdleTime.PT:= T#3s;
			SC_Devlink.AlarmTime.PT:= T#3s;
            
       
			IF Stav_PripojenieFTP_OK THEN
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 20;
			END_IF
			
        
        
		20:
			SC_Devlink.StepName:= '20 - Odoslanie fotky na server, nacitanie adresara kamery pred premenovanim';
			SC_Devlink.IdleTime.PT:= T#3s;
			SC_Devlink.AlarmTime.PT:= T#3s;
		
			DirInfo_0.enable:= TRUE;
			DirInfo_0.pDevice:= ADR('CAM12');
			DirInfo_0.pPath:= ADR('/');   //ak je nula tak èíta všetky súbory a adresáre v koreni ak je "/Temp" tak èíta všetky súbory a adresáre v adresári Temp//
			DirInfo_0();
			
			IF DirInfo_0.status = 0 THEN
				PocetNajdenychAdresarov:= DirInfo_0.dirnum;
				PocetNajdenychSuborov:= DirInfo_0.filenum;
				brsmemset(ADR(FileList[0]),0, SIZEOF(FileList));  //Vynulovanie pola stringov pre záznam adresárov a súborov
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 23;
			ELSIF DirInfo_0.status = 65535 THEN
				//BUSY//
			ELSIF DirInfo_0.status = 20723 THEN
				FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha nacitania adresara kamery';
				Buffer_12.Hodnota:= DirInfo_0.status;
				Buffer_12.ZapisHodnotu:= TRUE;
				PoruchaKomunikacie:= TRUE;
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 100;	
			ELSE
				FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha nacitania adresara kamery';
				IF DirInfo_0.status = 20799 THEN
					Buffer_12.Hodnota:= FileIoGetSysError();
				ELSE
					Buffer_12.Hodnota:= DirInfo_0.status;
				END_IF
                Buffer_12.ZapisHodnotu:= TRUE;
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;	
            END_IF
        
        23:
            SC_Devlink.StepName:= '23 - Odoslanie fotky na server, kontrola poctu najdenych suborov v adresari kamery';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;	
    			
            IF PocetNajdenychSuborov > 0 THEN
                PocetHladaniFotky:= 0;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 25;
            ELSIF PocetHladaniFotky < 100 THEN
                PocetHladaniFotky:= PocetHladaniFotky + 1;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 20;
            ELSIF PocetHladaniFotky >= 100 THEN
                AdresarPrazdny:= TRUE;
                FTP_CAM12.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF	
        
        25:
            SC_Devlink.StepName:= '25 - Odoslanie fotky na server, zapis nazvou najdenych suborov do pola stringov';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
    			
            DirRead_0.enable:= TRUE;
            DirRead_0.pDevice:= ADR('CAM12');
            DirRead_0.pPath:= ADR('/');   //ak je nula tak èíta všetky súbory a adresáre v koreni ak je "/Temp" tak èíta všetky súbory a adresáre v adresári Temp//
            DirRead_0.option:= fiFILE; //Zapíše súbory aj adresáre, ak je fiDIRECTORY zapíše len adresáre, ak je fiFILE tak zapíše len súbory//
            DirRead_0.entry:= i; //index zapisovania do pola//
            DirRead_0.pData:= ADR(ReadData);
            DirRead_0.data_len:= SIZEOF(ReadData);
            DirRead_0();
			
            IF DirRead_0.status = 0 THEN
                brsstrcpy(ADR(FileList[i]), ADR(ReadData.Filename[0])); //Uloženie názvou adresárov a súborov do pola stringov
				IF i< 100 THEN
					i:= i + 1;
				END_IF	
            ELSIF DirRead_0.status = 20702 THEN
                i:= 0;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 28;
            ELSIF DirRead_0.status = 65535 THEN
                //BUSY//
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha zapisu suborov do pola';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF	
            
      
        28:
            SC_Devlink.StepName:= '28 - Odoslanie fotky na server, premenovanie fotky';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
    						
            StaryNazovSuboru:= '';
            brsstrcat(ADR(StaryNazovSuboru),ADR('/'));
            brsstrcat(ADR(StaryNazovSuboru),ADR(FileList[i]));
    			
            NovyNazovSuboru:= '';
            brsstrcat(ADR(NovyNazovSuboru),ADR('/'));
            brsstrcat(ADR(NovyNazovSuboru),ADR(StruktNovehoNazvuSuboru.DATUM));
            brsstrcat(ADR(NovyNazovSuboru),ADR('_'));
            brsstrcat(ADR(NovyNazovSuboru),ADR(StruktNovehoNazvuSuboru.CAS));
            brsstrcat(ADR(NovyNazovSuboru),ADR('_'));
            brsstrcat(ADR(NovyNazovSuboru),ADR(StruktNovehoNazvuSuboru.SERIAL));
            brsstrcat(ADR(NovyNazovSuboru),ADR('_'));
            brsstrcat(ADR(NovyNazovSuboru),ADR(StruktNovehoNazvuSuboru.INDEX));
            brsstrcat(ADR(NovyNazovSuboru),ADR('_'));
            brsstrcat(ADR(NovyNazovSuboru),ADR(StruktNovehoNazvuSuboru.RESULT));
            brsstrcat(ADR(NovyNazovSuboru),ADR(StruktNovehoNazvuSuboru.Pripona));
    			
            FileRename_0.enable:= TRUE;
            FileRename_0.pDevice:= ADR('CAM12');
            FileRename_0.pName:= ADR(StaryNazovSuboru);  
            FileRename_0.pNewName:= ADR(NovyNazovSuboru);
            FileRename_0();
			
            IF FileRename_0.status = 0 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 30;
            ELSIF FileRename_0.status = 65535 THEN
                //BUSY//
            ELSIF FileRename_0.status = 20705 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 30;
            ELSIF FileRename_0.status = 20708 THEN
                AdresarPrazdny:= TRUE;
                FTP_CAM12.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha premenovania fotky';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF
		
        30:
            SC_Devlink.StepName:= '30 - Odoslanie fotky na server, kontrola poctu premenovanych suborov';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
    		
            IF NOT SC_Devlink.Switch1 THEN
                PocetPremenovanychSuborov:= PocetPremenovanychSuborov + 1;
                SC_Devlink.Switch1:= TRUE;
            END_IF 
            
            
            IF PocetPremenovanychSuborov < PocetNajdenychSuborov THEN			
                IF i< 100 THEN
					i:= i + 1;
				END_IF	
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 28;
            ELSE
                i:= 0;
                PocetNajdenychSuborov:= 0;
                PocetNajdenychAdresarov:= 0;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 33;//33
            END_IF	
            
         
        33: SC_Devlink.StepName:= '33 - Odoslanie fotky na server, vytvorenie adresara LINKA';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;	
			
            NazovAdresara_LINKA:= '';
            brsstrcat(ADR(NazovAdresara_LINKA),ADR('DesignMP'));
            brsstrcat(ADR(NazovAdresara_LINKA),ADR('/'));
            brsstrcat(ADR(NazovAdresara_LINKA),ADR(StruktNovehoNazvuAdresara.LINKA));
            
            
            DirCreate_0.enable:= TRUE;
            DirCreate_0.pDevice:= ADR('Panasonic');
            DirCreate_0.pName:= ADR(NazovAdresara_LINKA);
            DirCreate_0();
			
			
            IF DirCreate_0.status = 0 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 35;
            ELSIF DirCreate_0.status = 65535 THEN
                //BUSY//
            ELSIF DirCreate_0.status = 20725 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 35;
            ELSIF DirCreate_0.status = 20709 THEN
                //BUSY// 
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha vytvorenia adresara na FTP Panasonic';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF	
		
		
        35: SC_Devlink.StepName:= '35 - Odoslanie fotky na server, vytvorenie podadresara PRACOVISKO';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;	
			
            NazovPodAdresara_PRACOVISKO:= '';
            brsstrcat(ADR(NazovPodAdresara_PRACOVISKO),ADR(NazovAdresara_LINKA));
            brsstrcat(ADR(NazovPodAdresara_PRACOVISKO),ADR('/'));
            brsstrcat(ADR(NazovPodAdresara_PRACOVISKO),ADR(StruktNovehoNazvuAdresara.PRACOVISKO));
			
            DirCreate_0.enable:= TRUE;
            DirCreate_0.pDevice:= ADR('Panasonic');
            DirCreate_0.pName:= ADR(NazovPodAdresara_PRACOVISKO);
            DirCreate_0();
			
			
            IF DirCreate_0.status = 0 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 38;
            ELSIF DirCreate_0.status = 65535 THEN
                //BUSY//
            ELSIF DirCreate_0.status = 20725 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 38;
            ELSIF DirCreate_0.status = 20709 THEN
                //BUSY// 
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha vytvorenia adresara na FTP Panasonic';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF	
			
			
        38: SC_Devlink.StepName:= '38 - Odoslanie fotky na server, vytvorenie podadresara ROK';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;	
			
            NazovPodAdresara_ROK:= '';
            brsstrcat(ADR(NazovPodAdresara_ROK),ADR(NazovPodAdresara_PRACOVISKO));
            brsstrcat(ADR(NazovPodAdresara_ROK),ADR('/'));
            brsstrcat(ADR(NazovPodAdresara_ROK),ADR(StruktNovehoNazvuAdresara.ROK));
						
            DirCreate_0.enable:= TRUE;
            DirCreate_0.pDevice:= ADR('Panasonic');
            DirCreate_0.pName:= ADR(NazovPodAdresara_ROK);
            DirCreate_0();
			
				
            IF DirCreate_0.status = 0 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 40;
            ELSIF DirCreate_0.status = 65535 THEN
                //BUSY//
            ELSIF DirCreate_0.status = 20725 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 40;
            ELSIF DirCreate_0.status = 20709 THEN
                //BUSY// 
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha vytvorenia adresara na FTP Panasonic';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF	
			
	
        40: SC_Devlink.StepName:= '40 - Odoslanie fotky na server, vytvorenie podadresara DATUM';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;		
			
            NazovPodAdresara_DATUM:= '';
            brsstrcat(ADR(NazovPodAdresara_DATUM),ADR(NazovPodAdresara_ROK));
            brsstrcat(ADR(NazovPodAdresara_DATUM),ADR('/'));
            brsstrcat(ADR(NazovPodAdresara_DATUM),ADR(StruktNovehoNazvuAdresara.DATUM));
			
            DirCreate_0.enable:= TRUE;
            DirCreate_0.pDevice:= ADR('Panasonic');
            DirCreate_0.pName:= ADR(NazovPodAdresara_DATUM);
            DirCreate_0();
			
				
            IF DirCreate_0.status = 0 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 43;
            ELSIF DirCreate_0.status = 65535 THEN
                //BUSY//
            ELSIF DirCreate_0.status = 20725 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 43;
            ELSIF DirCreate_0.status = 20709 THEN
                //BUSY// 
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha vytvorenia adresara na FTP Panasonic';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF	
			   
            
        43:	SC_Devlink.StepName:= '43 - Odoslanie fotky na server, nacitanie adresara pred kopirovanim fotiek na server Panasonic';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;	
			
            DirInfo_0.enable:= TRUE;
            DirInfo_0.pDevice:= ADR('CAM12');
            DirInfo_0.pPath:= ADR('/');   //ak je nula tak èíta všetky súbory a adresáre v koreni ak je "/Temp" tak èíta všetky súbory a adresáre v adresári Temp//
            DirInfo_0();
			
            IF DirInfo_0.status = 0 THEN
                PocetNajdenychAdresarov:= DirInfo_0.dirnum;
                PocetNajdenychSuborov:= DirInfo_0.filenum;
                brsmemset(ADR(FileList[0]),0, SIZEOF(FileList));  //Vynulovanie pola stringov pre záznam adresárov a súborov
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 45;
            ELSIF DirInfo_0.status = 65535 THEN
                //BUSY//
            ELSIF DirInfo_0.status = 20723 THEN
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha nacitania adresara kamery';
                Buffer_12.Hodnota:= DirInfo_0.status;
                Buffer_12.ZapisHodnotu:= TRUE;
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;	
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha nacitania adresara kamery';
                IF DirInfo_0.status = 20799 THEN
                    Buffer_12.Hodnota:= FileIoGetSysError();
                ELSE
                    Buffer_12.Hodnota:= DirInfo_0.status;
                END_IF
                Buffer_12.ZapisHodnotu:= TRUE;
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF
			
        45: SC_Devlink.StepName:= '45 - Odoslanie fotky na server, zapis nazvou najdenych suborov do pola stringov';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;	
			
			
            DirRead_0.enable:= TRUE;
            DirRead_0.pDevice:= ADR('CAM12');
            DirRead_0.pPath:= ADR('/');   //ak je nula tak èíta všetky súbory a adresáre v koreni ak je "/Temp" tak èíta všetky súbory a adresáre v adresári Temp//
            DirRead_0.option:= fiFILE; //Zapíše súbory aj adresáre, ak je fiDIRECTORY zapíše len adresáre, ak je fiFILE tak zapíše len súbory//
            DirRead_0.entry:= i; //index zapisovania do pola//
            DirRead_0.pData:= ADR(ReadData);
            DirRead_0.data_len:= SIZEOF(ReadData);
            DirRead_0();
			
            IF DirRead_0.status = 0 THEN
                brsstrcpy(ADR(FileList[i]), ADR(ReadData.Filename[0])); //Uloženie názvou adresárov a súborov do pola stringov
				IF i< 100 THEN
					i:= i + 1;
				END_IF	
            ELSIF DirRead_0.status = 20702 THEN
                i:= 0;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 47;
            ELSIF DirRead_0.status = 65535 THEN
                //BUSY//
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha zapisu najdenych suborov do pola';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF		
	
		47:
			SC_Devlink.StepName:= '47 - Odoslanie fotky na server, vytvorenie cesty pre kopírovanie suboruk fotky na server Panasonic';
			SC_Devlink.IdleTime.PT:= T#3s;
			SC_Devlink.AlarmTime.PT:= T#3s;	

		
			ZdrojKopirovaniaSuboru:= '';
			brsstrcat(ADR(ZdrojKopirovaniaSuboru),ADR('/'));
			brsstrcat(ADR(ZdrojKopirovaniaSuboru),ADR(ReadData.Filename));
						
						
			CielKopirovaniaSuboru:= '';
			brsstrcat(ADR(CielKopirovaniaSuboru),ADR(NazovPodAdresara_DATUM));
			brsstrcat(ADR(CielKopirovaniaSuboru),ADR('/'));
			brsstrcat(ADR(CielKopirovaniaSuboru),ADR(ReadData.Filename));
            

			SC_Devlink.ResetStep:= TRUE;
			SC_Devlink.Step:= 48;	
			
			
			
			
        
            
        48: SC_Devlink.StepName:= '48 - Odoslanie fotky na server, kopirovanie fotky na server Panasonic';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;	
			
        			
			FileCopy_0.enable:= TRUE;
			FileCopy_0.pSrcDev:= ADR('CAM12'); //Zdrojové zariadenie od kial sa kopíruje
			FileCopy_0.pSrc:= ADR(ZdrojKopirovaniaSuboru); 
			FileCopy_0.pDestDev:= ADR('Panasonic'); //Cielové zariadenie kam sa má súbor skopírova
			FileCopy_0.pDest:= ADR(CielKopirovaniaSuboru);
			FileCopy_0.option := fiOVERWRITE;
			FileCopy_0();
			
            IF FileCopy_0.status = 0 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 50;
            ELSIF FileCopy_0.status = 65535 THEN
                //BUSY//
            ELSIF FileCopy_0.status = 20705 THEN
                SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 50;
			ELSIF FileCopy_0.status = 20799 THEN
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 50;	
            ELSIF FileCopy_0.status = 20708 THEN
                AdresarPrazdny:= TRUE;
                FTP_CAM12.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha kopirovania fotky na FTP Panasonic';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF
		
        50: SC_Devlink.StepName:= '50 - Odoslanie fotky na server, kontrola poctu skopirovanych suborov';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
			
            IF NOT SC_Devlink.Switch1 THEN
                PocetSkopirovanychSuborov:= PocetSkopirovanychSuborov + 1;
                SC_Devlink.Switch1:= TRUE;
            END_IF 
            
            
            IF PocetSkopirovanychSuborov < PocetNajdenychSuborov THEN			
                IF i< 100 THEN
					i:= i + 1;
				END_IF	
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 48;
            ELSE
                i:= 0;
                PocetNajdenychSuborov:= 0;
                PocetNajdenychAdresarov:= 0;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 60;
            END_IF	    
            
   
       
            
        60:
            SC_Devlink.StepName:= '60 - Odoslanie fotky na server, nacitanie adresara kamery pred vymazanim';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
    		
            DirInfo_0.enable:= TRUE;
            DirInfo_0.pDevice:= ADR('CAM12');
            DirInfo_0.pPath:= ADR('/');   //ak je nula tak èíta všetky súbory a adresáre v koreni ak je "/Temp" tak èíta všetky súbory a adresáre v adresári Temp//
            DirInfo_0();
    			
            IF DirInfo_0.status = 0 THEN
                PocetNajdenychAdresarov:= DirInfo_0.dirnum;
                PocetNajdenychSuborov:= DirInfo_0.filenum;
                brsmemset(ADR(FileList[0]),0, SIZEOF(FileList));  //Vynulovanie pola stringov pre záznam adresárov a súborov
                SC_Devlink.Step:= 63;
            ELSIF DirInfo_0.status = 65535 THEN
                //BUSY//
            ELSIF DirInfo_0.status = 20723 THEN
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha nacitania adresara kamery';
                Buffer_12.Hodnota:= DirInfo_0.status;
                Buffer_12.ZapisHodnotu:= TRUE;
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;	
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha nacitania adresara kamery';
                IF DirInfo_0.status = 20799 THEN
                    Buffer_12.Hodnota:= FileIoGetSysError();
                ELSE
                    Buffer_12.Hodnota:= DirInfo_0.status;
                END_IF
                Buffer_12.ZapisHodnotu:= TRUE;
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF
    			
        63: SC_Devlink.StepName:= '63 - Odoslanie fotky na server, zapis nazvou najdenych suborov do pola stringov';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
    			
            DirRead_0.enable:= TRUE;
            DirRead_0.pDevice:= ADR('CAM12');
            DirRead_0.pPath:= ADR('/');   //ak je nula tak èíta všetky súbory a adresáre v koreni ak je "/Temp" tak èíta všetky súbory a adresáre v adresári Temp//
            DirRead_0.option:= fiFILE; //Zapíše súbory aj adresáre, ak je fiDIRECTORY zapíše len adresáre, ak je fiFILE tak zapíše len súbory//
            DirRead_0.entry:= i; //index zapisovania do pola//
            DirRead_0.pData:= ADR(ReadData);
            DirRead_0.data_len:= SIZEOF(ReadData);
            DirRead_0();
    			
            IF DirRead_0.status = 0 THEN
                brsstrcpy(ADR(FileList[i]), ADR(ReadData.Filename[0])); //Uloženie názvou adresárov a súborov do pola stringov
				IF i< 100 THEN
					i:= i + 1;
				END_IF	
            ELSIF DirRead_0.status = 20702 THEN
                i:= 0;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 65;
            ELSIF DirRead_0.status = 65535 THEN
                //BUSY//
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha zapisu najdenych suborov do pola';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF	
    		
        65: SC_Devlink.StepName:= '65 - Odoslanie fotky na server, vymazanie suboru';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
    			
            ZdrojKopirovaniaSuboru:= '';
            brsstrcat(ADR(ZdrojKopirovaniaSuboru),ADR('/'));
            brsstrcat(ADR(ZdrojKopirovaniaSuboru),ADR(FileList[i]));
    			
    						
            FileDelete_0.enable:= TRUE;
            FileDelete_0.pDevice:= ADR('CAM12');
            FileDelete_0.pName:= ADR(ZdrojKopirovaniaSuboru);
            FileDelete_0();
    		
            IF FileDelete_0.status = 0 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 68;
            ELSIF FileDelete_0.status = 65535 THEN
                //BUSY//
            ELSIF FileDelete_0.status = 20708 THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 68;
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha vymazania fotky v adresari kamery';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF	
    		
    			
        68:	SC_Devlink.StepName:= '68 - Odoslanie fotky na server, kontrola poctu vymazanych suborov';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
    		
            IF NOT SC_Devlink.Switch1 THEN
                PocetVymazanychSuborov:= PocetVymazanychSuborov + 1;
                SC_Devlink.Switch1:= TRUE;
            END_IF 
            
            
            IF PocetVymazanychSuborov < PocetNajdenychSuborov THEN			
                IF i< 100 THEN
					i:= i + 1;
				END_IF	
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 65;
            ELSE
                i:= 0;
                PocetNajdenychSuborov:= 0;
                PocetNajdenychAdresarov:= 0;
                CAM12_PocetFotiek:= 0;
				FTP_CAM12.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 100;
            END_IF
    		
              
        100:
            SC_Devlink.StepName:= '100 - Odoslanie fotky, cakam na zrusenie prikazu odosli fotku';
            SC_Devlink.IdleTime.PT:= T#1s;
            SC_Devlink.AlarmTime.PT:= T#3s;
            
            SC_Devlink.IdleTime.IN:= TRUE;
            
            IF PoruchaKomunikacie AND SC_Devlink.IdleTime.Q AND PocetPokusov_FTP_KOM < 3 THEN
                PocetPokusov_FTP_KOM:= PocetPokusov_FTP_KOM + 1;
                PoruchaKomunikacie:= FALSE;
                i:= 0;
                PocetNajdenychSuborov:= 0;
                PocetNajdenychAdresarov:= 0;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 1;
            ELSIF PoruchaKomunikacie AND PocetPokusov_FTP_KOM >= 3 THEN
                FTP_CAM12.STATUS.KomunikaciaError:= TRUE;
            END_IF    
            
                         
            IF NOT FTP_CAM12.CMD.OdosliFotku THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 0; 
            END_IF
        
        
            //**************************************Vymazanie fotky*************************************************//   
        
               
		153:
			SC_Devlink.StepName:= '153 - Vymazanie fotky, nacitanie adresara kamery pred vymazanim';
			SC_Devlink.IdleTime.PT:= T#3s;
			SC_Devlink.AlarmTime.PT:= T#3s;
    		
			DirInfo_0.enable:= TRUE;
			DirInfo_0.pDevice:= ADR('CAM12');
			DirInfo_0.pPath:= ADR('/');   //ak je nula tak èíta všetky súbory a adresáre v koreni ak je "/Temp" tak èíta všetky súbory a adresáre v adresári Temp//
			DirInfo_0();
    			
			IF DirInfo_0.status = 0 THEN
				PocetNajdenychAdresarov:= DirInfo_0.dirnum;
				PocetNajdenychSuborov:= DirInfo_0.filenum;
				brsmemset(ADR(FileList[0]),0, SIZEOF(FileList));  //Vynulovanie pola stringov pre záznam adresárov a súborov
				SC_Devlink.Step:= 155;
			ELSIF DirInfo_0.status = 65535 THEN
				//BUSY//
			ELSIF DirInfo_0.status = 20723 THEN
				FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha nacitania adresara kamery';
				Buffer_12.Hodnota:= DirInfo_0.status;
				Buffer_12.ZapisHodnotu:= TRUE;
				PoruchaKomunikacie:= TRUE;
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 200;	
			ELSE
				FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha nacitania adresara kamery';
				IF DirInfo_0.status = 20799 THEN
					Buffer_12.Hodnota:= FileIoGetSysError();
				ELSE
					Buffer_12.Hodnota:= DirInfo_0.status;
				END_IF
				Buffer_12.ZapisHodnotu:= TRUE;
				PoruchaKomunikacie:= TRUE;
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 200;
			END_IF
    			
		155: SC_Devlink.StepName:= '155 - Vymazanie fotky, zapis nazvou najdenych suborov do pola stringov';
			SC_Devlink.IdleTime.PT:= T#3s;
			SC_Devlink.AlarmTime.PT:= T#3s;
    			
			DirRead_0.enable:= TRUE;
			DirRead_0.pDevice:= ADR('CAM12');
			DirRead_0.pPath:= ADR('/');   //ak je nula tak èíta všetky súbory a adresáre v koreni ak je "/Temp" tak èíta všetky súbory a adresáre v adresári Temp//
			DirRead_0.option:= fiFILE; //Zapíše súbory aj adresáre, ak je fiDIRECTORY zapíše len adresáre, ak je fiFILE tak zapíše len súbory//
			DirRead_0.entry:= i; //index zapisovania do pola//
			DirRead_0.pData:= ADR(ReadData);
			DirRead_0.data_len:= SIZEOF(ReadData);
			DirRead_0();
    			
			IF DirRead_0.status = 0 THEN
				brsstrcpy(ADR(FileList[i]), ADR(ReadData.Filename[0])); //Uloženie názvou adresárov a súborov do pola stringov
				IF i< 100 THEN
					i:= i + 1;
				END_IF	
			ELSIF DirRead_0.status = 20702 THEN
				i:= 0;
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 158;
			ELSIF DirRead_0.status = 65535 THEN
				//BUSY//
			ELSE
				FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha zapisu najdenych suborov do pola';
				PoruchaKomunikacie:= TRUE;
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 200;
			END_IF	
    		
		158: SC_Devlink.StepName:= '158 - Vymazanie fotky, vymazanie suboru';
			SC_Devlink.IdleTime.PT:= T#3s;
			SC_Devlink.AlarmTime.PT:= T#3s;
    			
			ZdrojKopirovaniaSuboru:= '';
			brsstrcat(ADR(ZdrojKopirovaniaSuboru),ADR('/'));
			brsstrcat(ADR(ZdrojKopirovaniaSuboru),ADR(FileList[i]));
    			
    						
			FileDelete_0.enable:= TRUE;
			FileDelete_0.pDevice:= ADR('CAM12');
			FileDelete_0.pName:= ADR(ZdrojKopirovaniaSuboru);
			FileDelete_0();
    		
			IF FileDelete_0.status = 0 THEN
				SC_Devlink.ResetStep:= TRUE;
				SC_Devlink.Step:= 160;
			ELSIF FileDelete_0.status = 65535 THEN
				//BUSY//
			ELSIF FileDelete_0.status = 20708 THEN
				SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 160;
            ELSE
                FTP_CAM12.STATUS.PopisPoruchy:= 'Porucha vymazania fotky v adresari kamery';
                PoruchaKomunikacie:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 200;
            END_IF	
    		
    			
        160:	SC_Devlink.StepName:= '160 - Vymazanie fotky, kontrola poctu vymazanych suborov';
            SC_Devlink.IdleTime.PT:= T#3s;
            SC_Devlink.AlarmTime.PT:= T#3s;
    		
            IF NOT SC_Devlink.Switch1 THEN
                PocetVymazanychSuborov:= PocetVymazanychSuborov + 1;
                SC_Devlink.Switch1:= TRUE;
            END_IF 
            
            
            IF PocetVymazanychSuborov < PocetNajdenychSuborov THEN			
                IF i< 100 THEN
					i:= i + 1;
				END_IF	
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 158;
            ELSE
                i:= 0;
                PocetNajdenychSuborov:= 0;
                PocetNajdenychAdresarov:= 0;
                CAM12_PocetFotiek:= 0;
				FTP_CAM12.STATUS.KomunikaciaUkoncena:= TRUE;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 200;
            END_IF
    		
              
        200:
            SC_Devlink.StepName:= '200 - Vymazanie fotky, cakam na zrusenie prikazu odosli fotku';
            SC_Devlink.IdleTime.PT:= T#1s;
            SC_Devlink.AlarmTime.PT:= T#3s;
            
            SC_Devlink.IdleTime.IN:= TRUE;
            
            IF PoruchaKomunikacie AND SC_Devlink.IdleTime.Q AND PocetPokusov_FTP_KOM < 3 THEN
                PocetPokusov_FTP_KOM:= PocetPokusov_FTP_KOM + 1;
                PoruchaKomunikacie:= FALSE;
                i:= 0;
                PocetNajdenychSuborov:= 0;
                PocetNajdenychAdresarov:= 0;
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 1;
            ELSIF PoruchaKomunikacie AND PocetPokusov_FTP_KOM >= 3 THEN
                FTP_CAM12.STATUS.KomunikaciaError:= TRUE;
            END_IF    
                     
            
            IF NOT FTP_CAM12.CMD.VymazFotku THEN
                SC_Devlink.ResetStep:= TRUE;
                SC_Devlink.Step:= 0; 
            END_IF
        
        
        
        
        
        
    END_CASE     
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

