#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "delays.h"
#include "process.h"

int main(void)
{
  printf("Before the fork: PID = %d, PPID = %d\n", getpid(), getppid());

  pid_t ret = pfork();
  if (ret == 0)
  {
    // 2 falhas neste programa:
    // 1o erro - chamar o execl em vez do pexecl:
        // o que é que aconteceria se falhasse?     procurar man 2 execve (mesmo que execl ig)
        // procurar por /return (2o next)
        // "On  success, execve() does not return, on error -1 is returned, and er‐
        // rno is set to indicate the error."
    // 2o erro - como é que com o exec associo ao novo programa?
        // o "./child" tem de ser um caminho no sistema operativo e tem de ser um programa

    execl("./child", "./child", NULL);
    // pexecl("./child", "./child", NULL);
    printf("why doesn't this message show up?\n");
    return EXIT_FAILURE;
  }
  else
  {
    //pwait(NULL);
    printf("I'm the parent: PID = %d, PPID = %d\n", getpid(), getppid());
    usleep(1000);
  }

  return EXIT_SUCCESS;
}
