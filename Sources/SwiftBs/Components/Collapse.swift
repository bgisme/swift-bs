import SwiftHtml


public class Collapse: Component {
    
    public enum Orientation {
        case horizontal(pixelWidth: Int)
        case vertical
    }
        
    let orientation: Orientation
    let buttons: [Tag]
    let contents: [Tag]
    
    public convenience init(_ orientation: Orientation = .vertical,
                buttons: [CollapseButton],
                contents: [CollapseContent]) {
        self.init(orientation,
                  buttons: { buttons.map{$0} },
                  contents: { contents.map{$0} })
    }
    
    public init(_ orientation: Orientation = .vertical,
                @TagBuilder buttons: () -> [Tag],
                @TagBuilder contents: () -> [Tag]) {
        self.orientation = orientation
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
        switch orientation {
        case .horizontal(let pixelWidth):
            Div {
                Div {
                    contents
                }
                .class(.collapse, .collapseHorizontal)
                .style(.width("\(pixelWidth)px;"))
                .addClassesStyles(self)
            }
        case .vertical:
            Div {
                contents
            }
            .class(.collapse)
            .addClassesStyles(self)
        }
    }
}

public class CollapseButton: Component {
    
    let tag: Tag
    let ids: [String]
    
    public convenience init(_ title: String, contents: [CollapseContent]) {
        self.init(Button(title), contents: contents)
    }
    
    public convenience init(_ a: A, contents: [CollapseContent]) {
        let ids = !contents.isEmpty ? contents.map{$0.id} : [String()]
        _ = a
            .role(.button)
            .href(ids.count < 2 ? "#\(ids.first!)" : BsClass.multiCollapse.rawValue)
        self.init(tag: a, contents: contents)
    }
    
    public convenience init(_ button: Button, contents: [CollapseContent]) {
        let ids = !contents.isEmpty ? contents.map{$0.id} : [String()]
        button
            .type(.button)
            .dataBsTarget(ids.count < 2 ? "#\(ids.first!)" : BsClass.multiCollapse.rawValue, isHashPrefixed: false)
        self.init(tag: button, contents: contents)
    }

    internal init(tag: Tag, contents: [CollapseContent]) {
        if contents.count > 1 {
            // add ".multi-collapse" to CollapseContent and class will be added in its func build() -> Tag
            _ = contents.map{$0.class(add: .multiCollapse)}
        }
        self.tag = tag
        self.ids = contents.map{$0.id}
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
    let div: Div
    
    public convenience init(id: String, @TagBuilder content: () -> [Tag]) {
        self.init(id: id, Div{ content() })
    }
    
    public init(id: String, _ div: Div) {
        self.id = id
        self.div = div
    }
}

extension CollapseContent: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(.collapse)
            .id(id)
            .addClassesStyles(self)
    }
}
