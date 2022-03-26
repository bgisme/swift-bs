//
//  CloseButton.swift
//  
//
//  Created by Brad Gourley on 3/9/22.
//

import SwiftHtml

public class CloseButton: Component {
    
    public enum Dismiss {
        case alert
        case modal
        case offcanvas
        
        var `class`: BsClass {
            switch self {
            case .alert:
                return .alert
            case .modal:
                return .modal
            case .offcanvas:
                return .offcanvas
            }
        }
    }
    
    public convenience init(dismiss: Dismiss) {
        self.init(dismiss: dismiss, Button())
    }
    
    public init(dismiss: Dismiss, _ button: Button) {
        button
            .dataBsDismiss(dismiss.class)
            .class(insert: .btnClose)
            .ariaLabel("Close")

        super.init(button)
    }
    
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .flagAttribute("disabled", nil)
        return self
    }
    
    @discardableResult
    public func isWhite(if condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .class(insert: .btnCloseWhite)
        return self
    }
    
    @discardableResult
    public func ariaLabel(_ value: String, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .ariaLabel(value)
        return self
    }
}
