//
//  ListGroup.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class ListGroup: Component {
    
    public enum `Type` {
        case ol
        case ul
        case div
    }
    
    let tag: Tag
    let isFlush: Bool
    let isNumbered: Bool
    let isHorizontal: Bool
    
    public init(_ type: `Type` = .ul,
                isFlush: Bool = false,
                isNumbered: Bool = false,
                isHorizontal: Bool = false,
                @TagBuilder items: () -> [Tag]) {
        let tag: Tag
        switch type {
        case .ol:
            tag = Ol { items() }
        case .ul:
            tag = Ul { items() }
        case .div:
            tag = Div { items() }
        }
        self.tag = tag
        self.isFlush = isFlush
        self.isNumbered = isNumbered
        self.isHorizontal = isHorizontal
    }
}

extension ListGroup: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .listGroup)
            .class(add: .listGroupFlush, if: isFlush)
            .class(add: .listGroupNumbered, if: isNumbered)
            .class(add: .listGroupHorizontal, if: isHorizontal)
            .addClassesStyles(self)
    }
}

public class ListGroupItem: Component {
    
    let tag: Tag
    let isAction: Bool
    let isActive: Bool
    let isDisabled: Bool
    
    public convenience init(_ text: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(tag: Li(text), isAction: false, isActive: isActive, isDisabled: isDisabled)
    }
    
    public convenience init(_ li: Li,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(tag: li, isAction: false, isActive: isActive, isDisabled: isDisabled)
    }
    
    public convenience init(_ a: A,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(tag: a, isAction: true, isActive: isActive, isDisabled: isDisabled)
    }
    
    public convenience init(_ button: Button,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(tag: button, isAction: true, isActive: isActive, isDisabled: isDisabled)
    }
    
    public convenience init(_ label: Label,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(tag: label, isAction: false, isActive: isActive, isDisabled: isDisabled)
    }
    
    internal init(tag: Tag,
                  isAction: Bool,
                  isActive: Bool,
                  isDisabled: Bool) {
        self.tag = tag
        self.isAction = isAction
        self.isActive = isActive
        self.isDisabled = isDisabled
    }
}

extension ListGroupItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .listGroupItem)
            .class(add: .listGroupItemAction, if: isAction)
            .class(add: .active, if: isActive)
            .ariaCurrent(isActive)
            .class(add: .disabled, if: isDisabled)
            .ariaDisabled(isDisabled)
            .addClassesStyles(self)
    }
}
