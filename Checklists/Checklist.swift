//
//  Checklist.swift
//  Checklists
//
//  Created by Sebastien Arbogast on 26/08/2016.
//  Copyright © 2016 BusinessTraining. All rights reserved.
//

import Foundation

class Checklist : NSObject, NSCoding{
    var title:String = ""
    var done:Bool = false
    static let TitleKey = "Title"
    static let DoneKey = "Done"
    
    init(withTitle:String) {
        self.title = withTitle
        self.done = false
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init()
        title = aDecoder.decodeObjectForKey(Checklist.TitleKey) as! String
        done = aDecoder.decodeBoolForKey(Checklist.DoneKey)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: Checklist.TitleKey)
        aCoder.encodeBool(done, forKey: Checklist.DoneKey)
    }
}