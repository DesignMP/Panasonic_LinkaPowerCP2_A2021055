/* Automation Studio generated header file */
/* Do not edit ! */
/* ScrewLoad 1.00.0 */

#ifndef _SCREWLOAD_
#define _SCREWLOAD_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _ScrewLoad_VERSION
#define _ScrewLoad_VERSION 1.00.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct VibracnyHrniecIN
{	plcbit PritomnostSkrutiekVHrnci;
	plcbit VibracnaListaZaplnena;
	plcbit PreletovySnimac;
} VibracnyHrniecIN;

typedef struct VibracnyHrniecOUT
{	plcbit PrerusenieZasobovaniaSkrutiek;
	plcbit TiedenieSkrutiek;
	plcbit VzduchNastreleniaSkrutky;
	plcbit OddelovacVysunut;
	plcbit ZapniVibromotor;
} VibracnyHrniecOUT;

typedef struct VibracnyHrniecVAR
{	struct TON T_ZapnutieTriediacehoVzduchu;
	struct TON T_Zaplnenie;
	struct TON T_PreletSkrutky;
} VibracnyHrniecVAR;

typedef struct VibracnyHrniecStruc
{	struct VibracnyHrniecIN IN;
	struct VibracnyHrniecOUT OUT;
	struct VibracnyHrniecVAR Premenne;
} VibracnyHrniecStruc;

typedef struct BrzdaIN
{	plcbit ZakladnaPoloha;
	plcbit PodajSkrutku;
	plcbit PreletSkrutky;
	plcbit SkrutkaPritomnaVBrzde;
	plcbit VyziadanieSkrutky;
} BrzdaIN;

typedef struct BrzdaOUT
{	plcbit ZakladnaPoloha;
	plcbit PodajSkrutku;
	plcbit OdsavanieNecistot;
	plcbit SktutkaPodana;
	plcbit NastrelenieSkrutky;
} BrzdaOUT;

typedef struct BrzdaVAR
{	struct TON T_PreletSkrutky;
	struct TON T_CasCisteniaSkrutky;
	struct TON T_PresunBrzdy;
} BrzdaVAR;

typedef struct BrzdaStruc
{	struct BrzdaIN IN;
	struct BrzdaOUT OUT;
	struct BrzdaVAR Premenne;
} BrzdaStruc;

typedef struct StepStruc_typ
{	unsigned char VibracnyHrniec;
	unsigned char Brzda;
} StepStruc_typ;

typedef struct StatusStruc_typ
{	plcwstring VibracnyHrniec[81];
	plcwstring Brzda[81];
} StatusStruc_typ;

typedef struct InternalStruc
{	struct BrzdaVAR Brzda;
	struct VibracnyHrniecVAR VibracnyHrniec;
	struct StepStruc_typ Step;
	struct StatusStruc_typ Status;
} InternalStruc;

typedef struct ErrorStruc_typ
{	plcbit ErrorBit;
	unsigned short ErrorNumber;
	plcwstring ErrorMessage[81];
} ErrorStruc_typ;

typedef struct StatusFBStruc
{	plcbit AutomatBezi;
	plcbit ManualBeziHrniec;
	plcbit SkrutkaPripravena;
} StatusFBStruc;

typedef struct CmdStruc
{	plcbit AutomatStart;
	plcbit ManualStartHrniec;
	plcbit PodajSkrutku;
} CmdStruc;

typedef struct OutStruc
{	struct BrzdaOUT Brzda;
	struct VibracnyHrniecOUT VibracnyHrniec;
} OutStruc;

typedef struct InStruc
{	struct BrzdaIN Brzda;
	struct VibracnyHrniecIN VibracnyHrniec;
} InStruc;

typedef struct ScrewLoading
{
	/* VAR_INPUT (analog) */
	struct CmdStruc Cmd;
	struct InStruc IN;
	/* VAR_OUTPUT (analog) */
	struct StatusFBStruc Status;
	struct ErrorStruc_typ Error;
	struct OutStruc OUT;
	/* VAR (analog) */
	struct InternalStruc Internal;
	/* VAR (digital) */
	plcbit zzEdge00000;
	plcbit zzEdge00001;
	plcbit zzEdge00002;
	plcbit zzEdge00003;
} ScrewLoading_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void ScrewLoading(struct ScrewLoading* inst);


#ifdef __cplusplus
};
#endif
#endif /* _SCREWLOAD_ */

