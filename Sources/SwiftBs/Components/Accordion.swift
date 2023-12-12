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

open class Accordion: Div {
    
    public let items: [AccordionItem]
    
    public convenience init(id: String, item: () -> AccordionItem) {
        self.init(id: id, items: [ item() ])
    }
    
    public init(id: String, items: [AccordionItem]) {
        self.items = items
        super.init(items)
        self
            .id(id)
            .class(insert: .accordion)
    }
    
    @discardableResult
    public func isFlush(if condition: Bool = true) -> Self {
        self.class(insert: .accordionFlush, if: condition)
    }
}

// MARK: - AccordionItem

open class AccordionItem: Div {
    
    public let header: AccordionHeader
    public let collapse: AccordionCollapse
    
    @discardableResult
    public convenience init(accordionID id: String,
                            index i: Int? = nil,
                            isAutoCollapsible: Bool = false,
                            isCollapsed: Bool = true,
                            @TagBuilder headerChildren: () -> Tag,
                            @TagBuilder bodyChildren: () -> Tag) {
        let collapseID = "\(id)_collapse\(i != nil ? "_\(i!)" : String())"
        let header = AccordionHeader(id: "\(id)_header\(i != nil ? "_\(i!)" : "")",
                                     collapseID: collapseID,
                                     isCollapsed: isCollapsed,
                                     [headerChildren()])
        let collapse = AccordionCollapse(id: collapseID,
                                         isCollapsed: isCollapsed,
                                         autoCollapse: isAutoCollapsible ? id : nil,
                                         [bodyChildren()])
        self.init(header: header,
                  collapse: collapse)
    }
    
    @discardableResult
    public init(header: AccordionHeader,
                collapse: AccordionCollapse) {
        self.header = header
        self.collapse = collapse
        let temp = Div {
            header
            collapse
        }
        super.init(temp.children)
        self.class(insert: .accordionItem)
    }
}

// MARK: - AccordionHeader

open class AccordionHeader: Div {
    
    public let button: AccordionButton
    
    @discardableResult
    public init(id: String,
                collapseID: String,
                isCollapsed: Bool = false,
                _ children: [Tag]? = nil) {
        let button = AccordionButton(collapseID: collapseID,
                                     isCollapsed: isCollapsed,
                                     children)
        self.button = button
        super.init([button])
        self
            .id(id)
            .class(insert: .accordionHeader)
            .isCollapsed(if: isCollapsed)
    }
        
    @discardableResult
    public func isCollapsed(if condition: Bool = true) -> Self {
        self.class(insert: .collapsed, if: condition)
    }
}

// MARK: - AccordionButton

open class AccordionButton: Button {
    
    public enum Placement {
        case left
        case right
    }
    
    public enum Pointing {
        case up
        case down
        case left
        case right
    }
        
    @discardableResult
    public convenience init(_ text: String,
                            collapseID: String,
                            isCollapsed: Bool = false) {
        self.init(collapseID: collapseID,
                  isCollapsed: isCollapsed,
                  [Text(text)])
    }
    
    @discardableResult
    public init(collapseID: String,
                isCollapsed: Bool = false,
                icon placement: Placement = .right,
                pointing: Pointing = .down,
                _ children: [Tag]? = nil) {
        super.init(children)
        self
            .class(insert: .accordionButton)
            .type(.button)
            .dataBsToggle(.collapse)
            .dataBsTarget(collapseID)
            .ariaControls(collapseID)
            .isCollapsed(if: isCollapsed)
#warning("TODO: Not working... Figure out how to implement")
//            .class(insert: .icon, .left, if: placement == .left)    // placed right by default
//            .class(insert: .icon, .rotate180, if: pointing == .up)  // pointing down by default
//            .class(insert: .icon, .rotate270, if: pointing == .left)
//            .class(insert: .icon, .rotate90, if: pointing == .right)
    }
    
    @discardableResult
    public func isCollapsed(if condition: Bool = true) -> Self {
        self
            .class(insert: .collapsed, if: condition)
            .ariaExpanded(false, condition)
    }
}

// MARK: - AccordionCollapse

open class AccordionCollapse: Div {
    
    public let body: AccordionBody
    
   @discardableResult
    public init(id: String,
                isCollapsed: Bool = true,
                autoCollapse accordionID: String? = nil,
                _ children: [Tag]? = nil) {
        let body = AccordionBody(children)
        self.body = body
        super.init([body])
        self
            .id(id)
            .ariaLabelledBy(id)
            .class(insert: .accordionCollapse, .collapse)
            .isExpanded(if: !isCollapsed)
            .autoCollapse(accordionID: accordionID)
    }
    
    @discardableResult
    public func isExpanded(if condition: Bool = true) -> Self {
        self.class(insert: .show, if: condition)
    }
    
    @discardableResult
    public func autoCollapse(accordionID: String?) -> Self {
        self.dataParent(accordionID)
    }
}

// MARK: - AccordionBody

open class AccordionBody: Div {
        
    @discardableResult
    public init(_ children: [Tag]? = nil) {
        super.init(children)
        self
            .class(insert: .accordionBody)
    }
}

