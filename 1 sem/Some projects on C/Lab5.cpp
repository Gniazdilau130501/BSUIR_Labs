// Lab Work 5.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include "stdafx.h"
#include <iomanip>
#include <cmath>
using namespace std;


int main()
{
	setlocale(LC_ALL, "RUSSIAN");

	int m=0;
	int row;
	int col;
	puts( "Введите количество строк матрицы");
	scanf_s("%d", row);
	cout << "Введите количество столбцов матрицы" << endl;
	scanf_s("%d", col);
	cout << endl;
	int **arr = new int*[row];
	for (int i = 0; i < row; i++)
	{
		arr[i] = new int[col];
	}
////////////////////////создание указателя на массив содержащий указатели на другие массивы
	
	
	for (int i = 0; i < row; i++){
		for (int j = 0; j < col; j++){
			arr[i][j] = rand() % 20;
		}
	}
///////////////////////заполнение массива
	
	
	for (int i = 0; i < row; i++){
		for (int j = 0; j < col; j++){
			printf("%d\t", arr[i][j]);
			//cout << arr[i][j] << "\t";
		}
		printf("\t");
		//cout << endl;
	}
	printf("\t"); 
	//cout << endl;
////////////////////////вывод массива
	
	
	for (int i = 0; i < row; i++){
		for (int j = 0; j < col; j++){
			if (arr[i][j]> arr[i][j - 1])
				if (arr[i][j] < arr[i][j + 1]){
					printf("Особое число - %d\n", arr[i][j]);
					//cout << arr[i][j] << "   - Особое число" << endl;
					m += 1;
				}
		}
	}
	printf("Особых элементов - %d\n", m);
	//cout << endl << m << " особых элементов в данной матрице" << endl;
////////////////////////определение особого числа в матрице
	
	
	for (int i = 0; i < row; i++){
		delete[] arr[i];
	}
	delete[] arr;
}
///////////////////////очистка данных массива для избежания утечки памяти

