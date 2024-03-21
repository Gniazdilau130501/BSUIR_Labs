#pragma once
#include "Header.h"
class avtobusi : public transrport
{
protected:
	int KolMest;
	string toplivo;
public:
	avtobusi()
	{
		KolMest = 0;
		toplivo = "";
	}
	int getKM()
	{
		return KolMest;
	}
	string getToplivo()
	{
		return toplivo;
	}
};