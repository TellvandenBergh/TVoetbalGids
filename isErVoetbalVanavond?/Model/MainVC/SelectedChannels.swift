//
//  SelectedChannels.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 17/07/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation
import UIKit

class SelectedChannels {
  
  public func isChannelSelected(channel: channels) -> Bool {
    if saveData.value(forKey: channel.rawValue) != nil{
      let channelIsSelected: Bool = saveData.value(forKey: channel.rawValue)  as! Bool
      if channelIsSelected == true {
        return true
      } else {
        return false
      }
    } else {
      return true
    }
  }
}
