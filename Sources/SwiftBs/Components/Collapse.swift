import SwiftHtml

public class Collapse: Component {
        
    let tag: Tag
    let id: String
    let contents: Div
    
    public convenience init(_ a: A, id: String, @TagBuilder contents: () -> [Tag]) {
        a
            .href(id)
            .role(.button)
        self.init(tag: a, id: id, contents: contents)
    }
    
    public convenience init(_ button: Button? = nil, id: String, @TagBuilder contents: () -> [Tag]) {
        let button = button != nil ? button! : Button()
        button
            .type(.button)
            .dataBsTarget(id)
        self.init(tag: button, id: id, contents: contents)
    }
    
    internal init(tag: Tag, id: String, @TagBuilder contents: () -> [Tag]) {
        self.tag = tag
        self.id = id
        self.contents = Div {
            contents()
        }
    }
}

extension Collapse: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        P {
            tag
        }
        Div {
            contents
                .class(.collapse)
                .id(id)
        }
        .dataBsToggle(.collapse)
        .ariaExpanded(false)
        .ariaControls(id)
    }
}
