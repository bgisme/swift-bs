//
//  CloseButton.swift
//  
//
//  Created by Brad Gourley on 3/9/22.
//

import SwiftHtml

public class CloseButton: Component {
    
    let button: Button
    let isDisabled: Bool
    let isWhite: Bool
    
    public init(isDisabled: Bool = false, isWhite: Bool = false) {
        self.button = Button()
        self.isDisabled = isDisabled
        self.isWhite = isWhite
    }
}

extension CloseButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        button
            .class(add: .btnClose)
            .class(add: .btnCloseWhite, if: isWhite)
            .ariaLabel("Close")
            .flagAttribute("disabled", nil, isDisabled)
            .merge(self.attributes)
    }
}
