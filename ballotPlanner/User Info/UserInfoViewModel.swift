//
//  UserInfoViewModel.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation

class UserInfoViewModel {
  var user_info: (String, Int) = ("", 0)
  
  
  let parser = UserInfoParser()
  
  func getUserInfo() {
    self.parser.DataFromSearchResponse { (user_info) in
    self.user_info = user_info

    }}
    
  func numberOfRows() -> Int {
    return 2
  }
  
  func getParty() -> String {
      return user_info.0
  }
  func getLocation() -> Int {

      return user_info.1
    }
}

