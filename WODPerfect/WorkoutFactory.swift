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
        return createWorkout(template, modalities: modalities)
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
            return [.Chipper, .Couplet, .Couplet, .Couplet, .Triplet, .Sandwich]
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
        let exercises = WorkoutPatternTracker.sharedInstance.generateExercisesForModalities(modalities, numberOfMovements: numberOfExercises)
        return Workout(exercises: exercises)
    }
    
}