//
//  EpochDateTest.swift
//  ProvaSicrediTests
//
//  Created by Rafael Hartmann on 29/06/21.
//

import XCTest
@testable import ProvaSicredi

class EpochDateTest: XCTestCase {
    func testEpoch(){
    let date = Components().convertEpochDateToString(epoch: 1625017062)
    
    XCTAssertEqual("29/06/2021 às 22:37", date)
    }
}
