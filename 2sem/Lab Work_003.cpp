// Lab Work_003.cpp: ���������� ����� ����� ��� ����������� ����������.
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
		     	///������

				
			      s1 = s;         // ������� ������� ����� 
			           if ((s = (struct zap *)malloc(sizeof(struct zap))) == NULL)
			            {                // ��������� ����� ������� �� ������� �����
			              puts("��� ��������� ������");
				          return 0;
			            }
			      s->inf = vr[i];
			      s->l = s1;       //  ��������� �� ���������� ������� �����
			      prt = 1;
			}else if ((vr[i] == '+' || vr[i] == '-') && prt == 0){
				///������
				s1 = s;
				if ((s = (struct zap *)malloc(sizeof(struct zap))) == NULL)
				{
					puts("��� ��������� ������");
					return 0;
				}
				s->inf = vr[i];
				s->l = s1;
			}
			else if ((vr[i] == '+' || vr[i] == '-') && prt == 1){
				/////�����
				s1 = s;           // ������� ������� ����� 
				if (s == NULL)
				{
					puts("���� �� ������");
					return 1;
				}
				do
				{
					pr[t] = s->inf;
					s1 = s1->l;       // ������� � ����������� �������� �����
					t++;
				} while (s1 != NULL);

				/////����
				          while (s != NULL){
			             	/*{
				         	puts("���� ����");
				        	return 0;
				             }*/
				  s1 = s;         // ���������� ������ ��������� �� ������� �����
				  s = s->l;      // ����������� ��������� �� ��������� ������� �����
				  free(s1);    // ������� ������� � ������� �����
			   }
			                                 ///������
			                                s1 = s;
			                                if ((s = (struct zap *)malloc(sizeof(struct zap))) == NULL)
			                                {
				                            puts("��� ��������� ������");
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
		/////�����
		   s1 = s;           // ������� ������� ����� 
	     if (s == NULL)
	    {
		puts("���� �� ������");
		return 1;
	     }
	       do
       	{
		    pr[t] = s->inf;
		    s1 = s1->l;       // ������� � ����������� �������� �����
		    t++;
	  } while (s1 != NULL);

	/////����
	  while (s != NULL)
	  {
		  s1 = s;         // ���������� ������ ��������� �� ������� �����
		  s = s->l;       // ����������� ��������� �� ��������� ������� �����
		  free(s1);       // ������� ������� � ������� �����	
	  }

	////����� ������
printf("\nOTBET:");	
for (i = t-1; i >= 0; i--){	
		printf("%c",pr[i]);
	}
	return 0;
}

