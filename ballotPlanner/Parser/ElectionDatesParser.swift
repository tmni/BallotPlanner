//
//  ElectionDatesParser.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/4/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class ElectionDatesParser {
  //var electionDates = [ElectionDate]()
  
  func createElectionDate(_ date: String, _ description: String, _ name: String) -> ElectionDate {
    let newElectionDate = ElectionDate(date: date, description: description, name: name)
    return newElectionDate
  }
  
  func electionDatesFromSearchResponse(completion: @escaping([ElectionDate]) -> Void) {
    var electionDatesTotal = [ElectionDate]()
    let db = Firestore.firestore()
    db.collection("electionDates").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
//          let newElectionDate = ElectionDate(date: document.data()["date"] as! String, description: document.data()["description"] as! String, name: document.data()["name"] as! String)
          let newElectionDate = self.createElectionDate(document.get("date") as! String, document.get("description") as! String, document.get("name") as! String)
          electionDatesTotal.append(newElectionDate)
        }
      }
      completion(electionDatesTotal)
    }
  }
  
}
