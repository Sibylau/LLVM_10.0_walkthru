int main()
{
  int t, i, j;
  int A[20][20], B[20][20];
  for (t = 0; t < 100; t++)
  {
    for (i = 1; i < 20 - 1; i++)
    	for (j = 1; j < 20 - 1; j++)
    	  B[i][j] = 0.2 * (A[i][j] + A[i][j-1] + A[i][1+j] + A[1+i][j] + A[i-1][j]);
    for (i = 1; i < 20 - 1; i++)
    	for (j = 1; j < 20 - 1; j++)
    	  A[i][j] = 0.2* (B[i][j] + B[i][j-1] + B[i][1+j] + B[1+i][j] + B[i-1][j]);
  }
  return 0;
}
