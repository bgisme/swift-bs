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
    
    public init(id: String,
                isFlush: Bool = false,
                isAlwaysOpen: Bool = false,
                @TagBuilder accordionItems: (AccordionId, IsAlwaysOpen) -> [Tag]) {
        super.init {
            Div {
                accordionItems(id, isAlwaysOpen)
            }
            .class(insert: .accordion)
            .id(id)
            .class(insert: .accordionFlush, if: isFlush)
        }
    }    
}

public class AccordionItem: Component {
    
    public typealias HeaderId = String
    public typealias CollapseId = String
    public typealias IsExpanded = Bool
    
    public init(_ title: String,
                index: Int,
                isExpanded: Bool = false,
                accordionId: String,
                isAlwaysOpen: Bool = false,
                @TagBuilder collapseContents: () -> [Tag]) {
        let headerId = accordionId + "Header" + String(index)
        let collapseId = accordionId + "Collapse" + String(index)
        super.init {
            Div {
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
            .class(insert: .accordionItem)
        }
    }
}

public class AccordionHeader: Component {
    
    public init(_ text: String,
                id: String,
                collapseId: String,
                isExpanded: Bool = false) {
        super.init {
            H2 {
                Button(text)
                    .class(insert: .accordionButton)
                    .class(insert: .collapsed, if: !isExpanded)
                    .type(.button)
                    .dataBsToggle(.collapse)
                    .dataBsTarget(collapseId)
                    .ariaExpanded(isExpanded)
                    .ariaControls(collapseId)
            }
            .class(insert: .accordionHeader)
            .id(id)
        }
    }
}

public class AccordionCollapse: Component {
    
    public init(id: String,
                accordionId: String,
                headerId: String,
                isExpanded: Bool = false,
                isAlwaysOpen: Bool = false,
                accordionBody: () -> AccordionBody) {
        super.init {
            Div {
                accordionBody()
            }
            .id(id)
            .class(insert: .accordionCollapse, .collapse)
            .class(insert: .show, if: isExpanded)
            .ariaLabelledBy(headerId)
            .dataParent(accordionId, !isAlwaysOpen)
        }
    }
}

public class AccordionBody: Component {
    
    /// contents ... anything
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .accordionBody)
        }
    }
}
