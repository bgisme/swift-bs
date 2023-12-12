//
//  ListGroup.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

open class ListGroup: Tag {
    
    public enum Kind: String {
        case ol
        case ul
        case div
    }
        
    public init(_ kind: Kind = .ul,
                @TagBuilder items: () -> [ListGroupItem]) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   items())
        self
            .class(insert: .listGroup)
    }
    
    @discardableResult
    public func isFlush(if condition: Bool = true) -> Self {
        self.class(insert: .listGroupFlush, if: condition)
    }
    
    @discardableResult
    public func isNumbered(if condition: Bool = true) -> Self {
        self.class(insert: .listGroupNumbered, if: condition)
    }
    
    @discardableResult
    public func isHorizontal(if condition: Bool = true) -> Self {
        self.class(insert: .listGroupHorizontal, if: condition)
    }
}

open class ListGroupItem: Tag {
    
    public enum Kind: String {
        case a
        case button
        case label
        case li
    }
    
    public convenience init(_ text: String) {
        self.init(.li) { Text(text) }
    }

    public init(_ kind: Kind,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .listGroupItem)
            .class(insert: .listGroupItemAction, if: kind == .a || kind == .button)
    }
    
    @discardableResult
    public func isActive(if condition: Bool = true) -> Self {
        self
            .class(insert: .active, if: condition)
            .ariaCurrent(condition)
    }
    
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        self
            .class(insert: .disabled, if: condition)
            .ariaDisabled(condition)
    }
    
    @discardableResult
    public func scrollspy(on id: String, _ condition: Bool = true) -> Self {
        self.attribute("href", "#\(id)", condition)
    }
}
