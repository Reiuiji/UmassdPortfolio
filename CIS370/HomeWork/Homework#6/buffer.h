/* buffer.h*/



typedef int buffer_item;


#define BUFFER_SIZE 5



int insert_item(buffer_item item);

int remove_item(buffer_item *item);
