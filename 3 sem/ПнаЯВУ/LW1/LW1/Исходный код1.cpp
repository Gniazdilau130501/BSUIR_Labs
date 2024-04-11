#include "Array.h"

void mas::add()
{
	for (int i = 0; i < size; i++)
		cin >> c[i];
};

void mas::wiv()
{
	for (int i = 0; i < size; i++)
		cout << setw(4) << this->c[i];
	cout << endl;
};

mas mas::peresech( mas& oth2)
{
    int m = 0;
	if (this->size < oth2.size)
	{
		m = this->size;
	}
	else
	{
		m = oth2.size;
	}
	mas arr3(m);
	m = 0;
	for (int i = 0; i < this->size; i++)
	{
		for (int j = 0; j < oth2.size; j++)
		{
			if (this->c[i] == oth2.c[j])
			{
				arr3.c[m] = this->c[i];
				m++;
			}
		}
	}
	arr3.size = m;
	return arr3;
}