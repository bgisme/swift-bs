//
//  ListGroup.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class ListGroup: Component {
    
    let tag: Tag
    let isFlush: Bool
    let isNumbered: Bool
    let isHorizontal: Bool
    
    internal init(isFlush: Bool = false,
                  isNumbered: Bool = false,
                  isHorizontal: Bool = false,
                  tag: () -> Tag) {
        self.isFlush = isFlush
        self.isNumbered = isNumbered
        self.isHorizontal = isHorizontal
        self.tag = tag()
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
            .merge(attributes)
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
        self.isAction = isAction
        self.isActive = isActive
        self.isDisabled = isDisabled
        self.tag = tag()
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
            .merge(attributes)
    }
}
