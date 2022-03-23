//
//  Container.swift
//  
//
//  Created by Brad Gourley on 3/23/22.
//

import SwiftHtml

public class Container: Component {
    
    public init(type: TagType = .div, @TagBuilder contents: () -> [Tag]) {
        super.init {
            type.tag(contents)
        }
    }
}
