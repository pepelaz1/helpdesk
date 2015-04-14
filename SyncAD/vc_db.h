#ifndef CHEMIC_VC_DB_INCLUDED
#define CHEMIC_VC_DB_INCLUDED 1

#include <comdef.h>
#import "C:\Program Files\Common Files\System\ADO\msado15.dll" no_namespace named_guids rename("BOF","BoF") rename("EOF","EoF")
#import "C:\Program Files\Common Files\System\ADO\msadox.dll" named_guids rename("Properties","XProperties") rename("Property","XProperty") rename("_DynaCollection","XDynaCollection") rename("_Collection","XCollection")

#define VARIANT_FIELD(v,n) _variant_t v((short)(n-1));

#define BEGIN_COM_SAFE_BLOCK try{
#define END_COM_SAFE_BLOCK }catch(_com_error& CoMeRrOr){Check(CoMeRrOr);}
#define END_COM_SAFE_BLOCK_C(c) }catch(_com_error& CoMeRrOr){c.Check(CoMeRrOr);}
#define END_COM_SAFE_BLOCK_PC(pc) }catch(_com_error& CoMeRrOr){pc->Check(CoMeRrOr);}

extern variant_t NullVariant;

#endif