//
//  Card.swift
//  
//
//  Created by Brad Gourley on 3/4/22.
//

import SwiftHtml

/// Cards contain layers of elements
/// Inside Card is one or more: ImageTop, Header, Body, Footer, ImageBottom
/// Card can also contain a CardImageOverlay (which is an Img and a Div)
/// Inside CardBody is one or more: Title, Subtitle, Text
/// Cardbody can also contain one or more links (without any other elements)

/*
 
    Card
        CardImageOverlay (optional)
        CardHeader
        Img
        CardBody
            CardTitle
            CardText
            CardLink
            CardLink
        CardFooter
 */

public class Card: Component {
    
    //! WHEN ALLOWED TO APPEND CHILDREN...
    //! MAYBE CREATE FUNCS FOR EACH SUB-COMPONENT
//    @discardableResult
//    public func header(_ header: CardHeader) {
//        self.append { header }
//    }
    
    public static func make(header: CardHeader? = nil,
                            topImage: Img? = nil,
                            body: CardBody? = nil,
                            bottomImage: Img? = nil,
                            footer: CardFooter? = nil) -> Card {
        self.make {
            if let header = header { header }
            if let topImage = topImage { topImage }
            if let body = body { body }
            if let bottomImage = bottomImage { bottomImage }
            if let footer = footer { footer }
        }
    }
    
    /// contents ...
    /// CardHeader
    /// Img top
    /// CardBody
    /// Img bottom
    /// CardFooter
    public static func make(@TagBuilder contents: () -> [Tag]) -> Card {
        Card {
            Div {
                contents()
            }
        }
    }
    
    public init(div: () -> Div) {
        super.init {
            div()
                .class(insert: .card)
        }
    }
    
    @discardableResult
    public func textAlign(_ value: AlignText?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.class, if: condition)
    }    
}

public class CardImageOverlay: TagRepresentable {
    
    let group: GroupTag
    
    public init(img: () -> Img, @TagBuilder contents: () -> [Tag]) {
        self.group = GroupTag {
            img().class(insert: .cardImg)
            Div {
                contents()
            }
            .class(insert: .cardImgOverlay)
        }
    }
    
    @TagBuilder
    public func build() -> Tag {
        group
    }
}

public class CardHeader: Component {
    
    public static func make(navTab: () -> NavTab) -> CardHeader {
        let cardNav: BsClass?
        switch navTab().style {
        case .pills:
            cardNav = .cardHeaderPills
        case .tabs:
            cardNav = .cardHeaderTabs
        default:
            cardNav = nil
        }
        return CardHeader(tag: {
            Div {
                navTab()
                    .class(insert: cardNav)
            }
        })
    }
    
    public static func make(_ text: String) -> CardHeader {
        CardHeader(tag: { Div(text) })
    }
        
    public convenience init(h1: () -> H1) {
        self.init(tag: h1)
    }
    
    public convenience init(h2: () -> H2) {
        self.init(tag: h2)
    }

    public convenience init(h3: () -> H3) {
        self.init(tag: h3)
    }

    public convenience init(h4: () -> H4) {
        self.init(tag: h4)
    }

    public convenience init(h5: () -> H5) {
        self.init(tag: h5)
    }
    
    public convenience init(h6: () -> H6) {
        self.init(tag: h6)
    }
    
    public convenience init(div: () -> Div) {
        self.init(tag: div)
    }
        
    private override init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardHeader)
        }
    }
}

public class CardBody: Component {
    
    public static func make(title: String? = nil,
                            subtitle: String? = nil,
                            text: String? = nil) -> CardBody {
        self.make(title: title, subtitle: subtitle, text: text, links: {})
    }
    
    public static func make(title: String? = nil,
                            subtitle: String? = nil,
                            text: String? = nil,
                            @TagBuilder links: () -> [Tag]) -> CardBody {
        self.make {
            if let title = title {
                CardTitle.make(title)
            }
            if let subtitle = subtitle {
                CardSubtitle.make(subtitle)
            }
            if let text = text {
                CardText.make(text)
            }
            links()
        }
    }
        
    /// contents ...
    /// CardTitle
    /// CardText
    /// CardLink
    public static func make(@TagBuilder contents: () -> [Tag]) -> CardBody {
        CardBody {
            Div {
                contents()
            }
        }
    }
    
    public init(div: () -> Div) {
        super.init {
            div()
                .class(insert: .cardBody)
        }
    }
}

public class CardTitle: Component {
    
    public static func make(_ text: String) -> CardTitle {
        CardTitle(h5: { H5(text) })
    }
        
    public convenience init(h1: () -> H1) {
        self.init(tag: h1)
    }

    public convenience init(h2: () -> H2) {
        self.init(tag: h2)
    }

    public convenience init(h3: () -> H3) {
        self.init(tag: h3)
    }

    public convenience init(h4: () -> H4) {
        self.init(tag: h4)
    }

    public convenience init(h5: () -> H5) {
        self.init(tag: h5)
    }
    
    public convenience init(h6: () -> H6) {
        self.init(tag: h6)
    }

    private override init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardTitle)
        }
    }
}

public class CardSubtitle: Component {
    
    public static func make(_ text: String) -> CardSubtitle {
        CardSubtitle(h6: { H6(text) })
    }
        
    public convenience init(h1: () -> H1) {
        self.init(tag: h1)
    }

    public convenience init(h2: () -> H2) {
        self.init(tag: h2)
    }

    public convenience init(h3: () -> H3) {
        self.init(tag: h3)
    }

    public convenience init(h4: () -> H4) {
        self.init(tag: h4)
    }

    public convenience init(h5: () -> H5) {
        self.init(tag: h5)
    }
    
    public convenience init(h6: () -> H6) {
        self.init(tag: h6)
    }

    private override init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardSubtitle)
        }
    }
}

public class CardText: Component {
    
    public static func make(_ text: String) -> CardText {
        CardText {
            P(text)
        }
    }
        
    public init(p: () -> P) {
        super.init {
            p()
                .class(insert: .cardText)
        }
    }
}

public class CardLink: Component {
    
    public static func make(_ title: String, href: String) -> CardLink {
        CardLink {
            A(title).href(href)
        }
    }
        
    public convenience init(_ a: () -> A) {
        self.init(tag: a)
    }
    
    public convenience init(_ button: () -> BsButton) {
        self.init(tag: { button().build() })
    }
    
    private override init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardLink)
        }
    }
}

public class CardFooter: Component {
    
    public static func make(_ text: String) -> CardFooter {
        CardFooter {
            Div(text)
        }
    }
        
    public init(div: () -> Div) {
        super.init {
            div()
                .class(insert: .cardFooter)
        }
    }
}
