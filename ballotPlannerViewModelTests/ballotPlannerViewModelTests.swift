//
//  ballotPlannerViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Taruna Emani on 11/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
import Firebase
@testable import ballotPlanner


class ballotPlannerViewModelTests: XCTestCase {
  /// MY ELECTIONS VIEW MODEL
  
  func testMENumberofRows(){
    let dates = [createElectionDate(), createElectionDate(), createElectionDate()]
    let viewModel = MyElectionsViewModel()
    viewModel.myElections = dates
    
    XCTAssertEqual(viewModel.numberOfRows(), 3)
  }
  
  func testMEtitleForRowAtIndexPath(){
    let date1 = ElectionDate(election_id: "election_id", date: "123", description: "789", name: "456", voting_locations: [["lat": 0.0, "long": 1.1]])
    let date2 = ElectionDate(election_id: "election_id1", date: "ABC", description: "DEF", name: "GHI", voting_locations: [["lat": 0.0, "long": 1.2]])
    let dates = [date1, date2]
    let viewModel = MyElectionsViewModel()
    viewModel.myElections = dates
    
    let indexPath1 = IndexPath(row: 0, section: 0)
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(indexPath1), "456")
    
    let indexPath2 = IndexPath(row: 1, section: 0)
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(indexPath2), "GHI")
    
    let indexPath3 = IndexPath(row: 99, section: 99)
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(indexPath3), "")
  }
  
  
  func testMEDateForRowAtIndexPath(){
    let date1 = ElectionDate(election_id: "election_id", date: "123", description: "789", name: "456", voting_locations: [["lat": 0.0, "long": 1.1]])
    let date2 = ElectionDate(election_id: "election_id1", date: "ABC", description: "DEF", name: "GHI", voting_locations: [["lat": 0.0, "long": 1.2]])
    let dates = [date1, date2]
    let viewModel = MyElectionsViewModel()
    viewModel.myElections = dates
    
    let indexPath1 = IndexPath(row: 0, section: 0)
    XCTAssertEqual(viewModel.dateForRowAtIndexPath(indexPath1), "123")
    
    let indexPath2 = IndexPath(row: 1, section: 0)
    XCTAssertEqual(viewModel.dateForRowAtIndexPath(indexPath2), "ABC")
    
    let indexPath3 = IndexPath(row: 99, section: 99)
    XCTAssertEqual(viewModel.dateForRowAtIndexPath(indexPath3), "")
  }
  
  
  func testMERefresh(){
    
  }
  
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  func createElectionDate() -> ElectionDate {
    return ElectionDate(election_id: "election_id", date: "123", description: "789", name: "456", voting_locations: [["lat": 0.0, "long": 1.1]] )
  }
  
}
