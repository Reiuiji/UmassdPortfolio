/*
 * Daniel Noyes
 * noyes_msgqueue,c
 * Lab 5
 */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>

#define MAX_SEND_SIZE 1024

struct mymsgbuf
{
	long mtype;    			/* type of message */
	long sender_id;			/* sender identifier */
	char msg[MAX_SEND_SIZE];	/* content of message */
};

/* Function prototypes */
int send_message(int qid, struct mymsgbuf *qbuf, long type);
int read_message(int qid, struct mymsgbuf *qbuf, long type);
int remove_queue(int qid);
int change_queue_mode(int qid, char *mode);
void usage(void);
int open_queue( key_t keyval );
int get_queue_ds( int qid, struct msqid_ds *qbuf );

int main(int argc, char *argv[])
{
	key_t key;
	int   msgqueue_id,status;
	long type;
	struct mymsgbuf qbuf;

	if(argc == 1)
		usage();

	/* Create unique key via call to ftok() */
	key = ftok("/tmp", 't');

	/* Open the queue - create if necessary */
	msgqueue_id =  open_queue(key);

	if(msgqueue_id == -1)
	{
		printf("[Error] : Unable to create/open the queue\n");
	}
	switch(tolower(argv[1][0]))
	{
		case 's': /***** send a message *****/
			type = atol(argv[2]);
			qbuf.mtype = type;
			strcpy(qbuf.msg, argv[3]);
			status = send_message(msgqueue_id, &qbuf, type);
			if(status == -1)
			{
				printf("[INFO] : Unable to send a message\n");
			}

			break;
		case 'r': /***** receive a message *****/
			type = atol(argv[2]);
			status = read_message(msgqueue_id, &qbuf, type);
			if(status != -1)
			{
				printf("[QuID: %i |SendID: %li |Type: %li ]: %s\n",msgqueue_id,qbuf.sender_id,qbuf.mtype,qbuf.msg);
			}
			else
			{
				printf("[INFO]: There is no message available at the moment\n");
			}

			break;
		case 'd': /***** remove the queue *****/
			status = remove_queue(msgqueue_id);
			if(status == -1)
			{
				printf("[INFO] : Unable to remove queue(something went wrong)\n");
			}
			break;
		case 'm': /***** change the queue mode *****/
			status = change_queue_mode(msgqueue_id, argv[2]);
			if(status == -1)
			{
				printf("[INFO] : Unable to change the permissions of the queue\n");
			} 
			break;

		default: usage();
	}

	return(0);
}

/*  The Book of Wind: open_queue ()

    Earlier today, you wanted to learn more about the book you found that created new children. Upon your observation you noticed that the book was from a library. It stated that it was from "The Library of Alexandria". In your mind you mummur, wait that library was destroyed a long time ago. After pondering on it, the writing of the library started to glow and it said "yes or no". Hesitant at first you proceeded to say Yes. The next thing you know is that your at a entrance of a huge library. Around you see only dense fog and just a heavy wooden door. 

    You lift yours hand and proceeded to bang on the door. Right when you put your hand on it, the doors opened. As you proceeded in, the doors slamed shut. The candles around you started to lit up and the only thing you can see what books upon books everywhere you can see. As you were walking you found a huge atrium right in the center. Right on one of the Desk there was a green book with what looks like a simbol for wind. As you peer in to the pages, you can see that this was home for you. You opened the book and It maraculassly fliped to a specific page. The Tombs of Travel. Upon observating you see one that was open the passage of travel, you proceeded to read it out loud and a envelope appeared right in front of you. It seems that this spell will allow you to open up a passage to anyone in the world. 

*/

int open_queue( key_t keyval )
{
	int qid;
	if((qid = msgget( keyval, IPC_CREAT | 0660 )) == -1)
	{
		return(-1);
	}
	return(qid);
}

/*The Book of Wind: send_message

  You were antious with the envelope and proceeded to write a letter and you looked at the book. The pages changed to messager of hermes, you put the letter in the envelope and red the next page and the enveloped disapeared.

*/

int send_message(int qid, struct mymsgbuf *qbuf, long type)
{
	int result, length;
	/* The length is essentially the size of the structure - sizeof(mtype) */
	length = sizeof(struct mymsgbuf) - sizeof(long)*2;
	/* Notice the type cast here!*/
	if((result = msgsnd( qid, (struct msgbuf *)qbuf, length, 0)) == -1)
		return(-1);
	return(result);
}

/*The Book of Wind: read_message
  On the next page it said "Gift from hermes". When you read it, a box apeared and a envelope poped up right in it.
  */

int read_message(int qid, struct mymsgbuf *qbuf, long type)
{
	int result, length;
	/* The length is essentially the size of the structure - sizeof(mtype) */
	length = sizeof(struct mymsgbuf) - sizeof(long)*2;
	if((result = msgrcv( qid, (struct msgbuf *)qbuf, length, type,IPC_NOWAIT)) == -1)
	{
		return(-1);
	}

	return(result);
}

/*The Book of Wind: remove_queue
  Its been a long night, after reading passages in the book, you asked the book how to stop for the night and it replied with the page "Parting ways". Upon reading the envelop and the Box both disapeared like it never happened.
  */

int remove_queue(int qid)
{
	if( msgctl( qid, IPC_RMID, 0) == -1)
	{
		return(-1);
	}
	return(0);
}

/*The Book of Wind: change_queue_mode

*/

int change_queue_mode(int qid, char *mode)
{
	struct msqid_ds tmpbuf;
	/* Retrieve a current copy of the internal data structure */
	get_queue_ds( qid, &tmpbuf);
	/* Change the permissions using an old trick */
	sscanf(mode, "%ho", &tmpbuf.msg_perm.mode);
	/* Update the internal data structure */
	if( msgctl( qid, IPC_SET, &tmpbuf) == -1)
	{
		return(-1);
	}
	return(0);
}

/*The Book of Wind: get_queue_ds

*/

int get_queue_ds( int qid, struct msqid_ds *qbuf )
{
	if( msgctl( qid, IPC_STAT, qbuf) == -1)
	{
		return(-1);
	}                                                
	return(0);
}

void usage(void)
{
	printf("USAGE:\tdnoyes_msgqueue\t(s)end  <type>  <message>\n");
	printf("\t\t\t(r)ecv  <type> \n");
	printf("\t\t\t(d)elete\n");
	printf("\t\t\t(m)ode  <mode>\n");

	exit(0);
}
