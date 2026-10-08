#include <iostream>
#include <string>
#include <cstdlib>

using namespace std;

void get_result(int*, int*, int);

int main()
{
    string line;

    while (true)
    {
        cout << "Input array length (empty line to exit): ";

        if (!getline(cin, line) || line.empty())
        {
            break;
        }

        int n = atoi(line.c_str());

        if (n <= 0)
        {
            cout << "Length must be a positive number" << endl << endl;
            continue;
        }

        int* array = new int[n];
        int* result = new int[n];

        cout << "Input array elements:" << endl;
        for (int i = 0; i < n; i++)
        {
            cout << "array[" << i << "] = ";
            getline(cin, line);
            array[i] = atoi(line.c_str());
        }

        get_result(array, result, n);

        cout << "Result: ";
        for (int i = 0; i < n; i++)
        {
            cout << result[i] << " ";
        }
        cout << endl << endl;

        delete[] array;
        array = nullptr;

        delete[] result;
        result = nullptr;
    }
}

void get_result(int* array, int* result, int n)
{
    __asm
    {
        mov esi, [array]
        mov edi, [result]
        mov ecx, n

        mov edx, ecx
        dec edx
        shl edx, 2

        lp:
            mov eax, [esi]
            mov [edi + edx], eax
            add esi, 4
            sub edx, 4
            loop lp
    }
}
