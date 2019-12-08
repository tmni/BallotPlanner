//
//  MyBallotsViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Erika Giuse on 12/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class MyBallotsViewModelTests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testNumberOfRows() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let person1 = Person(first_name: "first", last_name: "last", party_affiliation: "party", image: nil, contact_twitter: "twitter", summary: "summary", people_id: "id")
    let person2 = Person(first_name: "first2", last_name: "last2", party_affiliation: "party2", image: nil, contact_twitter: "twitter2", summary: "summary2", people_id: "id2")
    let viewModel = MyBallotsViewModel(election: electionDate)
    viewModel.myBallots = [person1, person2]
    XCTAssertEqual(viewModel.numberOfRows(), 2)
  }
  
  func testTitleForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let person1 = Person(first_name: "first", last_name: "last", party_affiliation: "party", image: nil, contact_twitter: "twitter", summary: "summary", people_id: "id")
    let person2 = Person(first_name: "first2", last_name: "last2", party_affiliation: "party2", image: nil, contact_twitter: "twitter2", summary: "summary2", people_id: "id2")
    let viewModel = MyBallotsViewModel(election: electionDate)
    viewModel.myBallots = [person1, person2]
    let x = IndexPath(row: 0, section: 0)
    let y = IndexPath(row: 3, section: 0)
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(x), "first last")
    XCTAssertEqual(viewModel.titleForRowAtIndexPath(y), "")
  }
  
  func testCandidateViewModelForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let person1 = Person(first_name: "first", last_name: "last", party_affiliation: "party", image: nil, contact_twitter: "twitter", summary: "summary", people_id: "id")
    let person2 = Person(first_name: "first2", last_name: "last2", party_affiliation: "party2", image: nil, contact_twitter: "twitter2", summary: "summary2", people_id: "id2")
    let viewModel = MyBallotsViewModel(election: electionDate)
    viewModel.myBallots = [person1, person2]
    let x = IndexPath(row: 0, section: 0)
    let a = viewModel.candidateViewModelForRowAtIndexPath(x)
    let b = CandidateViewModel(candidate: person1)
    XCTAssertEqual(a.candidate.first_name, b.candidate.first_name)
  }

}
