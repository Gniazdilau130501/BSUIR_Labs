#include "passag.h"

class avtobus :public passag
{
protected:
	int rashod;
public:
	avtobus()
	{
		name = "�������";
		rashod = 0;
	}
	/*friend ostream& operator << (ostream& out_avt, const  avtobus& obj);
	friend istream& operator >> (istream& in_avt, avtobus& obj_avt);*/
};