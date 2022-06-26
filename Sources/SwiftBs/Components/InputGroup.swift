//
//  InputGroup.swift
//  
//
//  Created by Brad Gourley on 6/26/22.
//

import SwiftHtml

public class InputGroup: Component {
    
    public init(@TagBuilder contents: () -> [Tag]) {
        let div = Div {
            contents()
        }.class(insert: .inputGroup)
        
        super.init(div)
    }
    
    @discardableResult
    public func noWrap() -> Self {
        tag.class(insert: .flexNowrap)
        return self
    }
}
