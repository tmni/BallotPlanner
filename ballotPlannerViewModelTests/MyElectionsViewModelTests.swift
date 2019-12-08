//
//  MyElectionsViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Erika Giuse on 12/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class MyElectionsViewModelTests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testNumberOfRows() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = MyElectionsViewModel()
    viewModel.myElections = [electionDate1, electionDate2]
    XCTAssertEqual(viewModel.numberOfRows(), 2)
  }
  
  func testTitleForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = MyElectionsViewModel()
    viewModel.myElections = [electionDate1, electionDate2]
    let x = IndexPath(row: 0, section: 0)
    let y = IndexPath(row: 3, section: 0)
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(x), "name")
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(y), "")
  }
  
  func testDateForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = MyElectionsViewModel()
    viewModel.myElections = [electionDate1, electionDate2]
    let x = IndexPath(row: 0, section: 0)
    let y = IndexPath(row: 3, section: 0)
    XCTAssertEqual(viewModel.dateForRowAtIndexPath(x), "date")
    XCTAssertEqual(viewModel.dateForRowAtIndexPath(y), "")
  }
  
  func testMyBallotsViewModelForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate1 = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let electionDate2 = ElectionDate(election_id: "election_id2", date: "date2", description: "description2", name: "name2", voting_locations: voting_locations)
    let viewModel = MyElectionsViewModel()
    viewModel.myElections = [electionDate1, electionDate2]
    let x = IndexPath(row: 0, section: 0)
    let a = viewModel.myBallotsViewModelForRowAtIndexPath(x)
    let b = MyBallotsViewModel(election: electionDate1)
    XCTAssertEqual(a.election.name, b.election.name)
  }

}
