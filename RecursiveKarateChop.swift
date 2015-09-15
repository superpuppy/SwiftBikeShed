//
//  RecursiveKarateChop.swift
//  
//
//  Created by Kristina Sontag on 9/15/15.
//
//

import Foundation

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

/*
HINTS:
https://twitter.com/gregtitus/status/643652546293174272
Guess #1 you may be looking for:

extension ArraySlice where Element : Comparable {
}

Guess #2 self.startIndex self.endIndex?
*/

/*
LESSONS LEARNED (so far...):
0) print() still rules the roost for debugging
1) ArraySlice<Int> is not directly comparable to [Int]
2) ArraySlices are a window into an Array, AND RETAIN THE INDEXES OF THE ORIGINAL ARRAY
3) Probably a better way to do this with extensions based on Greg's hint
4) All these return points make me twitchy!!
*/

func recursiveBinaryChop(target: Int, numbers: ArraySlice<Int>) -> Int
{
    //    print("start of func")
    //    print("numbers = \(numbers.description)")
    
    if (numbers.isEmpty) { return -1 }
    
    // since ArraySlices retain the original array indexcies, set up our max and min to the current start and end
    var max = numbers.endIndex
    var min = numbers.startIndex
    
    while (max > min)
    {
        // select the middle element as our guess
        let guess = Int(floor(Double((max + min) / 2)))
        
        //        print("target = \(target)")
        //        print("current guess = \(guess)")
        //        print("element = \(numbers[guess])")
        
        // test to see if our element contains the target, if so, done!
        if (numbers[guess] == target) {
            return guess
        } else if (numbers[guess] > target) { // ok, is our element too big? trim off the larger numbers
            max = guess
        } else { // is our element too small? trim off the smaller numbers
            min = guess + 1
        }
        
        //        print("maxIndex = \(max)")
        //        print("minIndex = \(min)")
        //        print("numbers = \(numbers.description)")
        //        print("numbers[(minIndex..<maxIndex)] = \(numbers[(min..<max)])")
        
        // right, recurse with our new ArraySlice!!
        return recursiveBinaryChop(target, numbers: numbers[(min..<max)])
    }
    // huh, no dice. guess our number doesn't exist in the array
    return -1
}

assert(recursiveBinaryChop(3, numbers: []) == -1)
assert(recursiveBinaryChop(3, numbers: [1]) == -1)
assert(recursiveBinaryChop(1, numbers: [1]) == 0)

assert(recursiveBinaryChop(1, numbers: [1, 3, 5]) == 0)
assert(recursiveBinaryChop(3, numbers: [1, 3, 5]) == 1)
assert(recursiveBinaryChop(5, numbers: [1, 3, 5]) == 2)
assert(recursiveBinaryChop(0, numbers: [1, 3, 5]) == -1)
assert(recursiveBinaryChop(2, numbers: [1, 3, 5]) == -1)
assert(recursiveBinaryChop(4, numbers: [1, 3, 5]) == -1)
assert(recursiveBinaryChop(6, numbers: [1, 3, 5]) == -1)

assert(recursiveBinaryChop(1, numbers: [1, 3, 5, 7]) == 0)
assert(recursiveBinaryChop(3, numbers: [1, 3, 5, 7]) == 1)
assert(recursiveBinaryChop(5, numbers: [1, 3, 5, 7]) == 2)
assert(recursiveBinaryChop(7, numbers: [1, 3, 5, 7]) == 3)
assert(recursiveBinaryChop(0, numbers: [1, 3, 5, 7]) == -1)
assert(recursiveBinaryChop(2, numbers: [1, 3, 5, 7]) == -1)
assert(recursiveBinaryChop(4, numbers: [1, 3, 5, 7]) == -1)
assert(recursiveBinaryChop(6, numbers: [1, 3, 5, 7]) == -1)
assert(recursiveBinaryChop(8, numbers: [1, 3, 5, 7]) == -1)
