//
//  Collapse.swift
//
//
//  Created by Brad Gourley on 3/9/22.
//

import SwiftHtml

public class Collapse: Component {
    
    public typealias Id = String
    
    let p: P
    let div: Div
        
    public init(id: String, p: (Id) -> P, div: (Id) -> Div) {
        self.p = p(id)
        self.div = div(id)
    }
}

extension Collapse: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        p
        div
    }
}

public class CollapseButton: Component {
    
    let tag: Tag
    let ids: [String]
    
    public convenience init(contentIds ids: [String], a: () -> A) {
        self.init(contentIds: ids, tag: {
            a()
                .role(.button)
                .href(ids.count < 2 ? "#\(ids.first ?? "")" : BsClass.multiCollapse.rawValue)
        })
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
        self.tag = tag()
    }
}

extension CollapseButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .dataBsToggle(.collapse)
            .ariaExpanded(false)
            .ariaControls(ids.map{$0}.joined(separator: " "))
            .merge(attributes)
    }
}

public class CollapseContent: Component {
    
    public enum Orientation {
        case horizontal(width: String)
        case vertical
    }
    
    let width: String
    let id: String
    var isMultiple: Bool
    let div: Div
    
    public init(orientation: Orientation = .vertical,
                id: String,
                isMultiple: Bool = false,
                div: () -> Div) {
        let div = div()
        switch orientation {
        case .horizontal(let width):
            self.width = width
            // children of horizontal collapse need width to display correctly
            for child in div.children {
                child.style(add: .width(width))
            }
        case .vertical:
            self.width = ""
        }
        self.id = id
        self.isMultiple = isMultiple
        self.div = div
    }
}

extension CollapseContent: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .collapse)
            .class(add: .collapseHorizontal, if: !width.isEmpty)
            .class(add: .multiCollapse, if: isMultiple)
            .id(id)
            .merge(attributes)
    }
}
