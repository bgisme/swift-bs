import SwiftHtml
import SwiftSgml
import AppKit


public class Collapse: Component {
    
    public enum Orientation {
        case horizontal(width: String)
        case vertical
    }
    
    let width: String
    let buttons: [Tag]
    let contents: [Tag]
        
    public init(orientation: Orientation = .vertical,
                @TagBuilder buttons: () -> [Tag],
                @TagBuilder contents: () -> [Tag]) {
        switch orientation {
        case .horizontal(let width):
            self.width = width
        case .vertical:
            self.width = String()
        }
        self.buttons = buttons()
        self.contents = contents()
    }
}

extension Collapse: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        P {
            buttons
        }
        Div {
            contents
        }
        .class(add: .collapse)
        .class(add: .collapseHorizontal, if: !width.isEmpty)
        .style(add: .width(width), if: !width.isEmpty)
    }
}

public class CollapseButton: Component {
    
    let tag: Tag
    let ids: [String]
    
    public convenience init(_ a: A, contentIds ids: [String]) {
        let ids = !ids.isEmpty ? ids : [String()]
        _ = a
            .role(.button)
            .href(ids.count < 2 ? "#\(ids.first!)" : BsClass.multiCollapse.rawValue)
        let tag = BsButton(a).build()
        self.init(tag: tag, contentIds: ids)
    }
    
    public convenience init(_ button: Button, contentIds ids: [String]) {
        let ids = !ids.isEmpty ? ids : [String()]
        let tag = BsButton(button).build()
        tag
            .type(.button)
            .dataBsTarget(ids.count < 2 ? "#\(ids.first!)" : BsClass.multiCollapse.rawValue, isHashPrefixed: false)
        self.init(tag: tag, contentIds: ids)
    }
    
    internal init(tag: Tag, contentIds ids: [String]) {
        self.tag = tag
        self.ids = ids
    }
}

extension CollapseButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .dataBsToggle(.collapse)
            .ariaExpanded(false)
            .ariaControls(ids.map{$0}.joined(separator: " "))
            .addClassesStyles(self)
    }
}

public class CollapseContent: Component {
    
    let id: String
    var isSibling: Bool
    let div: Div
    
    public init(id: String,
                isSibling: Bool = false,
                _ div: Div) {
        self.id = id
        self.isSibling = isSibling
        self.div = div
    }
}

extension CollapseContent: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .multiCollapse, if: isSibling)
            .id(id)
            .addClassesStyles(self)
    }
}
