//
//  CandidatesIndexViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Erika Giuse on 12/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class CandidatesIndexViewModelTests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

//  var allCandidatesSortedByOfficeId = Dictionary<String, [Person]>()
//  var officeIdsToName = Dictionary<String, String>()
//  var officeIdsToDescription = Dictionary<String, String>()
//  
//  func candidateViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> CandidateViewModel {
//    //return CandidateViewModel(candidate: allCandidates[indexPath.row])
//    var officeArray = Array(allCandidatesSortedByOfficeId.keys)
//    var officeId = officeArray[indexPath.section]
//    var candidateArray = allCandidatesSortedByOfficeId[officeId]
//    return CandidateViewModel(candidate: candidateArray![indexPath.row])
//  }
  func testCandidateViewModelForRowAtIndexPath() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: voting_locations)
    let viewModel = CandidatesIndexViewModel(election: electionDate)
    
    let person1 = Person(first_name: "first", last_name: "last", party_affiliation: "party", image: nil, contact_twitter: "twitter", summary: "summary", people_id: "id")
    let person2 = Person(first_name: "first2", last_name: "last2", party_affiliation: "party2", image: nil, contact_twitter: "twitter2", summary: "summary2", people_id: "id2")
    let personArray = [person1, person2]
    let allCandidatesSortedByOfficeId: Dictionary<String, [Person]> = ["office_id": personArray]
    let officeIdsToName: Dictionary<String, String> = ["office_id": "office_name"]
    let officeIdsToDescription: Dictionary<String, String> = ["office_id": "description"]
    viewModel.allCandidatesSortedByOfficeId = allCandidatesSortedByOfficeId
    viewModel.officeIdsToName = officeIdsToName
    viewModel.officeIdsToDescription = officeIdsToDescription
    
    let x = IndexPath(row: 0, section: 0)
    let officeArray = Array(allCandidatesSortedByOfficeId.keys)
    let officeId = officeArray[x.section]
    let candidateArray = allCandidatesSortedByOfficeId[officeId]
    let a = viewModel.candidateViewModelForRowAtIndexPath(x)
    let b = CandidateViewModel(candidate: candidateArray![x.row])
    XCTAssertEqual(a.candidate.first_name, b.candidate.first_name)
  }
  
}
