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
        .LowerBodyPull: 1
    ]
    
    func updateCurrentDayAndCycle() {
        let newCurrentDayInt = currentDay.rawValue >= 2 ? 0:currentDay.rawValue + 1
        var newCurrentCycleInt = currentCycle.rawValue
        if currentDay.rawValue >= 2 {
            newCurrentCycleInt = currentCycle.rawValue >= 2 ? 0:currentCycle.rawValue + 1
        }
        
        currentDay = CycleOfThree(rawValue: newCurrentDayInt) ?? .First
        currentCycle = CycleOfThree(rawValue: newCurrentCycleInt) ?? .First
    }
    
    func getWorkoutDetails() -> (modalities: [Modality], currentDay: CycleOfThree, currentCycle: CycleOfThree) {
        let returnValue = (currentModalities, currentDay, currentCycle)
        updateCurrentDayAndCycle()
        return returnValue
    }
    
    func generateExercisesForModalities(modalities: [Modality], numberOfMovements: Int) -> [Exercise] {
        var exercises: [Exercise] = []
        for modality in modalities.sort({$0.rawValue < $1.rawValue}) {
            switch modality {
            case .Conditioning:
                if modalities.count == 1 {
                    return generateExercisesForModality(modality, numberOfMovements: numberOfMovements)
                } else if numberOfMovements > 5 {
                    let oneOrTwo = Int(arc4random_uniform(UInt32(2))) + 1
                    exercises += generateExercisesForModality(modality, numberOfMovements: oneOrTwo)
                } else {
                    exercises += generateExercisesForModality(modality, numberOfMovements: 1)
                }
            case .Gymnastics:
                if modalities.count == 1 {
                    return generateExercisesForModality(modality, numberOfMovements: numberOfMovements)
                } else if modalities.count == 2 && exercises.count == 0 {
                    var numberOfExercises = (numberOfMovements - exercises.count)/2
                    if numberOfExercises % 2 != 0 {
                        let zeroOrOne = Int(arc4random_uniform(UInt32(2)))
                        numberOfExercises += zeroOrOne
                    }
                    exercises += generateExercisesForModality(modality, numberOfMovements: numberOfExercises)
                }
            case .Weightlifting:
                return generateExercisesForModality(modality, numberOfMovements: numberOfMovements - exercises.count)
            }
        }
        return exercises
    }
    
    private func generateExercisesForModality(modality: Modality, numberOfMovements: Int) -> [Exercise] {
        var exercisesForModality: [Exercise] = []
        var movementPatterns: [MovementPattern] = []
        for (movementPattern, count) in usedMovementsDictionary {
            for _ in 1...count {
                
                movementPatterns.append(movementPattern)
            }
        }
        
        
        var exercises: [Exercise] = []
        for _ in 1...numberOfMovements {
            if let exercise = getRandomExerciseForModality(modality) {
                exercises.append(exercise)
            }
        }
        return exercises
    }
    
    private func getRandomExerciseForModality(modality: Modality) -> Exercise? {
        var exercises: [Exercise] = []
        switch modality {
        case .Conditioning:
            exercises = remainingCardioExercises
        case .Gymnastics:
            exercises = remainingGymnasticsExercises
        case .Weightlifting:
            exercises = remainingWeightliftingExercises
        }
        let exercisesCount = exercises.count
        if exercisesCount > 0 {
            let randomNum = Int(arc4random_uniform(UInt32(exercisesCount)))
            let exercise = exercises[randomNum]
            updateMovementsDictionaryForExercise(exercise)
            return exercise
        }
        return nil
    }
    
    private func updateMovementsDictionaryForExercise(exercise: Exercise) {
        guard let primaryMovementPattern = exercise.primaryMovementPattern else {return}
        updateMovementsDictionaryForMovementPatterns(primaryMovementPattern, secondaryMovement: exercise.secondaryMovementPattern)
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