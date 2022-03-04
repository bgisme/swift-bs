//
//  Accordion.swift
//
//
//  Created by BG on 2/9/22.
//

import SwiftHtml

public class Accordion: Component {

    public typealias AccordionId = String
    public typealias IsAlwaysOpen = Bool

    let id: String
    let isFlush: Bool
    let isAlwaysOpen: Bool
    var items: (AccordionId, IsAlwaysOpen) -> [Tag]
    
    public init(id: String,
                isFlush: Bool = false,
                isAlwaysOpen: Bool = false,
                @TagBuilder items: @escaping (AccordionId, IsAlwaysOpen) -> [Tag]) {
        self.id = id
        self.isFlush = isFlush
        self.isAlwaysOpen = isAlwaysOpen
        self.items = items
    }
}

extension Accordion: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        Div {
            self.items(id, isAlwaysOpen)
        }
        .class(.accordion)
        .class(add: .accordionFlush, if: isFlush)
        .id(id)
        .class(add: bsClasses)
    }
}

public class AccordionItem: Component {

    let label: String
    let index: Int
    let isExpanded: Bool
    let isAlwaysOpen: Bool
    let accordionId: String
    let body: () -> [Tag]
    
    public init(_ label: String,
                index: Int = 0,
                isExpanded: Bool = false,
                isAlwaysOpen: Bool = false,
                accordionId: String,
                @TagBuilder body: @escaping () -> [Tag]) {
        self.label = label
        self.index = index
        self.isExpanded = isExpanded
        self.isAlwaysOpen = isAlwaysOpen
        self.accordionId = accordionId
        self.body = body
    }
}

extension AccordionItem: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        let headerId = String("\(accordionId)header\(index)")
        let collapseId = String("\(accordionId)collapse\(index)")

        Div {
            AccordionHeader(id: headerId,
                            collapseId: collapseId,
                            isExpanded: isExpanded) {
                AccordionButton(self.label, collapseId: collapseId)
            }
            AccordionCollapse(id: collapseId,
                              accordionId: accordionId,
                              headerId: headerId,
                              isExpanded: isExpanded,
                              isAlwaysOpen: isAlwaysOpen) {
                AccordionBody {
                    self.body()
                }
            }
        }
        .class(.accordionItem)
        .class(add: bsClasses)
    }
}

public class AccordionHeader: Component {

    let id: String
    let collapseId: String
    let isExpanded: Bool
    let children: () -> [Tag]
    
    public init(id: String,
                collapseId: String,
                isExpanded: Bool = false,
                @TagBuilder children: @escaping () -> [Tag]) {
        self.id = id
        self.collapseId = collapseId
        self.isExpanded = isExpanded
        self.children = children
    }
}

extension AccordionHeader: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        H2()
            .class(.accordionHeader)
            .id(id)
            .class(add: bsClasses)
        children()
    }
}

public class AccordionCollapse: Component {

    let id: String
    let accordionId: String
    let headerId: String
    let isExpanded: Bool
    let isAlwaysOpen: Bool
    let children: () -> [Tag]
    
    public init(id: String,
                accordionId: String,
                headerId: String,
                isExpanded: Bool = false,
                isAlwaysOpen: Bool = false,
                @TagBuilder children: @escaping () -> [Tag]) {
        self.id = id
        self.accordionId = accordionId
        self.headerId = headerId
        self.isExpanded = isExpanded
        self.isAlwaysOpen = isAlwaysOpen
        self.children = children
    }
}

extension AccordionCollapse: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        Div {
            children()
        }
        .id(id)
        .class(.accordionCollapse, .collapse)
        .class(add: .show, if: isExpanded)
        .ariaLabelledBy(headerId)
        .dataParent(accordionId, !isAlwaysOpen)
        .class(add: bsClasses)
    }
}

public class AccordionBody: Component {
    
    let children: () -> [Tag]
    
    init(@TagBuilder children: @escaping () -> [Tag]) {
        self.children = children
    }
}

extension AccordionBody: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        Div {
            children()
        }
        .class(.accordionBody)
        .class(add: bsClasses)
    }
}

public class AccordionButton: Component {

    let button: Button
    let isExpanded: Bool
    let collapseId: String

    public convenience init(_ title: String,
                            isExpanded: Bool = false,
                            collapseId: String) {
        let button = Button(title)
        self.init(button, isExpanded: isExpanded, collapseId: collapseId)
    }

    public init(_ button: Button,
                isExpanded: Bool = false,
                collapseId: String) {
        self.button = button
        self.isExpanded = isExpanded
        self.collapseId = collapseId
    }
}

extension AccordionButton: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        button
            .class(add: .accordionButton)
            .class(add: .collapsed, if: !isExpanded)
            .type(.button)
            .dataBsToggle(.collapse)
            .dataTarget(collapseId)
            .ariaExpanded(isExpanded)
            .ariaControls(collapseId)
            .class(add: bsClasses)
    }
}
