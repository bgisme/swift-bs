//
//  Accordion.swift
//
//
//  Created by BG on 2/9/22.
//

/*
    Accordion                       id(unique)
        AccordionItem
            AccordionHeader         id(unique)
                AccordionButton     dataBsTarget(collapseId)    ariaControls(collapseId)
            AccordionCollapse       id(unique)  dataBsParent(accordionId)   ariaLabelledBy(headerId)
                AccordionBody
        AccordionItem
            AccordionHeader
                AccordionButton
            AccordionCollapse
                AccordionBody
 */

import SwiftHtml

public class Accordion: Component {
    
    public typealias AccordionId = String
    public typealias IsAlwaysOpen = Bool
    
    public convenience init(id: String,
                            isAlwaysOpen: Bool = false,
                            @TagBuilder accordionItems: (AccordionId, IsAlwaysOpen) -> [Tag]) {
        let div = Div {
            accordionItems(id, isAlwaysOpen)
        }
        self.init(id: id, div)
    }
    
    public init(id: String, _ div: Div) {
        _ = div
            .class(insert: .accordion)
            .id(id)
        
        super.init(div)
    }
    
    @discardableResult
    public func isFlush(if condition: Bool = true) -> Self {
        tag
            .class(insert: .accordionFlush, if: condition)
        return self
    }
}

public class AccordionItem: Component {
    
    public typealias HeaderId = String
    public typealias CollapseId = String
    public typealias IsExpanded = Bool
    
    public convenience init(_ title: String,
                            index: Int,
                            isCollapsed: Bool = true,
                            accordionId: String,
                            isAlwaysOpen: Bool = false,
                            @TagBuilder collapseContents: () -> [Tag]) {
        let headerId = accordionId + "Header" + String(index)
        let collapseId = accordionId + "Collapse" + String(index)
        let div = Div {
            AccordionHeader(title,
                            id: headerId,
                            collapseId: collapseId,
                            isCollapsed: isCollapsed)
            AccordionCollapse(id: collapseId,
                              accordionId: accordionId,
                              headerId: headerId,
                              isExpanded: !isCollapsed,
                              isAutoCollapsable: !isAlwaysOpen) {
                AccordionBody {
                    collapseContents()
                }
            }
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .accordionItem)
        
        super.init(div)
    }
}

public class AccordionHeader: Component {
    
    public convenience init(_ text: String,
                            id: String,
                            collapseId: String,
                            isCollapsed: Bool = false) {
        self.init(id: id, isCollapsed: isCollapsed) {
            H2 {
                AccordionButton(text,
                                collapseId: collapseId,
                                isCollapsed: isCollapsed)
            }
        }
    }
    
    public init(id: String, isCollapsed: Bool = false, h2: () -> H2) {
        let h2 = h2()
            .class(insert: .accordionHeader)
            .id(id)

        super.init(h2)
        self.isCollapsed(if: isCollapsed)
    }
    
    @discardableResult
    public func isCollapsed(if condition: Bool = true) -> Self {
        tag
            .class(insert: .collapsed, if: condition)
        return self
    }
}

public class AccordionButton: Component {
    
    public convenience init(_ text: String,
                            collapseId: String,
                            isCollapsed: Bool = false) {
        let button = Button(text)
        self.init(collapseId: collapseId, button)
        self.isCollapsed(if: isCollapsed)
    }
    
    public init(collapseId: String, _ button: Button) {
        button
            .class(insert: .accordionButton)
            .type(.button)
            .dataBsToggle(.collapse)
            .dataBsTarget(collapseId)
            .ariaControls(collapseId)
        
        super.init(button)
    }
    
    @discardableResult
    public func isCollapsed(if condition: Bool = true) -> Self {
        tag
            .class(insert: .collapsed, if: condition)
            .ariaExpanded(false, condition)
        return self
    }
}

public class AccordionCollapse: Component {
    
    public convenience init(id: String,
                            accordionId: String,
                            headerId: String,
                            isExpanded: Bool = false,
                            isAutoCollapsable: Bool = true,
                            accordionBody: () -> AccordionBody) {
        let div = Div {
            accordionBody()
        }
        self.init(id: id, headerId: headerId, div)
        self.isExpanded(if: isExpanded)
        self.isAutoCollapsable(accordionId: accordionId, isAutoCollapsable)
    }
    
    public init(id: String, headerId: String, _ div: Div) {
        div
            .id(id)
            .class(insert: .accordionCollapse, .collapse)
            .ariaLabelledBy(headerId)

        super.init(div)
    }
    
    @discardableResult
    public func isExpanded(if condition: Bool = true) -> Self {
        tag
            .class(insert: .show, if: condition)
        return self
    }
    
    @discardableResult
    public func isAutoCollapsable(accordionId: String, _ condition: Bool = true) -> Self {
        tag
            .dataParent(accordionId, condition)
        return self
    }
}

public class AccordionBody: Component {
    
    /// contents ... anything
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div {
            contents()
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .accordionBody)

        super.init(div)
    }
}
