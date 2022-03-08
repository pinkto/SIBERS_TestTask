//
//  RoomGenerator.swift
//  SIBERS_TestTask
//
//  Created by Anna Abdeeva on 07.03.2022.
//

import Foundation

struct MazeRoomGenerator {
    static func generateMap() -> [[SomeRoom]] {
        let map: [[SomeRoom]] = [[.empty,.empty,.nonexistent,.withTreasure],
                                 [.empty,.withKey,.nonexistent,.empty],
                                 [.empty,.empty,.empty,.empty],
                                 [.nonexistent,.nonexistent,.empty,.nonexistent]]
        return map
    }
}

enum SomeRoom {
    case nonexistent
    case empty
    case withKey
    case withTreasure
    case withArtifact
}
