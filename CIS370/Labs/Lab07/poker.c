/***********************************************************************************
*	Lab 07 - Part 2
*	lastname_poker.c
*
*	This program creates two poker players.  You (Parent process) always lose,
*	  and since this program is obviously a substitute for the Old Wild West,
*	  you can accuse your opponent of cheating...even if he isn't.
*	  If you think he is cheating, you reserve the right to shoot him.
*
*	- You (child process) should send a custom signal to the cheating player
*	    (parent process) when you catch it cheating.
*	- When the parent process is caught cheating, and receives the signal from
*	    the child, it should getShot() and the game should end.
**********************************************************************************/
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

void gotShot();

/* Structure of a single playing card */
struct playing_card{
	char value;			// Value of card: 2 - 9, J, A, etc.
	char tenValue;		// Only used if the card value = 10...can't fit in one character
	char suit[8];			// Suit of card: SPADES, DIAMONDS, etc.
};

/* Structure of a single hand = 5 playing_cards */
struct player_hand{
	struct playing_card fiveCards[5];
};

/*main*/
int main(int argc, char *argv[])
{
	struct player_hand one_hand;		// Player hand
	pid_t playerID;

	srand(ftok(".", "A"));			// Used so that every player (user) gets different deals

	while(1)
	{
		playerID = fork();			//Deal the player back in -- creates a new child process for every hand

		if(playerID < 0)
		{
			printf("Error Dealing");
			exit(1);
		}
		else if(playerID == 0)
		{
			char isCheating;
			sleep(2);			//Wait for cards to be dealt to parent process

			printf("\nThe other player beat you with those cards.\nDo you think the player is cheating? (Y/N): ");
			scanf("%c", &isCheating);

			if(isCheating == 'y' || isCheating == 'Y')	// You think the other player is cheating
			{
				/**** Send a custom signal to cheating player (Parent process) -- To be completed by you! ****/
			}
			else
				printf("Ok, you have been beaten fair and square.  This hand is over.\n");

			exit(0);
		}
		else if(playerID > 0)
		{
			int c;


			/**** Handle the cheating signal from child process -- To be completed by you! ****/


			/* Randomly generate and then print out one hand. */
			printf("\nPLAYER'S CARDS:\n");
			for(c = 0; c < 5; c++)
			{
				int cardNum = rand() % 13 + 1;
				int cardSuit = rand() % 4;

				one_hand.fiveCards[c].tenValue = '\0';

				switch(cardNum){
					case 1:
						one_hand.fiveCards[c].value = 'A';
						break;
					case 10:
						one_hand.fiveCards[c].value = 1 + '0';
						one_hand.fiveCards[c].tenValue = 0 + '0';
						break;
					case 11:
						one_hand.fiveCards[c].value = 'J';
						break;
					case 12:
						one_hand.fiveCards[c].value = 'Q';
						break;
					case 13:
						one_hand.fiveCards[c].value = 'K';
						break;
					default:
						one_hand.fiveCards[c].value = cardNum + '0';
				}

				switch(cardSuit){
					case 0:
						strcpy(one_hand.fiveCards[c].suit, "SPADES");
						break;
					case 1:
						strcpy(one_hand.fiveCards[c].suit, "HEARTS");
						break;
					case 2:
						strcpy(one_hand.fiveCards[c].suit, "CLUBS");
						break;
					default:
						strcpy(one_hand.fiveCards[c].suit, "DIAMONDS");
				}

				printf("Value = %c%c - %s\n", one_hand.fiveCards[c].value, one_hand.fiveCards[c].tenValue, one_hand.fiveCards[c].suit);
			}
			printf("Take a few seconds to look over the other player's hand!\n");
			wait(NULL);
		}

		printf("\nDealing next hand.\n");
		sleep(1);
	}

  return 0;
}

/* This method should be called when the child accuses the parent of cheating */
void gotShot()
{
	printf("\nTarnation! You caught the other player cheating and shot that yellow-belly in the gut.\nI guess you win!\n");
	exit(1);
}