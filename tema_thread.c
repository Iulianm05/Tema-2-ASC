#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
// intervalul [a,b] in care se cauta solutia.
float a=-1;
float b=1;
float x0;
int  eps;
void *print_message_function(void *ptr);
float f(float xk);

int main()
{
pthread_t thread1, thread2;
x0=(a+b)/2;
eps=(int)log2((b-a)/0.001);
const char *message1 = "Executie Thread 1";
const char *message2 = "Executie Thread 2";

int iret1, iret2;
iret1 = pthread_create( &thread1, NULL, print_message_function, (void*) message1);

if(iret1)
{
fprintf(stderr,"Eroare - pthread_create() : %d\n",iret1);
exit(EXIT_FAILURE);
}
iret2 = pthread_create( &thread2, NULL, print_message_function, (void*) message2);
if(iret2)
{
fprintf(stderr,"Eroare - pthread_create() : %d\n",iret2);
exit(EXIT_FAILURE);
}

printf("Rezultat pthread_create() : %d\n",iret1);
printf("Rezultat pthread_create() : %d\n",iret2);

/* se asteapta completarea instructinilor din cele doua threaduri */
pthread_join( thread1, NULL);
pthread_join( thread2, NULL);

printf("Terminare thread!\nsolutia este %lf\n",x0);
return 0;
}

void *print_message_function(void *ptr)
{
char *message;
char *mesajthread1="Executie Thread 1";
message = (char *) ptr;
//printf("%s \n", message);
sleep(1);
for(int i=0; i<eps; i++)
{if (strcmp(message,mesajthread1)==0)
{
printf("Executie thread 1#\n");
// subprogram pentru thread 1
   if(f(x0)==0)
        {
           break; 
        }
        else{
            if((f(a)*f(x0))<0)
                {
                    b=x0;
                    x0=(a+b)/2;
                }

}}
else
{
printf("Executie thread 2#\n");
//subprogram pentru thread 2
if(f(a)*f(x0)>0)
{
    a=x0;
    x0=(a+b)/2;
}
}
}
}

float f(float xk)
{
    return 4*xk+4*xk*xk+xk*xk*xk;
}


