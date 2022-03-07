//
//  Card.swift
//  
//
//  Created by Brad Gourley on 3/4/22.
//

import SwiftHtml
import SwiftSvg
import SwiftSgml

/// Cards contain layers of elements
/// Inside Card is one or more: ImageTop, Header, Body, Footer, ImageBottom
/// Card can also contain a CardImageOverlay (which is an Img and a Div)
/// Inside CardBody is one or more: Title, Subtitle, Text
/// Cardbody can also contain one or more links (without any other elements)

public class Card: Component {
    
    let header: CardHeader?
    let imgTop: Img?
    let body: CardBody
    let imgBottom: Img?
    let footer: CardFooter?
    
    public convenience init(header: String? = nil,
                            imgTop: Img? = nil,
                            @TagBuilder body: () -> [Tag],
                            imgBottom: Img? = nil,
                            footer: String? = nil) {
        self.init(header: header != nil ? CardHeader(header!) : nil,
                  imgTop: imgTop,
                  body: CardBody(Div{ body() }),
                  imgBottom: imgBottom,
                  footer: footer != nil ? CardFooter(footer!) : nil)
    }
        
    public init(header: CardHeader? = nil,
                imgTop: Img? = nil,
                body: CardBody,
                imgBottom: Img? = nil,
                footer: CardFooter? = nil) {
        self.header = header
        self.imgTop = imgTop
        self.body = body
        self.imgBottom = imgBottom
        self.footer = footer
    }
}

extension Card: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            if let header = header {
                header
                    .class(add: .cardHeader)
            }
            if let imgTop = imgTop {
                imgTop
                    .class(add: .cardImgTop)
            }
            body
            if let imgBottom = imgBottom {
                imgBottom
                    .class(add: .cardImgBottom)
            }
            if let footer = footer {
                footer
                    .class(add: .cardFooter)
            }
        }
        .class(.card)
        .class(add: bsClasses)
        .style(add: styleString)
    }
}

/// Inside Card
public class CardImageOverlay: Component {
    
    let img: Img
    let div: Div
    
    public convenience init(_ img: Img, @TagBuilder children: () -> [Tag]) {
        self.init(img, div: Div { children () })
    }
    
    public init(_ img: Img, div: Div) {
        self.img = img
        self.div = div
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
        var cTitle: CardTitle?
        if let title = title { cTitle = CardTitle(title) }
        var cSubtitle: CardTitle?
        if let subtitle = subtitle { cSubtitle = CardTitle(subtitle, isSubtitle: true) }
        var cText: CardText?
        if let text = text { cText = CardText(text) }
        self.init(title: cTitle, subtitle: cSubtitle, text: cText, links: links)
    }
    
    public convenience init(title: CardTitle? = nil,
                            subtitle: CardTitle? = nil,
                            text: CardText? = nil,
                            links: [A]? = nil) {
        let div = Div {
            if let title = title { title.build() }
            if let subtitle = subtitle { subtitle.build() }
            if let text = text { text.build() }
            if let links = links { links.map{ CardLink($0) } }
        }
        self.init(div)
    }
    
    public convenience init(_ links: [A]) {
        let div = Div {
            links.map { $0.class(add: .cardLink) }
        }
        self.init(div)
    }
    
    public convenience init(@TagBuilder children: () -> [Tag]) {
        self.init(Div { children() })
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension CardBody: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .cardBody)
    }
}

/// Inside CardBody (can be either Title or Subtitle)
public class CardTitle: Component {
    
    let tag: Tag
    let isSubtitle: Bool
    
    public convenience init(_ text: String, isSubtitle: Bool = false) {
        if isSubtitle {
            self.init(H6(text), isSubtitle: isSubtitle)
        } else {
            self.init(H5(text), isSubtitle: isSubtitle)
        }
    }
    
    public convenience init(_ h1: H1, isSubtitle: Bool = false) {
        self.init(tag: h1, isSubtitle: isSubtitle)
    }
    
    public convenience init(_ h2: H2, isSubtitle: Bool = false) {
        self.init(tag: h2, isSubtitle: isSubtitle)
    }
    
    public convenience init(_ h3: H3, isSubtitle: Bool = false) {
        self.init(tag: h3, isSubtitle: isSubtitle)
    }
    
    public convenience init(_ h4: H4, isSubtitle: Bool = false) {
        self.init(tag: h4, isSubtitle: isSubtitle)
    }
    
    public convenience init(_ h5: H5, isSubtitle: Bool = false) {
        self.init(tag: h5, isSubtitle: isSubtitle)
    }
    
    public convenience init(_ h6: H6, isSubtitle: Bool = false) {
        self.init(tag: h6, isSubtitle: isSubtitle)
    }

    internal required init(tag: Tag, isSubtitle: Bool) {
        self.tag = tag
        self.isSubtitle = isSubtitle
    }
}

extension CardTitle: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        let `class`: BsClass = isSubtitle ? .cardSubtitle : .cardTitle
        tag
            .class(add: `class`)
            .class(add: bsClasses)
    }
}

/// Inside CardBody
public class CardText: Component {
    
    let p: P
    
    public convenience init(_ text: String) {
        self.init(P(text))
    }
    
    public init(_ p: P) {
        self.p = p
    }
}

extension CardText: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        p
            .class(add: .cardText)
            .class(add: bsClasses)
    }
}

/// Inside CardBody
public class CardLink: Component {
    
    let a: A
    
    public convenience init(_ title: String, _ href: String = "#") {
        self.init(A(title).href(href))
    }
    
    public init(_ a: A) {
        self.a = a
    }
}

extension CardLink: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        a
            .class(add: .cardLink)
            .class(add: bsClasses)
    }
}

/// Inside Card
public class CardHeader: Component {
    
    let tag: Tag
    
    public convenience init(_ text: String) {
        self.init(tag: Div(text))
    }
    
    public convenience init(_ h1: H1) {
        self.init(tag: h1)
    }
    
    public convenience init(_ h2: H2) {
        self.init(tag: h2)
    }

    public convenience init(_ h3: H3) {
        self.init(tag: h3)
    }

    public convenience init(_ h4: H4) {
        self.init(tag: h4)
    }

    public convenience init(_ h5: H5) {
        self.init(tag: h5)
    }
    
    public convenience init(_ h6: H6) {
        self.init(tag: h6)
    }

    public convenience init(@TagBuilder children: @escaping () -> [Tag]) {
        let div = Div { children() }
        self.init(tag: div)
    }
    
    internal required init(tag: Tag) {
        self.tag = tag
    }
}

extension CardHeader: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .cardHeader)
            .class(add: bsClasses)
    }
}

/// Inside Card
public class CardFooter: Component {
    
    let div: Div
    
    public convenience init(_ text: String) {
        self.init {
            Text(text)
        }
    }
    
    public convenience init(@TagBuilder children: () -> [Tag]) {
        self.init(Div(children()))
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension CardFooter: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .cardFooter)
            .class(add: bsClasses)
    }
}
