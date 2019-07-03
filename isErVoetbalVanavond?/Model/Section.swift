//
//  Section.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 08/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation

struct Section {
    var sectionName : String
    var sectionObjects : [Wedstrijd]
    var expanded = false
    
    init(sectionName: String, sectionObjects: [Wedstrijd], expanded: Bool) {
        self.sectionName = sectionName
        self.sectionObjects = sectionObjects
        self.expanded = expanded
    }
}
