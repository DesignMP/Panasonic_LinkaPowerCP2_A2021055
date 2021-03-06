﻿<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="UkladacieB" Source="UkladacieBuffery.UkladacieBuffery.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_Mapping" Source="Program.Pracovisko_1.P1_Mapping_IO.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Mapping" Source="Program.Pracovisko_2.P2_Mapping_IO.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Mapping" Source="Program.Pracovisko_3.P3_Mapping_IO.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Mapping" Source="Program.Pracovisko_4.P4_Mapping_IO.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_Srobova" Source="Program.Pracovisko_1.P1_Srobovanie.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Srobova" Source="Program.Pracovisko_2.P2_Srobovanie.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Srobova" Source="Program.Pracovisko_3.P3_Srobovanie.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="SafetyMapp" Source="Program.Linka.SafetyMapping_IO.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Program" Source="Program.TestSkrutkSetu.Program.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Statistik1" Source="Program.Linka.StatistikaLinky.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_SkrutSe" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2">
    <Task Name="P1_Vytah" Source="Program.Pracovisko_1.P1_Vytah.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_OvladVi" Source="Program.Pracovisko_1.P1_OvladVizu.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Cisteni" Source="Program.Pracovisko_2.P2_Cistenie.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_OvladVi" Source="Program.Pracovisko_2.P2_OvladVizu.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_Robot" Source="Program.Pracovisko_1.P1_Robot.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_ZaklTes" Source="Program.Pracovisko_2.P2_ZaklTesnenia.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Zvarani" Source="Program.Pracovisko_2.P2_Zvaranie.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Robot" Source="Program.Pracovisko_2.P2_Robot.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_StoperS" Source="Program.Pracovisko_1.P1_StoperSrobovania.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Stoper1" Source="Program.Pracovisko_2.P2_StoperZvarania.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_StoperS" Source="Program.Pracovisko_2.P2_StoperSrobovania.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_HV_Test" Source="Program.Pracovisko_3.P3_HV_Test.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Funkcny" Source="Program.Pracovisko_4.P4_FunkcnyTestA.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Funkcn1" Source="Program.Pracovisko_4.P4_FunkcnyTestB.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_StoperE" Source="Program.Pracovisko_4.P4_StoperEtiketovania.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Vytah" Source="Program.Pracovisko_4.P4_Vytah.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_OvladSa" Source="Program.Pracovisko_1.P1_OvladSafety.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_OvladSa" Source="Program.Pracovisko_2.P2_OvladSafety.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_OvladSa" Source="Program.Pracovisko_3.P3_OvladSafety.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_OvladSa" Source="Program.Pracovisko_4.P4_OvladSafety.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="OvladanieS" Source="Program.Linka.OvladanieSafety.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_OvladVi" Source="Program.Pracovisko_4.P4_OvladVizu.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="OvladanieV" Source="Program.Linka.OvladanieVizu.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="DevlinkFTP" Source="OdosielanieFotiek.DevlinkFTP.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM1" Source="OdosielanieFotiek.FTP_CAM1.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM2" Source="OdosielanieFotiek.FTP_CAM2.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM4" Source="OdosielanieFotiek.FTP_CAM4.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM6" Source="OdosielanieFotiek.FTP_CAM6.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM9" Source="OdosielanieFotiek.FTP_CAM9.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM10" Source="OdosielanieFotiek.FTP_CAM10.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM11" Source="OdosielanieFotiek.FTP_CAM11.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM12" Source="OdosielanieFotiek.FTP_CAM12.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM15" Source="OdosielanieFotiek.FTP_CAM15.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM16" Source="OdosielanieFotiek.FTP_CAM16.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FTP_CAM17" Source="OdosielanieFotiek.FTP_CAM17.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_Main" Source="Program.Pracovisko_1.P1_Main.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Main" Source="Program.Pracovisko_2.P2_Main.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Main" Source="Program.Pracovisko_3.P3_Main.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Main" Source="Program.Pracovisko_4.P4_Main.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#3">
    <Task Name="P1_Vytah_S" Source="TracebilitySystem.P1_Vytah_ST1.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_Srobov1" Source="TracebilitySystem.P1_Srobovanie_ST2.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Zaklada" Source="TracebilitySystem.P2_ZakladacTesnenia_ST3.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Maticov" Source="TracebilitySystem.P2_Maticovacka_ST4.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Srobov1" Source="TracebilitySystem.P2_Srobovanie_ST5.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Zvaran1" Source="TracebilitySystem.P2_Zvaranie_ST6.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Srobov1" Source="TracebilitySystem.P3_Srobovanie_ST7.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Leakag2" Source="TracebilitySystem.P3_LeakageTestA_ST8A.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Leakag3" Source="TracebilitySystem.P3_LeakageTestB_ST8B.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Etiketo" Source="TracebilitySystem.P4_Etiketovacka_ST9.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Vytah_S" Source="TracebilitySystem.P4_Vytah_ST10.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Blikanie10" Source="Blikace.Blikanie100ms.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Users_Main" Source="Uzivatelia.Users_Main.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Users_Pane" Source="Uzivatelia.Users_Panel1.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Users_Pan1" Source="Uzivatelia.Users_Panel2.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Users_Pan2" Source="Uzivatelia.Users_Panel3.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#4">
    <Task Name="RFID_Prg" Source="Uzivatelia.RFID_Prg.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Main" Source="Program.Linka.Main.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Blikanie20" Source="Blikace.Blikanie200ms.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_Dopravn" Source="Program.Pracovisko_1.P1_Dopravniky.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_SpodnyS" Source="Program.Pracovisko_1.P1_SpodnyStoper.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_Akumula" Source="Program.Pracovisko_1.P1_AkumStoper.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Dopravn" Source="Program.Pracovisko_2.P2_Dopravniky.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_SpodnyS" Source="Program.Pracovisko_2.P2_SpodnyStoper.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_StoperZ" Source="Program.Pracovisko_2.P2_StoperZaklTesnenia.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_StoperM" Source="Program.Pracovisko_2.P2_StoperMaticovacky.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_AkumSto" Source="Program.Pracovisko_2.P2_AkumStoper.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Dopravn" Source="Program.Pracovisko_3.P3_Dopravniky.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_SpodnyS" Source="Program.Pracovisko_3.P3_SpodnyStoper.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_StoperS" Source="Program.Pracovisko_3.P3_StoperSrobovania.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Zdvizka" Source="Program.Pracovisko_3.P3_ZdvizkaPredLeakTestA.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Leakage" Source="Program.Pracovisko_3.P3_LeakageTestA.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Zdvizk2" Source="Program.Pracovisko_3.P3_ZdvizkaZaLeakTestA.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Zdvizk1" Source="Program.Pracovisko_3.P3_ZdvizkaPredLeakTestB.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Leakag1" Source="Program.Pracovisko_3.P3_LeakageTestB.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P3_Zdvizk3" Source="Program.Pracovisko_3.P3_ZdvizkaZaLeakTestB.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Dopravn" Source="Program.Pracovisko_4.P4_Dopravniky.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_SpodnyS" Source="Program.Pracovisko_4.P4_SpodnyStoper.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Zdvizka" Source="Program.Pracovisko_4.P4_ZdvizkaZaFunkcTestA.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P4_Zdvizk1" Source="Program.Pracovisko_4.P4_ZdvizkaZaFunkcTestB.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="DatumCasPL" Source="DatumCasPLC.DatumCasPLC.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P1_Alarmy" Source="Alarmy.P1_Alarmy.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Alarmy" Source="Alarmy.P2_Alarmy.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P34_Alarmy" Source="Alarmy.P34_Alarmy.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#5">
    <Task Name="P1_Remanen" Source="RemanentnePremenne.P1_RemanentnePremenne.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P2_Remanen" Source="RemanentnePremenne.P2_RemanentnePremenne.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="P34_Remane" Source="RemanentnePremenne.P34_RemanentnePremenne.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Blikanie50" Source="Blikace.Blikanie500ms.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#6">
    <Task Name="Blikanie1s" Source="Blikace.Blikanie1s.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <NcDataObjects>
    <NcDataObject Name="mcdrivelog" Source="" Memory="UserROM" Language="Binary" />
  </NcDataObjects>
  <Binaries>
    <BinaryObject Name="FWRules" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arflatprv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arcoal" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCLang" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwac" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Config_2" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_3" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_4" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_5" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="asnxdb3" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asnxdb1" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asnxdb2" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="TC" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mCoWebSc" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="SC" Source="Libraries.SC.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="CoTrace" Source="Libraries.CoTrace.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="Operator" Source="Libraries.Operator.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIecCon" Source="Libraries.AsIecCon.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="IecCheck" Source="Libraries.IecCheck.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsZip" Source="Libraries.AsZip.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="Runtime" Source="Libraries.Runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsUSB" Source="Libraries.AsUSB.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="dvframe" Source="Libraries.dvframe.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsTCP" Source="Libraries.AsTCP.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="Banner" Source="Libraries.Banner.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="RFID_Heads" Source="Libraries.RFID_Heads.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="MpRecipe" Source="Libraries.MpRecipe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpBase" Source="Libraries.MpBase.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAlarmX" Source="Libraries.MpAlarmX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AtlasCopco" Source="Libraries.AtlasCopco.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="MyConvert" Source="Libraries.MyConvert.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="RFID" Source="Libraries.RFID.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="SkrutSety" Source="Libraries.SkrutSety.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="RoCa_Festo" Source="Libraries.RoCa_Festo.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="MpServer" Source="Libraries.MpServer.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Statistika" Source="Libraries.Statistika.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="ScrewLoad" Source="Libraries.ScrewLoad.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="AsICMP" Source="Libraries.AsICMP.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="SKTcp" Source="Libraries.SKTcp.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="arssl" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="dataobj" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="aruser" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>