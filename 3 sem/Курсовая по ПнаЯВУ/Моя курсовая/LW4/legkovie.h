#pragma once
#include "Header.h"
class legkovie : public transrport
{
protected:
	string model;
	string kyzov;
public:
	legkovie()
	{
		model = "";
		kyzov = "";
	}
	string getModel()
	{
		return model;
	}
	string getKyzov()
	{
		return kyzov;
	}
};