//
//  Carousel.swift
//  
//
//  Created by Brad Gourley on 3/8/22.
//

import SwiftHtml
import SwiftSgml

public class Carousel: Component {
    
    let div: Div
    
    public convenience init(imgs: [Img]) {
        let div = Div {
            for (index, img) in imgs.enumerated() {
                CarouselItem(Div{img.class(add: .dBlock, .w100)}, isActive: index == 0)
            }
        }
        self.init(div)
    }
    
    public convenience init(items: [CarouselItem]) {
        self.init(Div{ items.map {$0 } })
    }
    
    public convenience init(inner: CarouselInner) {
        self.init(Div { inner })
    }
    
    internal init(_ div: Div) {
        self.div = div
    }
}

extension Carousel: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carousel)
    }
}

public class CarouselInner: Component {
    
    let div: Div
    
    public convenience init(items: [CarouselItem]) {
        self.init(Div { items.map{$0} })
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension CarouselInner: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carouselInner)
    }
}

public class CarouselItem: Component {
    
    let div: Div
    let isActive: Bool
    
    public init(_ div: Div, isActive: Bool = false) {
        self.div = div
        self.isActive = isActive
    }
}

extension CarouselItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carouselItem)
            .class(add: .active, if: isActive)
    }
}
