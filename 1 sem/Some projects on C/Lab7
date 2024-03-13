// LabWork 7.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include <iomanip>
#include <cmath>
#include <string.h> 
using namespace std;

int main()
{
	struct strc{
		char date[40];
		char sity[7];
		int cod[4];
		double tar;
		char nums[9];
		char numab[9];
		double time;
	} msats[100];
	int nst, i;
	double sum=0;
	char St[7];
	double At = 0;
	double Pr = 0;
	cout << "Vvedite kol-vo zvonkov " << endl;
	cin >> nst;

		for (i = 0; i < nst; i++)
		{
			cout << "Vvedite daty ";
			cin >> msats[i].date;
            cout << "Vvedite gorad ";
			cin >> msats[i].sity;
			cout << "Vvedite nomer v gorade ";
			cin >> msats[i].nums;
			cout << "Vvedite nomer abonenta ";
			cin >> msats[i].numab;
			cout << "Vvedite tarif ";
			cin >> msats[i].tar;
			cout << "Vvedite time razgovora ";
			
msats[i].time = 0;
			cin >> msats[i].time;
			cout << endl;
		}
		strc stemp; {
			system("cls");
			cout << "wedite gelaemi gorod ";
			cin >> St;
			
			for (int i = 0; i < nst; i++){
				if (strcmp(St, msats[i].sity) == 0){
					
					At += msats[i].time;
					Pr += msats[i].time*msats[i].tar;
				}
			}
			
			cout << "obshee dlitelnost zvonkov - "<<At << endl;
			cout << "Oplata zvonkov = " << Pr << endl; }
	return 0;
}

