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

#define MAGMA_PATH "/usr/local/bin/magma"
#define MAGMA_NAME "magma"
#define SIZE_BUFFER 1024

struct magma_session
{
  int to_magma[2];
  int from_magma[2];
  int magma_pid;
};

/*This function opens a new magma session*/
extern int magma_init(struct magma_session *session);

/*This function close a magma session*/
extern void magma_close(struct magma_session *session);

/*This function issue a magma command*/
extern int magma_silent_cmd(struct magma_session *session, char *cmd);

/*This function issue a magma command and get the result*/
extern int magma_cmd(struct magma_session *session, char *cmd, char **result);

/*this command return the l last lines of a string of char*/
extern void last_lines(char **result, int l);

/* this function test if the character is an open or closing bracket */
extern int is_bracket(char test);

/* this function is true if the first charater of the string is alphanumeric */
extern int is_alphanum(char test);

/* this command return a matrix of integer */
extern void matrix_read(char **result, long **matrix);
