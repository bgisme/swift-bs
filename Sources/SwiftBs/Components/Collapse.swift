//
//  Collapse.swift
//
//
//  Created by Brad Gourley on 3/9/22.
//

import SwiftHtml

public class Collapse {
    
    public typealias Id = String
    
    let contents: [Tag]
            
    public init(contentIds ids: [String], p: ([Id]) -> P, div: ([Id]) -> Div) {
        self.contents = [
            p(ids),
            div(ids),
        ]
    }
    
}

extension Collapse: TagRepresentable {
    
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
        self.init(contentIds: ids, tag: {
            a()
                .role(.button)
                .href(ids.count < 2 ? "#\(ids.first ?? "")" : BsClass.multiCollapse.rawValue)
        })
    }
    
    public convenience init(contentIds ids: String..., button: () -> Button) {
        self.init(contentIds: ids, button: button)
    }
    
    public convenience init(contentIds ids: [String], button: () -> Button) {
        self.init(contentIds: ids, tag: {
            button()
                .type(.button)
                .dataBsTarget(ids.count < 2 ? ids.first ?? "" : BsClass.multiCollapse.rawValue, prefix: ids.count < 2 ? .hash : .dot)
        })
    }
    
    internal init(contentIds ids: [String], tag: () -> Tag) {
        self.ids = ids
        super.init {
            tag()
                .dataBsToggle(.collapse)
                .ariaExpanded(false)
                .ariaControls(ids.map{$0}.joined(separator: " "))
        }
    }
}

public class CollapseContent: Component {
    
    public enum Orientation {
        case horizontal(width: String)
        case vertical
    }
    
    public init(orientation: Orientation = .vertical,
                id: String,
                isMultiple: Bool = false,
                div: () -> Div) {
        let div = div()
        let isHorizontalCollapse: Bool
        switch orientation {
        case .horizontal(let width):
            isHorizontalCollapse = true
            // children of horizontal collapse need width to display correctly
            for child in div.children {
                child.style(set: .width(width))
            }
        case .vertical:
            isHorizontalCollapse = false
        }
        super.init {
            div
                .class(insert: .collapse)
                .class(insert: .collapseHorizontal, if: isHorizontalCollapse)
                .class(insert: .multiCollapse, if: isMultiple)
                .id(id)
        }
    }
}
