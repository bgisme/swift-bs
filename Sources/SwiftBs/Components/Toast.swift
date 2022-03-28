//
//  Toast.swift
//  
//
//  Created by Brad Gourley on 3/28/22.
//

import SwiftHtml

public class ToastContainer: Component {
    
    public convenience init(div: () -> Div) {
        self.init(div())
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .toastContainer)
        
        super.init(div)
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
    public func id(_ value: String?, _ condition: Bool = true) -> Self {
        guard condition, let value = value else { return self }
        _ = tag.id(value)
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
