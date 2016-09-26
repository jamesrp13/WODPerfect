//
//  ExerciseFactory.swift
//  WODPerfect
//
//  Created by James Pacheco on 9/23/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import Foundation

class ExerciseFactory {
    static func getExercise(modality: Modality, movementPattern: MovementPattern, excluding exercises: [Exercise]) -> Exercise {
        let availableExercises = getAvailableExercises(modality, movementPattern: movementPattern, excluding: exercises)
        let random = Int(arc4random_uniform(UInt32(availableExercises.count)))
        return availableExercises[random]
    }
    
    static private func getAvailableExercises(modality: Modality, movementPattern: MovementPattern, excluding exercises: [Exercise]) -> [Exercise] {
        var availableExercises: [Exercise] = []
        for exercise in ExerciseController.exercises {
            if exercise.modality == modality && exercise.primaryMovementPattern == movementPattern && !exercises.contains(exercise) {
                availableExercises.append(exercise)
            }
        }
        return availableExercises
    }
}
