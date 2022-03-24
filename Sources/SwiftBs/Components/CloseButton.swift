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
    
    public convenience init(dismiss: BsClass? = nil, isDisabled: Bool = false, isWhite: Bool = false) {
        self.init(dismiss: dismiss, isDisabled: isDisabled, isWhite: isWhite, Button())
    }
    
    public init(dismiss: BsClass? = nil,
                isDisabled: Bool = false,
                isWhite: Bool = false,
                _ button: Button) {
        self.isDisabled = isDisabled
        self.isWhite = isWhite
        button
            .dataBsDismiss(dismiss)
            .class(insert: .btnClose)
            .class(insert: .btnCloseWhite, if: isWhite)
            .ariaLabel("Close")
            .flagAttribute("disabled", nil, isDisabled)

        super.init(button)
    }
}
