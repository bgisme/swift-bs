import SwiftHtml


public class Collapse: Component {
    
    let buttons: [Tag]
    let contents: [Tag]
    
    public convenience init(_ button: CollapseButton,
                            _ content: CollapseContent) {
        self.init(buttons: [button], contents: [content])
    }
    
    public convenience init(buttons: [CollapseButton],
                            contents: [CollapseContent]) {
        self.init(buttons: { buttons.map{$0} },
                  contents: { contents.map{$0} })
    }
    
    public init(@TagBuilder buttons: () -> [Tag],
                @TagBuilder contents: () -> [Tag]) {
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
        contents
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
    
    public enum Orientation {
        case horizontal(pixelWidth: Int)
        case vertical
    }
    
    let orientation: Orientation
    let id: String
    var isSibling: Bool
    let div: Div
    
    public convenience init(orientation: Orientation = .vertical,
                            id: String,
                            isSibling: Bool = false,
                            _ text: String) {
        self.init(orientation: orientation, id: id, isSibling: isSibling) { Text(text) }
    }
    
    public convenience init(orientation: Orientation = .vertical,
                            id: String,
                            isSibling: Bool = false,
                            @TagBuilder content: () -> [Tag]) {
        self.init(orientation: orientation, id: id, isSibling: isSibling, Div{ content() })
    }
    
    public init(orientation: Orientation = .vertical,
                id: String,
                isSibling: Bool = false,
                _ div: Div) {
        self.orientation = orientation
        self.id = id
        self.isSibling = isSibling
        self.div = div
    }
}

extension CollapseContent: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        switch orientation {
        case .horizontal(let pixelWidth):
            Div {
                div
            }
            .class(.collapse, .collapseHorizontal)
            .style(.width("\(pixelWidth)px;"))
            .addClassesStyles(self)
        case .vertical:
            div
                .class(.collapse)
                .class(add: .multiCollapse, if: isSibling)
                .id(id)
                .addClassesStyles(self)
        }
    }
}
