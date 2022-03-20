//
//  CloseButton.swift
//  
//
//  Created by Brad Gourley on 3/9/22.
//

import SwiftHtml

public class CloseButton: Component {
    
    let isDisabled: Bool
    let isWhite: Bool
    
    public init(dismiss: BsClass? = nil, isDisabled: Bool = false, isWhite: Bool = false) {
        self.isDisabled = isDisabled
        self.isWhite = isWhite
        super.init {
            Button()
                .dataBsDismiss(dismiss)
                .class(insert: .btnClose)
                .class(insert: .btnCloseWhite, if: isWhite)
                .ariaLabel("Close")
                .flagAttribute("disabled", nil, isDisabled)
        }
    }
}
