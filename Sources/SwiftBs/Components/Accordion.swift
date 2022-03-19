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

    /// children ... AccordionItem
    public init(id: String,
                isFlush: Bool = false,
                isAlwaysOpen: Bool = false,
                div: (AccordionId, IsAlwaysOpen) -> Div) {
        super.init {
            div(id, isAlwaysOpen)
                .class(insert: .accordion)
                .id(id)
                .class(insert: .accordionFlush, if: isFlush)
        }
    }
}

public class AccordionItem: Component {

    /// children ... AccordionHeader, AccordionCollapse
    public init(_ div: () -> Div) {
        super.init {
            div()
                .class(insert: .accordionItem)
        }
    }
}

/// children ... AccordionButton
public class AccordionHeader: Component {
    
    public init(id: String, h2: () -> H2) {
        super.init {
            h2()
                .class(insert: .accordionHeader)
                .id(id)
        }
    }
}

public class AccordionButton: Component {

    public init(isExpanded: Bool = false,
                collapseId: String,
                button: () -> Button) {
        super.init {
            button()
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

public class AccordionCollapse: Component {

    /// children ... AccordionBody
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

/// children ... Any
public class AccordionBody: Component {
        
    public init(div: () -> Div) {
        super.init {
            div()
                .class(insert: .accordionBody)
        }
    }
}
