//
//  HeaderView.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 23/07/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation
import UIKit

class HeaderView {
  
  func getResetButton(buttonWidth: Int) -> UIButton {
    let resetButton = UIButton(type: .system)
    resetButton.isUserInteractionEnabled = true
    resetButton.frame = CGRect(x: 20, y: 0, width: buttonWidth , height: 30)
    resetButton.setTitle("Reset", for: .normal)
    resetButton.setTitleColor(#colorLiteral(red: 0.02117113583, green: 0.03491377458, blue: 0.102589108, alpha: 1), for: .normal)
    resetButton.layer.cornerRadius = 4
    resetButton.backgroundColor = #colorLiteral(red: 0.9412898421, green: 0.9590497613, blue: 1, alpha: 0.5521190068)
    
    return resetButton
  }
  
  func getSegmentedControl(buttonWidth: Int, selectionindex: Int) -> UISegmentedControl {
    let segmentedControlNames = ["Alles" , "Mijn Teams"]
    let segmentedControl = UISegmentedControl(items: segmentedControlNames)
    segmentedControl.frame = CGRect(x: buttonWidth + 40 , y: 0 , width: buttonWidth * 2, height: 30)
    segmentedControl.selectedSegmentIndex = selectionindex
    segmentedControl.clipsToBounds = false
    segmentedControl.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    segmentedControl.tintColor = #colorLiteral(red: 0.9412898421, green: 0.9590497613, blue: 1, alpha: 0.5521190068)
    segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
    
    return  segmentedControl
  }
  
}
