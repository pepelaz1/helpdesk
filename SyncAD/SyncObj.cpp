#include "StdAfx.h"
#include ".\syncobj.h"
#include <ATLComTime.h>
#include "vc_db.h"
#include "myado.h"
#include <stdio.h>



#define LOG

char *strRussian = "абвгдеЄжзиклмнопрстуфхцчшщъ€ьэю€јЅ¬√ƒ≈®∆«» ЋћЌќѕ–—“”‘’÷„ЎўЏџ№Ёёя";


CSyncObj::CSyncObj(void)
{
	m_strUserName = "";
	m_strPassword = "";
	m_strDB = "";

	CoInitialize(NULL);
}

CSyncObj::~CSyncObj(void)
{
}

HRESULT CSyncObj::Initialize( void )
{

	/*FILE *f = fopen("SyncAD.txt","rt");
	if (!f)
		return E_FAIL;

	char buff[512];
	while (!feof(f)) 
	{
		fscanf(f,"%s",buff);
		groups.AddTail(buff);
		members.AddTail(buff);
	};
	fclose(f);
	return S_OK;*/

	HRESULT hr = S_OK;
	IXMLDOMDocumentPtr xml;
	hr = xml.CreateInstance("Msxml2.DOMDocument.3.0");
	if (FAILED(hr))
		return hr;

	_variant_t varXml("SyncAD.xml");
	VARIANT_BOOL b;
	hr = xml->load(varXml, &b);
	//hr = xml->loadXML(varXml,&b);
	if (FAILED(hr))
		return hr;
		
	if (hr == S_FALSE || b == VARIANT_FALSE)
		return E_FAIL;

	IXMLDOMNodePtr first_child = NULL;
	IXMLDOMNodePtr syncdata = NULL;
	hr = xml->get_firstChild(&first_child);
	if ( hr != S_OK)
		return E_FAIL;

	hr = first_child->get_nextSibling(&syncdata);
	if ( hr != S_OK)
		return E_FAIL;


	CComBSTR name;
	hr = syncdata->get_nodeName(&name);
	if (FAILED(hr))
		return hr;

	if (name != "syncdata")
		return E_FAIL;



	 hr = read_sync_data(syncdata);
	 if(FAILED(hr))
		 return hr;


	 first_child.Release();
	 xml.Release();
	 return S_OK;



	/*groups.AddTail(L"LDAP://OU=CDiP,OU=RMZ Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=OGM,OU=RMZ Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=RMZ Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=OGP,OU=ZRI Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=ZRI Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=HMZ Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=SZ Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=RZ Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=TEC Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=ZGES Hub,DC=atomsib,DC=ru");
	groups.AddTail(L"LDAP://OU=ZDS Hub,DC=atomsib,DC=ru");

	members.AddTail(L"LDAP://OU=CDiP,OU=RMZ Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=OGM,OU=RMZ Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=RMZ Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=OGP,OU=ZRI Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=ZRI Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=HMZ Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=SZ Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=RZ Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=TEC Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=ZGES Hub,DC=atomsib,DC=ru");
	members.AddTail(L"LDAP://OU=ZDS Hub,DC=atomsib,DC=ru");
	return S_OK;*/
}

HRESULT CSyncObj::read_sync_data( IXMLDOMNodePtr node)
{
	HRESULT hr;
	IXMLDOMNodeListPtr nodelist;
	hr = node->get_childNodes(&nodelist);
	if (FAILED(hr))
		return hr;

	nodelist->reset();

	IXMLDOMNodePtr target_node = NULL;
	CComBSTR text;
	while( nodelist->nextNode( &target_node) != S_FALSE)
	{
		target_node->get_text( &text );
		groups.AddTail( text );
		members.AddTail(text);
		target_node.Release();
	}
	return S_OK;
}




void CSyncObj::SetCredentials(char	*strUserName, char *strPassword, char *strDB)
{
	m_strUserName = strUserName;
	m_strPassword = strPassword;
	m_strDB = strDB;
}


HRESULT  CSyncObj::SyncronizeUsersAndGroups(void)
{
	USES_CONVERSION;
	int count = 0;

	HRESULT hr = S_OK;
	CComPtr<IADsContainer>pCont;
	IDispatch *pDisp=NULL;
	CComPtr< IADs>pUser;
	//CComBSTR strQuery;

#ifdef LOG
	char strErr[256];
	DWORD		dwWritten;
	HANDLE hFile = CreateFile("ads.log", GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, 0,CREATE_ALWAYS,0,0);
	if (hFile == INVALID_HANDLE_VALUE) {
		return HRESULT_FROM_WIN32( GetLastError() ) ;
	}


	// Helper variables for ADsGetLastError
	DWORD dwError = 0;
	CComBSTR strError, strProvError;
#endif

	hr = ADsGetObject( L"LDAP://OU=KU Hub,DC=atomsib,DC=ru", 
		IID_IADsContainer, 
		(void**) &pCont );


#ifdef LOG
	if (FAILED(hr)) {

		ADsGetLastError(&dwError,strError,512,strProvError,512);
		sprintf(strErr, "Failed to create Active Directory container object - %s\n",W2T(strError));
		WriteFile(hFile, strErr, (DWORD)strlen(strErr), &dwWritten,NULL);
	}
#endif 

	if (SUCCEEDED(hr))
	{
		CComPtr<IEnumVARIANT> pEnum;
		hr = ADsBuildEnumerator(pCont, &pEnum);
		if (SUCCEEDED(hr))
		{
			unsigned long lFetch = 0;
			CComVariant var;
			CComPtr<IDispatch>pDisp;

			queries[count++] = "GROUP_USERS_PACKAGE.Prepare;";
			while(SUCCEEDED(pEnum->Next(1, &var, &lFetch)) && lFetch > 0)
			{

				if (lFetch == 1)
				{
					CComPtr<IADs>pADs;
					pDisp = V_DISPATCH( &var );
					hr = pDisp.QueryInterface(&pADs);
					if (SUCCEEDED(hr))
					{
						CComBSTR	 strClass;

						hr = pADs->get_Class( &strClass );

						if (strClass == L"organizationalUnit")
						{
							CComVariant	varName, varDesc;
							CComBSTR		guid;
							pADs->Get( L"Name", &varName );
							pADs->Get( L"Description", &varDesc);
							pADs->get_GUID( &guid );

							CComBSTR		bstrDesc = varDesc.bstrVal;
							queries[count++].Format("GROUP_USERS_PACKAGE.InsertGroup('%s', '%s', '%s');", W2T(guid), W2T(varName.bstrVal), W2T(varDesc.bstrVal));
						}
						pADs.Release();
					}
				}
				var.Clear();
			}
			pEnum.Release();
		}
		pCont.Release();

		// обработка вс€ких разных подразделений ( группы )
		POSITION pos = groups.GetHeadPosition();
		CComBSTR grp;
		
		for(;pos != NULL;)
		{
			 grp = groups.GetAt( pos );
			 process_groupsOU( grp, hFile, count );
			 groups.GetNext(pos);
		}
		

		
		queries[count++] = "GROUP_USERS_PACKAGE.DeleteInactives;";
		queries[count++] = "PERSONNEL_PACKAGE.Prepare;";
		// Enumerate OUs and Users in them
		hr = ADsGetObject( L"LDAP://OU=KU Hub,DC=atomsib,DC=ru", 
			IID_IADsContainer, 
			(void**) &pCont );

#ifdef LOG
		if (FAILED(hr)) {
			ADsGetLastError(&dwError,strError,512,strProvError,512);
			sprintf(strErr, "Failed to create Active Directory container object - %s\n",W2T(strError));
			WriteFile(hFile, strErr, (DWORD)strlen(strErr), &dwWritten,NULL);
		}
#endif 
		if ( SUCCEEDED(hr))
		{
			CComPtr<IEnumVARIANT> pEnum;
			hr = ADsBuildEnumerator(pCont, &pEnum);
			if (SUCCEEDED(hr))
			{
				unsigned long lFetch = 0;
				CComVariant var;
				CComPtr<IDispatch>pDisp;

				while(SUCCEEDED(pEnum->Next(1, &var, &lFetch)) && lFetch > 0)
				{

					if (lFetch == 1)		{
						CComPtr<IADs>pADs;
						pDisp = V_DISPATCH( &var );
						hr = pDisp.QueryInterface(&pADs);
						if ( SUCCEEDED(hr))
						{
							CComBSTR		OUName;
							hr = pADs->get_Name( &OUName );
							if (SUCCEEDED(hr))
							{
								// Create AD path using current OU name
								CComBSTR		AdPath = L"LDAP://";
								AdPath.Append(OUName);
								AdPath.Append(",OU=KU Hub,DC=atomsib,DC=ru");

								// Get contaiter object for current OU
								CComPtr<IADsContainer>pOUCont;
								hr = ADsGetObject( AdPath ,
									IID_IADsContainer, 
									(void**) &pOUCont );

								CComPtr<IEnumVARIANT> pEnum2;
								hr = ADsBuildEnumerator(pCont, &pEnum2);

								if (SUCCEEDED(hr))
								{
									// Enumerate all object in OU in order to find users objects in it
									CComPtr<IEnumVARIANT> pEnumOU;
									hr = ADsBuildEnumerator(pOUCont, &pEnumOU);


									if (SUCCEEDED(hr))
									{
										unsigned long lFetch2 = 0;
										CComVariant var2;
										CComPtr<IDispatch>pDisp2;

										CComPtr<IADs>pOU;
										hr = pOUCont.QueryInterface( &pOU );
										if (SUCCEEDED(hr))
										{
											// Save GUID of UO in order to insert it later into PERSONNEL table as FK
											CComBSTR OUGuid;								
											hr = pOU->get_GUID( &OUGuid);
											if (SUCCEEDED(hr))
											{

												while(SUCCEEDED(pEnumOU->Next(1, &var2, &lFetch2)) && lFetch2 > 0)
												{
													if (lFetch2 == 1)
													{
														CComPtr<IADs>pUser;
														pDisp = V_DISPATCH( &var2);
														hr = pDisp.QueryInterface(&pUser);
														if ( SUCCEEDED(hr))
														{
															CComBSTR	 cls, name;
															hr = pUser->get_Class( &cls );
															if (SUCCEEDED(hr))
															{
																if (cls == L"user")
																{

																	CComVariant	name;
																	CComPtr<IADsUser>pUserInfo;
																	hr = pUser.QueryInterface( &pUserInfo );
																	if (SUCCEEDED(hr))
																	{
																		// Find an user, get it's attributes																
																		CComBSTR	 email, guid, desc;
																		CComVariant	phone, login, address;

																		hr = pUser->get_GUID(&guid);
																		hr = pUser->Get(L"Name", &name);
																		hr = pUserInfo->Get(L"samAccountName", &login);
																		
																		hr = pUserInfo->get_Description(&desc);
																		if (FAILED(hr)) {
																			desc = "n/a";
																		}


																		hr = pUserInfo->get_EmailAddress( &email);
																		if (FAILED(hr)) {
																			email = "n/a";
																		}
																		hr = pUserInfo->get_TelephoneNumber( &phone );
																		if (FAILED(hr)) {
																			phone = "n/a";
																		}	

																		address = "";
																		hr = pUserInfo->get_OfficeLocations( &address );
																		if (FAILED(hr) || !wcscmp(address.bstrVal,L"")) {
																			address = "n/a";
																		}	

																		char sname [256];
																		sprintf (sname,"%s", W2T(name.bstrVal));

																		if (!lstrcmp(sname, "≈рмошко ¬ера Ћеонидовна"))
																		{
																			int t = 4;
																		}
									

																		if (strchr(strRussian, sname[0])) {
																			queries[count++].Format( "PERSONNEL_PACKAGE.InsertPersonnel('%s','%s','%s','%s','%s','%s','%s','%s');",W2T(guid),W2T(name.bstrVal),
																				W2T(login.bstrVal), W2T(email), W2T(phone.bstrVal),W2T(address.bstrVal),W2T(desc),W2T(OUGuid));
																		} else {
																			if (CComBSTR(name.bstrVal) == L"helpdesk") {
																					queries[count++].Format("PERSONNEL_PACKAGE.InsertPersonnel('%s','%s','%s','%s','%s','%s','%s','%s');",W2T(guid),W2T(name.bstrVal),
																					W2T(login.bstrVal), W2T(email), W2T(phone.bstrVal),W2T(address.bstrVal),W2T(desc),W2T(OUGuid));
																			}
																		}

																		email.Empty();
																		guid.Empty();
																		phone.Clear();
																		login.Clear();
																		address.Clear();
																		desc.Empty();

																		pUserInfo.Release();
																	}
																}
																cls.Empty();
															}
														}
														var2.Clear();
													}
												}
												OUGuid.Empty();
											}
											pOU.Release();
										}
										pEnumOU.Release();
									}
									pOUCont.Release();
								}
								OUName.Empty();
							}
							pDisp.Release();
						}

					}

					var.Clear();
				}
				pEnum.Release();
			}
			pCont.Release();
		}


		// обработка вс€ких разных подразделений ( пользователи )
		pos = members.GetHeadPosition();
		CComBSTR mbrs;
		
		for(;pos != NULL;)
		{
			 mbrs = members.GetAt( pos );
			 process_usersOU( mbrs, hFile, count );
			 members.GetNext(pos);
		}

		queries[count++].Format(" PERSONNEL_PACKAGE.InsertPersonnel('%s','%s','%s','%s','%s','%s','%s','%s');",
			"0","Ќе назначен",	"нет", "нет", "нет","нет","нет","0");
		queries[count++] =" PERSONNEL_PACKAGE.DeleteInactives;";
		return PostToDB(count);
	
	}
	return hr;
}

HRESULT  CSyncObj::PostToDB( int count )
{
	USES_CONVERSION;
	int i = 0;
	try {

		CString connection_string = CString("Provider=MSDAORA;Data Source=") + W2T(m_strDB) + CString(";User ID=") +
			+ W2T(m_strUserName) + CString("; Password=")+W2T(m_strPassword); 

		BOOL b = ado.Connect(connection_string);
		if (b)
		{
			for ( i = 0; i < count; i++)
			{
				if (i == 864)
					int t = 4;
				queries[i] = CString("begin ") + queries[i] + CString(" end; ");
				Execute(queries[i]);
			}
			ado.Disconnect();
		}
	} 
	catch(...)
	{
		ado.Disconnect();
		return E_FAIL;
	}
	return S_OK;
}

void CSyncObj::Execute( CString sql )
{
	_CommandPtr cmd;
	cmd.CreateInstance(CLSID_Command);
	cmd->PutActiveConnection(ado.m_Conn);
	cmd->PutCommandText(sql.GetString());
	cmd->PutCommandType(adCmdText);
	cmd->Execute( 0, 0, -1 );	
	cmd.Release();
}


void	 CSyncObj::process_groupsOU ( LPWSTR wstrOU, HANDLE hFile, int &count )
{
	USES_CONVERSION;

	HRESULT hr = S_OK;
	DWORD dwError, dwWritten;
	WCHAR	strError[256], strProvError[256];
	TCHAR  strErr[256];
	CComPtr<IADsContainer>pCont;

	hr = ADsGetObject( wstrOU, IID_IADsContainer, (void**) &pCont );
#ifdef LOG
	if (FAILED(hr))
	{
		ADsGetLastError(&dwError,strError,512,strProvError,512);
		sprintf(strErr, "Failed to create Active Directory container object - %s\n",W2T(strError));
		WriteFile(hFile, strErr, (DWORD)strlen(strErr), &dwWritten,NULL);
	}
#endif 
	if (SUCCEEDED(hr))
	{
		CComPtr<IADs>pADs;
		hr = pCont.QueryInterface( &pADs );
		if (SUCCEEDED(hr))
		{
			CComVariant	varName, varDesc;
			CComBSTR		guid;
			pADs->Get( L"Name", &varName );
			pADs->Get( L"Description", &varDesc);
			pADs->get_GUID( &guid );

			CComBSTR		bstrDesc = (varDesc.vt == VT_EMPTY) ? L"" :varDesc.bstrVal;
			queries[count++].Format("GROUP_USERS_PACKAGE.InsertGroup('%s', '%s', '%s');\n", W2T(guid), W2T(varName.bstrVal), W2T(bstrDesc));
		}
		pCont.Release();
	}
}

void	 CSyncObj::process_usersOU ( LPWSTR wstrOU, HANDLE hFile, int &count )
{
	USES_CONVERSION;

	HRESULT hr = S_OK;
	DWORD dwError, dwWritten;
	WCHAR	strError[256], strProvError[256];
	TCHAR  strErr[256];
	CComPtr<IADsContainer>pCont;
	CComPtr<IDispatch>pDisp;


	hr = ADsGetObject(wstrOU, IID_IADsContainer, (void**) &pCont );

#ifdef LOG
	if (FAILED(hr)) {
		ADsGetLastError(&dwError,strError,512,strProvError,512);
		sprintf(strErr, "Failed to create Active Directory container object - %s\n",W2T(strError));
		WriteFile(hFile, strErr, (DWORD)strlen(strErr), &dwWritten,NULL);
	}
#endif 
	if ( SUCCEEDED(hr))
	{

		CComPtr<IEnumVARIANT> pEnum2;
		hr = ADsBuildEnumerator(pCont, &pEnum2);

		if (SUCCEEDED(hr))
		{
			// Enumerate all object in OU in order to find users objects in it
			CComPtr<IEnumVARIANT> pEnumOU;
			hr = ADsBuildEnumerator(pCont, &pEnumOU);


			if (SUCCEEDED(hr))
			{
				unsigned long lFetch2 = 0;
				CComVariant var2;
				CComPtr<IDispatch>pDisp2;

				CComPtr<IADs>pOU;
				hr = pCont.QueryInterface( &pOU );
				if (SUCCEEDED(hr))
				{
					// Save GUID of UO in order to insert it later into PERSONNEL table as FK
					CComBSTR OUGuid;								
					hr = pOU->get_GUID( &OUGuid);
					if (SUCCEEDED(hr))
					{

						while(SUCCEEDED(pEnumOU->Next(1, &var2, &lFetch2)) && lFetch2 > 0)
						{
							if (lFetch2 == 1)
							{
								CComPtr<IADs>pUser;
								pDisp = V_DISPATCH( &var2);
								hr = pDisp.QueryInterface(&pUser);
								if ( SUCCEEDED(hr))
								{
									CComBSTR	 cls, name;
									hr = pUser->get_Class( &cls );
									if (SUCCEEDED(hr))
									{
										if (cls == L"user")
										{

											CComVariant	name;
											CComPtr<IADsUser>pUserInfo;
											hr = pUser.QueryInterface( &pUserInfo );
											if (SUCCEEDED(hr))
											{
												// Find an user, get it's attributes																
												CComBSTR	 email, guid, desc;
												CComVariant	phone, login, address;

												hr = pUser->get_GUID(&guid);
												hr = pUser->Get(L"Name", &name);

												hr = pUserInfo->Get(L"samAccountName", &login);

												hr = pUserInfo->get_Description( &desc);
												if (FAILED(hr)) {
													desc = "n/a";
												}
											
												hr = pUserInfo->get_EmailAddress( &email);
												if (FAILED(hr)) {
													email = "n/a";
												}
												hr = pUserInfo->get_TelephoneNumber( &phone );
												if (FAILED(hr)) {
													phone = "n/a";
												}	

												address = "";
												hr = pUserInfo->get_OfficeLocations( &address );
												if (FAILED(hr) || !wcscmp(address.bstrVal,L"") ) {
													address = "n/a";
												}	
												
												char sname [256];
												sprintf (sname,"%s", W2T(name.bstrVal));

												if (strchr(strRussian, sname[0])) {
										//			char s[512];
										//			sprintf (s, " PERSONNEL_PACKAGE.InsertPersonnel('%s','%s','%s','%s','%s','%s','%s','%s');\n",W2T(guid),W2T(name.bstrVal),
										//				W2T(login.bstrVal), W2T(email), W2T(phone.bstrVal),W2T(address.bstrVal),W2T(desc), W2T(OUGuid));
										//			strQuery.Append(s);
													queries[count++].Format("PERSONNEL_PACKAGE.InsertPersonnel('%s','%s','%s','%s','%s','%s','%s','%s');\n",W2T(guid),W2T(name.bstrVal),
														W2T(login.bstrVal), W2T(email), W2T(phone.bstrVal),W2T(address.bstrVal),W2T(desc), W2T(OUGuid));
												} else {
													if (CComBSTR(name.bstrVal) == L"helpdesk") {
												//		char s[512];
												//		sprintf (s, " PERSONNEL_PACKAGE.InsertPersonnel('%s','%s','%s','%s','%s','%s','%s','%s');\n",W2T(guid),W2T(name.bstrVal),
												//			W2T(login.bstrVal), W2T(email), W2T(phone.bstrVal),W2T(address.bstrVal),W2T(desc), W2T(OUGuid));
												//		strQuery.Append(s);
														queries[count++].Format("PERSONNEL_PACKAGE.InsertPersonnel('%s','%s','%s','%s','%s','%s','%s','%s');\n",W2T(guid),W2T(name.bstrVal),
															W2T(login.bstrVal), W2T(email), W2T(phone.bstrVal),W2T(address.bstrVal),W2T(desc), W2T(OUGuid));
													}
												}

												email.Empty();
												guid.Empty();
												desc.Empty();
												phone.Clear();
												login.Clear();
												address.Clear();

												pUserInfo.Release();
											}
										}
										cls.Empty();
									}
								}
								var2.Clear();
							}
						}
						OUGuid.Empty();
					}
					pOU.Release();
				}
				pEnumOU.Release();
			}
			pCont.Release();
		}
	}
}


void	CSyncObj::sync_infrastructure(IADsContainer *pCont, int &count )
{
	USES_CONVERSION;
	HRESULT hr = S_OK;
	
	CComPtr<IEnumVARIANT> pEnum;
	hr = ADsBuildEnumerator(pCont, &pEnum);
	if (SUCCEEDED(hr))
	{
		unsigned long lFetch = 0;
		CComVariant var;
		CComPtr<IDispatch>pDisp;

		while(SUCCEEDED(pEnum->Next(1, &var, &lFetch)) && lFetch > 0)
		{
			if (lFetch == 1)
			{
				CComPtr<IADs>pADs;
				pDisp = V_DISPATCH( &var );
				hr = pDisp.QueryInterface(&pADs);
				if (SUCCEEDED(hr))
				{
					CComBSTR	 strClass, strName, strGuid;
					CComVariant varName;
	   				hr = pADs->get_Class( &strClass );
					hr = pADs->get_GUID( &strGuid );
					hr=  pADs->Get(L"Name", &varName);

					if ( (strClass == L"organizationalUnit") || (strClass == L"container"))
					{
					   CComPtr<IADsContainer> pCont2;
					   hr = pADs.QueryInterface( &pCont2 );
					   if (SUCCEEDED(hr))
					   {
						   sync_infrastructure( pCont2,  count );
					   }
					}
					else if ( strClass == L"computer")
					{
						queries[count++].Format("INFRASTRUCTURE_PACKAGE.InsertInfrastructure('%s','%s','%s','%s');\n",W2T(strGuid),W2T(varName.bstrVal),"", "");
					}
					pADs.Release();
				}
			}
			var.Clear();
		}
		pEnum.Release();

	}
}

HRESULT	 CSyncObj::SyncronizeInfrastructure(void)
{
	USES_CONVERSION;

	int count = 0;
	HRESULT hr = S_OK;
	CComPtr<IADsContainer>pCont;
	IDispatch *pDisp=NULL;
	CComPtr< IADs>pUser;

	COleDateTime tCurrent = COleDateTime::GetCurrentTime();
	CString	strCurrDate = tCurrent.Format("%d.%m.%Y");

#ifdef LOG
	char strErr[256];
	DWORD		dwWritten;
	HANDLE hFile = CreateFile("ads.log", GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, 0,CREATE_ALWAYS,0,0);
	if (hFile == INVALID_HANDLE_VALUE) {
		return HRESULT_FROM_WIN32( GetLastError() ) ;
	}

	// Helper variables for ADsGetLastError
	DWORD dwError = 0;
	CComBSTR strError, strProvError;
#endif

	hr = ADsGetObject( L"LDAP://DC=atomsib,DC=ru", 
		IID_IADsContainer, 
		(void**) &pCont );


#ifdef LOG
	if (FAILED(hr)) 
	{
		ADsGetLastError(&dwError,strError,512,strProvError,512);
		sprintf(strErr, "Failed to create Active Directory container object - %s\n",W2T(strError));
		WriteFile(hFile, strErr, (DWORD)strlen(strErr), &dwWritten,NULL);
	}
#endif 

	if (SUCCEEDED(hr))
	{
		queries[count++] = "INFRASTRUCTURE_PACKAGE.Prepare;";
		sync_infrastructure( pCont, count );
		queries[count++].Format("INFRASTRUCTURE_PACKAGE.InsertInfrastructure('%s','%s','%s','%s');\n","0","Ќеизвестен","", "");
		queries[count++]  = "INFRASTRUCTURE_PACKAGE.DeleteInactives;";
		return PostToDB( count );
	}
	return hr;
}
