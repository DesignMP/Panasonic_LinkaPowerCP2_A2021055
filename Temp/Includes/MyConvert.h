/* Automation Studio generated header file */
/* Do not edit ! */
/* MyConvert  */

#ifndef _MYCONVERT_
#define _MYCONVERT_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct UsintToUint
{
	/* VAR_INPUT (analog) */
	unsigned char IN_Byte0;
	unsigned char IN_Byte1;
	/* VAR_OUTPUT (analog) */
	unsigned short OUT_UINT;
} UsintToUint_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void UsintToUint(struct UsintToUint* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MYCONVERT_ */

