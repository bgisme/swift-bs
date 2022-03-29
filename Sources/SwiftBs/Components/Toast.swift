//
//  Toast.swift
//  
//
//  Created by Brad Gourley on 3/28/22.
//

import SwiftHtml

public class ToastContainer: Component {
    
    public enum Placement {
        case topLeft
        case topCenter
        case topRight
        case middleLeft
        case middleCenter
        case middleRight
        case bottomLeft
        case bottomCenter
        case bottomRight
        
        var classes: [BsClass] {
            switch self {
            case .topLeft:
                return [.top0, .start0]
            case .topCenter:
                return [.top0, .start50, .translateMiddleX]
            case .topRight:
                return [.top0, .end0]
            case .middleLeft:
                return [.top50, .start0, .translateMiddleY]
            case .middleCenter:
                return [.top50, .start50, .translateMiddle]
            case .middleRight:
                return [.top50, .end0, .translateMiddleY]
            case .bottomLeft:
                return [.bottom0, .start0]
            case .bottomCenter:
                return [.bottom0, .start50, .translateMiddleX]
            case .bottomRight:
                return [.bottom0, .end0]
            }
        }
    }
        
    public convenience init(@TagBuilder toasts: () -> [Tag]) {
        let div = Div {
            toasts()
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .toastContainer)
        
        super.init(div)
    }
    
    @discardableResult
    public func placement(_ value: Placement, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .class(insert: value.classes)
            .style(set: .zIndex("11"))
        return self
    }
}

public class Toast: Component {
    
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div {
            contents()
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .toast)
            .role(.alert)
            .ariaLive(.assertive)
            .ariaAtomic(true)
        
        super.init(div)
    }
    
    @discardableResult
    public func placement(_ value: ToastContainer.Placement, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .class(insert: value.classes)
            .style(set: .zIndex("11"))
        return self
    }
}

public class ToastHeader: Component {
    
    public convenience init(_ closeButton: CloseButton, @TagBuilder contents: () -> [Tag]) {
        let div = Div {
            contents()
            closeButton.dismiss(.toast)
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .toastHeader)
        
        super.init(div)
    }
}

public class ToastBody: Component {
    
    public convenience init(div: () -> Div) {
        self.init(div())
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .toastBody)
        
        super.init(div)
    }
}
