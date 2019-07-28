//
//  MainViewController.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 04/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, jsonIsParsedProtocol {
 
  override func viewDidLoad() {
    super.viewDidLoad()
    json.myProtocol = self
    json.parseJSON()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateView()
    tableView.reloadData()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: nil) { _ in
      self.updateView()
      self.tableView.reloadData()
    }
  }

  func jsonIsParsed(jsonDidParse: Bool, parsedJsonData: [Match]) {
    if jsonDidParse {
      jsonData = parsedJsonData
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Declarations
  //
  @IBOutlet weak var background: UIImageView!
  @IBOutlet weak var tableView: UITableView!

  private var matches = [[Match]]()
  private var jsonData = [Match]()
  private var mijnTeamsIsOn = false
  private let data = TableViewDataMainVC()
  private let json = parseJSON()
  
  // MARK: - Functions
  //
  @IBAction func selector(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      mijnTeamsIsOn = false
    } else {
      mijnTeamsIsOn = true
    }
    saveData.set(mijnTeamsIsOn, forKey: "mijnTeamsIsOn")
    tableView.reloadData()
  }
  
  private func updateView() {
    if UIScreen.main.bounds.width < screenSizeIphone5Portrait {
      UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
        self.background.alpha = 1
      }, completion: nil)
    } else {
      UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
        self.background.alpha = 0
      }, completion: nil)
    }
  } 
  
  //  MARK: - Colors
  //
  private let backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
  private let headerTitleColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
  private let textColor = #colorLiteral(red: 0.9688113332, green: 0.9777501225, blue: 1, alpha: 0.584572988)
  private let cellBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
  private let blurCellBackgroundColor = #colorLiteral(red: 0.7882352941, green: 0.8078431373, blue: 0.968627451, alpha: 0.1998341181)
  
  // MARK: - Make match array
  //
  private func getData() {
    matches = data.getTableViewData(matches: jsonData)
  }
  
  // MARK: - Make TableView
  //
  private let logos = Logos().logoDict
  
  func numberOfSections(in tableView: UITableView) -> Int {
    getData()
    return matches.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return matches[section].count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    let label = UILabel()
    view.backgroundColor = backgroundColor
    label.frame = CGRect(x: 20 , y: 0, width: 300, height: 35)
    label.font = (UIFont.boldSystemFont(ofSize: 30))
    label.textColor = headerTitleColor
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = NSTextAlignment.left
    //
    let date = Dates()
    let todayDate = date.getDate(for: .today)
    let tomorrowDate = date.getDate(for: .tomorrow)
    //
    switch section {
    case 0:
      if matches[0][0].date == todayDate {
        label.text = "Vandaag"
      } else {
        label.text = "\(matches[0][0].date)" }
    case 1:
      label.text = "Advertisement"
      label.font = (UIFont.boldSystemFont(ofSize: 12))
      label.frame = CGRect(x: 15 , y: 15, width: 300, height: 35)
    case 2:
      if matches[2][0].date == tomorrowDate {
        label.text = "Morgen"
      } else {
        label.text = "\(matches[2][0].date)" }
    case 3:
      label.text = "\(matches[3][0].date)"
    case 4:
      label.text = "\(matches[4][0].date)"
    case 5:
      label.text = "\(matches[5][0].date)"
    case 6:
      label.text = "\(matches[6][0].date)"
    case 7:
      label.text = "\(matches[7][0].date)"
    case 8:
      label.text = "\(matches[8][0].date)"
    case 9:
      label.text = "\(matches[9][0].date)"
    default:
      label.text = ""
    }
    view.addSubview(label)
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let nibName = UINib(nibName: "TableViewCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "myCell")
    let matchCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CellMainVC
    let nibName2 = UINib(nibName: "vanNoorCell", bundle: nil)
    tableView.register(nibName2, forCellReuseIdentifier: "vanNoor")
    let advertisementCell = tableView.dequeueReusableCell(withIdentifier: "vanNoor", for: indexPath) as! Advertisement
    //
    matchCell.Myinit(timeLabel: matches[indexPath.section][indexPath.row].time,
                     channelLabel: matches[indexPath.section][indexPath.row].channel,
                     homeLabel:matches[indexPath.section][indexPath.row].homeTeam,
                     awayLabel:matches[indexPath.section][indexPath.row].awayTeam,
                     homeLogoImageName:Logos().logoDict[matches[indexPath.section][indexPath.row].homeTeam] ?? "noLogo.png",
                     awayLogoImageName: Logos().logoDict[matches[indexPath.section][indexPath.row].awayTeam] ?? "noLogo.png",
                     logoImageName: matches[indexPath.section][indexPath.row].leaugue,
                     backgroundName: ""
    )
    //
    matchCell.timeLabel.textColor = textColor
    matchCell.homeLabel.textColor = textColor
    matchCell.awayLabel.textColor = textColor
    matchCell.visualEffectView.backgroundColor = blurCellBackgroundColor
    matchCell.background.backgroundColor = cellBackgroundColor
    matchCell.cellBackground.backgroundColor = backgroundColor
    matchCell.channelLabel.textColor = textColor
    if matches[indexPath.section][indexPath.row].leaugue == "CL" {
      matchCell.background.image = UIImage(named: "CL2")
      matchCell.background.alpha = 0.7
      let color = #colorLiteral(red: 0.9254969954, green: 0.9199952483, blue: 0.9297260642, alpha: 1)
      matchCell.timeLabel.textColor = color
      matchCell.channelLabel.textColor = color
    }
    //
    if UIScreen.main.bounds.width < screenSizeIphone5Portrait {
      matchCell.homeLabel.isHidden = true
      matchCell.awayLabel.isHidden = true
    } else {
      matchCell.homeLabel.isHidden = false
      matchCell.awayLabel.isHidden = false
    }
    //
    if matches[indexPath.section][indexPath.row].homeTeam == "advertisement" {
      return advertisementCell
    } else {
      return matchCell
    }
  }
}
