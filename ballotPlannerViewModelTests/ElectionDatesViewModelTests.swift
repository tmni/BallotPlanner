//
//  ElectionDatesViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Erika Giuse on 12/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class ElectionDatesViewModelTests: XCTestCase {

  override func setUp() {
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testNumberOfRows() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = ElectionDatesViewModel()
    viewModel.electionDates = [electionDate1, electionDate2]
    XCTAssertEqual(viewModel.numberOfRows(), 2)
  }
  
  func testTitleForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = ElectionDatesViewModel()
    viewModel.electionDates = [electionDate1, electionDate2]
    let x = IndexPath(row: 0, section: 0)
    let y = IndexPath(row: 3, section: 0)
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(x), electionDate1.name)
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(y), "")
  }
  
  func testDateForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = ElectionDatesViewModel()
    viewModel.electionDates = [electionDate1, electionDate2]
    let x = IndexPath(row: 0, section: 0)
    let y = IndexPath(row: 3, section: 0)
    XCTAssertEqual(viewModel.dateForRowAtIndexPath(x), "date")
    XCTAssertEqual(viewModel.dateForRowAtIndexPath(y), "")
  }
  
  func testDetailViewModelForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = ElectionDatesViewModel()
    viewModel.electionDates = [electionDate1, electionDate2]
    let x = IndexPath(row: 0, section: 0)
    let a = viewModel.detailViewModelForRowAtIndexPath(x)
    let b = ElectionDateDetailViewModel(electionDate: electionDate1)
    XCTAssertEqual(a.electionDate.name, b.electionDate.name)
  }
  
  func testCandidatesIndexViewModelForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = ElectionDatesViewModel()
    viewModel.electionDates = [electionDate1, electionDate2]
    let x = IndexPath(row: 0, section: 0)
    let a = viewModel.candidatesIndexViewModelForRowAtIndexPath(x)
    let b = CandidatesIndexViewModel(election: electionDate1)
    XCTAssertEqual(a.election.name, b.election.name)
  }
  
  
}
