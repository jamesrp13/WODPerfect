//
//  Exercise.swift
//  WODPerfect
//
//  Created by James Pacheco on 8/25/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import Foundation

class Exercise: Equatable {
    
    let name: String
    
    let averageRepsPerMinute: Int

    let modality: Modality
    
    let requiredEquipment: [Equipment]
    
    let primaryMovementPattern: MovementPattern
    
    let secondaryMovementPattern: MovementPattern?
    
    init(name: String, averageRepsPerMinute: Int, modality: Modality, requiredEquipment: [Equipment], primaryMovementPattern: MovementPattern, secondaryMovementPattern: MovementPattern?) {
        self.name = name
        self.averageRepsPerMinute = averageRepsPerMinute
        self.modality = modality
        self.requiredEquipment = requiredEquipment
        self.primaryMovementPattern = primaryMovementPattern
        self.secondaryMovementPattern = secondaryMovementPattern
    }
    
}

func ==(lhs: Exercise, rhs: Exercise) -> Bool {
    return lhs.name == rhs.name
}

