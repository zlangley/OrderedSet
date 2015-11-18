//
//  OrderedSetTests.swift
//  OrderedSetTests
//
//  Created by Zach Langley on 11/18/15.
//  Copyright © 2015 Zach Langley. All rights reserved.
//

import XCTest
@testable import OrderedSet

class OrderedSetTests: XCTestCase {
    func testNewOrderedSetHasNoCount() {
        let orderedSet: OrderedSet<Int> = []
        XCTAssertEqual(orderedSet.count, 0)
    }

    func testIndexable() {
        let orderedSet: OrderedSet = [1, 2, 3]
        XCTAssertEqual(orderedSet[1], 2)
    }

    func testAppend() {
        var orderedSet: OrderedSet = [1, 2, 3]
        orderedSet.append(4)

        XCTAssertEqual(orderedSet.last, 4)
    }

    func testReplaceRange() {
        var orderedSet: OrderedSet = [1, 2, 3, 4, 5]
        orderedSet[0...2] = [-1, -2, -3]

        XCTAssertTrue(orderedSet == [-1, -2, -3, 4, 5])
        XCTAssertTrue([-1, -2, -3, 4, 5] == orderedSet)
    }

    func testReplaceWithExisting() {
        var orderedSet: OrderedSet = [1, 2, 3, 4, 5]
        orderedSet[0] = 5

        XCTAssertTrue(orderedSet == [2, 3, 4, 5])
    }

    func testEquals() {
        XCTAssertTrue([1, 2, 3] as OrderedSet == [1, 2, 3])
    }

    func testNotEquals() {
        XCTAssertTrue([1, 2, 3] as OrderedSet != [1, 2])
    }
}
