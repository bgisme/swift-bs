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
    
    /// contents ... AccordionItems
    public init(id: String,
                isFlush: Bool = false,
                isAlwaysOpen: Bool = false,
                @TagBuilder contents: (AccordionId, IsAlwaysOpen) -> [Tag]) {
        super.init {
            Div {
                contents(id, isAlwaysOpen)
            }
            .class(insert: .accordion)
            .id(id)
            .class(insert: .accordionFlush, if: isFlush)
        }
    }
}

public class AccordionItem: Component {
    
    public init(header: () -> AccordionHeader,
                collapse: () -> AccordionCollapse) {
        super.init {
            Div {
                header()
                collapse()
            }
            .class(insert: .accordionItem)
        }
    }
}

public class AccordionHeader: Component {
    
    public init(_ text: String,
                id: String,
                collapseId: String,
                index: Int,
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
    
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .accordionBody)
        }
    }
}
