int main()
{
  int A[50], B[50];
  for (unsigned t = 0; t < 50; t++)
  {
    for (unsigned i = 1; i < 50 - 1; i++)
      B[i] = 3 * (A[i-1] + A[i] + A[i + 1]);
    for (unsigned i = 1; i < 50 - 1; i++)
      A[i] = 3 * (B[i-1] + B[i] + B[i + 1]);
  }
  return 0;
}
