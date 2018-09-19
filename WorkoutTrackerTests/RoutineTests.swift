//
//  RoutineTests.swift
//  WorkoutTrackerTests
//
//  Created by Austin Heath on 9/18/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import XCTest
@testable import WorkoutTracker

class RoutineTests: XCTestCase {
    private let id = RoutineIdentifier()
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
        let routine:Routine? = Routine(name: "Pull Day", description: "", exerciseIDs:self.exerciseIDs, sets: [[ExerciseSet(reps: 10, weight: 100)]], id: self.id)
        
        XCTAssert(routine == nil)
    }
    
    func testInitNoExerciseWithSetsOrSuggestedSets() {
        let routine:Routine? = Routine(name: "Pull Day", description: "", exerciseIDs: [], sets: [[ExerciseSet(reps: 10, weight: 100)]], id: self.id)
        
        XCTAssert(routine == nil)
    }
}
