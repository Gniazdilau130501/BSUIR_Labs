#include <iostream>
#include <string>
#include <locale>
using namespace std;
class String
{
private:
	int size;
	char* str;
public:
	String( char* strok="")
	{
		size = strlen(strok);
		this->str = new char[size + 1];
		strcpy_s(str, size+1, strok);
	
	}
	String(const String& other)                                 //конструктор копирования 
	{
		this->size = strlen(other.str);                        
		this->str = new char[this->size+1];
		strcpy_s(this->str, strlen(other.str)+1, other.str);
	}

	 ~String()
	{
		delete[] str;
	}

	String& operator = (const String& other);                     //перегрузки
	bool operator == (const String& other);
	String operator + (const String& other);
	String operator += (const String& other);
	char operator [](int index);
	char* operator()(int a, int b);
	void get();
};