#include <stdio.h>
#include <string.h>

int checkInput(char str[]){
    int i = 0;

    while (str[i] != '\0')
    {
        if(str[i] < 97 || str[i] > 122)
            return 0;
        i++;
    }
    return 1;
}

int countCharacter(char str[]){
    int count=0, i=0, j, check;

    while(str[i] != '\0'){
        check = 1;
        for (j = 0; j < i; j++){
            if(str[j] == str[i])
            {
                check = 0;
                break;
            }
        }

        if(check == 1)
            count++;

        i++;
    }

    return count;
}

int main(){
    char str[99];

    do{
        printf("Enter a string: ");
        gets(str);
        if(checkInput(str) == 0)
            printf("Invalid string ! Please enter again\n");

    } while (checkInput(str) != 1);

    printf("Number of different character: %d\n", countCharacter(str));
}
