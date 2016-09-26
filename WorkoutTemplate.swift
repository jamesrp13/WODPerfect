//
//  WorkoutTemplate.swift
//  WODPerfect
//
//  Created by James Pacheco on 8/27/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import Foundation

protocol WorkoutTemplate {
    var maxNumberOfMovements: Int {get}
    var minNumberOfMovements: Int {get}
    var averageNumberOfMovements: Int {get}
    var maxNumberOfRounds: Int {get}
    var minNumberOfRounds: Int {get}
    var averageNumberOfRounds: Int {get}
//    var maxTimeTarget: Int {get}
//    var minTimeTarget: Int {get}
//    var averageTimeTarget: Int {get}
    
    func generateRandomNumberOfMovements() -> Int
    
    func generateRandomNumberOfRounds() -> Int
    
//    func generateTimeTarget() -> Int
    
//    func generateWorkout(exercises: [Exercise]) -> Workout
}

extension WorkoutTemplate {
    func generateRandomNumberOfMovements() -> Int {
        return generateRandomNumberBetween(minNumberOfMovements, high: maxNumberOfMovements)
    }
    
    func generateRandomNumberOfRounds() -> Int {
        return generateRandomNumberBetween(minNumberOfRounds, high: maxNumberOfRounds)
    }
    
//    func generateTimeTarget() -> Int {
//        return generateRandomNumberBetween(minTimeTarget, high: maxTimeTarget)
//    }
    
    private func generateRandomNumberBetween(low: Int, high: Int) -> Int {
        let possibilities = high - low + 1
        let randomSelection = Int(arc4random_uniform(UInt32(possibilities))) + low
        return randomSelection
    }
}