//
//  ElectionDateDetailViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Erika Giuse on 12/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class ElectionDateDetailViewModelTests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testTitle() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let viewModel = ElectionDateDetailViewModel(electionDate: electionDate)
    XCTAssertEqual(viewModel.title(), electionDate.name)
  }
  
  func testDate() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let viewModel = ElectionDateDetailViewModel(electionDate: electionDate)
    XCTAssertEqual(viewModel.date(), electionDate.date)
  }
  
  func testDescription() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let viewModel = ElectionDateDetailViewModel(electionDate: electionDate)
    XCTAssertEqual(viewModel.description(), electionDate.description)
  }
  
  func testVoting_locations() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let viewModel = ElectionDateDetailViewModel(electionDate: electionDate)
    XCTAssertEqual(viewModel.voting_locations(), electionDate.voting_locations)
  }

}
