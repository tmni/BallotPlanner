//
//  AchievementViewModel.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class AchievementParser {
  var achievements = [Achievement]()
  let parser = Parser()
  
  func AchievementsFromSearchResponse(completion: @escaping([Achievement]) -> Void) {
    let db = Firestore.firestore()
    db.collection("achievements").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          let newAchievement: Achievement = self.parser.createAchievement(document.get("name") as! String, document.get("description") as! String, document.get("isActive") as! Bool)
          print("adding ", newAchievement.name)
          self.achievements.append(newAchievement)
        }
      }
      completion(self.achievements)
    }
  }
  
}

class AchievementViewModel {
  var achievements = [Achievement]()
  
  
  let parser = AchievementParser()
  
  func refresh(_ completion: @escaping () -> Void) {

    self.parser.AchievementsFromSearchResponse { (achievements) in
      self.achievements = achievements
      completion()
    }}
  
  func numberOfRows() -> Int {
    return achievements.count
  }
  
  func nameForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    let row = indexPath.row
    if (row >= self.numberOfRows()) {
      return ""
    }
    else {
      let a = achievements[row]
      return a.name
    }
  }
  func descForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    let row = indexPath.row
    if (row >= self.numberOfRows()) {
      return ""
    } else {
      let a = achievements[row]
      return a.description
    }
  }
  
  

  func getAchNames()-> [String]{
    var names = [String]()
    for a in achievements{
      names.append(a.name)
    }
    return names
}
  func getAchDescs()-> [String]{
    var descs = [String]()
    for a in achievements{
      descs.append(a.description)
    }
    return descs
}
  
}


