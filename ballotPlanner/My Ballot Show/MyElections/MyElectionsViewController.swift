//
//  MyElectionsViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/10/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit

class MyElectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView: UITableView!
  
  let viewModel = MyElectionsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let selectedRow = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedRow, animated: true)
    }
    
    let cellNib = UINib(nibName: "MyElectionsTableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "myElectionCell")

    viewModel.refresh { [unowned self] in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailVC = segue.destination as? MyBallotsViewController,
      let indexPath = sender as? IndexPath {
      detailVC.viewModel = viewModel.myBallotsViewModelForRowAtIndexPath(indexPath)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myElectionCell", for: indexPath) as! MyElectionsTableViewCell
    cell.name.text = viewModel.titleForRowAtIndexPath(indexPath)
    cell.date.text = viewModel.dateForRowAtIndexPath(indexPath)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toDetailVC", sender: indexPath)
  }
  
}
