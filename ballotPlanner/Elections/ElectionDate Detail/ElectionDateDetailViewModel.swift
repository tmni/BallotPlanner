//
//  ElectionDateDetailViewModel.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation

class ElectionDateDetailViewModel {
  var electionDate: ElectionDate
  
  init(electionDate: ElectionDate) {
    self.electionDate = electionDate
  }
  
  func title() -> String? {
    return self.electionDate.name
  }
  
  func date() -> String? {
    return self.electionDate.date
  }
  
  func description() -> String? {
    return self.electionDate.description
  }
  
  func voting_locations() -> Array<Dictionary<String, Double>> {
    return self.electionDate.voting_locations
  }
  
}
