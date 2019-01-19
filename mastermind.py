#! python3
# Mastermind Game for Python

import random

def print_guesses(list):
    print('---' + 'GUESS'.center(9, '-') + 'CONTAINED'.center(9) + 'EXACT'.center(9, '-') + '---')
    for item in list:
        print(str(list.index(item) + 1) + '. ' + ''.join(item[0:5]).center(9) + str(item[5]).center(9) + str(item[6]).center(9))

codeletters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
code = random.sample(codeletters, 5)
guesslist = []

print('Try to guess the correct 5-letter code out of A, B, C, D, E, F, G, H.')
print('Each letter occurs only once. You have 8 attempts.')

for i in range(8):
    guess = list(input('Please enter a guess: ').upper())
    while len(guess) != 5 or len(set(guess)) != 5 or not ''.join(guess).isalpha():
        print('Guess must consist of five unique letters.')
        guess = list(input('Please try again: ').upper())
    guesslist.append(guess)
    if guesslist[i] == code:
        print('You cracked the code!')
        break
    elif guesslist[i] != code and i == 7:
        print('You ran out of guesses.')
        print('The correct answer was ' + ''.join(code) + '.')
        break

    match1=0
    for guess_letter in guesslist[i]:
        if guess_letter in code:
            match1 += 1
    
    match2=0
    for j in range(len(code)):
        if guesslist[i][j] == code[j]:
            match2 += 1

    guesslist[i].extend([match1, match2])

    print_guesses(guesslist)
