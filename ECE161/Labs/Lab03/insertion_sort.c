void InsertionSort(int numbers[], int array_size)
{
/*
This is a typical function that sorts the array of integers called numbers into ascending order
using the "Insertion Sort" algorithm. The number of integers in the array is in array_size.
*/
  int i, j, index;

  for (i=1; i < array_size; i++)
  {
    index = numbers[i];
    j = i;
    while ((j > 0) && (numbers[j-1] > index))
    {
      numbers[j] = numbers[j-1];
      j = j - 1;
    }
    numbers[j] = index;
  }
}

