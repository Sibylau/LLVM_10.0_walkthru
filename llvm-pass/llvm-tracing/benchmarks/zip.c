void zip(double *arr) {
  for (int i = 1; i < 100; i++) {
    arr[i] = arr[i-1];
  }
}