//
//  Checklist.swift
//  Checklists
//
//  Created by Sebastien Arbogast on 26/08/2016.
//  Copyright © 2016 BusinessTraining. All rights reserved.
//

import Foundation

class Checklist {
    var title:String = ""
    var done:Bool = false
    
    init(withTitle:String) {
        self.title = withTitle
        self.done = false
    }
}