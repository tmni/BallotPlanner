//
//  ElectionDateDetailViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Taruna Emani on 11/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class ElectionDateDetailViewModelTests: XCTestCase {

  func testTitle() {
    let viewModel = ElectionDateDetailViewModel(electionDate: createElectionDate())
    XCTAssertEqual(viewModel.title(), "456")
  }
  
  func testDate() {
    let viewModel = ElectionDateDetailViewModel(electionDate: createElectionDate())
    XCTAssertEqual(viewModel.date(), "123")
  }
  
  func testDescription(){
    let viewModel = ElectionDateDetailViewModel(electionDate: createElectionDate())
    XCTAssertEqual(viewModel.description(), "789")
  }
  
  func createElectionDate() -> ElectionDate {
    return ElectionDate(date: "123", description: "789", name: "456" )
  }
  
}
