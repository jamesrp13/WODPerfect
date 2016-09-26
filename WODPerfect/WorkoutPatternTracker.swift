//
//  WorkoutFactory.swift
//  WODPerfect
//
//  Created by James Pacheco on 8/26/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import Foundation

class WorkoutPatternTracker {
    
    static let sharedInstance = WorkoutPatternTracker()
    
    private let modalities = [Modality.Conditioning, Modality.Gymnastics, Modality.Weightlifting]
    
    private var currentDay: CycleOfThree = .First
    
    private var currentCycle: CycleOfThree = .First
    
    private var remainingCardioExercises: [Exercise] = []
    private var remainingGymnasticsExercises: [Exercise] = []
    private var remainingWeightliftingExercises: [Exercise] = []
    
    private var currentModalities: [Modality] {
        switch (currentDay.rawValue, currentCycle.rawValue) {
        case (0, 0):
            return [.Conditioning]
        case (0, 1):
            return [.Gymnastics]
        case (0, 2):
            return [.Weightlifting]
        case (1, 0):
            return [.Gymnastics, .Weightlifting]
        case (1, 1):
            return [.Weightlifting, .Conditioning]
        case (1, 2):
            return [.Conditioning, .Gymnastics]
        default:
            return [.Conditioning, .Gymnastics, .Weightlifting]
        }
    }
    
    private var usedMovementsDictionary: [MovementPattern: Int] = [
        .UpperBodyPush: 1,
        .UpperBodyPull: 1,
        .Core: 1,
        .LowerBodyPush: 1,
        .LowerBodyPull: 1,
        .Lungs: 1
    ]
    
    func getWorkoutDetails() -> (modalities: [Modality], currentDay: CycleOfThree, currentCycle: CycleOfThree) {
        let returnValue = (currentModalities, currentDay, currentCycle)
        return returnValue
    }
    
    func getMovementPattern(modality: Modality) -> MovementPattern {
        let availableMovementPatterns: [MovementPattern] = getAvailableMovementPatterns(modality)
        let movementPatternScores: [Int] = availableMovementPatterns.map {usedMovementsDictionary[$0] ?? 1}
        let minScore = movementPatternScores.minElement() ?? 1
        var leastUsedMovementPatterns: [MovementPattern] = []
        for (index, pattern) in availableMovementPatterns.enumerate() {
            if movementPatternScores[index] == minScore {
                leastUsedMovementPatterns.append(pattern)
            }
        }
        let random = Int(arc4random_uniform(UInt32(leastUsedMovementPatterns.count)))
        return leastUsedMovementPatterns[random]
    }
    
    private func getAvailableMovementPatterns(modality: Modality) -> [MovementPattern] {
        var movementPatterns: Set<MovementPattern> = Set()
        for exercise in ExerciseController.exercises {
            if exercise.modality == modality {
                movementPatterns.insert(exercise.primaryMovementPattern)
            }
        }
        return Array(movementPatterns)
    }
    
    func updateTrackerForWorkout(workout: Workout) {
        updateCurrentDayAndCycle()
    }
    
    private func updateCurrentDayAndCycle() {
        let newCurrentDayInt = currentDay.rawValue >= 2 ? 0:currentDay.rawValue + 1
        var newCurrentCycleInt = currentCycle.rawValue
        if currentDay.rawValue >= 2 {
            newCurrentCycleInt = currentCycle.rawValue >= 2 ? 0:currentCycle.rawValue + 1
        }
        
        currentDay = CycleOfThree(rawValue: newCurrentDayInt) ?? .First
        currentCycle = CycleOfThree(rawValue: newCurrentCycleInt) ?? .First
    }
    
    func updateMovementsDictionaryForExercise(exercise: Exercise) {
        updateMovementsDictionaryForMovementPatterns(exercise.primaryMovementPattern, secondaryMovement: exercise.secondaryMovementPattern)
    }
    
    private func updateMovementsDictionaryForMovementPatterns(primaryMovement: MovementPattern, secondaryMovement: MovementPattern?) {
        var normalization = 2
        if usedMovementsDictionary[primaryMovement] ?? 0 <= 1 {
            for (movement, _) in usedMovementsDictionary {
                if movement != primaryMovement {
                    usedMovementsDictionary[movement] = (usedMovementsDictionary[movement] ?? 0) + normalization
                }
            }
        } else {
            normalization = -2
            for (movement, _) in usedMovementsDictionary {
                if movement == primaryMovement {
                    usedMovementsDictionary[movement] = (usedMovementsDictionary[movement] ?? 0) + normalization
                }
            }
        }
        
        guard let secondaryMovement = secondaryMovement else {return}
        if usedMovementsDictionary[secondaryMovement] ?? 0 <= 1 {
            normalization = 1
            for (movement, _) in usedMovementsDictionary {
                if movement != secondaryMovement {
                    usedMovementsDictionary[movement] = (usedMovementsDictionary[movement] ?? 0) + normalization
                }
            }
        } else {
            normalization = -1
            for (movement, _) in usedMovementsDictionary {
                if movement == secondaryMovement {
                    usedMovementsDictionary[movement] = (usedMovementsDictionary[movement] ?? 0) + normalization
                }
            }
        }
    }
    
}