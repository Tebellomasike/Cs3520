/*Filename: Assignment.c
Author: Tebello Masike
student number: 202002500
date: 30/10/2022
purpose: Program that finds first 10 reversible prime sqaures
*/

#include<stdio.h>
#include<stdbool.h>
#include<math.h>

int reverse(int num) // iterative function that reverses digits of num 
{
	int r;             
	int reverse=0;
	while(num!=0) 
	{
		r=num%10;
		reverse= (reverse*10)+r;
		num=num/10;
	}
	return reverse;
}

bool prime_num(int num) //this function checks whether a given number is prime or not
{
	int i;
	bool isPrime=true;
	
	if(num==0 || num==1 ) //since 0 and 1 are not
	{
		isPrime=false;
	}
	
	for(i=2;i<=(num)/2;i++)
	{
		if(num%i == 0)
		{
			isPrime=false;
			break;
		}
		
	}
	return isPrime;
}

bool isPerfect(long num)//checks whether a given number is a perfect sqaure 
{
	int i;
    for(i=1; i * i <= num; i++ )
    {
        if((num % i == 0) && (num / i == i))
        {
            return 1;
        }
    }
    return 0;
}

bool not_palindrome(int num) //checks that a given is not a palindrome
{
	if(reverse(num)==num)
	{
		return false;
	}
	return true;
}




int main(){
	int count=0;
	int k,x,s,l;

	for(k=0;k>=0;k++)//checking for every number from k to infinity which is defined by the declared functions
	{
		
		int s = reverse(k); //stores the reverse of int k in s

        if(isPerfect(k) == true && isPerfect(s) == true ) //checks if k and s are perfect 
        {
            x = sqrt(k); //takes the square root of the given numbers
            l = sqrt(s);

            if(prime_num(x) == true && prime_num(l)==true)// checks if x and l are prime
            {
                if(not_palindrome(k)) //checks that k is not a palindrome
                {
                    printf("%d \n",k); //prints out k
                    count++;
                    if(count==11) //accounts for the first 10 reversibleprime sqaures
                    {
                    	break;
					}
                }

            }
        }
			
	}

	
	return 0;
}
