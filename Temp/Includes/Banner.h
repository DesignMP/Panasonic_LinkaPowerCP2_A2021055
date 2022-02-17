/* Automation Studio generated header file */
/* Do not edit ! */
/* Banner  */

#ifndef _BANNER_
#define _BANNER_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct Banner_IN_typ
{	plcbit CervenaLED_ON;
	plcbit ZelenaLED_ON;
	plcbit ModraLED_ON;
	plcbit OranzovaLED_ON;
	plcbit ZltaLED_ON;
	plcbit CyanLED_ON;
	plcbit ModraRotujucaLED_ON;
	plcbit Blikac100ms;
} Banner_IN_typ;

typedef struct Banner_OUT_typ
{	plcbit Stlaceny;
} Banner_OUT_typ;

typedef struct BannerIOlink
{
	/* VAR_INPUT (analog) */
	unsigned char Mapping_IN[16];
	struct Banner_IN_typ IN;
	/* VAR_OUTPUT (analog) */
	unsigned char Mapping_OUT[16];
	struct Banner_OUT_typ OUT;
	/* VAR (analog) */
	unsigned char Step;
	/* VAR (digital) */
	plcbit zzEdge00000;
} BannerIOlink_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void BannerIOlink(struct BannerIOlink* inst);


#ifdef __cplusplus
};
#endif
#endif /* _BANNER_ */

