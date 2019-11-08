//
//  UserInfoViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Taruna Emani on 11/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class UserInfoViewModelTests: XCTestCase {

  func testGetUserInfo(){
}
  func testnumberOfRows(){
    let viewModel = UserInfoViewModel()
    
    XCTAssertEqual(viewModel.numberOfRows(), 2)
    
  }
  func testGetParty(){
    let user_info = ("Democratic",12345)
    let viewModel = UserInfoViewModel()
    viewModel.user_info = user_info
    
    XCTAssertEqual(viewModel.getParty(), "Democratic")
  }
  
  func testGetLocation(){
    let user_info = ("Democratic",12345)
    let viewModel = UserInfoViewModel()
    viewModel.user_info = user_info
    
    XCTAssertEqual(viewModel.getLocation(), 12345)
  }
  
  
}
