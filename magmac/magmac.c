/*********************************************************/
/* This file is part of magmac an interface between      */
/*                     c and magma                       */
/*                 David Lubicz CELAR                    */
/*            Copyright (C) 2006 David Lubicz            */
/*********************************************************/

/*
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "magmac.h"


struct magma_session *stop;

/* This function dump the pipe */
int dump(struct magma_session *session)
{
  int nbytes;
  char *buffer;

  buffer = (char *)malloc(SIZE_BUFFER);

  printf("Wait while dumping the pipe... \n");
  while (nbytes > 0)
    {
      nbytes = read(session->from_magma[0], buffer, SIZE_BUFFER);
      buffer[nbytes]='\0';
      printf("%s", buffer);
      fflush(NULL);
    }

  return(1);  
}

/* This function handle a SIGHUP */
static void handle_action(int signal)

{
  dump(stop);
  
  exit(0);
}

/*This function wait for magma prompt and return the output of magma in output*/
int get_magma_line(struct magma_session *session, char **output)
{
  int nbytes, i, flag, nblocks;
  char *buffer, *result;
  

  buffer = (char *)malloc(SIZE_BUFFER);
  result = (char *)malloc(SIZE_BUFFER);
  result[0]='\0';
  i=0;
  flag = 0;
  nblocks = 1;
  
  while (flag == 0)
    {
      nbytes = read(session->from_magma[0], buffer, SIZE_BUFFER);
      i = i + nbytes;
      if ((i+1) > nblocks * SIZE_BUFFER)
	{
	  nblocks = ((i+1)/SIZE_BUFFER)+1;
	  result = (char *)realloc((void *)result, nblocks * SIZE_BUFFER);

	}
      strncat(result, buffer, nbytes);


      if (result[i-1] == '\n')
	{
	  flag = 1;
	}
    }
  result[i-1]='\0';
  free(buffer);

  *output = result;
  return(1);
}

/*This function opens a new magma session*/
int magma_init(struct magma_session *session)
{
  pid_t fork_result;
  char *output;
  int execerr;
  sigset_t catch_stop;
  struct sigaction action;
  
  if ((pipe(session->to_magma)==0) && (pipe(session->from_magma)==0))
    {
      fork_result = fork();
      
      if (fork_result==-1)
	{
	  fprintf(stderr,"Fork failure");
	  return(0);
	}
    }
  else
    return(0);

  if (fork_result == 0)
    {
      close(0);
      dup(session->to_magma[0]);
      close(session->to_magma[0]);
      close(session->to_magma[1]);

      close(1);
      dup(session->from_magma[1]);
      close(session->from_magma[0]);
      close(session->from_magma[1]);
      
      execerr = execl(MAGMA_PATH,MAGMA_NAME, (char *)0);
      fprintf(stderr,"Execl failure %d \n", execerr);
    }
  else
    {
      session->magma_pid = fork_result;
      close(session->to_magma[0]);
      close(session->from_magma[1]);

      magma_cmd(session, "", &output); 
      
      sigemptyset(&catch_stop);
      sigaddset(&catch_stop, SIGHUP);
      
      action.sa_handler = &handle_action;
      action.sa_mask = catch_stop;
      sigaction(SIGHUP, &action, NULL);
      stop = session;

      return(1);
    }
  return (1);
}

/*This function close a magma session*/
void magma_close(struct magma_session *session)
{
  const char escape[] ="^D";
  int status;

  write(session->to_magma[1],&escape, 1);
  close(session->to_magma[1]);
  close(session->from_magma[0]);
  wait(&status);
}

/*This function issue a magma command*/
int magma_silent_cmd(struct magma_session *session, char *cmd)
{
  write(session->to_magma[1], cmd, strlen(cmd));
  write(session->to_magma[1], "\n", 1);
  return 1;
}

/*This function test the presence of the string fin at the end of a line*/
int test_fin(char *line)

{
  int i;
  char fin[4]="fin\0";
  size_t min,j=strlen(fin)-1;
  size_t k = strlen(line);
 
  min = (k > 5) ? 5 : k;

  if (k >= j)
    {
      for(i=k; i>= k-min; i--)
	{
	  if (line[i] == fin[j])
	    {
	      if (j == 0)
		{
		  line[i] = '\0';
		  return(1);
		}
	      j--;
	    }
	  else
	    {
	      j=strlen(fin)-1;
	    }
	}
    }
  return(0);
}

/*This function issue a magma command and get the result*/
int magma_cmd(struct magma_session *session, char *cmd, char **result)
{
  char **line;
  char *output;
  size_t taille;
  char cmd_fin[]="print \"fin\";";

  taille =0;
  line = malloc(sizeof(size_t));
  output = (char *)malloc(1);
  output[0]='\0';

  write(session->to_magma[1], cmd, strlen(cmd));
  write(session->to_magma[1], "\n", 1);
  write(session->to_magma[1], cmd_fin, strlen(cmd_fin));
  write(session->to_magma[1], "\n", 1);


  get_magma_line(session, line);

  while (test_fin(*line) == 0)
    {
      taille = taille + strlen(*line)+2;
      output = (char *)realloc(output, taille);
      strcat(output, *line);

      free(*line);
      get_magma_line(session, line);
    }

  taille = taille + strlen(*line);
  output = (char *)realloc(output, taille);
  strcat(output, *line);

  free(*line);
  free(line);
  *result = output;
  return(1);
}

/*this command return the l last lines of a string of char*/
void last_lines(char **result, int l)
{
  size_t i;
  int cmp;
  char *tmp;

  cmp = l+1;

  for (i=strlen(*result); i>0; i--)
    {
      if ((*result)[i-1]=='\n') 
	cmp--;
      if (cmp == 0)
	break;
    }
  tmp = (char *)malloc(strlen(*result)-i+1);
  strcpy(tmp, (char *)((*result)+i));
  free(*result);
  *result = tmp;
}

/* this function test if the character is an open or closing bracket */
int is_bracket(char test)
{
  if ((test == ']') || (test == ')'))
    return 1;
  if ((test == '[') || (test == '('))
    return 2;
  return 0;
}

/* this function is true if the first charater of the string is alphanumeric */
int is_alphanum(char test)
{
  if ( ((test >= '0') && (test <= '9')) || (test == '+') || (test == '-'))
    return 1;
  else return 0;
}

/* this command returns a matrix of integers */
void matrix_read(char **result, long **matrix)
{
  int flag_par, flag_num;
  int i,j,k;

  flag_par=0;
  flag_num=0;
  i = 0; j = 0;

  for(k=0; k<=strlen(*result); k++)
    {
      if ((is_bracket((*result)[k]) == 1) && flag_par == 1)
	{
	  i++;
	  j = 0;
	  flag_par = 0;
	}

      if (is_bracket((*result)[k]) == 2)
	flag_par = 1;
      
      if ( (is_alphanum((*result)[k])) && (flag_num==0) && (flag_par == 1))
	{
	  matrix[i][j]=atoi((*result)+k);
	  j++;
	}

      if (is_alphanum((*result)[k]))
	  flag_num = 1;
	  else
	  flag_num = 0;
    }
}
