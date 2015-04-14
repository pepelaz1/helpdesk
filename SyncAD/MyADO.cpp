//////////////////////////
/// MyAdo.cpp
///
/// Date: 01.04.03
/// Last: 07.04.03
//////////////////////////

//#define INITGUID
///
#include "StdAfx.h"
///#include "Itog.h"
#include "MyADO.h"
#include "atlstr.h"
//#include "exc.h"


////////////////////////////////////////////////////////////////////
// конструктор
MyIsvrAdo::MyIsvrAdo()
{
	m_IsCnt= FALSE;
}


MyIsvrAdo::~MyIsvrAdo()
{
	if (m_IsCnt) {
		m_Conn->Close();
		m_Conn->Release();
	}
	CoUninitialize();
}


// Соединение
BOOL MyIsvrAdo::Connect(const char* scon)
{
	HRESULT hr;
	_bstr_t bst=scon;
	if (!scon[0]) return false;
	hr=CoCreateInstance(CLSID_Connection, NULL, CLSCTX_INPROC_SERVER, IID__Connection, (LPVOID *)&m_Conn);
	try {
		if (SUCCEEDED(m_Conn->Open(bst, _bstr_t(""), _bstr_t(""), adConnectUnspecified))) {
			m_IsCnt= TRUE;
			return TRUE;
		}
	} catch (_com_error& CoEr) {
		CString s;
		s=s+(const char*)CoEr.Source()+":\r\n"+CoEr.ErrorMessage()+"\r\n"+(const char*)CoEr.Description();
		MessageBox(NULL, s, "Ошибка подключения к БД", MB_OK);
		return FALSE;
	}
	return FALSE;
}

void MyIsvrAdo::Disconnect( void )
{
	m_Conn->Close();
	m_Conn->Release();
}


////////////////////////////////////////////////////////////////////