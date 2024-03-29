//
//  ballotPlanner
//
//  Created by Erika Giuse on 11/4/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation

class MyElectionsViewModel {
  var myElections = [ElectionDate]()
  
  let parser = MyElectionsParser()
  
  func numberOfRows() -> Int {
    return myElections.count
  }
  
  func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    let row = indexPath.row
    if (row >= self.numberOfRows()) {
      return ""
    }
    else {
      let myElection = myElections[row]
      return myElection.name
    }
  }
  
  func dateForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    let row = indexPath.row
    
    if (row >= self.numberOfRows()) {
      return ""
    }
    else {
      let myElection = myElections[row]
      return myElection.date
    }
  }
  
//  func detailViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> MyElectionDetailViewModel {
//    return MyElectionDetailViewModel(myElection: myElections[indexPath.row])
//  }
  func myBallotsViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> MyBallotsViewModel {
    return MyBallotsViewModel(election: myElections[indexPath.row])
  }
  
  func refresh(_ completion: @escaping () -> Void) {
    self.parser.getAllMyElections {
      (result) in self.myElections = result
      completion()
    }
  }
  
  
}
