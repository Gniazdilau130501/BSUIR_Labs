// Lab_Work04.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include <locale.h>

	struct Queue
	{
		char inf[20]; // информация элемента очереди
		struct Queue *next; // указатель на следующий элемент
	};
	void AddElementToQueue(struct Queue**, struct Queue**);
	void ShowQueue(struct Queue*);
	/*void DeleteFirstElement(struct Queue*, struct Queue*);*/


int main()
{

		setlocale(LC_ALL, "Russian");
		struct Queue *head, *tail; // указатели на голову и хвост очереди
		char *str;
		str = (char *)malloc(10);
		head = tail = NULL;

		////очереди создание
		while (1) // бесконечный цикл
		{
			printf("1) Добавить фамилию\n 2)Вывести инвертированный список\n 0)Выход");
				fflush(stdin);
			switch (_getch())
			{
			case '1': AddElementToQueue(&tail, &head); // добавление в хвост
				system("CLS");
				break;
			case '2': ShowQueue(tail); // вывод очереди на экран
				break;
			//case '0':DeleteFirstElement(&tail, &head); return 1; //очистка памяти(а то хули она?!)
			default:
				printf("Ошибка, повторите \n");
				system("PAUSE");
				system("CLS");
			}
		}
	return 0;
}



// Функция создания очереди
// Функция создания очереди
void AddElementToQueue(struct Queue **tail, struct Queue **head)
{ // временная переменная для добавления нового элемента в очередь
	struct Queue *temp;
	puts("Создание очереди \n");
	do
	{ // выделение памяти под temp; если память не выделилась
		if (!(temp = (struct Queue *)calloc(1, sizeof(struct Queue))))
		{
			puts("Ошибка выделения памяти");
			system("PAUSE");
			exit(0); // то завершение работы программы
		}
		puts("Введите информацию ");
		fflush(stdin);
		gets_s(temp->inf);
		if (!*tail) // если очередь ещё не создана,
			*tail = *head = temp; // то устанавливаем оба указателя (голова и хвост)
		// на единственный элемент очереди
		else // иначе, если очередь уже существует,
		{
			temp->next = *tail; // добавляем элемент в конец очереди
			*tail = temp; // устанавливаем указатель на конец очереди
		} // на последний элемент
		puts("Продолжить (y/n): ");
		fflush(stdin);
	} while (_getch() == 'y');
	puts("");
	system("PAUSE");
}



// Функция вывода содержимого очереди, начиная с хвоста
void ShowQueue(struct Queue *tail)
{
	struct Queue *ttail;
	puts("Содержимое очереди:\n");
	if (!tail) // если очередь не создана
	{
		puts("Очередь пуста");
		system("PAUSE");
		return; // выход их функции
	}
	ttail = tail;
	do
	{
		printf("\n %s", ttail->inf); // выводим на экран текущий элемент очереди
		ttail = ttail->next; // передвигаем указатель temp на следующий элемент
	} while (ttail); // пока указатель tail не дошёл до головы очереди
	puts("");
	system("PAUSE");
	
}




//// функция удаления первого элемента очереди
	void DeleteFirstElement(struct Queue **tail, struct Queue **head)
	{
	struct Queue *tempTail = *tail; // временная переменная
	if (*tail == *head) // если в очереди только один элемент
	{
		free(*head); // освобождаем выделенную под head память
		*tail = *head = NULL; // «зануляем» указатели
		return; // выходим из функции
	}
	while (tempTail->next != *head) // перемещаем указатель tempTail
		tempTail = tempTail->next; // на второй элемент очереди
	free(*head); // удаляем первый элемент очереди
	*head = tempTail; // присваиваем указателю на голову адрес второго элемента
	(*head)->next = NULL; // «зануляем» указатель на следующий элемент
	puts("Элемент удалён.\n");
	system("PAUSE");                  // перемещение указателя h на голову очереди
	DeleteFirstElement(tail, head);
}
