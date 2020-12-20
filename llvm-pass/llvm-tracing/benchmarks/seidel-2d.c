
int main()
{
  unsigned t, i, j;
  static int A[20][20];
  for (unsigned t = 0; t <= 20 - 1; t++)
    for (unsigned i = 1; i<= 20 - 2; i++)
      for (unsigned j = 1; j <= 20 - 2; j++)
	A[i][j] = (A[i-1][j-1] + A[i-1][j] + A[i-1][j+1]
		   + A[i][j-1] + A[i][j] + A[i][j+1]
		   + A[i+1][j-1] + A[i+1][j] + A[i+1][j+1])/9;
  return 0;
}