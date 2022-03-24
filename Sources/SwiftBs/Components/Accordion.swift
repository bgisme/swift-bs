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
                            isFlush: Bool = false,
                            isAlwaysOpen: Bool = false,
                            @TagBuilder accordionItems: (AccordionId, IsAlwaysOpen) -> [Tag]) {
        let div = Div {
            accordionItems(id, isAlwaysOpen)
        }
        self.init(id: id, isFlush: isFlush, isAlwaysOpen: isAlwaysOpen, div)
    }
    
    public init(id: String,
                isFlush: Bool,
                isAlwaysOpen: Bool,
                _ div: Div) {
        div
            .class(insert: .accordion)
            .id(id)
            .class(insert: .accordionFlush, if: isFlush)
        
        super.init(div)
    }
}

public class AccordionItem: Component {
    
    public typealias HeaderId = String
    public typealias CollapseId = String
    public typealias IsExpanded = Bool
    
    public convenience init(_ title: String,
                            index: Int,
                            isExpanded: Bool = false,
                            accordionId: String,
                            isAlwaysOpen: Bool = false,
                            @TagBuilder collapseContents: () -> [Tag]) {
        let headerId = accordionId + "Header" + String(index)
        let collapseId = accordionId + "Collapse" + String(index)
        let div = Div {
            AccordionHeader(title,
                            id: headerId,
                            collapseId: collapseId,
                            isExpanded: isExpanded)
            AccordionCollapse(id: collapseId,
                              accordionId: accordionId,
                              headerId: headerId,
                              isExpanded: isExpanded,
                              isAlwaysOpen: isAlwaysOpen) {
                AccordionBody {
                    collapseContents()
                }
            }
        }
        self.init(title,
                  index: index,
                  isExpanded: isExpanded,
                  accordionId: accordionId,
                  isAlwaysOpen: isAlwaysOpen,
                  div)
    }
    
    public init(_ title: String,
                index: Int,
                isExpanded: Bool,
                accordionId: String,
                isAlwaysOpen: Bool,
                _ div: Div) {
        div
            .class(insert: .accordionItem)
        
        super.init(div)
    }
}

public class AccordionHeader: Component {
    
    public convenience init(_ text: String,
                            id: String,
                            collapseId: String,
                            isExpanded: Bool = false) {
        let h2 = H2 {
            Button(text)
                .class(insert: .accordionButton)
                .class(insert: .collapsed, if: !isExpanded)
                .type(.button)
                .dataBsToggle(.collapse)
                .dataBsTarget(collapseId)
                .ariaExpanded(isExpanded)
                .ariaControls(collapseId)
        }
        self.init(id: id, h2)
    }
    
    public init(id: String, _ h2: H2) {
        _ = h2
            .class(insert: .accordionHeader)
            .id(id)

        super.init(h2)
    }
}

public class AccordionCollapse: Component {
    
    public convenience init(id: String,
                            accordionId: String,
                            headerId: String,
                            isExpanded: Bool = false,
                            isAlwaysOpen: Bool = false,
                            accordionBody: () -> AccordionBody) {
        let div = Div {
            accordionBody()
        }
        self.init(id: id,
                  accordionId: accordionId,
                  headerId: headerId,
                  isExpanded: isExpanded,
                  isAlwaysOpen: isAlwaysOpen,
                  div)
    }
    
    public init(id: String,
                accordionId: String,
                headerId: String,
                isExpanded: Bool,
                isAlwaysOpen: Bool,
                _ div: Div) {
        div
            .id(id)
            .class(insert: .accordionCollapse, .collapse)
            .class(insert: .show, if: isExpanded)
            .ariaLabelledBy(headerId)
            .dataParent(accordionId, !isAlwaysOpen)

        super.init(div)
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
