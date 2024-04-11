#pragma once
#include <iostream>
#include<iomanip>
using namespace std;


class mas
{ //����� ���������� ������ � ������ �������

private:
	int* c;
	int size;
public:
	mas(int n=0)
	{
		this->size = n;
		c = new int[size];
		for (int i = 0; i < size; i++)
			this->c[i] = 0;
	}
	mas(const mas& other)
	{
		this->size = other.size;
		this->c = new int[this->size];
		for (int i = 0; i < this->size; i++)
			this->c[i] = other.c[i];
	}
	~mas()
	{
		delete[] c;
	}
	//������ ������
	void add();			//������������� ������� � �������
	void wiv();			//����� ������� �������
	mas peresech( mas& oth2);
};