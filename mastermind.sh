#! /usr/bin/env bash
# Mastermind Game for Bash

codeletters='ABCDEFGH'

# Bash has no built-in random sampler unlike Python so this is a hack.
shuf_letters=$(echo $codeletters | fold -w1 | shuf | tr -d '\n')
code=${shuf_letters:0:5}
guesslist=()

echo 'Try to guess the correct 5-letter code out of A, B, C, D, E, F, G, H.'
echo 'Each letter occurs only once. You have 8 attempts.'

for i in {0..7}
do
    read -p 'Please enter a guess: ' guess
    # Bash has no alphanumeric check functions but it does have
    # an easy way to test with regular expressions (=~). First, we
    # have to strip the guess word of possible letter repetitions.
    guess=$(echo $guess | fold -w1 | sort -u | tr -d '\n')
    while [[ ${#guess} != 5 || "$guess" =~ [^A-Z] ]]
    do
        echo 'Guess must consist of five unique upper-case letters.'
        read -p 'Please try again: ' guess
        guess=$(echo $guess | fold -w1 | sort -u | tr -d '\n')
    done
    if [ $guess = $code ]
    then
        echo You cracked the code!
        break
    elif [ $guess != $code ] && [ $i -eq 7 ]
    then
        echo You ran out of guesses.
        echo The correct answer was $code.
        break
    fi

    # Bash has no easy way to convert a string into an array
    # letter by letter. So instead we test the string itself letter
    # by letter.
    match1=0
    for j in {0..4}
    do
        for k in {0..4}
        do
            if [ ${code:$j:1} = ${guess:$k:1} ]
            then
                (( match1++ ))
            fi
        done
    done

    match2=0
    for l in {0..4}
    do
        if [ ${code:$l:1} = ${guess:$l:1} ]
        then
            (( match2++ ))
        fi
    done

    # Bash has no multidimensional array support so we need to 
    # concatenate the current guess with its additional data to
    # store it in the array that memorizes all guesses.
    guess+=$match1
    guess+=$match2
    guesslist+=($guess)

    echo -----GUESS--CONTAINED--EXACT-----

    # Bash has no string formatting support so the following
    # code section does not look as nice as the Python version.
    # Also note that functions in Bash are severely limited when
    # it comes to input/output variables. Writing the following
    # print section as a function in Bash wouldn't improve code.
    for index in ${!guesslist[@]}
    do
        value="${guesslist[index]}"
        echo "$(($index + 1)).   ${value:0:5}      ${value:5:1}        ${value:6:1}"
    done
done
