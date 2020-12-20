
int main()
{
  unsigned t, i, j;
  int A[20][20][20];
  int B[20][20][20];
  for (unsigned i = 1; i < 20-1; i++) {
    for (unsigned j = 1; j < 20-1; j++) {
        for (unsigned k = 1; k < 20-1; k++) {
            B[i][j][k] =   12 * (A[i+1][j][k] - 2 * A[i][j][k] + A[i-1][j][k])
                + 2 * (A[i][j+1][k] - 2 * A[i][j][k] + A[i][j-1][k])
                + 2 * (A[i][j][k+1] - 2 * A[i][j][k] + A[i][j][k-1])
                + A[i][j][k];
        }
    }
}
  return 0;
}