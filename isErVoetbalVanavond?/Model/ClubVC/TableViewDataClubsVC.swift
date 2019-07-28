//
//  TableViewDataClubsVC.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 22/07/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation

class TableViewDataClubsVC {
  
  func getData() -> [String : cellData] {
    let clubNames = Logos()
    var unsortedData = [cellData]()
    var sortedData = [cellData]()
    var returnDict = [String : cellData]()
    
    for logoData in clubNames.logoDict {
      unsortedData.append(cellData(imageName: logoData.value, clubName: logoData.key, isSelected: false))
    }
    sortedData = unsortedData.sorted(by: { $0.clubName! < $1.clubName!})
    
    for cell in sortedData {
      returnDict[cell.clubName!] = cell
    }
    return returnDict
  }
  
}
