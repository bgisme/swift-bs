//
//  ListGroup.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class ListGroup: Component {
        
    public convenience init(isFlush: Bool = false,
                            isNumbered: Bool = false,
                            isHorizontal: Bool = false,
                            ol: () -> Ol) {
        self.init(isFlush: isFlush, isNumbered: isNumbered, isHorizontal: isHorizontal, tag: { ol() })
    }
    
    public convenience init(isFlush: Bool = false,
                            isNumbered: Bool = false,
                            isHorizontal: Bool = false,
                            ul: () -> Ul) {
        self.init(isFlush: isFlush, isNumbered: isNumbered, isHorizontal: isHorizontal, tag: { ul() })
    }
    
    public convenience init(isFlush: Bool = false,
                            isNumbered: Bool = false,
                            isHorizontal: Bool = false,
                            div: () -> Div) {
        self.init(isFlush: isFlush, isNumbered: isNumbered, isHorizontal: isHorizontal, tag: { div() })
    }
    
    internal init(isFlush: Bool = false,
                  isNumbered: Bool = false,
                  isHorizontal: Bool = false,
                  tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .listGroup)
                .class(insert: .listGroupFlush, if: isFlush)
                .class(insert: .listGroupNumbered, if: isNumbered)
                .class(insert: .listGroupHorizontal, if: isHorizontal)
        }
    }
}

public class ListGroupItem: Component {
    
    public convenience init(_ text: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(isAction: false, isActive: isActive, isDisabled: isDisabled) {
            Li(text)
        }
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            li: () -> Li) {
        self.init(isAction: false, isActive: isActive, isDisabled: isDisabled) { li() }
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            a: () -> A) {
        self.init(isAction: true, isActive: isActive, isDisabled: isDisabled) { a() }
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            button: () -> Button) {
        self.init(isAction: true, isActive: isActive, isDisabled: isDisabled) { button() }
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            label: () -> Label) {
        self.init(isAction: false, isActive: isActive, isDisabled: isDisabled) { label() }
    }
    
    internal init(isAction: Bool,
                  isActive: Bool,
                  isDisabled: Bool,
                  tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .listGroupItem)
                .class(insert: .listGroupItemAction, if: isAction)
                .class(insert: .active, if: isActive)
                .ariaCurrent(isActive)
                .class(insert: .disabled, if: isDisabled)
                .ariaDisabled(isDisabled)
        }
    }
}
