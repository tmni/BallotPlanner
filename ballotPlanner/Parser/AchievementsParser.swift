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
  var achievements = [Achievement]()
  
  func createAchievement(_ name: String, _ description: String, _ isActive: Bool) -> Achievement {
    let newAchievement = Achievement(name: name, description: description, isActive: isActive)
    return newAchievement
  }
  
  func AchievementsFromSearchResponse(completion: @escaping([Achievement]) -> Void) {
    let db = Firestore.firestore()
    db.collection("achievements").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
//          let newAchievement = Achievement(name: document.data()["name"] as! String, description: document.data()["description"] as! String, isActive: document.data()["isActive"] as! Bool)
          let newAchievement: Achievement = self.createAchievement(document.get("name") as! String, document.get("description") as! String, document.get("isActive") as! Bool)
          print("adding ", newAchievement.name)
          self.achievements.append(newAchievement)
        }
      }
      completion(self.achievements)
    }
  }
  
}
