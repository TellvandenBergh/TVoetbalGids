//
//  CellMainVC.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 07/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit

class CellMainVC: UITableViewCell {

    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!

    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var thuisLogo: UIImageView!
    @IBOutlet weak var uitLogo: UIImageView!
    @IBOutlet weak var league: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var cellBackground: UIView!
  
  
    func Myinit( timeLabel: String, channelLabel: String, homeLabel: String, awayLabel: String, homeLogoImageName: String, awayLogoImageName: String, logoImageName: String, backgroundName: String) {
        self.timeLabel.text = timeLabel
        self.channelLabel.text = channelLabel
        self.homeLabel.text = homeLabel
        self.awayLabel.text = awayLabel
        thuisLogo.image = UIImage(named: homeLogoImageName)
        uitLogo.image = UIImage(named: awayLogoImageName)
        league.image = UIImage(named: logoImageName)
        background.image = UIImage(named: backgroundName)
        background.layer.cornerRadius = 20
        background.clipsToBounds = true
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        visualEffectView.layer.cornerRadius = 20
        visualEffectView.clipsToBounds = true
        visualEffectView.alpha = 0.9
    }
}
