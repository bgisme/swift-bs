//
//  ListGroup.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class ListGroup: Component {
    
    public enum TagType {
        case ol
        case ul
        case div
    }
        
    /// contents ... ListGroupItems
    public init(isFlush: Bool = false,
                            isNumbered: Bool = false,
                            isHorizontal: Bool = false,
                            type: TagType,
                            @TagBuilder listGroupItems: () -> [Tag]) {
        let tag: Tag
        switch type {
        case .ol:
            tag = Ol { listGroupItems() }
        case .ul:
            tag = Ul { listGroupItems() }
        case .div:
            tag = Div { listGroupItems() }
        }
        super.init {
            tag
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
    
    private init(isAction: Bool,
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
