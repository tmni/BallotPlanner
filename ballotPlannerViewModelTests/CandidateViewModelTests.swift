//
//  CandidateViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Erika Giuse on 12/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class CandidateViewModelTests: XCTestCase {
  
  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testTitle() {
    let candidate = Person(first_name: "first_name", last_name: "last_name", party_affiliation: "party_affiliation", image: nil, contact_twitter: "contact_twitter", summary: "summary", people_id: "people_id")
    let viewModel = CandidateViewModel(candidate: candidate)
    XCTAssertEqual(viewModel.title(), "first_name last_name")
  }
  
  func testParty() {
    let candidate = Person(first_name: "first_name", last_name: "last_name", party_affiliation: "party_affiliation", image: nil, contact_twitter: "contact_twitter", summary: "summary", people_id: "people_id")
    let viewModel = CandidateViewModel(candidate: candidate)
    XCTAssertEqual(viewModel.party(), "party_affiliation")
  }
  
  func testAbout() {
    let candidate = Person(first_name: "first_name", last_name: "last_name", party_affiliation: "party_affiliation", image: nil, contact_twitter: "contact_twitter", summary: "summary", people_id: "people_id")
    let viewModel = CandidateViewModel(candidate: candidate)
    XCTAssertEqual(viewModel.about(), "summary")
  }
  
  func testImage() {
    let candidate = Person(first_name: "first_name", last_name: "last_name", party_affiliation: "party_affiliation", image: nil, contact_twitter: "contact_twitter", summary: "summary", people_id: "people_id")
    let viewModel = CandidateViewModel(candidate: candidate)
    XCTAssertEqual(viewModel.image(), nil)
  }
  
  func testPerson_id() {
    let candidate = Person(first_name: "first_name", last_name: "last_name", party_affiliation: "party_affiliation", image: nil, contact_twitter: "contact_twitter", summary: "summary", people_id: "people_id")
    let viewModel = CandidateViewModel(candidate: candidate)
    XCTAssertEqual(viewModel.person_id(), "people_id")
  }

}
