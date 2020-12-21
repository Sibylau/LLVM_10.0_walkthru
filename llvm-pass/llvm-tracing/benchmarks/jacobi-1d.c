int main()
{
  unsigned t, i;
  static int A[20], B[20];
  for (t = 0; t < 20; t++)
  {
    for (i = 1; i < 20 - 1; i++)
      B[i] = 3 * (A[i-1] + A[i] + A[i + 1]);
    for (i = 1; i < 20 - 1; i++)
      A[i] = 3 * (B[i-1] + B[i] + B[i + 1]);
  }
  return 0;
}
