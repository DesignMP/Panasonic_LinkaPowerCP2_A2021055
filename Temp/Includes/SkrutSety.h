/* Automation Studio generated header file */
/* Do not edit ! */
/* SkrutSety  */

#ifndef _SKRUTSETY_
#define _SKRUTSETY_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct PickAndPlace_CMD_typ
{	plcbit ENABLE;
	plcbit PodajSkrutku;
	plcbit RucnyRezim;
	plcbit RR_ZapniZasobnik;
	plcbit RR_ZapniVibrolistu;
	plcbit RR_OtocPodavac_Vstup;
	plcbit RR_OtocPodavac_Vystup;
	plcbit ResetPoruchy;
} PickAndPlace_CMD_typ;

typedef struct PickAndPlace_IN_typ
{	plcbit ZasobnikSkrutiekPrazdny;
	plcbit ZaplnenieListyZasobnika;
	plcbit ZaplnenieVibrolisty_MIN;
	plcbit ZaplnenieVibrolisty_MAX;
	plcbit PodavacOtoceny_VSTUP;
	plcbit PodavacOtoceny_VYSTUP;
	plcbit Podavac_SkrutkaNaVstupe;
	plcbit Podavac_SkrutkaNaVystupe;
	plcbit NapajanieZasobnika_OK;
	plcbit NapajanieVibrolisty_OK;
} PickAndPlace_IN_typ;

typedef struct PickAndPlace_OUT_typ
{	plcbit VibropohonZasobnika_RUN;
	plcbit VibropohonListy_RUN;
	plcbit TriediaciVzduch_RUN;
	plcbit ZhadzovaciVzduch_RUN;
	plcbit OtocPodavac_NaVstup;
	plcbit OtocPodavac_NaVystup;
} PickAndPlace_OUT_typ;

typedef struct PickAndPlace_STAV_typ
{	plcbit SkrutkaPripravena;
	plcbit ERROR;
	unsigned char CisloPoruchy;
	plcstring PopisPoruchy[101];
} PickAndPlace_STAV_typ;

typedef struct PickAndPlace_Internal_typ
{	struct TON CasZaplneniaVibrolisty;
	struct TON CasZaplneniaZasobnika;
	struct TON CasVypnTriediacehoVzduchu;
	struct TON CasPredSpustenimZasobnika;
	struct TON IdleTime_200ms;
	struct TON IdleTime_1s;
	struct TON IdleTime_500ms;
	struct TON IdleTime_100ms;
	struct TON AlarmTime_10s;
} PickAndPlace_Internal_typ;

typedef struct MaticaSet_CMD_typ
{	plcbit ENABLE;
	plcbit PodajMaticu;
	plcbit RucnyRezim;
	plcbit RR_ZapniZasobnik;
	plcbit RR_VysunPodavacMatic;
	plcbit RR_OtocPodavac_Vstup;
	plcbit RR_OtocPodavac_Vystup;
	plcbit ResetPoruchy;
} MaticaSet_CMD_typ;

typedef struct MaticaSet_IN_typ
{	plcbit ZasobnikMaticPrazdny;
	plcbit ZaplnenieListyZasobnika;
	plcbit Oddelovac_SnimPrechoduMatice;
	plcbit OddelovacOtoceny_VSTUP;
	plcbit OddelovacOtoceny_VYSTUP;
	plcbit PodavacMatice_VYSUNUTY;
	plcbit PodavacMatice_ZASUNUTY;
	plcbit Podavac_SnimPrechoduMatice;
	plcbit PritomnostMaticeNaVystupe;
	plcbit NapajanieZasobnika_OK;
} MaticaSet_IN_typ;

typedef struct MaticaSet_OUT_typ
{	plcbit VibropohonZasobnika_RUN;
	plcbit TriediaciVzduch_RUN;
	plcbit ZhadzovaciVzduch_RUN;
	plcbit OtocOddelovacMatice_NaVystup;
	plcbit NastrelenieMatice_RUN;
	plcbit PodavacMatice_Vysun;
} MaticaSet_OUT_typ;

typedef struct MaticaSet_STAV_typ
{	plcbit MaticaPripravena;
	plcbit ERROR;
	unsigned char CisloPoruchy;
	plcstring PopisPoruchy[101];
	plcbit PodanieMatice_BUSY;
} MaticaSet_STAV_typ;

typedef struct MaticaSet_Internal_typ
{	plcbit PoInit;
	struct TON CasZaplneniaZasobnika;
	struct TON CasVypnTriediacehoVzduchu;
	struct TON CasVypnZasobnika;
	struct TON IdleTime_200ms;
	struct TON IdleTime_1s;
	struct TON IdleTime_500ms;
	struct TON IdleTime_100ms;
	struct TON AlarmTime_3s;
	struct TON IdleTime_1500ms;
} MaticaSet_Internal_typ;

typedef struct PickAndPlace
{
	/* VAR_INPUT (analog) */
	struct PickAndPlace_CMD_typ CMD;
	struct PickAndPlace_IN_typ IN;
	/* VAR_OUTPUT (analog) */
	struct PickAndPlace_OUT_typ OUT;
	struct PickAndPlace_STAV_typ STAV;
	/* VAR (analog) */
	struct PickAndPlace_Internal_typ Internal;
	unsigned char Step;
	/* VAR (digital) */
	plcbit zzEdge00000;
} PickAndPlace_typ;

typedef struct MaticaSet
{
	/* VAR_INPUT (analog) */
	struct MaticaSet_CMD_typ CMD;
	struct MaticaSet_IN_typ IN;
	/* VAR_OUTPUT (analog) */
	struct MaticaSet_OUT_typ OUT;
	struct MaticaSet_STAV_typ STAV;
	/* VAR (analog) */
	struct MaticaSet_Internal_typ Internal;
	unsigned char Step;
} MaticaSet_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void PickAndPlace(struct PickAndPlace* inst);
_BUR_PUBLIC void MaticaSet(struct MaticaSet* inst);


#ifdef __cplusplus
};
#endif
#endif /* _SKRUTSETY_ */

