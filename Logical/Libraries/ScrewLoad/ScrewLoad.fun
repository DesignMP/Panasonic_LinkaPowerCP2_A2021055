
{REDUND_ERROR} FUNCTION_BLOCK ScrewLoading (*Nabíjanie skrutiek pre systém WEBER*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Cmd : {REDUND_UNREPLICABLE} CmdStruc; (*Ovládacie príkazy*)
		IN : InStruc;
	END_VAR
	VAR_OUTPUT
		Status : StatusFBStruc; (*Statusové bity*)
		Error : {REDUND_UNREPLICABLE} ErrorStruc_typ; (*Chybové hlásenia*)
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
