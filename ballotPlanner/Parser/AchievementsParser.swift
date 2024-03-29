//
//  AchievementsParser.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class AchievementParser {
  
  func AchievementsFromSearchResponse(completion: @escaping([Achievement]) -> Void) {
    var achievements = [Achievement]()
    let db = Firestore.firestore()
    db.collection("achievements").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          let newAchievement = Achievement(name: document.data()["name"] as! String, description: document.data()["description"] as! String, isActive: document.data()["isActive"] as! Bool)
          achievements.append(newAchievement)
        }
      }
      completion(achievements)
    }
  }
  
}
