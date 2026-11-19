#include <iostream>

int main() {
    int* p = new int(5);                 // allocate one int on the heap, initialised with 5
    *p += 1;
    std::cout << *p << "\n";
    delete p;                            // give the memory back
    p = nullptr;                         // good habit: no dangling pointer left

    int n;
    std::cin >> n;
    int* a = new int[n];                 // an array whose size is known only at run time
    for (int i = 0; i < n; ++i) a[i] = i * i;
    long sum = 0;
    for (int i = 0; i < n; ++i) sum += a[i];
    std::cout << "sum of the first " << n << " squares (from 0) = " << sum << "\n";
    delete[] a;                          // arrays are released with delete[]
    return 0;
}
