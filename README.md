# Mastermind Game: Python vs Bash comparison

This is a programming exercise. The goal was to make a command prompt version of the popular game "Mastermind", written both in Python and Bash.

Comments about the programming differences (also annotated inside mastermind.sh):
* Bash has no built-in random sampler unlike Python so a hack was needed to generate the code word to be guessed.
* Bash has no alphanumeric check functions but it does have an easy way to test with regular expressions (=~).
* Bash has no easy way to convert a string into an array or to use the "in" statement on strings. Comparing letters between words thus was done with slices.
* Bash has no multidimensional array support so additional data was string-concatenated to be stored in a hack 2D-array.
* Note that functions in Bash are severely limited when it comes to input/output variables.
* Code ended up being more concise in Python.
