// Lab Work_003.cpp: определ€ет точку входа дл€ консольного приложени€.
//

#include "stdafx.h"
#include <stdio.h>
#include <malloc.h>
#include <conio.h>
#include <string.h>


	struct zap
	{
		char inf;
		struct zap *l;
	};



int main()
{
	char vr[20];
	char pr[20];
	zap *s;
	s = NULL; 
	
   struct zap *s1;
	printf("wedite viragenie: ");
	fflush(stdin);
	gets_s(vr);
	int i = strlen(vr)-1;
	int t = 0;
	int prt = 0;  
	   while (i >=0){
		    if (vr[i] == '*' || vr[i] == '/'){
		     	///запись

				
			      s1 = s;         // текуща€ вершина стека 
			           if ((s = (struct zap *)malloc(sizeof(struct zap))) == NULL)
			            {                // размещаем новый элемент на вершину стека
			              puts("Ќет свободной пам€ти");
				          return 0;
			            }
			      s->inf = vr[i];
			      s->l = s1;       //  указатель на предыдущий элемент стека
			      prt = 1;
			}else if ((vr[i] == '+' || vr[i] == '-') && prt == 0){
				///запись
				s1 = s;
				if ((s = (struct zap *)malloc(sizeof(struct zap))) == NULL)
				{
					puts("Ќет свободной пам€ти");
					return 0;
				}
				s->inf = vr[i];
				s->l = s1;
			}
			else if ((vr[i] == '+' || vr[i] == '-') && prt == 1){
				/////вывод
				s1 = s;           // текуща€ вершина стека 
				if (s == NULL)
				{
					puts("—тек не создан");
					return 1;
				}
				do
				{
					pr[t] = s->inf;
					s1 = s1->l;       // переход к предыдущему элементу стека
					t++;
				} while (s1 != NULL);

				/////удал
				          while (s != NULL){
			             	/*{
				         	puts("—тек пуст");
				        	return 0;
				             }*/
				  s1 = s;         // запоминаем старый указатель на вершину стека
				  s = s->l;      // передвигаем указатель на следующий элемент стека
				  free(s1);    // удал€ем элемент с вершины стека
			   }
			                                 ///запись
			                                s1 = s;
			                                if ((s = (struct zap *)malloc(sizeof(struct zap))) == NULL)
			                                {
				                            puts("Ќет свободной пам€ти");
				                            return 0;
			                                }
			                                s->inf = vr[i];
			                                s->l = s1;
											prt = 0;
		     }else{
			 pr[t] = vr[i];
			 t++;
											
		     }
		     i--; 
	     }
		/////вывод
		   s1 = s;           // текуща€ вершина стека 
	     if (s == NULL)
	    {
		puts("—тек не создан");
		return 1;
	     }
	       do
       	{
		    pr[t] = s->inf;
		    s1 = s1->l;       // переход к предыдущему элементу стека
		    t++;
	  } while (s1 != NULL);

	/////удал
	  while (s != NULL)
	  {
		  s1 = s;         // запоминаем старый указатель на вершину стека
		  s = s->l;       // передвигаем указатель на следующий элемент стека
		  free(s1);       // удал€ем элемент с вершины стека	
	  }

	////вывод строки
printf("\nOTBET:");	
for (i = t-1; i >= 0; i--){	
		printf("%c",pr[i]);
	}
	return 0;
}

