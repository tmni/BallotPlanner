//
//  CandidateViewModel.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation

class CandidateViewModel {
  var candidate: Person
  
  init(candidate: Person) {
    self.candidate = candidate
  }
  
  func title() -> String? {
    return self.candidate.first_name + self.candidate.last_name
  }
  
  func party() -> String? {
    return self.candidate.party_affiliation
  }
  
  func about() -> String? {
    return self.candidate.summary
  }
  
  func twitter_url() -> String? {
    return self.candidate.contact_twitter
  }
  
  func person_id() -> String? {
    return self.candidate.people_id
  }
  
  
}
