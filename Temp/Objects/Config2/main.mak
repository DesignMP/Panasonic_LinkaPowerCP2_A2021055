SHELL := cmd.exe
CYGWIN=nontsec
export PATH := C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files (x86)\Common Files\Acronis\VirtualFile\;C:\Program Files (x86)\Common Files\Acronis\VirtualFile64\;C:\Program Files (x86)\Common Files\Acronis\FileProtector\;C:\Program Files (x86)\Common Files\Acronis\FileProtector64\;C:\Program Files (x86)\Common Files\Acronis\SnapAPI\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files (x86)\EAC MW klient\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\150\Tools\Binn\;C:\Program Files\Microsoft SQL Server\150\Tools\Binn\;C:\Program Files\Microsoft SQL Server\150\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\150\DTS\Binn\;C:\Program Files\Azure Data Studio\bin;C:\Program Files (x86)\Intel\Intel(R) Management Engine Components\DAL;C:\Program Files\Intel\Intel(R) Management Engine Components\DAL;C:\Users\marti\AppData\Local\Microsoft\WindowsApps;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Program Files\Azure Data Studio\bin;C:\Users\marti\AppData\Local\Microsoft\WindowsApps;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Program Files\Azure Data Studio\bin;C:\BrAutomation\AS410\bin-en\4.10;C:\BrAutomation\AS410\bin-en\4.9;C:\BrAutomation\AS410\bin-en\4.8;C:\BrAutomation\AS410\bin-en\4.7;C:\BrAutomation\AS410\bin-en\4.6;C:\BrAutomation\AS410\bin-en\4.5;C:\BrAutomation\AS410\bin-en\4.4;C:\BrAutomation\AS410\bin-en\4.3;C:\BrAutomation\AS410\bin-en\4.2;C:\BrAutomation\AS410\bin-en\4.1;C:\BrAutomation\AS410\bin-en\4.0;C:\BrAutomation\AS410\bin-en
export AS_BUILD_MODE := BuildAndTransfer
export AS_VERSION := 4.10.3.60 SP
export AS_WORKINGVERSION := 4.10
export AS_COMPANY_NAME :=  
export AS_USER_NAME := Martin Dvorscak
export AS_PATH := C:/BrAutomation/AS410
export AS_BIN_PATH := C:/BrAutomation/AS410/bin-en
export AS_PROJECT_PATH := D:/Projekty\ BER/Panasonic_LinkaPowerCP2_A2021055
export AS_PROJECT_NAME := Panasonic_LinkaPowerCP2_A2021055
export AS_SYSTEM_PATH := C:/BrAutomation/AS/System
export AS_VC_PATH := C:/BrAutomation/AS410/AS/VC
export AS_TEMP_PATH := D:/Projekty\ BER/Panasonic_LinkaPowerCP2_A2021055/Temp
export AS_CONFIGURATION := Config2
export AS_BINARIES_PATH := D:/Projekty\ BER/Panasonic_LinkaPowerCP2_A2021055/Binaries
export AS_GNU_INST_PATH := C:/BrAutomation/AS410/AS/GnuInst/V6.3.0
export AS_GNU_BIN_PATH := C:/BrAutomation/AS410/AS/GnuInst/V6.3.0/4.9/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/BrAutomation/AS410/AS/GnuInst/V6.3.0
export AS_GNU_BIN_PATH_SUB_MAKE := C:/BrAutomation/AS410/AS/GnuInst/V6.3.0/4.9/bin
export AS_INSTALL_PATH := C:/BrAutomation/AS410
export WIN32_AS_PATH := "C:\BrAutomation\AS410"
export WIN32_AS_BIN_PATH := "C:\BrAutomation\AS410\bin-en"
export WIN32_AS_PROJECT_PATH := "D:\Projekty BER\Panasonic_LinkaPowerCP2_A2021055"
export WIN32_AS_SYSTEM_PATH := "C:\BrAutomation\AS\System"
export WIN32_AS_VC_PATH := "C:\BrAutomation\AS410\AS\VC"
export WIN32_AS_TEMP_PATH := "D:\Projekty BER\Panasonic_LinkaPowerCP2_A2021055\Temp"
export WIN32_AS_BINARIES_PATH := "D:\Projekty BER\Panasonic_LinkaPowerCP2_A2021055\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\BrAutomation\AS410\AS\GnuInst\V6.3.0"
export WIN32_AS_GNU_BIN_PATH := "$(WIN32_AS_GNU_INST_PATH)\\bin" 
export WIN32_AS_INSTALL_PATH := "C:\BrAutomation\AS410"

.suffixes:

ProjectMakeFile:

	@'$(AS_BIN_PATH)/4.9/BR.AS.AnalyseProject.exe' '$(AS_PROJECT_PATH)/Panasonic_LinkaPowerCP2_A2021055.apj' -t '$(AS_TEMP_PATH)' -c '$(AS_CONFIGURATION)' -o '$(AS_BINARIES_PATH)'   -sfas -buildMode 'BuildAndTransfer'   

