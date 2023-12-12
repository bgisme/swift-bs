//
//  Icon.swift
//  
//
//  Created by Brad Gourley on 12/26/22.
//

import SwiftHtml

open class Icon: I {
    
    public init(_ name: IconName) {
        super.init()
        self
            .class("bi \(name.rawValue)")
    }
}
