/* Automation Studio generated header file */
/* Do not edit ! */
/* RFID_Heads  */

#ifndef _RFID_HEADS_
#define _RFID_HEADS_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct SickHeads
{
	/* VAR_INPUT (analog) */
	unsigned char ZadaneCisloPaletky;
	unsigned char Mapping_IN[8];
	/* VAR_OUTPUT (analog) */
	unsigned char PrecitaneCisloPaletky;
	unsigned char Mapping_OUT[8];
	/* VAR (analog) */
	unsigned char Step;
	struct TON AlarmTime;
	/* VAR_INPUT (digital) */
	plcbit CitaciuHlavu_VYPNI;
	plcbit PrecitajChipRFID;
	plcbit ZapisNaChipRFID;
	/* VAR_OUTPUT (digital) */
	plcbit PritomnostPaletky;
	plcbit Stav_CitaciaHlava_ON;
	plcbit Stav_CitanieZapis_OK;
	plcbit Stav_CitanieZapis_NG;
} SickHeads_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void SickHeads(struct SickHeads* inst);


#ifdef __cplusplus
};
#endif
#endif /* _RFID_HEADS_ */

