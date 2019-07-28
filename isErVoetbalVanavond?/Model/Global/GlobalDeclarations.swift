//
//  GlobalDeclarations.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 18/07/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation
import UIKit

public let saveData = UserDefaults.standard

public let screenSizeIphone5Portrait: CGFloat = 567

protocol jsonIsParsedProtocol {
  func jsonIsParsed(jsonDidParse: Bool, parsedJsonData: [Match])
}

public enum days {
  case today
  case tomorrow
  case date3
  case date4
  case date5
  case date6
  case date7
  case date8
  case date9
}

public enum channels : String {
  case ziggoSport
  case ziggoSportTotaal
  case foxSportsEredivisie
  case foxSportsInternationaal
}

public struct Match: Decodable {
  var date: String
  var time: String
  var homeTeam: String
  var awayTeam: String
  var channel: String
  var leaugue: String
}

public struct cellData: Codable {
  var imageName : String?
  var clubName : String?
  var isSelected : Bool
}
