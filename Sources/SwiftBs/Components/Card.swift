
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
    
    /// contents ... CardHeader, top Img, CardBody, bottom Img, CardFooter
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .card)

        super.init(div)
    }
    
    @discardableResult
    public func textAlign(_ value: AlignText?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.class)
        } else {
            tag.class(remove: AlignText.allCases.map{$0.class})
        }
        return self
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
    
    public convenience init(navTab: () -> NavTab) {
        let cardNav: Utility?
        switch navTab().style {
        case .pills:
            cardNav = .cardHeaderPills
        case .tabs:
            cardNav = .cardHeaderTabs
        default:
            cardNav = nil
        }
        let div = Div {
            navTab()
                .class(insert: cardNav)
        }
        self.init(div)
    }
    
    public convenience init(_ text: String) {
        self.init(Div(text))
    }
        
    public convenience init(h1: () -> H1) {
        self.init(h1())
    }
    
    public convenience init(h2: () -> H2) {
        self.init(h2())
    }

    public convenience init(h3: () -> H3) {
        self.init(h3())
    }

    public convenience init(h4: () -> H4) {
        self.init(h4())
    }

    public convenience init(h5: () -> H5) {
        self.init(h5())
    }
    
    public convenience init(h6: () -> H6) {
        self.init(h6())
    }
    
    public convenience init(div: () -> Div) {
        self.init(div())
    }
        
    private override init(_ tag: Tag) {
        tag
            .class(insert: .cardHeader)

        super.init(tag)
    }
}

public class CardImgTop: Component {
    
    public convenience init(img: () -> Img) {
        self.init(img())
    }
    
    public init(_ img: Img) {
        img
            .class(insert: .cardImgTop)
        
        super.init(img)
    }
}

public class CardImgBottom: Component {
    
    public convenience init(img: () -> Img) {
        self.init(img())
    }
    
    public init(_ img: Img) {
        img
            .class(insert: .cardImgBottom)
        
        super.init(img)
    }
}

public class CardBody: Component {
    
    public convenience init(_ text: String) {
        self.init(text: text)
    }
    
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
        
    /// contents ...
    /// CardTitle
    /// CardText
    /// CardLink
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .cardBody)

        super.init(div)
    }
}

public class CardTitle: Component {
    
    public convenience init(_ text: String) {
        self.init(H5(text))
    }
        
    public convenience init(h1: () -> H1) {
        self.init(h1())
    }

    public convenience init(h2: () -> H2) {
        self.init(h2())
    }

    public convenience init(h3: () -> H3) {
        self.init(h3())
    }

    public convenience init(h4: () -> H4) {
        self.init(h4())
    }

    public convenience init(h5: () -> H5) {
        self.init(h5())
    }
    
    public convenience init(h6: () -> H6) {
        self.init(h6())
    }

    private override init(_ tag: Tag) {
        tag
            .class(insert: .cardTitle)

        super.init(tag)
    }
}

public class CardSubtitle: Component {
    
    public convenience init(_ text: String) {
        self.init(H6(text))
    }
        
    public convenience init(h1: () -> H1) {
        self.init(h1())
    }

    public convenience init(h2: () -> H2) {
        self.init(h2())
    }

    public convenience init(h3: () -> H3) {
        self.init(h3())
    }

    public convenience init(h4: () -> H4) {
        self.init(h4())
    }

    public convenience init(h5: () -> H5) {
        self.init(h5())
    }
    
    public convenience init(h6: () -> H6) {
        self.init(h6())
    }

    private override init(_ tag: Tag) {
        tag
            .class(insert: .cardSubtitle)

        super.init(tag)
    }
}

public class CardText: Component {
    
    public convenience init(_ text: String) {
        self.init(P(text))
    }
    
    public convenience init(p: () -> P) {
        self.init(p())
    }
        
    public init(_ p: P) {
        p
            .class(insert: .cardText)

        super.init(p)
    }
}

public class CardLink: Component {
    
    public convenience init(_ title: String, href: String) {
        self.init(A(title).href(href))
    }
        
    public convenience init(_ a: () -> A) {
        self.init(a())
    }
    
    public convenience init(_ button: () -> BsButton) {
        self.init( button().build() )
    }
    
    private override init(_ tag: Tag) {
        tag
            .class(insert: .cardLink)

        super.init(tag)
    }
}

public class CardFooter: Component {
    
    public convenience init(_ text: String) {
        self.init(Div(text))
    }
        
    public init(_ div: Div) {
        div
            .class(insert: .cardFooter)

        super.init(div)
    }
}
