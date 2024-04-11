#pragma once
#include "Header.h"
class legkovie : public transrport
{
protected:
	char model[10];
	char kyzov[10];
public:
	legkovie()
	{
		/*model = "";
		kyzov = "";*/
	}
	char *getModel()
	{
		return model;
	}
	char *getKyzov()
	{
		return kyzov;
	}
	void setModel()
	{
		cin>> model;
	}
	void setKyzov()
	{
		cin>> kyzov;
	}
};