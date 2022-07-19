
#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
#include "SKTcp.h"
#include <AsBrStr.h>
#include <sys_lib.h>
#ifdef __cplusplus
	};
#endif

void SKTcpLogger(struct SKTcpLogger* inst)
{

	RTCtime_typ	RTCtime_struct;
	STRING		lstr1[5000], lstr2[5000];

	if ( inst->enable == 1 ) 
	{
		switch ( inst->internal.step )
		{
			case 0:
        
				if ( inst->trigger == 1 ) 
					inst->internal.step++;
   
				break;

			case 1:
				inst->internal.FileOpen.enable = 1;
				inst->internal.FileOpen.pDevice = inst->pDevice;
				inst->internal.FileOpen.pFile = inst->pFile;
				inst->internal.FileOpen.mode = fiREAD_WRITE;
				FileOpen(&inst->internal.FileOpen);
				if ( inst->internal.FileOpen.status == ERR_OK ) {
					inst->internal.FileOpen.enable = 0;
					inst->internal.step++;
				}
				break;
   
			case 2:
    
				brsstrcpy(lstr1, "");
				brsstrcpy(lstr2, "");
    
				RTC_gettime(&RTCtime_struct);
    
				brsitoa(RTCtime_struct.year, (UDINT)&lstr1);
				if(brsstrlen(lstr1) == 1) brsstrcat(lstr2, "0");
				brsstrcat(lstr2, lstr1);
				brsstrcat(lstr2, "-");
				brsitoa(RTCtime_struct.month, (UDINT)&lstr1);
				if(brsstrlen(lstr1) == 1) brsstrcat(lstr2, "0");
				brsstrcat(lstr2, lstr1);
				brsstrcat(lstr2, "-");
				brsitoa(RTCtime_struct.day, (UDINT)&lstr1);
				if(brsstrlen(lstr1) == 1) brsstrcat(lstr2, "0");
				brsstrcat(lstr2, lstr1);
				brsstrcat(lstr2, " ");
				brsitoa(RTCtime_struct.hour, (UDINT)&lstr1);
				if(brsstrlen(lstr1) == 1) brsstrcat(lstr2, "0");
				brsstrcat(lstr2, lstr1);
				brsstrcat(lstr2, ":");
				brsitoa(RTCtime_struct.minute, (UDINT)&lstr1);
				if(brsstrlen(lstr1) == 1) brsstrcat(lstr2, "0");
				brsstrcat(lstr2, lstr1);
				brsstrcat(lstr2, ":");
				brsitoa(RTCtime_struct.second, (UDINT)&lstr1);
				if(brsstrlen(lstr1) == 1) brsstrcat(lstr2, "0");
				brsstrcat(lstr2, lstr1);
				brsstrcat(lstr2, ":");
				brsitoa(RTCtime_struct.millisec, (UDINT)&lstr1);
				if(brsstrlen(lstr1) == 1) brsstrcat(lstr2, "00");
				if(brsstrlen(lstr1) == 2) brsstrcat(lstr2, "0");
				brsstrcat(lstr2, lstr1);
    
				brsstrcat(lstr2, " ");
    
				if ( inst->mode == 0 )
					brsstrcat(lstr2, " -> ");
			
				if ( inst->mode == 1 )
					brsstrcat(lstr2, " <- ");
				
				brsstrcat(lstr2, " ");
				
				brsstrcpy((UDINT)&inst->internal.data, lstr2);
				brsstrcat((UDINT)&inst->internal.data, inst->pSrc);
				brsstrcat((UDINT)&inst->internal.data, (UDINT)&"\r");
    
				inst->internal.step++;
				break;
   
			case 3:
				inst->internal.FileWrite.enable = 1;
				inst->internal.FileWrite.ident = inst->internal.FileOpen.ident;
				inst->internal.FileWrite.offset = inst->internal.FileOpen.filelen;
				inst->internal.FileWrite.pSrc = (UDINT)&inst->internal.data;
				inst->internal.FileWrite.len = brsstrlen((UDINT)&inst->internal.data); 
				FileWrite(&inst->internal.FileWrite);
				if ( inst->internal.FileWrite.status == ERR_OK ) {
					inst->internal.FileWrite.enable = 0;
					inst->internal.step++;
				}
				break;

			case 4:
				inst->internal.FileClose.enable = 1;
				inst->internal.FileClose.ident = inst->internal.FileOpen.ident;
				FileClose(&inst->internal.FileClose);
				if ( inst->internal.FileClose.status == ERR_OK ) {
					inst->internal.FileClose.enable = 0;
					inst->internal.step++;
				}
				break;
   
			case 5:
				inst->done = 1;
				break;
		}
  
		inst->active = 1;
  
		if ( inst->trigger == 0 ) 
		{
			inst->internal.step = 0;
			inst->done = 0; 
		}
  
	} 
	else if ( inst->enable == 0 )
	{
		inst->internal.step = 0;
		inst->active = 0; 
		inst->done = 0;
	}
}
