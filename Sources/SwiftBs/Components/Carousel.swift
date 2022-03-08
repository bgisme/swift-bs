//
//  Carousel.swift
//  
//
//  Created by Brad Gourley on 3/8/22.
//

import SwiftHtml
import SwiftSgml

public class Carousel: Component {
    
    let id: String
    let isAutoplay: Bool
    let isCrossFade: Bool
    let isTouchDisabled: Bool
    let isDark: Bool
    let div: Div
    
    public convenience init(id: String,
                            controls: Bool = false,
                            indicators: Bool = false,
                            isAutoplay: Bool = true,
                            isCrossFade: Bool = false,
                            isTouchDisabled: Bool = false,
                            isDark: Bool = false,
                            imgs: [Img]) {
        let items = imgs.enumerated().map { CarouselItem($1, isActive: $0 == 0) }
        self.init(id: id,
                  controls: controls,
                  indicators: indicators,
                  isAutoplay: isAutoplay,
                  isCrossFade: isCrossFade,
                  isTouchDisabled: isTouchDisabled,
                  isDark: isDark,
                  items: items)
    }
    
    public convenience init(id: String,
                            controls: Bool = false,
                            indicators: Bool = false,
                            isAutoplay: Bool = true,
                            isCrossFade: Bool = false,
                            isTouchDisabled: Bool = false,
                            isDark: Bool = false,
                            items: [CarouselItem]) {
        let cntrls = controls ? [CarouselControl.prev(carouselId: id), CarouselControl.next(carouselId: id)] : nil
        let indctrs = indicators ? CarouselIndicator.batch(count: items.count, carouselId: id) : nil
        self.init(id: id,
                  isAutoplay: isAutoplay,
                  isCrossFade: isCrossFade,
                  isTouchDisabled: isTouchDisabled,
                  inner: CarouselInner(items),
                  controls: cntrls,
                  indicators: indctrs)
    }
    
    public convenience init(id: String,
                            isAutoplay: Bool = true,
                            isCrossFade: Bool = false,
                            isTouchDisabled: Bool = false,
                            isDark: Bool = false,
                            inner: CarouselInner,
                            controls: [CarouselControl]? = nil,
                            indicators: [CarouselIndicator]? = nil) {
        let div = Div {
            if let indicators = indicators {
                Div { indicators.map { $0 } }.class(add: .carouselIndicators)
            }
            inner
            if let controls = controls {
                controls.map { $0 }
            }
        }
        self.init(id: id,
                  isAutoplay: isAutoplay,
                  isCrossFade: isCrossFade,
                  isTouchDisabled: isTouchDisabled,
                  isDark: isDark,
                  div: div)
    }
    
    internal init(id: String,
                  isAutoplay: Bool,
                  isCrossFade: Bool,
                  isTouchDisabled: Bool,
                  isDark: Bool,
                  div: Div) {
        self.id = id
        self.isAutoplay = isAutoplay
        self.isCrossFade = isCrossFade
        self.isTouchDisabled = isTouchDisabled
        self.isDark = isDark
        self.div = div
    }
}

extension Carousel: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carousel, .slide)
            .class(add: .carouselFade, if: isCrossFade)
            .class(add: .carouselDark, if: isDark)
            .id(id)
            .dataBsRide(.carousel, isAutoplay)
            .dataBsInterval(false, !isAutoplay)
            .dataBsTouch(false, isTouchDisabled)
            .addClassesStyles(self)
    }
}

public class CarouselInner: Component {
    
    let div: Div
    
    public convenience init(_ items: [CarouselItem]) {
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
            .addClassesStyles(self)
    }
}

public class CarouselItem: Component {
    
    let div: Div
    let isActive: Bool
    let interval: Int?
    
    public convenience init(_ img: Img,
                            caption: CarouselCaption? = nil,
                            isActive: Bool = false,
                            interval seconds: Int? = nil) {
        let div = Div {
            img
            if let caption = caption {
                caption
            }
        }
        self.init(div, isActive: isActive, interval: seconds)
    }
    
    public init(_ div: Div, isActive: Bool = false, interval seconds: Int? = nil) {
        self.div = div
        self.isActive = isActive
        if let seconds = seconds {
            self.interval = seconds < Int.max / 1000 ? seconds * 1000 : Int.max
        } else {
            self.interval = nil
        }
    }
}

extension CarouselItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carouselItem)
            .class(add: .active, if: isActive)
            .dataBsInterval(interval)
            .addClassesStyles(self)
    }
}

public class CarouselCaption: Component {
    
    let div: Div
    
    public convenience init(_ title: String, _ text: String) {
        self.init {
            H5(title)
            P(text)
        }
    }
    
    public convenience init(@TagBuilder children: () -> [Tag]) {
        let div = Div { children() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension CarouselCaption: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carouselCaption)
            .addClassesStyles(self)
    }
}

public class CarouselControl: Component {
    
    public enum `Type`: String {
        case prev
        case next
    }
    
    let tag: Tag
    let type: `Type`
    let carouselId: String
    
    public static func prev(carouselId id: String) -> Self {
        let button = Self.button(type: .prev)
        return Self.init(tag: button, type: .prev, carouselId: id)
    }
    
    public static func next(carouselId id: String) -> Self {
        let button = Self.button(type: .next)
        return Self.init(tag: button, type: .next, carouselId: id)
    }
    
    private static func button(type: `Type`) -> Button {
        let text: String
        let icon: String
        switch type {
        case .prev:
            text = "Previous"
            icon = "carousel-control-prev-icon"
        case .next:
            text = "Next"
            icon = "carousel-control-next-icon"
        }
        return Button {
            Span()
                .class(icon)
                .ariaHidden(true)
            Span(text)
                .class(add: .visuallyHidden)
        }
            .type(.button)
    }
    
    public convenience init(_ button: Button, type: `Type`, carouselId id: String) {
        self.init(tag: button, type: type, carouselId: id)
    }
    
    public convenience init(_ a: A, type: `Type`, carouselId id: String) {
        self.init(tag: a, type: type, carouselId: id)
    }
    
    internal required init(tag: Tag, type: `Type`, carouselId id: String) {
        self.tag = tag
        self.type = type
        self.carouselId = id
    }
}

extension CarouselControl: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        switch type {
        case .prev:
            tag.class(add: .carouselControlPrev)
        case .next:
            tag.class(add: .carouselControlNext)
        }
        tag.dataBsTarget(carouselId)
        tag.dataBsSlide(type.rawValue)
        tag.addClassesStyles(self)
    }
}

public class CarouselIndicator: Component {
    
    let button: Button
    let index: Int
    let isActive: Bool
    let carouselId: String
    
    public static func batch(count: Int, activeIndex: Int = 0, carouselId id: String) -> [CarouselIndicator] {
        guard count > 0 else { return [] }
        let activeIndex = activeIndex >= count ? count - 1 : activeIndex
        var indicators = [CarouselIndicator]()
        for i in 0...count {
            indicators.append(CarouselIndicator(index: i, isActive: i == activeIndex, carouselId: id))
        }
        return indicators
    }

    public init(button: Button? = nil, index: Int, isActive: Bool = false, carouselId: String) {
        self.button = button ?? Button()
        self.index = index
        self.isActive = isActive
        self.carouselId = carouselId
    }
}

extension CarouselIndicator: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        button
            .type(.button)
            .dataBsTarget(carouselId)
            .dataBsSlideTo(String(index))
            .ariaLabel("Slide \(index)")
            .class(add: .active, if: isActive)
            .ariaCurrent(isActive)
            .addClassesStyles(self)
    }
}
