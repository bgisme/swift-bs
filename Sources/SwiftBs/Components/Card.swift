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
    
    public convenience init(header: CardHeader? = nil,
                            topImage: Img? = nil,
                            body: CardBody? = nil,
                            bottomImage: Img? = nil,
                            footer: CardFooter? = nil) {
        self.init {
            Div {
                if let header = header { header }
                if let topImage = topImage { topImage }
                if let body = body { body }
                if let bottomImage = bottomImage { bottomImage }
                if let footer = footer { footer }
            }
        }
    }
        
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }.class(insert: .card)
        }
    }
    
    /// children ...
    /// CardHeader
    /// Img top
    /// CardBody
    /// Img bottom
    /// CardFooter
//    public init(div: () -> Div) {
//        super.init {
//            div()
//                .class(insert: .card)
//        }
//    }
}

public class CardImageOverlay: Component {
    
    public init(img: () -> Img, div: () -> Div) {
        super.init {
            img().class(insert: .cardImg)
            div().class(insert: .cardImgOverlay)
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
    
    internal init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .cardHeader)
        }
    }
}

public class CardBody: Component {
    
    public convenience init(_ title: String,
                            subtitle: String? = nil,
                            text: String? = nil) {
        self.init(title, subtitle: subtitle, text: text, links: {})
    }
    
    public convenience init(_ title: String,
                            subtitle: String? = nil,
                            text: String? = nil,
                            @TagBuilder links: () -> [Tag]) {
        self.init(div: {
            Div {
                CardTitle(title)
                if let subtitle = subtitle {
                    CardTitle(subtitle, isSubtitle: true)
                }
                if let text = text {
                    CardText(text)
                }
                links()
            }
        })
    }
        
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        self.init(div: {
            Div { contents() }
        })
    }
    
    /// children ...
    /// CardTitle
    /// CardText
    /// A  A  A
    public init(div: () -> Div) {
        super.init {
            div()
                .class(insert: .cardBody)
        }
    }
}

/// Inside CardBody (can be either Title or Subtitle)
public class CardTitle: Component {
    
    public convenience init(_ text: String, isSubtitle: Bool = false) {
        if isSubtitle {
            self.init(isSubtitle: isSubtitle, h6: { H6(text) })
        } else {
            self.init(isSubtitle: isSubtitle, h5: { H5(text) })
        }
    }
        
    public convenience init(isSubtitle: Bool = false, h1: () -> H1) {
        self.init(isSubtitle: isSubtitle, tag: h1)
    }

    public convenience init(isSubtitle: Bool = false, h2: () -> H2) {
        self.init(isSubtitle: isSubtitle, tag: h2)
    }

    public convenience init(isSubtitle: Bool = false, h3: () -> H3) {
        self.init(isSubtitle: isSubtitle, tag: h3)
    }

    public convenience init(isSubtitle: Bool = false, h4: () -> H4) {
        self.init(isSubtitle: isSubtitle, tag: h4)
    }

    public convenience init(isSubtitle: Bool = false, h5: () -> H5) {
        self.init(isSubtitle: isSubtitle, tag: h5)
    }
    
    public convenience init(isSubtitle: Bool = false, h6: () -> H6) {
        self.init(isSubtitle: isSubtitle, tag: h6)
    }

    internal required init(isSubtitle: Bool, tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: isSubtitle ? .cardSubtitle : .cardTitle)
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
        
    public init(_ a: () -> A) {
        super.init {
            a()
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
