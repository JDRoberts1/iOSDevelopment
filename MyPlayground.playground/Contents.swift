import UIKit

import Foundation


/*
 * Complete the 'numPlayers' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts following parameters:
 *  1. INTEGER k
 *  2. INTEGER_ARRAY scores
 */


let index = 0

func numPlayers(k: Int, scores: [Int]) -> Int {
    
    let scores = scores.sorted{$0 > $1}
    var winningScores : [Int] = []
    
    for score in scores[0...k-1]{
        
        winningScores.append(score)
        
    }
    
    return winningScores.count
    
    
}

let input1 = 4
let score = [20, 40, 60, 80, 100]
print(numPlayers(k: input1, scores: score))

let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
