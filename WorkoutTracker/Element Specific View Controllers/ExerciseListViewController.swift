//
//  ExerciseListViewController.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/19/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

class ExerciseListViewController:ListViewController {
    override var newElementText:String { return "New Exercise" }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //TODO: Get all exercises
        let sampleExercises = [Exercise(name: "Dumbbell Press", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "Lat Pulldown", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "Abs", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "231 Exercise", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "Back Squat", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "Appricot", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "Ball Roller", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "Skull Crusher", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "Dumbbell Flye", description: "", id: ExerciseIdentifier()),
                               Exercise(name: "🤪 HEHE", description: "", id: ExerciseIdentifier())]
        
        load(namedElements: sampleExercises)
    }
    
    override func createNewElement() {
        print("TODO: Will show view to create new exercise")
    }
}
