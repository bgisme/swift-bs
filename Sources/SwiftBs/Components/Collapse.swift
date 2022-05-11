//
//  Collapse.swift
//
//
//  Created by Brad Gourley on 3/9/22.
//

import SwiftHtml

public class Collapse: TagRepresentable {
    
    public typealias Id = String
    
    let triggersContainer: Tag?
    let contentsContainer: Tag?
    let buttons: [CollapseButton]?
    let content: CollapseContent?
    
    public convenience init(id: Id,
                            isExpanded: Bool = false,
                            button: () -> Button,
                            @TagBuilder contents: () -> [Tag]) {
        self.init(triggersContainer: nil,
                  contentsContainer: nil,
                  buttons: [CollapseButton(contentId: id, button: button).isExpanded(if: isExpanded)],
                  content: CollapseContent(id: id, contents: contents).isExpanded(if: isExpanded))
    }
    
    public convenience init(id: Id,
                            isExpanded: Bool = false,
                            a: () -> A,
                            @TagBuilder contents: () -> [Tag]) {
        self.init(triggersContainer: nil,
                  contentsContainer: nil,
                  buttons: [CollapseButton(contentId: id, a: a).isExpanded(if: isExpanded)],
                  content: CollapseContent(id: id, contents: contents).isExpanded(if: isExpanded))
    }
    
    public convenience init(ids: [Id],
                            @TagBuilder triggersContainer: ([Id]) -> Tag,
                            content: ([Id]) -> CollapseContent) {
        self.init(triggersContainer: triggersContainer(ids),
                  contentsContainer: nil,
                  buttons: nil,
                  content: content(ids))
    }
    
    public convenience init(ids: [Id],
                            triggersContainer: ([Id]) -> Tag,
                            contentsContainer: ([Id]) -> Tag) {
        self.init(triggersContainer: triggersContainer(ids),
                  contentsContainer: contentsContainer(ids),
                  buttons: nil,
                  content: nil)
    }
    
    private init(triggersContainer: Tag?,
                 contentsContainer: Tag?,
                 buttons: [CollapseButton]?,
                 content: CollapseContent?) {
        self.triggersContainer = triggersContainer
        self.contentsContainer = contentsContainer
        self.buttons = buttons
        self.content = content
    }
    
    @TagBuilder
    public func build() -> Tag {
        if let triggersContainer = triggersContainer {
            triggersContainer
        }
        if let contentsContainer = contentsContainer {
            contentsContainer
        }
        if let buttons = buttons {
            buttons
        }
        if let content = content {
            content
        }
    }
}

public class CollapseButton: Component {
    
    let ids: [String]
    
    public convenience init(contentId id: String, a: () -> A) {
        self.init(contentIds: [id], a: a)
    }
    
    public convenience init(contentId id: String, button: () -> Button) {
        self.init(contentIds: [id], button: button)
    }
    
    public convenience init(contentIds ids: [String], a: () -> A) {
        let a = a()
            .class(insert: .btn)
            .role(.button)
            .href(ids.count < 2 ? "#\(ids.first ?? "")" : Utility.multiCollapse.rawValue)

        self.init(contentIds: ids, a)
    }
    
    public convenience init(contentIds ids: [String], button: () -> Button) {
        let button = button()
            .class(insert: .btn)
            .type(.button)
            .dataBsTarget(ids.count < 2 ? ids.first ?? "" : Utility.multiCollapse.rawValue, prefix: ids.count < 2 ? .hash : .dot)

        self.init(contentIds: ids, button)
    }
    
    private init(contentIds ids: [String], _ tag: Tag) {
        self.ids = ids
        tag
            .dataBsToggle(.collapse)
            .ariaControls(ids.map{$0}.joined(separator: " "))
            .class(insert: .collapsed)
        
        super.init(tag)
    }
    
    @discardableResult
    public func isExpanded(if condition: Bool) -> Self {
        tag
            .class(remove: .collapsed, condition)
            .ariaExpanded(true, condition)
        return self
    }
}

public class CollapseContent: Component {
    
    /// contents ... anything
    public convenience init(id: String, @TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(id: id, div)
    }
    
    private init(id: String, _ div: Div) {
        _ = div
            .class(insert: .collapse)
            .id(id)
        
        super.init(div)
    }
    
    ///@NOTE: style='max-width:...' applied to all children
    @discardableResult
    public func isHorizontal(maxWidth: String?, if condition: Bool = true) -> Self {
        guard condition else { return self}
        for child in tag.children {
            child.style(set: .maxWidth(maxWidth))
        }
        tag
            .class(insert: .collapseHorizontal)
        return self
    }
    
    @discardableResult
    public func isExpanded(if condition: Bool = true) -> Self {
        tag
            .class(insert: .show, if: condition)
        return self
    }
    
    @discardableResult
    public func isMultiCollapse(if condition: Bool = true) -> Self {
        tag
            .class(insert: .multiCollapse, if: condition)
        return self
    }
}
