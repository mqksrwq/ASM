#include <iostream>
#include <string>

using namespace std;

// Лабораторная работа 5

void get_result(char*, char*, char*);

int main()
{
    const size_t max_length = 1000;
    char* input = new char[max_length];
    char* letters = new char[max_length];
    char* digits = new char[max_length];

    cout << "Input string S of letters and digits: ";
    cin.getline(input, max_length);

    get_result(input, letters, digits);

    cout << "S1 (letters): " << letters << endl;
    cout << "S2 (digits):  " << digits << endl;

    delete[] input;
    input = nullptr;

    delete[] letters;
    letters = nullptr;

    delete[] digits;
    digits = nullptr;
}

void get_result(char* input, char* letters, char* digits)
{
    const size_t len = strlen(input);
    __asm
    {
        mov esi, input
        mov edi, letters
        mov ebx, digits

        mov ecx, len
        cmp ecx, 0
        je finish

        copy_loop:
            lodsb
            cmp al, '0'
            jb skip_char
            cmp al, '9'
            jbe is_digit
            cmp al, 'A'
            jb skip_char
            cmp al, 'Z'
            jbe is_letter
            cmp al, 'a'
            jb skip_char
            cmp al, 'z'
            ja skip_char

        is_letter:
            stosb
            jmp skip_char

        is_digit:
            mov [ebx], al
            inc ebx

        skip_char:
            loop copy_loop

        finish:
            mov byte ptr[edi], 0
            mov byte ptr[ebx], 0
    }
}
