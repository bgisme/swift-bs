//
//  Card.swift
//  
//
//  Created by Brad Gourley on 3/4/22.
//

import SwiftHtml
import SwiftSvg

/// Cards contain layers of elements
/// Inside Card is one or more: ImageTop, Header, Body, Footer, ImageBottom
/// Card can also contain a CardImageOverlay (which is an Img and a Div)
/// Inside CardBody is one or more: Title, Subtitle, Text
/// Cardbody can also contain one or more links (without any other elements)

public class Card: Component {
    
    let imageTop: Tag?
    let body: CardBody
    let imageBottom: Tag?
    
    public convenience init(top: Img? = nil,
                            bottom: Img? = nil,
                            body: CardBody) {
        self.init(imageTop: top, imageBottom: bottom, body: body)
    }
    
    public convenience init(top: Svg? = nil,
                            bottom: Svg? = nil,
                            body: CardBody) {
        self.init(imageTop: top, imageBottom: bottom, body: body)
    }
    
    internal required init(imageTop: Tag? = nil,
                           imageBottom: Tag? = nil,
                           body: CardBody) {
        self.imageTop = imageTop
        self.imageBottom = imageBottom
        self.body = body
    }
}

extension Card: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            if let imageTop = imageTop {
                imageTop
                    .class(add: .cardImgTop)
            }
            body
            if let imageBottom = imageBottom {
                imageBottom
                    .class(add: .cardImgBottom)
            }
        }
        .class(.card)
    }
}

/// Inside Card
public class CardImageOverlay: Component {
    
    let image: Tag
    let div: Div
    
    public convenience init(_ img: Img, @TagBuilder children: () -> [Tag]) {
        self.init(img, div: Div { children () })
    }
    
    public convenience init(_ svg: Svg, @TagBuilder children: () -> [Tag]) {
        self.init(svg, div: Div { children () })
    }
    
    internal required init(_ tag: Tag, div: Div) {
        self.image = tag
        self.div = div
    }
}

extension CardImageOverlay: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        image.class(add: .cardImg)
        div.class(add: .cardImgOverlay)
    }
}

/// Inside Card
public class CardBody: Component {
    
    let div: Div
    
    public convenience init(title: String? = nil, subtitle: String? = nil, text: String? = nil) {
        var cTitle: CardTitle?
        if let title = title { cTitle = CardTitle(title, h:4) }
        var cSubtitle: CardTitle?
        if let subtitle = subtitle { cSubtitle = CardTitle(subtitle, h:5, isSubtitle: true) }
        var cText: CardText?
        if let text = text { cText = CardText(text) }
        self.init(title: cTitle, subtitle: cSubtitle, text: cText)
    }
    
    public convenience init(title: CardTitle? = nil, subtitle: CardTitle? = nil, text: CardText? = nil) {
        let div = Div {
            if let title = title { title.build() }
            if let subtitle = subtitle { subtitle.build() }
            if let text = text { text.build() }
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
            .class(.cardBody)
    }
}

/// Inside CardBody (can be either Title or Subtitle)
public class CardTitle: Component {
    
    let tag: Tag
    let isSubtitle: Bool
    
    public convenience init(_ text: String, h: Int, isSubtitle: Bool = false) {
        switch h {
        case 0, 1: self.init(tag: H1(text), isSubtitle: isSubtitle)
        case 2: self.init(tag: H2(text), isSubtitle: isSubtitle)
        case 3: self.init(tag: H3(text), isSubtitle: isSubtitle)
        case 4: self.init(tag: H4(text), isSubtitle: isSubtitle)
        case 5: self.init(tag: H5(text), isSubtitle: isSubtitle)
        default: self.init(tag: H6(text), isSubtitle: isSubtitle)
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
        tag
            .class(.cardTitle, if: !isSubtitle)
            .class(.cardSubtitle, if: isSubtitle)
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
            .class(.cardText)
    }
}

/// Inside Card
public class CardListGroup: Component {
    
    let items: [Li]
    
    public convenience init(@TagBuilder items: () -> [Li]) {
        self.init(items())
    }
    
    public convenience init( _ items: [String]) {
        self.init(items.map{ Li($0) })
    }
    
    public init(_ items: [Li]) {
        self.items = items
    }
}

extension CardListGroup: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Ul {
            items.map { $0.class(add: .listGroupItem) }
        }
        .class(.listGroup, .listGroupFlush)
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
    }
}

/// Inside Card
public class CardFooter: Component {
    
    let div: Div
    
    public convenience init(_ text: String) {
        self.init(Div(text))
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
    }
}
