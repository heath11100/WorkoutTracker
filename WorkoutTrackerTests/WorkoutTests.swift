//
//  WorkoutTests.swift
//  WorkoutTrackerTests
//
//  Created by Austin Heath on 9/18/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import XCTest
@testable import WorkoutTracker

class WorkoutTests: XCTestCase {
    private let id = WorkoutIdentifier()
    private var exerciseIDs:[ExerciseIdentifier] = [ExerciseIdentifier(), ExerciseIdentifier(), ExerciseIdentifier()]
    private var sets:[[ExerciseSet]] = []
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sets = [[ExerciseSet]](repeating: [], count: self.exerciseIDs.count)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitInvalidSets() {
        let workout:Workout? = Workout(name: "Pull Day", description: "", exerciseIDs:self.exerciseIDs, sets: [[ExerciseSet(reps: 10, weight: 100)]], startDate: Date(), endDate: Date(), elapsedTime: 100.0, id: self.id)
        
        XCTAssert(workout == nil)
    }
    
    func testInitNoExerciseWithSetsOrSuggestedSets() {
        let workout:Workout? = Workout(name: "Pull Day", description: "", exerciseIDs: [], sets: [[ExerciseSet(reps: 10, weight: 100)]], startDate: Date(), endDate: Date(), elapsedTime: 100.0, id: self.id)
        
        XCTAssert(workout == nil)
    }
}
