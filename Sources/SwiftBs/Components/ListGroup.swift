import SwiftHtml
import SwiftSgml

public class ListGroup: Component {
    
    let tag: Tag
    let isFlush: Bool
    let isNumbered: Bool
    let isHorizontal: Bool
    
    public convenience init(isFlush: Bool = false,
                            isNumbered: Bool = false,
                            isHorizontal: Bool = false,
                            @TagBuilder unordered items: () -> [Tag]) {
        self.init(tag: Ul { items() }, isFlush: isFlush, isNumbered: isNumbered, isHorizontal: isHorizontal)
    }
    
    public convenience init(isFlush: Bool = false,
                            isNumbered: Bool = false,
                            isHorizontal: Bool = false,
                            @TagBuilder ordered items: () -> [Tag]) {
        self.init(tag: Ol { items() }, isFlush: isFlush, isNumbered: isNumbered, isHorizontal: isHorizontal)
    }
    
    public convenience init(isFlush: Bool = false,
                            isNumbered: Bool = false,
                            isHorizontal: Bool = false,
                            @TagBuilder action items: () -> [Tag]) {
        self.init(tag: Div { items() }, isFlush: isFlush, isNumbered: isNumbered, isHorizontal: isHorizontal)
    }

    internal init(tag: Tag,
                  isFlush: Bool,
                  isNumbered: Bool,
                  isHorizontal: Bool) {
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
