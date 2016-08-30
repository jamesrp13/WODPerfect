//
//  Workout.swift
//  WODPerfect
//
//  Created by James Pacheco on 8/26/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import Foundation

class Workout {
    init(exercises: [Exercise]) {
        
    }
}



class ChipperTemplate: WorkoutTemplate {
    var maxNumberOfMovements: Int {
        return 20
    }
    
    var minNumberOfMovements: Int {
        return 1
    }
    
    var averageNumberOfMovements: Int {
        return 8
    }
    
    var maxNumberOfRounds: Int {
        return 10
    }
    
    var minNumberOfRounds: Int {
        return 1
    }
    
    var averageNumberOfRounds: Int {
        return 2
    }
    
}

class CoupletTemplate: WorkoutTemplate {
    var maxNumberOfMovements: Int {
        return 2
    }
    
    var minNumberOfMovements: Int {
        return 2
    }
    
    var averageNumberOfMovements: Int {
        return 2
    }
    
    var minNumberOfRounds: Int {
        return 2
    }
    
    var maxNumberOfRounds: Int {
        return 10
    }
    
    var averageNumberOfRounds: Int {
        return 5
    }
}

class TripletTemplate: WorkoutTemplate {
    var maxNumberOfMovements: Int {
        return 3
    }
    
    var minNumberOfMovements: Int {
        return 3
    }
    
    var averageNumberOfMovements: Int {
        return 3
    }
    
    var maxNumberOfRounds: Int {
        return 10
    }
    
    var minNumberOfRounds: Int {
        return 2
    }
    
    var averageNumberOfRounds: Int {
        return 4
    }
}

class SandwichTemplate: WorkoutTemplate {
    var maxNumberOfMovements: Int {
        return 20
    }
    
    var minNumberOfMovements: Int {
        return 3
    }
    
    var averageNumberOfMovements: Int {
        return 9
    }
    
    var maxNumberOfRounds: Int {
        return 1
    }
    
    var minNumberOfRounds: Int {
        return 1
    }
    
    var averageNumberOfRounds: Int {
        return 1
    }
}

class WeightliftingTemplate: WorkoutTemplate {
    var maxNumberOfMovements: Int {
        return 1
    }
    
    var minNumberOfMovements: Int {
        return 1
    }
    
    var averageNumberOfMovements: Int {
        return 1
    }
    
    var maxNumberOfRounds: Int {
        return 10
    }
    
    var minNumberOfRounds: Int {
        return 4
    }
    
    var averageNumberOfRounds: Int {
        return 6
    }
}

class CardioTemplate: WorkoutTemplate {
    var maxNumberOfMovements: Int {
        return 1
    }
    
    var minNumberOfMovements: Int {
        return 1
    }
    
    var averageNumberOfMovements: Int {
        return 1
    }
    
    var maxNumberOfRounds: Int {
        return 10
    }
    
    var minNumberOfRounds: Int {
        return 1
    }
    
    var averageNumberOfRounds: Int {
        return 2
    }
}

class GymnasticsTemplate: WorkoutTemplate {
    var maxNumberOfMovements: Int {
        return 2
    }
    
    var minNumberOfMovements: Int {
        return 1
    }
    
    var averageNumberOfMovements: Int {
        return 1
    }
    
    var maxNumberOfRounds: Int {
        return 10
    }
    
    var minNumberOfRounds: Int {
        return 1
    }
    
    var averageNumberOfRounds: Int {
        return 5
    }
}