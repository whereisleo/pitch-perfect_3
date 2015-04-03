//
//  RecordedAudio.swift
//  Pitch Perfect-Leo
//
//  Created by Leonardo Martinez on 3/20/15.
//  Copyright (c) 2015 LooseMonkey. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String){
        
        self.filePathUrl = filePathUrl
        self.title = title
        
    }
    
    
}