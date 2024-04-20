#include <stdio.h> 
#include <stdlib.h> // for atoi
static int calls = 0;
int ackermann(int m, int n){
	calls++;
	if(m == 0) return n + 1;
	else if (m > 0 && n == 0) return ackermann(m - 1, 1);
	else if(m > 0 && n > 0) return ackermann(m-1, ackermann(m, n - 1));	
}
 
int main(int argc, char*argv[]){

	if(argc!= 3){
		fprintf(stderr, "Usage: ./%s <m> <n>", argv[0]);
		exit(EXIT_FAILURE);
	}
	int m = atoi(argv[1]);// don't use atoi in any serious program
	int n = atoi(argv[2]);// use strtol(3) instead
	printf("Result: %d \n ackermann(a, b) was called: %d times\n", ackermann(m,n), calls);

}
