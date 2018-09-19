//
//  Routine.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/18/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import Foundation

struct Routine {
    let name:String
    let description:String
    
    let exerciseIDs:[ExerciseIdentifier]
    let sets:[[ExerciseSet]]
    
    let id:RoutineIdentifier
    
    init?(name:String, description:String, exerciseIDs:[ExerciseIdentifier], sets:[[ExerciseSet]], id:RoutineIdentifier) {
        self.name = name
        self.description = description
        self.exerciseIDs = exerciseIDs
        guard sets.count == exerciseIDs.count else {
            return nil
        }
        self.sets = sets
        self.id = id
    }
    
}
