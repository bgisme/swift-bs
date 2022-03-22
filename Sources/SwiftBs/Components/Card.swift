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
    
    public convenience init(header: CardHeader? = nil,
                            topImage: Img? = nil,
                            body: CardBody? = nil,
                            bottomImage: Img? = nil,
                            footer: CardFooter? = nil,
                            textAlign: TextAlign? = nil,
                            width: String? = nil) {
        self.init(width: width) {
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
    public init(width: String? = nil,
                textAlign: TextAlign? = nil,
                @TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .card)
            .class(insert: textAlign?.class)
            .style(set: .width(width))
        }
    }
}

public class CardImageOverlay: Component {
    
    public init(img: () -> Img, @TagBuilder contents: () -> [Tag]) {
        super.init {
            img().class(insert: .cardImg)
            Div {
                contents()
            }
            .class(insert: .cardImgOverlay)
        }
    }
}

public class CardHeader: Component {
    
    public convenience init(_ text: String) {
        self.init(tag: { Div(text) })
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
    
    public convenience init(navTab: () -> NavTab) {
        let cardNav: BsClass?
        switch navTab().style {
        case .pills:
            cardNav = .cardHeaderPills
        case .tabs:
            cardNav = .cardHeaderTabs
        default:
            cardNav = nil
        }
        self.init(tag: {
            Div {
                navTab()
                    .class(insert: cardNav)
            }
        })
    }
    
    private init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardHeader)
        }
    }
}

public class CardBody: Component {
    
    public convenience init(title: String? = nil,
                            subtitle: String? = nil,
                            text: String? = nil) {
        self.init(title: title, subtitle: subtitle, text: text, links: {})
    }
    
    public convenience init(title: String? = nil,
                            subtitle: String? = nil,
                            text: String? = nil,
                            @TagBuilder links: () -> [Tag]) {
        self.init {
            Div {
                if let title = title {
                    CardTitle(title)
                }
                if let subtitle = subtitle {
                    CardSubtitle(subtitle)
                }
                if let text = text {
                    CardText(text)
                }
                links()
            }
        }
    }
        
    /// contents ...
    /// CardTitle
    /// CardText
    /// A  A  A
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .cardBody)
        }
    }
}

public class CardTitle: Component {
    
    public convenience init(_ text: String) {
        self.init(h5: { H5(text) })
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

    private init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardTitle)
        }
    }
}

public class CardSubtitle: Component {
    
    public convenience init(_ text: String) {
        self.init(h6: { H6(text) })
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

    private init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardSubtitle)
        }
    }
}

public class CardText: Component {
    
    public convenience init(_ text: String) {
        self.init {
            P(text)
        }
    }
        
    public init(_ p: () -> P) {
        super.init {
            p()
                .class(insert: .cardText)
        }
    }
}

public class CardLink: Component {
    
    public convenience init(_ title: String, href: String) {
        self.init {
            A(title).href(href)
        }
    }
        
    public convenience init(_ a: () -> A) {
        self.init(tag: a)
    }
    
    public convenience init(_ button: () -> BsButton) {
        self.init(tag: { button().build() })
    }
    
    private init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardLink)
        }
    }
}

public class CardFooter: Component {
    
    public convenience init(_ text: String) {
        self.init {
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
