//
//  AchievementViewModel.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation

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


