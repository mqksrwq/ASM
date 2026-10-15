#include <iostream>
#include <bitset>

using namespace std;

// Лабораторная работа 6

unsigned int set_even_bits(unsigned int);
unsigned int div_by_8(unsigned int);
unsigned int swap_halves(unsigned int);

int main()
{
    unsigned int x = 0;

    cout << "Input X: ";
    cin >> x;

    cout << "X              = " << bitset<32>(x) << "  " << x << endl;

    x = set_even_bits(x);
    cout << "Even bits set  = " << bitset<32>(x) << "  " << x << endl;

    x = div_by_8(x);
    cout << "Divided by 8   = " << bitset<32>(x) << "  " << x << endl;

    x = swap_halves(x);
    cout << "Halves swapped = " << bitset<32>(x) << "  " << x << endl;
}

unsigned int set_even_bits(unsigned int x)
{
    unsigned int res = 0;
    __asm
    {
        mov eax, x
        or eax, 55555555h
        mov res, eax
    }
    return res;
}

unsigned int div_by_8(unsigned int x)
{
    unsigned int res = 0;
    __asm
    {
        mov eax, x
        shr eax, 3
        mov res, eax
    }
    return res;
}

unsigned int swap_halves(unsigned int x)
{
    unsigned int res = 0;
    __asm
    {
        mov eax, x
        ror eax, 16
        mov res, eax
    }
    return res;
}
