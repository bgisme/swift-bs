//
//  Collapse.swift
//
//
//  Created by Brad Gourley on 3/9/22.
//

import SwiftHtml

public class Collapse: TagRepresentable {
    
    public typealias Id = String
    
    let contents: [Tag]

    public init(contentIds ids: [String],
                p: ([Id]) -> P,
                @TagBuilder contents: ([Id]) -> [Tag]) {
        self.contents = [p(ids)] + contents(ids)
    }
    
    @TagBuilder
    public func build() -> Tag {
        contents
    }
}

public class CollapseButton: Component {
    
    let ids: [String]
    
    public convenience init(contentIds ids: String..., a: () -> A) {
        self.init(contentIds: ids, a: a)
    }
    
    public convenience init(contentIds ids: [String], a: () -> A) {
        let a = a()
            .class(insert: .btn)
            .role(.button)
            .href(ids.count < 2 ? "#\(ids.first ?? "")" : Utility.multiCollapse.rawValue)

        self.init(contentIds: ids, a)
    }
    
    public convenience init(contentIds ids: String..., button: () -> Button) {
        self.init(contentIds: ids, button: button)
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
