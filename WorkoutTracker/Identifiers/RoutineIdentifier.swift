//
//  RoutineIdentifier.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/18/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import Foundation

struct RoutineIdentifier:Identifier {
    private let uuid:UUID;
    
    var idString: String { return uuid.uuidString }
    
    init() {
        self.uuid = UUID()
    }
    
    init(uuid:UUID) {
        self.uuid = uuid
    }
}
