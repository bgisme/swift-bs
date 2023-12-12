//
//  InputGroup.swift
//  
//
//  Created by Brad Gourley on 6/26/22.
//

import SwiftHtml

open class InputGroup: Div {
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .inputGroup)
    }
    
    @discardableResult
    public func noWrap() -> Self {
        self.class(insert: .flexNowrap)
    }
}
