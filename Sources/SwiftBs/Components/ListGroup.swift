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
        
    public convenience init(as type: TagType = .ul,
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
        self.init(tag)
    }
    
    private override init(_ tag: Tag) {
        tag
            .class(insert: .listGroup)
        
        super.init(tag)
    }
    
    @discardableResult
    public func isFlush(if condition: Bool = true) -> Self {
        tag
            .class(insert: .listGroupFlush, if: condition)
        return self
    }
    
    @discardableResult
    public func isNumbered(if condition: Bool = true) -> Self {
        tag
            .class(insert: .listGroupNumbered, if: condition)
        return self
    }
    
    @discardableResult
    public func isHorizontal(if condition: Bool = true) -> Self {
        tag
            .class(insert: .listGroupHorizontal, if: condition)
        return self
    }
}

public class ListGroupItem: Component {
    
    public convenience init(_ text: String) {
        self.init(isActionable: false, Li(text))
    }
    
    public convenience init(li: () -> Li) {
        self.init(isActionable: false, li())
    }
    
    public convenience init(a: () -> A) {
        self.init(isActionable: true, a())
    }
    
    public convenience init(button: () -> Button) {
        self.init(isActionable: true,  button())
    }
    
    public convenience init(label: () -> Label) {
        self.init(isActionable: false, label())
    }
    
    private init(isActionable: Bool, _ tag: Tag) {
        tag
            .class(insert: .listGroupItem)
            .class(insert: .listGroupItemAction, if: isActionable)

        super.init(tag)
    }
    
    @discardableResult
    public func isActive(if condition: Bool = true) -> Self {
        tag
            .class(insert: .active, if: condition)
            .ariaCurrent(condition)
        return self
    }
    
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        tag
            .class(insert: .disabled, if: condition)
            .ariaDisabled(condition)
        return self
    }
    
    @discardableResult
    public func scrollspy(on id: String, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        tag.attribute("href", "#\(id)")
        return self
    }
}
