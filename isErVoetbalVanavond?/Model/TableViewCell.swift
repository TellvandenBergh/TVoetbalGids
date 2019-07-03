//
//  TableViewCell.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 07/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var tijdLabel: UILabel!
    
    @IBOutlet weak var thuisLabel: UILabel!
    @IBOutlet weak var uitLabel: UILabel!

    @IBOutlet weak var zenderLabel: UILabel!
    @IBOutlet weak var thuisLogo: UIImageView!
    @IBOutlet weak var uitLogo: UIImageView!
    @IBOutlet weak var league: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var cellBackground: UIView!
    

    
    
    func Myinit( tijdLabel: String, zenderLabel: String, thuisLabel: String, uitLabel: String, thuisLogoImageName: String, uitLogoImageName: String, logoImageName: String, backgroundName: String) {
        self.tijdLabel.text = tijdLabel
        self.zenderLabel.text = zenderLabel
        self.thuisLabel.text = thuisLabel
        self.uitLabel.text = uitLabel
        thuisLogo.image = UIImage(named: thuisLogoImageName)
        uitLogo.image = UIImage(named: uitLogoImageName)
        league.image = UIImage(named: logoImageName)
        background.image = UIImage(named: backgroundName)
        background.layer.cornerRadius = 20
        background.clipsToBounds = true
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        visualEffectView.layer.cornerRadius = 20
        visualEffectView.clipsToBounds = true
        visualEffectView.alpha = 0.9
    }
    


    
}
