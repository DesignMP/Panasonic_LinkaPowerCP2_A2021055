
{REDUND_ERROR} FUNCTION_BLOCK ScrewLoading (*Nab�janie skrutiek pre syst�m WEBER*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Cmd : {REDUND_UNREPLICABLE} CmdStruc; (*Ovl�dacie pr�kazy*)
		IN : InStruc;
	END_VAR
	VAR_OUTPUT
		Status : StatusFBStruc; (*Statusov� bity*)
		Error : {REDUND_UNREPLICABLE} ErrorStruc_typ; (*Chybov� hl�senia*)
		OUT : OutStruc;
	END_VAR
	VAR
		Internal : InternalStruc;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
		zzEdge00003 : BOOL;
	END_VAR
END_FUNCTION_BLOCK
