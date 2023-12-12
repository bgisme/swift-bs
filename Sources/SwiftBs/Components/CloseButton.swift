//
//  CloseButton.swift
//  
//
//  Created by Brad Gourley on 12/26/22.
//

import SwiftHtml

open class CloseButton: Button {
        
    public enum Dismiss {
        case alert
        case modal
        case offcanvas
        case toast
        
        var `class`: Utility {
            switch self {
            case .alert:
                return .alert
            case .modal:
                return .modal
            case .offcanvas:
                return .offcanvas
            case .toast:
                return .toast
            }
        }
    }
    
    public convenience init(dismiss: Dismiss) {
        self.init(dismiss: dismiss) {}
    }
    
    public init(dismiss: Dismiss, @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .dataBsDismiss(dismiss.class)
            .class(insert: .btnClose)
            .ariaLabel("Close")
    }
    
    @discardableResult
    public func dismiss(_ value: Dismiss, _ condition: Bool = true) -> Self {
        self.dataBsDismiss(value.class, condition)
    }
    
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        self.flagAttribute("disabled", nil, condition)
    }
    
    @discardableResult
    public func isWhite(if condition: Bool = true) -> Self {
        self.class(insert: .btnCloseWhite, if: condition)
    }
}
