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

public class Card: Component {
    
    let div: Div
    
    public convenience init(header: String? = nil,
                            imgTop: Img? = nil,
                            text: String? = nil,
                            imgBottom: Img? = nil,
                            footer: String? = nil) {
        self.init {
            Div {
                if let header = header {
                    CardHeader { Div(header) }
                }
                if let imgTop = imgTop { imgTop }
                if let text = text {
                    CardBody {
                        Div(text)
                    }
                }
                if let imgBottom = imgBottom { imgBottom }
                if let footer = footer {
                    CardFooter { Div(footer) }
                }
            }
        }
    }
    
    public init(div: () -> Div) {
        self.div = div()
    }
}

extension Card: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .card)
            .merge(attributes)
    }
}

/// Inside Card
public class CardImageOverlay: Component {
    
    let img: Img
    let div: Div
    
    public init(img: () -> Img, div: () -> Div) {
        self.img = img()
        self.div = div()
    }
}

extension CardImageOverlay: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        img.class(add: .cardImg)
        div.class(add: .cardImgOverlay)
    }
}

/// Inside Card
public class CardBody: Component {
    
    let div: Div
    
    public convenience init(title: String? = nil,
                            subtitle: String? = nil,
                            text: String? = nil,
                            links: [A]? = nil) {
        self.init(title: title != nil ? CardTitle(title!) : nil,
                  subtitle: subtitle != nil ? CardTitle(subtitle!, isSubtitle: true) : nil,
                  text: text != nil ? CardText(text!) : nil,
                  links: links)
    }
    
    public convenience init(title: CardTitle? = nil,
                            subtitle: CardTitle? = nil,
                            text: CardText? = nil,
                            links: [A]? = nil) {
        self.init {
            Div {
                if let title = title {
                    title
                }
                if let subtitle = subtitle {
                    subtitle
                }
                if let text = text {
                    text
                }
                if let links = links {
                    for link in links {
                        CardLink { link }
                    }
                }
            }
        }
    }
    
    public init(_ div: () -> Div) {
        self.div = div()
    }
}

extension CardBody: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .cardBody)
            .merge(attributes)
    }
}

/// Inside CardBody (can be either Title or Subtitle)
public class CardTitle: Component {
    
    let tag: Tag
    let isSubtitle: Bool
    
    public convenience init(_ text: String, isSubtitle: Bool = false) {
        if isSubtitle {
            self.init(isSubtitle: isSubtitle) { H6(text) }
        } else {
            self.init(isSubtitle: isSubtitle) { H5(text) }
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
        self.isSubtitle = isSubtitle
        self.tag = tag()
    }
}

extension CardTitle: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        let `class`: BsClass = isSubtitle ? .cardSubtitle : .cardTitle
        tag
            .class(add: `class`)
            .merge(attributes)
    }
}

/// Inside CardBody
public class CardText: Component {
    
    let p: P
    
    public convenience init(_ text: String) {
        self.init { P(text) }
    }
    
    public init(_ p: () -> P) {
        self.p = p()
    }
}

extension CardText: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        p
            .class(add: .cardText)
            .merge(attributes)
    }
}

/// Inside CardBody
public class CardLink: Component {
    
    let a: A
    
    public convenience init(_ title: String, _ href: String = "#") {
        self.init {
            A(title).href(href)
        }
    }
    
    public init(_ a: () -> A) {
        self.a = a()
    }
}

extension CardLink: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        a
            .class(add: .cardLink)
            .merge(attributes)
    }
}

/// Inside Card
public class CardHeader: Component {
    
    let tag: Tag
    
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

    internal required init(tag: () -> Tag) {
        self.tag = tag()
    }
}

extension CardHeader: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .cardHeader)
            .merge(attributes)
    }
}

/// Inside Card
public class CardFooter: Component {
    
    let div: Div
    
    public convenience init(_ text: String) {
        self.init { Div(text) }
    }
    
    public init(div: () -> Div) {
        self.div = div()
    }
}

extension CardFooter: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .cardFooter)
            .merge(attributes)
    }
}
