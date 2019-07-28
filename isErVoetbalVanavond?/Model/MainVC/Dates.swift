//
//  Dates.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 17/07/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation

class Dates {
  
  public func getDate(for day: days) -> String {
    
    var dateString = String()
    
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd-MM"
    
    var dateComponents = DateComponents()
    dateComponents.setValue(1, for: .day); // + 1 day
    
    let now = Date() // Current date
    let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)
    let date3 = Calendar.current.date(byAdding: dateComponents, to: tomorrow!)
    let date4 = Calendar.current.date(byAdding: dateComponents, to: date3!)
    let date5 = Calendar.current.date(byAdding: dateComponents, to: date4!)
    let date6 = Calendar.current.date(byAdding: dateComponents, to: date5!)
    let date7 = Calendar.current.date(byAdding: dateComponents, to: date6!)
    let date8 = Calendar.current.date(byAdding: dateComponents, to: date7!)
    let date9 = Calendar.current.date(byAdding: dateComponents, to: date8!)
    
    switch day {
    case .today:
      dateString = formatter.string(from: now)
    case .tomorrow:
      dateString = formatter.string(from: tomorrow!)
    case .date3:
      dateString = formatter.string(from: date3!)
    case .date4:
      dateString = formatter.string(from: date4!)
    case .date5:
      dateString = formatter.string(from: date5!)
    case .date6:
      dateString = formatter.string(from: date6!)
    case .date7:
      dateString = formatter.string(from: date7!)
    case .date8:
      dateString = formatter.string(from: date8!)
    case .date9:
      dateString = formatter.string(from: date9!)
    }
    
    return dateString
  }
  
}
