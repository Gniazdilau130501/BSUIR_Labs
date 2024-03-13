#include "Array.h"
using namespace std;

int main()
{
	setlocale(LC_ALL, "RUSSIAN");
	int sizek = 0, a = 0, b = 0;
	cout << "���� ������� ������ a" << endl;
	cin >> a;
	mas arr1(a);
	cout << "���� ������� ������ b" << endl;
	cin >> b;
	mas arr2(b); //�������� �������� ������
	cout << "����  �������� a:" << endl;
	arr1.add();
	cout << "����  �������� b:" << endl;
	arr2.add();
	cout << "������ a �������� ���:";
	arr1.wiv();
	cout << "������ b �������� ���:";
	arr2.wiv();
	mas arr3= arr1.peresech(arr2);
	arr3.wiv();
	return 0;
}