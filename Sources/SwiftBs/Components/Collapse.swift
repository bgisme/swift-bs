//
//  Collapse.swift
//
//
//  Created by Brad Gourley on 3/9/22.
//

import SwiftHtml

public class Collapse: Component {
    
    let buttons: [Tag]
    let contents: [Tag]
        
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
    
    public enum `Type` {
        case button
        case link
    }
    
    let tag: Tag
    let ids: [String]
    
    public convenience init(_ title: String, type: `Type` = .button, contentIds ids: String...) {
        self.init(title, type: type, contentIds: ids)
    }
    
    public init(_ title: String, type: `Type` = .button, contentIds ids: [String]) {
        let tag: Tag
        switch type {
        case .button:
            let btn = Button(title)
                .type(.button)
                .dataBsTarget(ids.count < 2 ? ids.first ?? "" : BsClass.multiCollapse.rawValue, prefix: ids.count < 2 ? .hash : .dot)
            tag = BsButton(btn).build()
        case .link:
            let a = A(title)
                .role(.button)
                .href(ids.count < 2 ? "#\(ids.first ?? "")" : BsClass.multiCollapse.rawValue)
            tag = BsButton(a).build()
        }
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
    
    public convenience init(orientation: Orientation = .vertical,
                id: String,
                isMultiple: Bool = false,
                @TagBuilder content: () -> [Tag]) {
        self.init(orientation: orientation, id: id, isMultiple: isMultiple, Div { content() })
    }
    
    public init(orientation: Orientation = .vertical,
                id: String,
                isMultiple: Bool = false,
                _ div: Div) {
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
