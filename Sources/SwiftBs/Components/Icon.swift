//
//  Icon.swift
//  
//
//  Created by Brad Gourley on 5/7/22.
//

import SwiftHtml

public class Icon: Component {
        
    init(_ name: IconName) {
        let tag = I().class("bi \(name.rawValue)")
        super.init(tag)
    }
}
