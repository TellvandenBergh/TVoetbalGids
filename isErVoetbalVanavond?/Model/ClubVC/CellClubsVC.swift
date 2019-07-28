//
//  CellClubsVC.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 14/02/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation
import UIKit

class CellClubsVC: UITableViewCell {
    
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!

    func Myinit(imageName: String, labelName: String) {
        
        imageOutlet.image = UIImage(named: imageName)
        labelOutlet.text = labelName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        visualEffectView.layer.cornerRadius = 20
        visualEffectView.clipsToBounds = true
        visualEffectView.alpha = 0.75
        labelOutlet.adjustsFontSizeToFitWidth = true
    }
}
