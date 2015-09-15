//
//  KarateChop.swift
//  
//
//  Created by Kristina Sontag on 9/14/15.
//
//

import Cocoa

/* http://codekata.com/kata/kata02-karate-chop/
*  Specification:
*  Write a binary chop method that takes an integer search target and a sorted array of integers. It should return the integer index of the target in the array,
*  or -1 if the target is not in the array. The signature will logically be:
*      chop(int, array_of_int)  -> int
*  You can assume that the array has less than 100,000 elements. For the purposes of this Kata, time and memory performance are not issues (assuming the chop
*  terminates before you get bored and kill it, and that you have enough RAM to run it).
*
*  Basic pseudocode from Khan Academy
*  1) Let min = 0 and max = n-1
*  2) If max < min, then stop: target is not present in array. Return -1.
*  3) Compute guess as the average of max and min, rounded down (so that it is an integer).
*  4) If array[guess] equals target, then stop. You found it! Return guess.
*  5) If the guess was too low, that is, array[guess] < target, then set min = guess + 1.  //<-- these next two are basically trimming the array we're handing on to the next iteration
*  6) Otherwise, the guess was too high. Set max = guess - 1.
*  7) Go back to step 2. //<-- screams recursion!
*/

// super basic not very Swifty binary chop
// accepts an int to search for and an array of ints to search in
// (has a bonus sort for my benefit)
// returns the index of the matching int in the array
// DOESN'T HANDLE DUPLICATE NUMBERS IN THE ARRAY
func binaryChop(target: Int, numbers: [Int]) -> Int
{
    /*
    let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37,
    41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
    */
    
    // threw a sort in here so I could remember the trick of it for later
    numbers.sort {
        return $0 < $1
    }
    
    var max = numbers.count - 1
    var min = 0
    var guess = Int(floor(Double((max + min) / 2)))
    
    while (max >= min)
    {
        guess = Int(floor(Double((max + min) / 2)))
        if (numbers[guess] == target) {
            return guess
        } else if (numbers[guess] > target) {
            max = guess - 1
        } else {
            min = guess + 1
        }
    }
    return -1
}

assert(binaryChop(3, numbers: []) == -1)
assert(binaryChop(3, numbers: [1]) == -1)
assert(binaryChop(1, numbers: [1]) == 0)

assert(binaryChop(1, numbers: [1, 3, 5]) == 0)
assert(binaryChop(3, numbers: [1, 3, 5]) == 1)
assert(binaryChop(5, numbers: [1, 3, 5]) == 2)
assert(binaryChop(0, numbers: [1, 3, 5]) == -1)
assert(binaryChop(2, numbers: [1, 3, 5]) == -1)
assert(binaryChop(4, numbers: [1, 3, 5]) == -1)
assert(binaryChop(6, numbers: [1, 3, 5]) == -1)

assert(binaryChop(1, numbers: [1, 3, 5, 7]) == 0)
assert(binaryChop(3, numbers: [1, 3, 5, 7]) == 1)
assert(binaryChop(5, numbers: [1, 3, 5, 7]) == 2)
assert(binaryChop(7, numbers: [1, 3, 5, 7]) == 3)
assert(binaryChop(0, numbers: [1, 3, 5, 7]) == -1)
assert(binaryChop(2, numbers: [1, 3, 5, 7]) == -1)
assert(binaryChop(4, numbers: [1, 3, 5, 7]) == -1)
assert(binaryChop(6, numbers: [1, 3, 5, 7]) == -1)
assert(binaryChop(8, numbers: [1, 3, 5, 7]) == -1)
