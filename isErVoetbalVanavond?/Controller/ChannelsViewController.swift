//
//  ChannelsViewController.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 18/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit

class ChannelsViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setSwitches()
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
  }
  
  // MARK: - Declerations
  //
  enum channels: String {
    case ziggoSport
    case ziggoSportTotaal
    case foxSportsEredivisie
    case foxSportsInternationaal
  }
  
  var ziggoSportIsOn = Bool()
  var ziggoSportTotaalIsOn = Bool()
  var foxSportsEredivisieIsOn = Bool()
  var foxSportsInternationaalIsOn = Bool()
  
  @IBOutlet weak var ziggoSportSwitch: UISwitch!
  @IBOutlet weak var ziggoSportTotaalSwitch: UISwitch!
  @IBOutlet weak var foxSportsEredivisieSwitch: UISwitch!
  @IBOutlet weak var foxSportsInternationaalSwitch: UISwitch!
  @IBOutlet weak var background: UIImageView!
  
  //MARK: - Set and save switches
  //
  @IBAction func ziggoSportSwitch(_ sender: UISwitch) {
    updateSwitchState(sender: sender, channel: channels.ziggoSport)
  }
  @IBAction func ziggoSportTotaalSwitch(_ sender: UISwitch) {
    updateSwitchState(sender: sender, channel: channels.ziggoSportTotaal)
  }
  @IBAction func FoxSportsEredivisieSwitch(_ sender: UISwitch) {
    updateSwitchState(sender: sender, channel: channels.foxSportsEredivisie)
  }
  @IBAction func FoxSportsInternationaalSwitch(_ sender: UISwitch) {
    updateSwitchState(sender: sender, channel: channels.foxSportsInternationaal)
  }
  
  func updateSwitchState(sender: UISwitch, channel: channels) {
    var switchState = Bool()
    if sender.isOn {
      switchState = true
    } else {
      switchState = false
    }
    
    switch channel {
    case .ziggoSport:
      ziggoSportIsOn = switchState
      saveData.set(ziggoSportIsOn, forKey: channel.rawValue)
    case .ziggoSportTotaal:
      ziggoSportTotaalIsOn = switchState
      saveData.set(ziggoSportTotaalIsOn, forKey: channel.rawValue)
    case .foxSportsEredivisie:
      foxSportsEredivisieIsOn = switchState
      saveData.set(foxSportsEredivisieIsOn, forKey: channel.rawValue)
    case .foxSportsInternationaal:
      foxSportsInternationaalIsOn = switchState
      saveData.set(foxSportsInternationaalIsOn, forKey: channel.rawValue)
    }
  }
  
  // MARK: - set switches
  //
  func setSwitches() {
    setSwitch(sender: ziggoSportSwitch, channel: channels.ziggoSport)
    setSwitch(sender: ziggoSportTotaalSwitch, channel: channels.ziggoSportTotaal)
    setSwitch(sender: foxSportsEredivisieSwitch, channel: channels.foxSportsEredivisie)
    setSwitch(sender: foxSportsInternationaalSwitch, channel: channels.foxSportsInternationaal)
  }
  
  func setSwitch(sender: UISwitch, channel: channels) {
    if saveData.value(forKey: channel.rawValue) != nil {
      let channelIsOn: Bool = saveData.value(forKey: channel.rawValue)  as! Bool
      if channelIsOn == true {
        sender.isOn = true
      } else {
        sender.isOn = false
      }
    } else {
      sender.isOn = true
    }
  }
}
