//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Илья Тимченко on 05.06.2023.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    
    func testMyViewController() {
        let vc = MainTabBarViewController()
        assertSnapshot(matching: vc, as: .image)
      }

}
