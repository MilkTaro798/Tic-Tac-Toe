//
//  Grid.swift
//  TicTacToe
//
//  Created by Yutong Sun on 1/31/24.
//

import Foundation


enum State {
    case continuation
    case X_win
    case O_win
    case Tie
}



class Grid {
    var state: State
    var X_grids: Set<Int>
    var O_grids: Set<Int>
    var occupied_num: Int
    
    let winningCombinations = [Set([0, 1, 2]), Set([3, 4, 5]), Set([6, 7, 8]), Set([0, 3, 6]), Set([1, 4, 7]), Set([2, 5, 8]), Set([0, 4, 8]), Set([2, 4, 6])]
    
    init() {
        state = State.continuation
        occupied_num = 0
        X_grids = []
        O_grids = []
    }
    
    func isSquareEmpty(square: Int) -> Bool {
        return !X_grids.contains(square) && !O_grids.contains(square)
    }

    
    func winnerGrids(grids: Set<Int>) -> [Int] {
        for combination in winningCombinations {
            if combination.isSubset(of: grids) {
                return Array(combination).sorted()
            }
        }
        return []
    }
    
    func updateGrids(for player: String, with squareIndex: Int) {
        if player == "X" {
            X_grids.insert(squareIndex)
        } else if player == "O" {
            O_grids.insert(squareIndex)
        }
        occupied_num += 1
    }
    
    func ifWin(grids: Set<Int>) -> Bool {
        for combination in winningCombinations {
            if combination.isSubset(of: grids) {
                return true
            }
        }
        return false
    }
    
    func isTie() -> Bool {
        return occupied_num == 9 && !ifWin(grids: X_grids) && !ifWin(grids: O_grids)
    }
    
    func checkState(for player: String) -> Bool {
        let currentGrids = (player == "X") ? X_grids : O_grids

        if ifWin(grids: currentGrids) {
            state = (player == "X") ? .X_win : .O_win
            return true
        }

        if isTie() {
            state = .Tie
            return true
        }

        return false
    }
    
    func clearGrid() {
        X_grids.removeAll()
        O_grids.removeAll()
        occupied_num = 0
    }
    
    func resetGame() {
        clearGrid()
        state = .continuation
    }
    
}
