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
    
    public static func make(id: String,
                            isFlush: Bool = false,
                            isAlwaysOpen: Bool = false,
                            @TagBuilder accordionItems: (AccordionId, IsAlwaysOpen) -> [Tag]) -> Accordion {
        Accordion(id: id, isFlush: isFlush, isAlwaysOpen: isAlwaysOpen) {
            Div {
                accordionItems(id, isAlwaysOpen)
            }
        }
    }
    
    public init(id: String,
                isFlush: Bool = false,
                isAlwaysOpen: Bool = false,
                div: () -> Div) {
        super.init {
            div()
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
    
    public static func make(_ title: String,
                            index: Int,
                            isExpanded: Bool = false,
                            accordionId: String,
                            isAlwaysOpen: Bool = false,
                            @TagBuilder collapseContents: () -> [Tag]) -> AccordionItem {
        let headerId = accordionId + "Header" + String(index)
        let collapseId = accordionId + "Collapse" + String(index)
        return AccordionItem(title,
                             index: index,
                             isExpanded: isExpanded,
                             accordionId: accordionId,
                             isAlwaysOpen: isAlwaysOpen) {
            Div {
                AccordionHeader.make(title,
                                     id: headerId,
                                     collapseId: collapseId,
                                     isExpanded: isExpanded)
                AccordionCollapse.make(id: collapseId,
                                       accordionId: accordionId,
                                       headerId: headerId,
                                       isExpanded: isExpanded,
                                       isAlwaysOpen: isAlwaysOpen) {
                    AccordionBody.make {
                        collapseContents()
                    }
                }
            }
        }
    }
    
    public init(_ title: String,
                index: Int,
                isExpanded: Bool = false,
                accordionId: String,
                isAlwaysOpen: Bool = false,
                div: () -> Div) {
        super.init {
            div()
                .class(insert: .accordionItem)
        }
    }
}

public class AccordionHeader: Component {
    
    public static func make(_ text: String,
                            id: String,
                            collapseId: String,
                            isExpanded: Bool = false) -> AccordionHeader {
        AccordionHeader(text, id: id) {
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
        }
    }
    
    public init(_ text: String,
                id: String,
                h2: () -> H2) {
        super.init {
            h2()
                .class(insert: .accordionHeader)
                .id(id)
        }
    }
}

public class AccordionCollapse: Component {
    
    public static func make(id: String,
                            accordionId: String,
                            headerId: String,
                            isExpanded: Bool = false,
                            isAlwaysOpen: Bool = false,
                            accordionBody: () -> AccordionBody) -> AccordionCollapse {
        AccordionCollapse(id: id,
                          accordionId: accordionId,
                          headerId: headerId,
                          isExpanded: isExpanded,
                          isAlwaysOpen: isAlwaysOpen) {
            Div {
                accordionBody()
            }
        }
    }
    
    public init(id: String,
                accordionId: String,
                headerId: String,
                isExpanded: Bool = false,
                isAlwaysOpen: Bool = false,
                div: () -> Div) {
        super.init {
            div()
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
    public static func make(@TagBuilder contents: () -> [Tag]) -> AccordionBody {
        AccordionBody.init {
            Div {
                contents()
            }
        }
    }
    
    public init(div: () -> Div) {
        super.init {
            div()
                .class(insert: .accordionBody)
        }
    }
}
