
import UIKit

var str = "Hello, playground"

enum Modality: Int {
    case Conditioning = 0
    case Gymnastics
    case Weightlifting
}

func determineNumberOfExercisesPerModality(modalities: [Modality], numberOfMovements: Int) -> [Modality: Int] {
    var remainingNumberOfModalities = modalities.count
    var remainingNumberOfMovements = numberOfMovements
    var modalityExerciseDictionary: [Modality: Int] = [:]
    let containsConditioning = modalities.contains(.Conditioning)
    
    if containsConditioning && remainingNumberOfModalities > 1 {
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

let this = determineNumberOfExercisesPerModality([.Conditioning, .Gymnastics, .Weightlifting], numberOfMovements: 8)
print(this)
