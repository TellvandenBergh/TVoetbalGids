//
//  ClubsViewController.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 01/02/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit

class ClubsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
    setTableViewData()
    loadSelectedClubs()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateView()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: nil) { _ in
      self.updateView()
    }
  }
  
  // MARK: - Declerations
  //
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var background: UIImageView!
  
  var tableViewData = [cellData]()
  var savedData = [String : cellData]()
  var selectieIsOn = false
  
  // MARK: - Colors & Alpha
  //
  let cellColor = #colorLiteral(red: 0.9107066989, green: 0.9180753231, blue: 0.9578188062, alpha: 0.1998341181)
  let selectedCellColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 0.1685038527)
  
  let cellAlpha: CGFloat = 0.75
  let selectedAlpha: CGFloat = 1
  
  //MARK: - functions
  //
  func getData() {
    let data = TableViewDataClubsVC()
    savedData = data.getData()
  }
  
  func setTableViewData() {
    tableViewData.removeAll()
    
    for cell in savedData.values {
      if selectieIsOn {
        if cell.isSelected {
          tableViewData.append(cell)
        }
      } else {
        tableViewData.append(cell)
      }
    }
    tableViewData = tableViewData.sorted(by: { $0.clubName! < $1.clubName!})
  }
  
  func saveSelectedClubs() {
    var favoriteTeams = [String]()
    for team in savedData.values {
      if team.isSelected {
        favoriteTeams.append(team.clubName ?? "Geen naam")
      }
    }
    saveData.set(favoriteTeams, forKey: "selectedClubsKey")
  }
  
  func loadSelectedClubs() {
    let favoriteTeams = saveData.array(forKey: "selectedClubsKey") as? [String] ?? [""]
    for team in favoriteTeams {
      savedData[team]?.isSelected = true
    }
  }
  
  func updateView() {
    if UIScreen.main.bounds.width < screenSizeIphone5Portrait {
      UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
        self.background.alpha = 1
      }, completion: nil)
    } else {
      UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
        self.background.alpha = 0
      }, completion: nil)
    }
    tableView.reloadData()
  }
  
  @objc func resetButtonAction(sender: UIButton!) {
    for team in savedData.keys {
      savedData[team]?.isSelected = false
    }
    saveSelectedClubs()
    tableView.reloadData()
  }
  
  var selectionindex = 0
  @objc func segmentControlfunc(sender: UISegmentedControl!) {
    if sender.selectedSegmentIndex == 0 {
      selectieIsOn = false
      selectionindex = 0
    } else {
      selectieIsOn = true
      selectionindex = 1
    }
    setTableViewData()
    tableView.reloadData()
  }
  
  // MARK: - SearchBar
  //
  var searchString = [String]()
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    guard !searchText.isEmpty else {setTableViewData() ; tableView.reloadData() ; return }
    searchString = savedData.keys.filter({$0.prefix(searchText.count) == searchText})
    
    tableViewData.removeAll()
    for club in searchString {
      tableViewData.append(savedData[club]!)
    }
    tableViewData = tableViewData.sorted(by: { $0.clubName! < $1.clubName!})
    tableView.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }
  
  // MARK: - TableView Functions
  //
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewData.count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = HeaderView()
    let view = UIView()
    view.isUserInteractionEnabled = true
    let buttonWith = Int((tableView.frame.width / 3) - 20)
    
    let resetButton = headerView.getResetButton(buttonWidth: buttonWith)
    resetButton.addTarget(self, action: #selector(resetButtonAction(sender:)), for: .touchUpInside)
    view.addSubview(resetButton)
    
    let segmentedControl = headerView.getSegmentedControl(buttonWidth: buttonWith, selectionindex: selectionindex)
    segmentedControl.addTarget(self, action: #selector(segmentControlfunc(sender:)), for: .valueChanged)
    view.addSubview(segmentedControl)
    
    return view
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let nibName = UINib(nibName: "CellForClubNamen", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "clubCell")
    let cell = tableView.dequeueReusableCell(withIdentifier: "clubCell", for: indexPath) as! CellClubsVC
    cell.selectionStyle = .none
    
    if savedData[tableViewData[indexPath.row].clubName!]!.isSelected {
        cell.visualEffectView.backgroundColor = selectedCellColor
        cell.visualEffectView.alpha = selectedAlpha
    } else {
      UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
        cell.visualEffectView.backgroundColor = self.cellColor
        cell.visualEffectView.alpha = self.cellAlpha
      }, completion: nil)
    }
    
    cell.Myinit(imageName: tableViewData[indexPath.row].imageName ?? "??",
                labelName: tableViewData[indexPath.row].clubName ?? "??")
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! CellClubsVC
    
    if savedData[tableViewData[indexPath.row].clubName!]!.isSelected {
      UIView.animate(withDuration: 0.4, animations: {
        cell.visualEffectView.backgroundColor = self.cellColor
        cell.visualEffectView.alpha = self.cellAlpha
      }, completion: nil)
      savedData[tableViewData[indexPath.row].clubName!]?.isSelected = false
    } else {
      UIView.animate(withDuration: 0.2, animations: {
        cell.visualEffectView.backgroundColor = self.selectedCellColor
        cell.visualEffectView.alpha = self.selectedAlpha
      }, completion: nil)
      savedData[tableViewData[indexPath.row].clubName!]?.isSelected = true
    }
    saveSelectedClubs()
  }
}
