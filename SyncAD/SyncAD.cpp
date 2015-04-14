// SyncAD.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "SyncObj.h"

CSyncObj g_SyncObj;

BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	if ( ul_reason_for_call == DLL_PROCESS_ATTACH )
	{
		if(FAILED(g_SyncObj.Initialize()))
			return FALSE;
	}
    return TRUE;
}


extern "C"  void __stdcall SetCredentials(char *strUserName, char *strPassword, char *strDB)
{
	g_SyncObj.SetCredentials(strUserName, strPassword, strDB);
}

extern "C" void __stdcall SyncronizeUsersAndGroups( void )
{
	g_SyncObj.SyncronizeUsersAndGroups();
}
			
extern "C" void __stdcall SyncronizeInfrastructure( void )
{
	g_SyncObj.SyncronizeInfrastructure();
}
		