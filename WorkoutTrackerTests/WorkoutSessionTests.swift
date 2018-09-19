//
//  WorkoutSessionTests.swift
//  WorkoutTrackerTests
//
//  Created by Austin Heath on 9/18/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import XCTest
@testable import WorkoutTracker

class WorkoutSessionTests: XCTestCase {
    private var workoutSession:WorkoutSession!
    private let id = WorkoutSessionIdentifier()
    private var exerciseIDs:[ExerciseIdentifier] = [ExerciseIdentifier(), ExerciseIdentifier(), ExerciseIdentifier()]
    private var sets:[[ExerciseSet]] = []
    private var suggestedSets:[[ExerciseSet]] = []
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sets = [[ExerciseSet]](repeating: [], count: self.exerciseIDs.count)
        self.suggestedSets = [[ExerciseSet]](repeating: [], count: self.exerciseIDs.count)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitInvalidSets() {
        let session:WorkoutSession? = WorkoutSession(name: "Pull Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: [[ExerciseSet(reps: 10, weight: 100)]], startDate: Date(), sessionTime: 0.0, id: self.id)
        
        XCTAssert(session == nil)
    }
    
    func testInitInvalidSuggestedSets() {
        let session:WorkoutSession? = WorkoutSession(name: "Pull Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: [[ExerciseSet(reps: 10, weight: 100)]], sets: self.sets, startDate: Date(), sessionTime: 0.0, id: self.id)
        
        XCTAssert(session == nil)
    }
    
    func testInitNoExerciseWithSetsOrSuggestedSets() {
        let session:WorkoutSession? = WorkoutSession(name: "Pull Day", description: "", exerciseIDs: [], suggestedSets: [[ExerciseSet(reps: 10, weight: 100)]], sets: [[ExerciseSet(reps: 10, weight: 100)]], startDate: Date(), sessionTime: 0.0, id: self.id)
        
        XCTAssert(session == nil)
    }
    
    func testSetName() {
        let name = "Push Day"
        let newName = "Pull Day"
        
        self.workoutSession = WorkoutSession(name: name, description: "", exerciseIDs: [], sessionTime: 0.0, id: id)!
        
        XCTAssert(self.workoutSession.name == name)
        self.workoutSession.name = newName
        XCTAssert(self.workoutSession.name == newName)
    }
    
    func testSetDescription() {
        let description = "Sample description of this workout session.."
        let newDescription = "New description."
        
        self.workoutSession = WorkoutSession(name: "Push Day", description: description, exerciseIDs: [], sessionTime: 0.0, id: id)!
        
        XCTAssert(self.workoutSession.description == description)
        self.workoutSession.description = newDescription
        XCTAssert(self.workoutSession.description == newDescription)
    }
    
    func testSetExerciseIDs() {
        let newExerciseIDs = [self.exerciseIDs[1], ExerciseIdentifier(), ExerciseIdentifier(), self.exerciseIDs[0]]
        //Setup
        self.sets[0] = [ExerciseSet(reps: 10, weight: 100)]
        self.sets[1] = [ExerciseSet(reps: 10, weight: 100), ExerciseSet(reps: 10, weight: 100)]
        self.sets[2] = [ExerciseSet(reps: 10, weight: 100), ExerciseSet(reps: 10, weight: 100), ExerciseSet(reps: 10, weight: 100)]
        
        self.suggestedSets[0] = [ExerciseSet(reps: 5, weight: 100), ExerciseSet(reps: 10, weight: 100), ExerciseSet(reps: 10, weight: 100)]
        self.suggestedSets[1] = [ExerciseSet(reps: 5, weight: 100), ExerciseSet(reps: 10, weight: 100)]
        self.suggestedSets[2] = [ExerciseSet(reps: 5, weight: 100)]
        
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        //Begin tests
        XCTAssert(self.workoutSession.exerciseIDs == self.exerciseIDs)
        XCTAssert(self.workoutSession.sets == self.sets)
        XCTAssert(self.workoutSession.suggestedSets == self.suggestedSets)
        
        self.workoutSession.set(exerciseIDs: newExerciseIDs)
        
        XCTAssert(self.workoutSession.exerciseIDs == newExerciseIDs)
        XCTAssert(self.workoutSession.sets == [self.sets[1], [], [], self.sets[0]])
        XCTAssert(self.workoutSession.suggestedSets == [self.suggestedSets[1], [], [],self.suggestedSets[0]])
    }
    
    func testRemoveNextSuggestedSet() {
        //Setup
        self.suggestedSets[0] = [ExerciseSet(reps: 5, weight: 100), ExerciseSet(reps: 10, weight: 100), ExerciseSet(reps: 10, weight: 100)]
        self.suggestedSets[1] = [ExerciseSet(reps: 5, weight: 100), ExerciseSet(reps: 10, weight: 100)]
        self.suggestedSets[2] = [ExerciseSet(reps: 5, weight: 100)]
        
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        //Begin tests
        let set = self.workoutSession.remove(nextSuggestedSetFor: self.exerciseIDs[0])
        XCTAssert(set == self.suggestedSets[0][0])
        XCTAssert(self.workoutSession.suggestedSets[0].count == self.suggestedSets[0].count-1)
        XCTAssert(self.workoutSession.suggestedSets[1].count == self.suggestedSets[1].count)
        XCTAssert(self.workoutSession.suggestedSets[2].count == self.suggestedSets[2].count)

        let _ = self.workoutSession.remove(nextSuggestedSetFor: self.exerciseIDs[2])
        XCTAssert(self.workoutSession.suggestedSets[2].count == 0)
        let _ = self.workoutSession.remove(nextSuggestedSetFor: self.exerciseIDs[2]) //ensure removing something that doesnt exist does not cause crash
    }
    
    func testAddSet() {
        //Setup
        self.sets[0] = []
        self.sets[1] = [ExerciseSet(reps: 10, weight: 100), ExerciseSet(reps: 10, weight: 100)]
        self.sets[2] = [ExerciseSet(reps: 10, weight: 100), ExerciseSet(reps: 10, weight: 100), ExerciseSet(reps: 10, weight: 100)]
        
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        //Begin tests
        let set = ExerciseSet(reps: 15, weight: 150)
        self.workoutSession.add(set: set, for: self.exerciseIDs[0])
        XCTAssert(self.workoutSession.sets[0][0] == set)
    }
    
    func testStart() {
        let date = Date(timeIntervalSince1970: 60_000)
        let sessionTime = 100.00
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: date, sessionTime: sessionTime, id: id)!
        
        XCTAssert(self.workoutSession.state == .created)
        XCTAssert(self.workoutSession.startDate == date)
        XCTAssert(self.workoutSession.sessionTime == sessionTime)
        
        self.workoutSession.start()
        
        XCTAssert(self.workoutSession.state == .active)
        XCTAssert(self.workoutSession.startDate != date)
        XCTAssert(self.workoutSession.sessionTime == 0.00)
    }
    
    //MARK: Pause Tests
    func testPauseCreated() {
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        XCTAssert(self.workoutSession.state == .created)
        self.workoutSession.pause()
        XCTAssert(self.workoutSession.state == .created)
    }
    
    func testPause() {
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        self.workoutSession.start()
        
        let activeTime = 5.0
        guard XCTWaiter.wait(for: [XCTestExpectation(description: "Test after 5 seconds")], timeout: activeTime)
            == XCTWaiter.Result.timedOut else {
            XCTFail()
            return
        }
        
        self.workoutSession.pause()
        
        XCTAssert(self.workoutSession.state == .paused)
        XCTAssert(self.workoutSession.startDate.timeIntervalSinceNow < 50.0)
        XCTAssert(self.workoutSession.sessionTime >= activeTime)
    }
    
    func testPauseStartPause() {
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        self.workoutSession.start()
        
        let activeTime = 5.0
        guard XCTWaiter.wait(for: [XCTestExpectation(description: "Test after 5 seconds")], timeout: activeTime)
            == XCTWaiter.Result.timedOut else {
                XCTFail()
                return
        }
        
        self.workoutSession.pause()
        
        XCTAssert(self.workoutSession.state == .paused)
        XCTAssert(self.workoutSession.startDate.timeIntervalSinceNow < 50.0)
        XCTAssert(self.workoutSession.sessionTime >= activeTime)
        
        self.workoutSession.start()
        
        guard XCTWaiter.wait(for: [XCTestExpectation(description: "Test after 5 seconds")], timeout: activeTime)
            == XCTWaiter.Result.timedOut else {
                XCTFail()
                return
        }
        
        self.workoutSession.pause()
        
        XCTAssert(self.workoutSession.state == .paused)
        XCTAssert(self.workoutSession.startDate.timeIntervalSinceNow < 50.0)
        XCTAssert(self.workoutSession.sessionTime >= activeTime*2)
    }
    
    func testPauseFinished() {
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        self.workoutSession.start()
        self.workoutSession.finish()
        XCTAssert(self.workoutSession.state == .finished)
        self.workoutSession.pause()
        XCTAssert(self.workoutSession.state == .finished)
    }
    
    //MARK: Finish Tests
    func testFinishCreated() {
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        XCTAssert(self.workoutSession.state == .created)
        self.workoutSession.finish()
        XCTAssert(self.workoutSession.state == .created)
    }
    
    func testFinishActive() {
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        XCTAssert(self.workoutSession.state == .created)
        self.workoutSession.start()
        XCTAssert(self.workoutSession.state == .active)
        self.workoutSession.finish()
        XCTAssert(self.workoutSession.state == .finished)
    }
    
    func testFinishPaused() {
        self.workoutSession = WorkoutSession(name: "Push Day", description: "", exerciseIDs: self.exerciseIDs, suggestedSets: self.suggestedSets, sets: self.sets, startDate: Date(), sessionTime: 0.0, id: id)!
        
        XCTAssert(self.workoutSession.state == .created)
        self.workoutSession.start()
        self.workoutSession.pause()
        XCTAssert(self.workoutSession.state == .paused)
        self.workoutSession.finish()
        XCTAssert(self.workoutSession.state == .finished)
    }
}
