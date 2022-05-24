#include <stdio.h>
#include <math.h>
float f(float x0)
{
    return 4*x0+4*x0*x0+x0*x0*x0;
}

int main()
{
    float a=-5;
    float b=1;
    float x0=(a+b)/2;
    int  eps=(int)log2((b-a)/0.000001);
    printf("\n%d",eps);
    float xaprox;
    for(int k=0; k<eps; k++)
    {
        if(f(x0)==0)
        {
           xaprox=x0;
           break; 
        }
        else{
            if((f(a)*f(x0))<0)
                {
                    b=x0;
                    x0=(a+b)/2;
                }
                else{
                    if(f(a)*f(x0)>0)
                    {
                        a=x0;
                        x0=(a+b)/2;
                    }
                }
        }
        xaprox=x0;
    }
    printf("\nSol: %f",xaprox);
    return 0;
}
