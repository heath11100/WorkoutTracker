//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/18/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import Foundation

struct Workout {
    let name:String
    let description:String
    
    let exerciseIDs:[ExerciseIdentifier]
    let sets:[[ExerciseSet]]
    
    let startDate:Date
    let endDate:Date
    let elapsedTime:Double //Seconds
    
    let id:WorkoutIdentifier
    
    init?(name:String, description:String, exerciseIDs:[ExerciseIdentifier], sets:[[ExerciseSet]], startDate:Date, endDate:Date, elapsedTime:Double, id:WorkoutIdentifier) {
        self.name = name
        self.description = description
        self.exerciseIDs = exerciseIDs
        guard sets.count == exerciseIDs.count else {
            return nil
        }
        self.sets = sets
        self.startDate = startDate
        self.endDate = endDate
        self.elapsedTime = elapsedTime
        self.id = id
    }
}
