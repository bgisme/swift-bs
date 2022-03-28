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
    
    public convenience init(id: String, @TagBuilder contents: () -> [Tag]) {
        let div = Div {
            contents()
        }
        self.init(id: id, div)
    }
    
    public init(id: String, _ div: Div) {
        _ = div
            .class(insert: .toast)
            .role(.alert)
            .ariaLive(.assertive)
            .ariaAtomic(true)
            .id(id)
        
        super.init(div)
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
    
    public init(_ div: Div) {
        div
            .class(insert: .toastBody)
        
        super.init(div)
    }
}
