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

    let div: Div
    let id: String
    let isFlush: Bool
    
    public convenience init(id: String,
                            isFlush: Bool = false,
                            isAlwaysOpen: Bool = false,
                            @TagBuilder items: (AccordionId, IsAlwaysOpen) -> [Tag]) {
        let div = Div { items(id, isAlwaysOpen) }
        self.init(div, id: id, isFlush: isFlush)
    }
    
    public init(_ div: Div, id: String, isFlush: Bool = false) {
        self.div = div
        self.id = id
        self.isFlush = isFlush
    }
}

extension Accordion: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        div
            .class(.accordion)
            .id(id)
            .class(add: .accordionFlush, if: isFlush)
            .addClassesStyles(self)
    }
}

public class AccordionItem: Component {

    let div: Div

    public convenience init(_ label: String,
                            index: Int = 0,
                            isExpanded: Bool = false,
                            isAlwaysOpen: Bool = false,
                            accordionId: String,
                            @TagBuilder body: @escaping () -> [Tag]) {
        let headerId = String("\(accordionId)header\(index)")
        let collapseId = String("\(accordionId)collapse\(index)")
        
        let div = Div {
            AccordionHeader(id: headerId) {
                AccordionButton(label, collapseId: collapseId)
            }
            AccordionCollapse(id: collapseId,
                              accordionId: accordionId,
                              headerId: headerId,
                              isExpanded: isExpanded,
                              isAlwaysOpen: isAlwaysOpen) {
                AccordionBody { body() }
            }
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension AccordionItem: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        div
            .class(.accordionItem)
            .addClassesStyles(self)
    }
}

public class AccordionHeader: Component {
    
    let h2: H2

    public convenience init(id: String, @TagBuilder children: () -> [Tag]) {
        let h2 = H2 {
            children()
        }.id(id)
        self.init(h2)
    }
    
    public init(_ h2: H2) {
        self.h2 = h2
    }
}

extension AccordionHeader: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        h2
            .class(.accordionHeader)
            .addClassesStyles(self)
    }
}

public class AccordionCollapse: Component {

    let div: Div
    let id: String
    let accordionId: String
    let headerId: String
    let isExpanded: Bool
    let isAlwaysOpen: Bool
    
    public convenience init(id: String,
                accordionId: String,
                headerId: String,
                isExpanded: Bool = false,
                isAlwaysOpen: Bool = false,
                @TagBuilder children: () -> [Tag]) {
        let div = Div { children() }
        self.init(div, id: id, accordionId: accordionId, headerId: headerId, isExpanded: isExpanded, isAlwaysOpen: isAlwaysOpen)
    }

    public init(_ div: Div,
                id: String,
                accordionId: String,
                headerId: String,
                isExpanded: Bool = false,
                isAlwaysOpen: Bool = false) {
        self.div = div
        self.id = id
        self.accordionId = accordionId
        self.headerId = headerId
        self.isExpanded = isExpanded
        self.isAlwaysOpen = isAlwaysOpen
    }
}

extension AccordionCollapse: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        div
            .id(id)
            .class(.accordionCollapse, .collapse)
            .class(add: .show, if: isExpanded)
            .ariaLabelledBy(headerId)
            .dataParent(accordionId, !isAlwaysOpen)
            .addClassesStyles(self)
    }
}

public class AccordionBody: Component {
    
    let div: Div
    
    public convenience init(@TagBuilder children: () -> [Tag]) {
        self.init(Div{ children() })
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension AccordionBody: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        div
            .class(.accordionBody)
            .addClassesStyles(self)
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
            .dataBsTarget(collapseId)
            .ariaExpanded(isExpanded)
            .ariaControls(collapseId)
            .addClassesStyles(self)
    }
}
