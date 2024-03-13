// towrs of hanoi.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <stdio.h>

// C recursive function to solve tower of hanoi puzzle
void towerOfHanoi(int n, char nach, char kon, char vspom)
{
	if (n == 1)
	{
		printf("\n Move disk 1 from rod %c to rod %c", nach, kon);
		return;
	}
	towerOfHanoi(n - 1, nach, vspom, kon);
	printf("\n Move disk %d from rod %c to rod %c", n, nach, kon);
	towerOfHanoi(n - 1, vspom, kon, nach);
}

int main()
{
	int n; // количество дисков
	printf("enter the number of disks -");
	scanf_s("%d",&n);
	towerOfHanoi(n, 'A', 'C', 'B');  //  A, B и C условные названия осей
		return 0;
}

