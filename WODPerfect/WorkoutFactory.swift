//
//  WorkoutTemplate.swift
//  WODPerfect
//
//  Created by James Pacheco on 8/26/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import Foundation

class WorkoutFactory {

    func getWorkout() -> Workout {
        let details = WorkoutPatternTracker.sharedInstance.getWorkoutDetails()
        let modalities = details.modalities
        let currentDay = details.currentDay
        let currentCycle = details.currentCycle
        let template = generateWorkoutTemplate(modalities, currentDay: currentDay, currentCycle: currentCycle)
        let workout = createWorkout(template, modalities: modalities)
        WorkoutPatternTracker.sharedInstance.updateTrackerForWorkout(workout)
        return workout
    }
    
    private func generateWorkoutTemplate(modalities: [Modality], currentDay: CycleOfThree, currentCycle: CycleOfThree) -> WorkoutTemplate {
        let possibleWorkouts = getPossibleWorkoutTemplates(modalities)
        let possibleWorkoutsCount = possibleWorkouts.count
        let randomNum = Int(arc4random_uniform(UInt32(possibleWorkoutsCount)))
        let templateName = possibleWorkouts[randomNum]
        return getTemplateFromEnum(templateName)
    }
    
    private func getPossibleWorkoutTemplates(modalities: [Modality]) -> [WorkoutTemplateEnum] {
        let numberOfModalities = modalities.count
        if numberOfModalities == 1 {
            switch modalities[0] {
            case .Conditioning:
                return [.Cardio]
            case .Gymnastics:
                return [.Gymnastics]
            case .Weightlifting:
                return [.Weightlifting]
            }
        } else if numberOfModalities == 2 {
            return [.Chipper, .Couplet, .Couplet, .Couplet, .Couplet, .Triplet, .Sandwich]
        }
        return [.Chipper, .Triplet, .Sandwich]
    }
    
    private func getTemplateFromEnum(workoutTemplateName: WorkoutTemplateEnum) -> WorkoutTemplate {
        switch workoutTemplateName {
        case .Cardio:
            return CardioTemplate()
        case .Gymnastics:
            return GymnasticsTemplate()
        case .Weightlifting:
            return WeightliftingTemplate()
        case .Chipper:
            return ChipperTemplate()
        case .Couplet:
            return CoupletTemplate()
        case .Triplet:
            return TripletTemplate()
        case .Sandwich:
            return SandwichTemplate()
        }
    }
    
    private func createWorkout(workoutTemplate: WorkoutTemplate, modalities: [Modality]) -> Workout {
        let numberOfExercises = workoutTemplate.generateRandomNumberOfMovements()
        let exercisesPerModality = determineNumberOfExercisesPerModality(modalities, numberOfMovements: numberOfExercises)
        let exercises = getExercisesForModalities(exercisesPerModality)
        return Workout(exercises: exercises)
    }
    
    private func getExercisesForModalities(exercisesPerModality: [Modality: Int]) -> [Exercise] {
        var exercises: [Exercise] = []
        for (modality, numberOfExercises) in exercisesPerModality {
            for _ in 1...numberOfExercises {
                let movementPattern = WorkoutPatternTracker.sharedInstance.getMovementPattern(modality)
                let exercise = ExerciseFactory.getExercise(modality, movementPattern: movementPattern, excluding: exercises)
                WorkoutPatternTracker.sharedInstance.updateMovementsDictionaryForExercise(exercise)
                exercises.append(exercise)
            }
        }
        return exercises
    }
    
    private func determineNumberOfExercisesPerModality(modalities: [Modality], numberOfMovements: Int) -> [Modality: Int] {
        var remainingNumberOfModalities = modalities.count
        var remainingNumberOfMovements = numberOfMovements
        var modalityExerciseDictionary: [Modality: Int] = [:]
        let containsConditioning = modalities.contains(.Conditioning)
        
        if containsConditioning {
            let movementRemainder = remainingNumberOfMovements % remainingNumberOfModalities
            var numberOfConditioningMovements = ((movementRemainder + remainingNumberOfMovements)/remainingNumberOfModalities) - movementRemainder
            numberOfConditioningMovements = min(numberOfConditioningMovements, 3)
            modalityExerciseDictionary[.Conditioning] = numberOfConditioningMovements
            remainingNumberOfMovements -= numberOfConditioningMovements
            remainingNumberOfModalities -= 1
        }
        
        for modality in modalities {
            if containsConditioning && modality == .Conditioning {
                continue
            }
            modalityExerciseDictionary[modality] = remainingNumberOfMovements/remainingNumberOfModalities
        }
        return modalityExerciseDictionary
    }
    
}
