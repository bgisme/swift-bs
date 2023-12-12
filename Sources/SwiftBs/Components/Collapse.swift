
import SwiftHtml

//open class Collapse: GroupTag {
//
//    public typealias Id = String
//
//    let triggersContainer: Tag?
//    let contentsContainer: Tag?
//    let buttons: [CollapseButton]?
//    let content: CollapseContent?
//
//    public convenience init(id: Id,
//                            isExpanded: Bool = false,
//                            button: () -> Button,
//                            @TagBuilder contents: () -> [Tag]) {
//        self.init(triggersContainer: nil,
//                  contentsContainer: nil,
//                  buttons: [CollapseButton(contentId: id, button: button).isExpanded(if: isExpanded)],
//                  content: CollapseContent(id: id, contents: contents).isExpanded(if: isExpanded))
//    }
//
//    public convenience init(id: Id,
//                            isExpanded: Bool = false,
//                            a: () -> A,
//                            @TagBuilder contents: () -> [Tag]) {
//        self.init(triggersContainer: nil,
//                  contentsContainer: nil,
//                  buttons: [CollapseButton(contentId: id, a: a).isExpanded(if: isExpanded)],
//                  content: CollapseContent(id: id, contents: contents).isExpanded(if: isExpanded))
//    }
//
//    public convenience init(ids: [Id],
//                            @TagBuilder triggersContainer: ([Id]) -> Tag,
//                            content: ([Id]) -> CollapseContent) {
//        self.init(triggersContainer: triggersContainer(ids),
//                  contentsContainer: nil,
//                  buttons: nil,
//                  content: content(ids))
//    }
//
//    public convenience init(ids: [Id],
//                            triggersContainer: ([Id]) -> Tag,
//                            contentsContainer: ([Id]) -> Tag) {
//        self.init(triggersContainer: triggersContainer(ids),
//                  contentsContainer: contentsContainer(ids),
//                  buttons: nil,
//                  content: nil)
//    }
//
//    private init(triggersContainer: Tag?,
//                 contentsContainer: Tag?,
//                 buttons: [CollapseButton]?,
//                 content: CollapseContent?) {
//        self.triggersContainer = triggersContainer
//        self.contentsContainer = contentsContainer
//        self.buttons = buttons
//        self.content = content
//    }
//
//    @TagBuilder
//    public func build() -> Tag {
//        if let triggersContainer = triggersContainer {
//            triggersContainer
//        }
//        if let contentsContainer = contentsContainer {
//            contentsContainer
//        }
//        if let buttons = buttons {
//            buttons
//        }
//        if let content = content {
//            content
//        }
//    }
//
//    public convenience init(ids: [Id],
//                            @TagBuilder triggers: ([Id]) -> [Tag],
//                            @TagBuilder containers: ([Id]) -> [Tag]) {
//
//    }
//}

open class CollapseButton: Tag {
    
    public enum Kind: String {
        case a
        case button
    }
    
    public init(_ kind: Kind,
                contentIds ids: [String],
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        switch kind {
        case .a:
            self
                .class(insert: .btn)
                .role(.button)
                .attribute("href", ids.count < 2 ? "#\(ids.first ?? "")" : Utility.multiCollapse.rawValue)
        case .button:
            self
                .class(insert: .btn)
                .type(.button)
                .dataBsTarget(ids.count < 2 ? ids.first ?? "" : Utility.multiCollapse.rawValue, prefix: ids.count < 2 ? .hash : .dot)
        }
        self
            .dataBsToggle(.collapse)
            .ariaControls(ids.map{$0}.joined(separator: " "))
            .class(insert: .collapsed)
    }
        
    @discardableResult
    public func isExpanded(if condition: Bool) -> Self {
        self
            .class(remove: .collapsed, condition)
            .ariaExpanded(true, condition)
    }
}

open class CollapseContent: Div {
    
    public init(id: String,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .collapse)
            .id(id)
    }
        
    ///@NOTE: style='max-width:...' applied to all children
    @discardableResult
    public func isHorizontal(maxWidth: String?, if condition: Bool = true) -> Self {
        guard condition else { return self}
        _ = children?.map { $0.style(set: .maxWidth(maxWidth)) }
        return self
            .class(insert: .collapseHorizontal)
    }
    
    @discardableResult
    public func isExpanded(if condition: Bool = true) -> Self {
        self.class(insert: .show, if: condition)
    }
    
    @discardableResult
    public func isMultiCollapse(if condition: Bool = true) -> Self {
        self.class(insert: .multiCollapse, if: condition)
    }
}
