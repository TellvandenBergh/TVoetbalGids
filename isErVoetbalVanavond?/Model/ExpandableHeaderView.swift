//
//  ExpandableHeaderView.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 16/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelagete {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    var delegate: ExpandableHeaderViewDelagete?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been iplementededet")
    }
    
    @objc func selectHeaderAction(getsureRecognizer: UITapGestureRecognizer) {
        let cell = getsureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelagete) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
