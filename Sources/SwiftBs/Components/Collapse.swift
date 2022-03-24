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

//    public init(contentIds ids: [String],
//                p: ([Id]) -> P,
//                div: ([Id]) -> Div) {
//        self.contents = [
//            p(ids),
//            div(ids),
//        ]
//    }
    
    public init(contentIds ids: [String],
                p: ([Id]) -> P,
                @TagBuilder contents: ([Id]) -> [Tag]) {
        self.contents = contents(ids) + [p(ids)]
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
            .href(ids.count < 2 ? "#\(ids.first ?? "")" : BsClass.multiCollapse.rawValue)

        self.init(contentIds: ids, a)
    }
    
    public convenience init(contentIds ids: String..., button: () -> Button) {
        self.init(contentIds: ids, button: button)
    }
    
    public convenience init(contentIds ids: [String], button: () -> Button) {
        let button = button()
            .class(insert: .btn)
            .type(.button)
            .dataBsTarget(ids.count < 2 ? ids.first ?? "" : BsClass.multiCollapse.rawValue, prefix: ids.count < 2 ? .hash : .dot)

        self.init(contentIds: ids, button)
    }
    
    private init(contentIds ids: [String], _ tag: Tag) {
        self.ids = ids
        tag
            .dataBsToggle(.collapse)
            .ariaExpanded(false)
            .ariaControls(ids.map{$0}.joined(separator: " "))
        
        super.init(tag)
    }
}

public class CollapseContent: Component {
    
    public enum Orientation {
        case horizontal(width: String)
        case vertical
    }
    
    /// contents ... anything
    public convenience init(orientation: Orientation = .vertical,
                id: String,
                isMultiple: Bool = false,
                @TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(orientation: orientation, id: id, isMultiple: isMultiple, div)
    }
    
    private init(orientation: Orientation = .vertical,
                 id: String,
                 isMultiple: Bool = false,
                 _ div: Div) {
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

        _ = div
            .class(insert: .collapse)
            .class(insert: .collapseHorizontal, if: isHorizontalCollapse)
            .class(insert: .multiCollapse, if: isMultiple)
            .id(id)
        
        super.init(div)
    }
}
