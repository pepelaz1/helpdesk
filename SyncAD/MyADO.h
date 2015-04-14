//////////////////////////
/// MyAdo.h
///
/// Date: 01.04.03
/// Last: 06.06.03
//////////////////////////
#pragma once
#include "vc_db.h"


class MyIsvrAdo
{
public:
	MyIsvrAdo();
	~MyIsvrAdo();
	BOOL Connect(const char*);			// Установка соединения
	void Disconnect( void );
	_Connection	*m_Conn;				// Connection
private:
	BOOL	m_IsCnt;
};


////////////////////////////////////////////////////////////////////