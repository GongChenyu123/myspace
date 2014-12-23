#include<stdio.h>
#include<sys/types.h>
#include<unistd.h>
#include<sys/ipc.h>
#include<sys/shm.h>
#define SIZE 1024
#define KEY 99
int shmid;
int j=5;


int main(){

pid_t pid;
int i,*pint;
char *addr;
i=10;

shmid=shmget(SIZE,KEY,IPC_CREAT|0777);


pint=shmat(shmid,0,0);
*pint=100;

printf("start of fork testing\n\n");

pid=fork();//创建子进程
i++;j++;*pint+=1;

printf("return of fork success:pid=%d\n\n",pid);
printf("i=%d\tj=%d\n\n",i,j);
printf("pint=%d\n",*pint);

return 0;

}
