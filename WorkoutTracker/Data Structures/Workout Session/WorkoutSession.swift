//
//  WorkoutSession.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/18/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import Foundation

struct WorkoutSession {
    var name:String
    var description:String
    
    private(set) var exerciseIDs:[ExerciseIdentifier]
    private(set) var suggestedSets:[[ExerciseSet]]
    private(set) var sets:[[ExerciseSet]]
    
    private(set) var startDate:Date
    private(set) var sessionTime:Double //Seconds
    private var _timerStartDate:Date = Date()
    
    private(set) var state:WorkoutSessionState = .created
    
    let id:WorkoutSessionIdentifier
    
    init?(name:String, description:String, exerciseIDs:[ExerciseIdentifier], suggestedSets:[[ExerciseSet]], sets:[[ExerciseSet]], startDate:Date, sessionTime:Double, id:WorkoutSessionIdentifier) {
        self.name = name
        self.description = description
        self.exerciseIDs = exerciseIDs
        guard sets.count == exerciseIDs.count else {
            return nil
        }
        self.sets = sets
        guard suggestedSets.count == exerciseIDs.count else {
            return nil
        }
        self.suggestedSets = suggestedSets
        self.startDate = startDate
        self.sessionTime = sessionTime
        self.id = id
    }
    
    init?(name:String, description:String, exerciseIDs:[ExerciseIdentifier], sessionTime:Double, id:WorkoutSessionIdentifier) {
        self.init(name: name, description: description, exerciseIDs: exerciseIDs,
                  suggestedSets: [[ExerciseSet]](repeating: [], count: exerciseIDs.count),
                  sets: [[ExerciseSet]](repeating: [], count: exerciseIDs.count),
                  startDate: Date(), sessionTime: 0.0, id: id)
    }
    
    //MARK: Exercise IDs
    mutating func set(exerciseIDs newExerciseIDs:[ExerciseIdentifier]) {
        var newSets = [[ExerciseSet]]()
        var newSuggestedSets = [[ExerciseSet]]()
        
        for index in 0..<newExerciseIDs.count {
            let id = newExerciseIDs[index]
            if let index = self.exerciseIDs.index(of: id) { //id currently exists
                newSets.append(self.sets[index])
                newSuggestedSets.append(self.suggestedSets[index])
            } else {
                newSets.append([])
                newSuggestedSets.append([])
            }
        }
        
        self.exerciseIDs = newExerciseIDs
        self.sets = newSets
        self.suggestedSets = newSuggestedSets
    }
    
    //MARK: Suggested Sets
    mutating func remove(nextSuggestedSetFor exerciseID:ExerciseIdentifier) -> ExerciseSet? {
        guard let index = self.exerciseIDs.index(of: exerciseID) else {
            return nil
        }
        
        var suggestedSets = self.suggestedSets[index]
        guard let set = suggestedSets.first else {
            return nil
        }
        suggestedSets.removeFirst()
        self.suggestedSets[index] = suggestedSets
        return set
    }
    
    //MARK: Exercise Sets
    mutating func add(set:ExerciseSet, for exerciseID:ExerciseIdentifier) {
        guard let index = self.exerciseIDs.index(of: exerciseID) else {
            return
        }
        var sets = self.sets[index]
        sets.append(set)
        self.sets[index] = sets
    }
    
    //MARK: State
    mutating func start() {
        guard self.state == .created || self.state == .paused else {
            return
        }
        
        if self.state == .created {
            self.startDate = Date()
            self.sessionTime = 0.0
        }
        
        self._timerStartDate = Date()
        
        self.state = .active
    }
    
    mutating func pause() {
        guard self.state == .active else {
            return
        }
        
        self.sessionTime += Date().timeIntervalSince(self._timerStartDate)
        
        self.state = .paused
    }
    
    mutating func finish() {
        pause()
        
        guard self.state == .paused else {
            return
        }
        
        self.state = .finished
    }
}
