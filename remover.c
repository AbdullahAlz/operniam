#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX_LINE  8192

static void die(char* msg){
	perror(msg);
	exit(EXIT_FAILURE);
	
}
int main(int argc, char * argv[]){
	if (argc < 3){
		fprintf(stderr, " Usage: ./%s <PathToFile> <String s> \n For each line in file: a<s>b -> b\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	if(access("result.txt", F_OK) != -1){ 
		int c = 0;
		while(c != 'y'){
			fprintf(stdout, "result.txt exists already; [y] to turnicate, [n] to exit\n");
			c = getchar();
			if(c == 'n'){
				exit(EXIT_SUCCESS);
			}
		}
	}
	FILE* fp = fopen(argv[1], "r");
	FILE* resultFile = fopen("result.txt", "w");
	if(resultFile == NULL || fp == NULL){
		die("fopen");
	}
	char line[MAX_LINE];
	while(fgets(line, sizeof(line), fp) != NULL){
		char* position = NULL;
		char* iter = line;
		while((iter = strstr(iter, argv[2])) != NULL){
			position = iter;
			iter++;
		}
		if(position != NULL){
			fprintf(resultFile, "%s", position + strlen(argv[2]));
		}else{
			fprintf(resultFile, "%s", line);
		}
	}
	fclose(fp);
	fclose(resultFile);
	exit(EXIT_SUCCESS);
	
}
