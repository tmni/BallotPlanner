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
  

  func getUserInfo(completion: @escaping((String, Int)) -> Void) {
    let parser = UserInfoParser()
    parser.DataFromSearchResponse { (user_info) in
      self.user_info = user_info
      completion(self.user_info)
    }
  }
  
  func numberOfRows() -> Int {
    return 2
  }
  
  func getParty() -> String {
     print("the function for getParty in ViewModel returns" , user_info.0, " which is type ", type(of: self.user_info.0))
      return self.user_info.0
   
  }
  func getLocation() -> Int {

      return user_info.1
    }
}

