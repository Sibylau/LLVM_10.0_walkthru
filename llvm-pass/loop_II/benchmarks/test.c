
int main()
{
  static int A[20];
  for (unsigned t = 2; t <= 20 - 1; t++)
        A[t] = A[t - 2] + A[t - 1];
  return 0;
}