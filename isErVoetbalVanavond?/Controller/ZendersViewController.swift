//
//  ZendersViewController.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 18/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit



class ZendersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkSavedData()
        backgroundTransition()
        ziggoSportSwitch.bringSubviewToFront(view)

    }
    
    var ziggoSportIsAan = Bool()
    var ziggoSportTotaalIsAan = Bool()
    var foxSportsEredivisieIsAan = Bool()
    var foxSportsInternationaalIsAan = Bool()
    

    @IBOutlet weak var ziggoSportSwitch: UISwitch!
    @IBOutlet weak var ziggoSportTotaalSwitch: UISwitch!
    @IBOutlet weak var foxSportsEredivisieSwitch: UISwitch!
    @IBOutlet weak var foxSportsInternationaalSwitch: UISwitch!
    
    @IBOutlet weak var background: UIImageView!
    
    
    func backgroundTransition() {
        if UIScreen.main.bounds.width < 567 {
            background.isHidden = false
        } else {
            background.isHidden = true
        }
    }
    
    

    @IBAction func ziggoSportSwitch(_ sender: UISwitch) {
        if ziggoSportSwitch.isOn{
            ziggoSportIsAan = true
            setDefaults.set(ziggoSportIsAan, forKey: "ziggoSportIsAan")
        }
        if ziggoSportSwitch.isOn == false{
            ziggoSportIsAan = false
            setDefaults.set(ziggoSportIsAan, forKey: "ziggoSportIsAan")
        }
    }

    @IBAction func ziggoSportTotaalSwitch(_ sender: UISwitch) {
        if ziggoSportTotaalSwitch.isOn{
            ziggoSportTotaalIsAan = true
            setDefaults.set(ziggoSportTotaalIsAan, forKey: "ziggoSportTotaalIsAan")
        }
        if ziggoSportTotaalSwitch.isOn == false{
            ziggoSportTotaalIsAan = false
            setDefaults.set(ziggoSportTotaalIsAan, forKey: "ziggoSportTotaalIsAan")
        }
    }

    @IBAction func FoxSportsEredivisieSwitch(_ sender: UISwitch) {
        if foxSportsEredivisieSwitch.isOn{
            foxSportsEredivisieIsAan = true
            setDefaults.set(foxSportsEredivisieIsAan, forKey: "foxSportsEredivisieIsAan")
        }
        if foxSportsEredivisieSwitch.isOn == false{
            foxSportsEredivisieIsAan = false
            setDefaults.set(foxSportsEredivisieIsAan, forKey: "foxSportsEredivisieIsAan")
        }
    }

    @IBAction func FoxSportsInternationaalSwitch(_ sender: UISwitch) {
        if foxSportsInternationaalSwitch.isOn{
            foxSportsInternationaalIsAan = true
            setDefaults.set(foxSportsInternationaalIsAan, forKey: "foxSportsInternationaalIsAan")
        }
        if foxSportsInternationaalSwitch.isOn == false{
            foxSportsInternationaalIsAan = false
            setDefaults.set(foxSportsInternationaalIsAan, forKey: "foxSportsInternationaalIsAan")
        }
    }
    
    func checkSavedData() {
        if setDefaults.value(forKey: "ziggoSportIsAan") != nil{
            let ziggoSportIsAan: Bool = setDefaults.value(forKey: "ziggoSportIsAan")  as! Bool
            if ziggoSportIsAan == true{
                ziggoSportSwitch.isOn = true
            }
            else if ziggoSportIsAan == false{
                ziggoSportSwitch.isOn = false
            }
        } else {
            ziggoSportSwitch.isOn = true
        }
        
        if setDefaults.value(forKey: "ziggoSportTotaalIsAan") != nil{
            let ziggoSportTotaalIsAan: Bool = setDefaults.value(forKey: "ziggoSportTotaalIsAan")  as! Bool
            if ziggoSportTotaalIsAan == true{
                ziggoSportTotaalSwitch.isOn = true
            }
            else if ziggoSportTotaalIsAan == false{
                ziggoSportTotaalSwitch.isOn = false
            }
        } else {
            ziggoSportTotaalSwitch.isOn = true
        }
        
        if setDefaults.value(forKey: "foxSportsEredivisieIsAan") != nil{
            let foxSportsEredivisieIsAan: Bool = setDefaults.value(forKey: "foxSportsEredivisieIsAan")  as! Bool
            if foxSportsEredivisieIsAan == true{
                foxSportsEredivisieSwitch.isOn = true
            }
            else if foxSportsEredivisieIsAan == false{
                foxSportsEredivisieSwitch.isOn = false
            }
        } else {
            foxSportsEredivisieSwitch.isOn = true
        }
        
        if setDefaults.value(forKey: "foxSportsInternationaalIsAan") != nil{
            let foxSportsInternationaalIsAan: Bool = setDefaults.value(forKey: "foxSportsInternationaalIsAan")  as! Bool
            if foxSportsInternationaalIsAan == true{
                foxSportsInternationaalSwitch.isOn = true
            }
            else if foxSportsInternationaalIsAan == false{
                foxSportsInternationaalSwitch.isOn = false
            }
        } else {
            foxSportsInternationaalSwitch.isOn = true
        }
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.backgroundTransition()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundTransition()
    }
    

    
    
}
