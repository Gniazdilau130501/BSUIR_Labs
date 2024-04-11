#include "Class.h"

void String::get()
{
	cout << this->str;
	cout << endl;
}

String& String::operator = (const String& other)
{
	this->size = other.size;
	this->str = new char[this->size + 1];
	strcpy_s(this->str, strlen(other.str) + 1, other.str);
	return *this;
}

bool String:: operator == (const String& other){
	return !strcmp(this->str, other.str);
}

String String::operator + (const String& other)
{
	int i = 0;
	int t = 0;
	String temp1;
	temp1.str = new char[this->size + other.size + 1];
	strcpy_s(temp1.str, strlen(this->str) + 1, this->str);
	strcat_s(temp1.str, strlen(this->str) + strlen(other.str) + 1, other.str);
	return temp1;
}

String String::operator += (const String& other)
{
	*this = *this + other;
	return *this;
}

char String::operator [](int index)
{
	char simbol;
	simbol = this->str[index];
	//this->str[index];
	return simbol;


}

char* String::operator()(int a, int b)
{
	int t = 0;
	int g = 0;
	g = a;
	char* oth = new char[b];
	while (t < b)
	{
		oth[t] = this->str[g];
		t++;
		g++;
	}
	oth[t] = '\0';
	return oth;
}