//
//  ElectionDatesViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit

class ElectionDatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView: UITableView!
  
  let viewModel = ElectionDatesViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "cell")
    
    viewModel.refresh { [unowned self] in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let selectedRow = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedRow, animated: true)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let detailVC = segue.destination as? ElectionDateDetailViewController,
//      let indexPath = sender as? IndexPath {
//      detailVC.viewModel = viewModel.detailViewModelForRowAtIndexPath(indexPath)
//    }
    if let detailVC = segue.destination as? CandidatesIndexViewController,
      let indexPath = sender as? IndexPath {
      detailVC.viewModel = viewModel.candidatesIndexViewModelForRowAtIndexPath(indexPath)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
    cell.name.text = viewModel.titleForRowAtIndexPath(indexPath)
    cell.date.text = viewModel.dateForRowAtIndexPath(indexPath)
    return cell
  }
  
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    performSegue(withIdentifier: "toDetailVC", sender: indexPath)
//  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toCandidatesIndexVC", sender: indexPath)
  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

