//
//  UserInfoController.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//
import Foundation
import UIKit

class UserInfoController: UIViewController {
  @IBOutlet weak var tableView: UITableView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  enum ProfileViewModelItemType {
    case nameAndPicture
    case about
    case email
    case friend
    case attribute
  }
}
