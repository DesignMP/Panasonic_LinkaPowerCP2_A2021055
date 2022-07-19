/* Automation Studio generated header file */
/* Do not edit ! */
/* Statistika  */

#ifndef _STATISTIKA_
#define _STATISTIKA_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct Statistika_IN_typ
{	plcbit START_MeraniaCasu;
	plcbit START_MeraniaStratovehoCasu;
	plcbit ZAPIS_MeraniaCasu;
	plcbit ZAPIS_StratovyCas;
	unsigned short TaskovaTrieda_ms;
	plcbit RESET_CelkovehoCasu;
	plcbit RESET_HistorieMeraniCasu;
	plcbit RESET_PoctuKusov;
	plcbit RESET_CelkovehoPoctuKusov;
	plcbit RESET_StratovehoCasu;
	plcbit PriratajKus_OK;
	plcbit PriratajKus_NG;
} Statistika_IN_typ;

typedef struct Statistika_OUT_typ
{	float NameranyCas_v_Sekundach;
	float NameranyCas_v_Minutach;
	float NameranyCas_v_Hodinach;
	float PriemernyCas_v_Sekundach;
	float PriemernyCas_v_Minutach;
	float StratoveSekundy;
	float StratoveMinuty;
	float StratoveHodiny;
	float HistoriaMerani_v_Sekundach[15];
	float HistoriaMerani_v_Minutach[15];
	float HistoriaMerani_v_Hodinach[15];
	float CelkovyPocetNameranychSekund;
	float CelkovyPocetNameranychMinut;
	float CelkovyPocetNameranychHodin;
	unsigned long PocetKusov_OK;
	unsigned long PocetKusov_NG;
	unsigned long CelkovyPocetKusov;
} Statistika_OUT_typ;

typedef struct Statistika_VAR_typ
{	float NameraneMilisekundy_REAL;
	float NameraneSekundy_REAL;
	float NameraneMinuty_REAL;
	float NameraneHodiny_REAL;
	unsigned short Milisekundy;
	unsigned short Sekundy;
	unsigned short Minuty;
	unsigned short Hodiny;
	unsigned short CelkoveSekundy;
	unsigned short CelkoveMinuty;
	unsigned short CelkoveHodiny;
	unsigned char i;
	unsigned char a;
	unsigned char b;
	unsigned char c;
	unsigned char d;
	float Priemer_SucetSekund_REAL;
	float Priemer_SucetMinut_REAL;
	float Priemer_SucetHodin_REAL;
	unsigned short StratoveMilisekundy;
	unsigned short StratoveSekundy;
	unsigned short StratoveMinuty;
	unsigned short StratoveHodiny;
	float CelkoveStratoveMilisekundy_REAL;
	float CelkoveStratoveSekundy_REAL;
} Statistika_VAR_typ;

typedef struct Taktime
{
	/* VAR_INPUT (analog) */
	struct Statistika_IN_typ IN;
	/* VAR_OUTPUT (analog) */
	struct Statistika_OUT_typ OUT;
	/* VAR (analog) */
	struct Statistika_VAR_typ IntVAR;
} Taktime_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void Taktime(struct Taktime* inst);


#ifdef __cplusplus
};
#endif
#endif /* _STATISTIKA_ */

