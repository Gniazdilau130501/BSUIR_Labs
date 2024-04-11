#pragma once
#include "Header.h"
class passag : public transrport
{
protected:
	int KolMest;
	int dlina;
public:
	int getKM()
	{
		return KolMest;
	}
	int getDlina()
	{
		return dlina;
	}
	void setKM()
	{
		cin >> KolMest;
	}
	void setDlina()
	{
		cin >> dlina;
	}
	passag()
	{
		KolMest = 0;
		dlina = 0;
	}
};
