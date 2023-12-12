
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

open class Card: Div {
        
    /// contents ... CardHeader, top Img, CardBody, bottom Img, CardFooter
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .card)
    }
    
    @discardableResult
    public func textAlign(_ value: AlignText?, _ condition: Bool = true) -> Self {
        if let value = value {
            return self.class(insert: value.class, if: condition)
        } else {
            return self.class(remove: AlignText.allCases.map{$0.class}, condition)
        }
    }
}

open class CardImageOverlay: Tag {
    
    public init(img: () -> Img,
                @TagBuilder content: () -> Tag) {
        let temp = Tag {
            img().class(insert: .cardImg)
            Div {
                content()
            }
            .class(insert: .cardImgOverlay)
        }
        super.init(temp.children)
    }
}

open class CardHeader: Tag {
    
    public enum Kind: String {
        case div
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
    }
    
    public convenience init(_ text: String) {
        self.init(.div) { Text(text) }
    }
    
    public convenience init(_ navTab: () -> NavTab) {
        let cardNav: Utility?
        let navTab = navTab()
        switch navTab.style {
        case .pills:
            cardNav = .cardHeaderPills
        case .tabs:
            cardNav = .cardHeaderTabs
        default:
            cardNav = nil
        }
        self.init(.div) {
            navTab.class(insert: cardNav)
        }
    }
    
    public init(_ kind: Kind,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .cardHeader)
    }
}

open class CardImgTop: Img {
    
    override public init(src: String, alt: String) {
        super.init(src: src, alt: alt)
        self
            .class(insert: .cardImgTop)
    }
}

open class CardImgBottom: Img {
    
    override public init(src: String, alt: String) {
        super.init(src: src, alt: alt)
        self
            .class(insert: .cardImgBottom)
    }
}

open class CardBody: Div {
        
    public convenience init(_ text: String) {
        self.init { Text(text) }
    }
    
    public convenience init(title: String? = nil,
                            subtitle: String? = nil,
                            text: String? = nil) {
        self.init(title: title, subtitle: subtitle, text: text) {}
    }
    
    public convenience init(title: String? = nil,
                            subtitle: String? = nil,
                            text: String? = nil,
                            @TagBuilder content: () -> Tag) {
        self.init {
            if let title = title {
                CardTitle(title)
            }
            if let subtitle = subtitle {
                CardSubtitle(subtitle)
            }
            if let text = text {
                CardText(text)
            }
            content()
        }
    }
    
    /// contents ...
    /// CardTitle
    /// CardText
    /// CardLink
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .cardBody)
    }
}

open class CardTitle: Tag {
    
    public enum Kind: String {
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
    }
    
    public convenience init(_ text: String) {
        self.init(.h5) { Text(text) }
    }
    
    public init(_ kind: Kind,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .cardTitle)
    }
}

open class CardSubtitle: Tag {
    
    public enum Kind: String {
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
    }
    
    public convenience init(_ text: String) {
        self.init(.h6) { Text(text) }
    }
    
    public init(_ kind: Kind,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .cardSubtitle)
    }
}

open class CardText: P {
    
    public convenience init(_ text: String) {
        self.init { Text(text) }
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .cardText)
    }
}

open class CardLink: Tag {
    
    public enum Kind: String {
        case a
        case button
    }
    
    public convenience init(_ title: String, href: String) {
        self.init(.a) { Text(title) }
        self
            .attribute("href", href)
    }
    
    public init(_ kind: Kind,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .cardLink)
    }
}

open class CardFooter: Div {
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .cardFooter)
    }    
}
