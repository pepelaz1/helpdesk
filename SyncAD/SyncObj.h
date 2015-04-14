#pragma once
#include "myado.h"
#include "atlstr.h"
#include "atlcoll.h"

class CSyncObj
{
protected:
	CString queries[3000];
	MyIsvrAdo	ado;
	CComBSTR  m_strUserName, m_strPassword, m_strDB;
	CAtlList<CComBSTR> groups, members;
	
    HRESULT read_sync_data( IXMLDOMNodePtr node );
    void	sync_infrastructure(IADsContainer *pCont, int &count );
	void	process_groupsOU ( LPWSTR wstrOU, HANDLE hFile, int &count );
	void	process_usersOU ( LPWSTR wstrOU, HANDLE hFile, int &count);
	void  Execute( CString sql );
	HRESULT PostToDB( int count );
public:
	CSyncObj(void);
	virtual ~CSyncObj(void);
	
	HRESULT Initialize( void );
	void SetCredentials(char	*strUserName, char *strPassword, char *strDB);
	HRESULT	 SyncronizeUsersAndGroups (void);
	HRESULT	 SyncronizeInfrastructure (void);
};
