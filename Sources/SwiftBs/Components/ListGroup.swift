import SwiftHtml
import SwiftSgml

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
    }
}

public class ListGroupItem: Component {
    
    let tag: Tag
    
    public convenience init(_ text: String) {
        self.init(tag: Li(text))
    }
    
    public convenience init(_ li: Li) {
        self.init(tag: li)
    }
    
    public convenience init(_ a: A) {
        self.init(tag: a)
    }
    
    public convenience init(_ button: Button) {
        self.init(tag: button)
    }
    
    public convenience init(_ label: Label) {
        self.init(tag: label)
    }
    
    internal init(tag: Tag) {
        self.tag = tag
    }
}

extension ListGroupItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .listGroupItem)
    }
}

public class ListGroupActionItem: Component {
    
    let tag: Tag
    
    internal init(tag: Tag) {
        self.tag = tag
    }
}

extension ListGroupActionItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .listGroupItem, .listGroupItemAction)
    }
}
