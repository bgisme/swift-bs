//
//  Carousel.swift
//  
//
//  Created by Brad Gourley on 3/8/22.
//

import SwiftHtml

public class Carousel: Component {
    
    let id: String
    let interval: Int?   // milliseconds... seconds * 1000
    let isCrossFade: Bool
    let isAutoplayDisabled: Bool
    let isTouchDisabled: Bool
    let isDark: Bool
    let div: Div
    
    public convenience init(id: String,
                            interval milliseconds: Int? = nil,
                            controls: Bool = false,
                            indicators: Bool = false,
                            isCrossFade: Bool = false,
                            isAutoplayDisabled: Bool = false,
                            isTouchDisabled: Bool = false,
                            isDark: Bool = false,
                            imgs: [Img]) {
        let items = imgs.enumerated().map { CarouselItem($1, isActive: $0 == 0) }
        self.init(id: id,
                  interval: milliseconds,
                  controls: controls,
                  indicators: indicators,
                  isCrossFade: isCrossFade,
                  isAutoplayDisabled: isAutoplayDisabled,
                  isTouchDisabled: isTouchDisabled,
                  isDark: isDark,
                  items: items)
    }
    
    public convenience init(id: String,
                            interval milliseconds: Int? = nil,
                            controls: Bool = false,
                            indicators: Bool = false,
                            isCrossFade: Bool = false,
                            isAutoplayDisabled: Bool = false,
                            isTouchDisabled: Bool = false,
                            isDark: Bool = false,
                            items: [CarouselItem]) {
        let cntrls = controls ? [CarouselControl(.prev, carouselId: id), CarouselControl(.next, carouselId: id)] : nil
        let indctrs = indicators ? CarouselIndicator.batch(count: items.count, carouselId: id) : nil
        self.init(id: id,
                  interval: milliseconds,
                  isCrossFade: isCrossFade,
                  isAutoplayDisabled: isAutoplayDisabled,
                  isTouchDisabled: isTouchDisabled,
                  isDark: isDark,
                  inner: CarouselInner(items),
                  controls: cntrls,
                  indicators: indctrs)
    }
    
    public convenience init(id: String,
                            interval milliseconds: Int? = nil,
                            isCrossFade: Bool = false,
                            isAutoplayDisabled: Bool = false,
                            isTouchDisabled: Bool = false,
                            isDark: Bool = false,
                            inner: CarouselInner,
                            controls: [CarouselControl]? = nil,
                            indicators: [CarouselIndicator]? = nil) {
        self.init(id: id,
                  interval: milliseconds,
                  isCrossFade: isCrossFade,
                  isAutoplayDisabled: isAutoplayDisabled,
                  isTouchDisabled: isTouchDisabled,
                  isDark: isDark) {
            Div {
                if let indicators = indicators {
                    Div { indicators.map { $0 } }.class(add: .carouselIndicators)
                }
                inner
                if let controls = controls {
                    controls.map { $0 }
                }
            }
        }
    }
    
    internal init(id: String,
                  interval milliseconds: Int?,
                  isCrossFade: Bool,
                  isAutoplayDisabled: Bool,
                  isTouchDisabled: Bool,
                  isDark: Bool,
                  div: () -> Div) {
        self.id = id
        self.interval = !isAutoplayDisabled ? milliseconds : nil
        self.isCrossFade = isCrossFade
        self.isAutoplayDisabled = isAutoplayDisabled
        self.isTouchDisabled = isTouchDisabled
        self.isDark = isDark
        self.div = div()
    }
}

extension Carousel: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .id(id)
            .class(add: .carousel, .slide)
            .dataBsInterval(interval)
            .class(add: .carouselFade, if: isCrossFade)
            .class(add: .carouselDark, if: isDark)
            .dataBsRide(.carousel)
            .dataBsInterval(false, isAutoplayDisabled)
            .dataBsTouch(false, isTouchDisabled)
            .merge(attributes)
    }
}

public class CarouselInner: Component {
    
    let div: Div
    
    public convenience init(_ items: [CarouselItem]) {
        self.init(div: {
            Div { items.map{$0} }
        })
    }
    
    public init(div: () -> Div) {
        self.div = div()
    }
}

extension CarouselInner: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carouselInner)
            .merge(attributes)
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
        self.init(isActive: isActive, interval: seconds) {
            Div {
                img
                if let caption = caption {
                    caption
                }
            }
        }
    }
    
    public init(isActive: Bool = false, interval seconds: Int? = nil, div: () -> Div) {
        self.isActive = isActive
        if let seconds = seconds {
            self.interval = seconds < Int.max / 1000 ? seconds * 1000 : Int.max
        } else {
            self.interval = nil
        }
        self.div = div()
    }
}

extension CarouselItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carouselItem)
            .class(add: .active, if: isActive)
            .dataBsInterval(interval)
            .merge(attributes)
    }
}

public class CarouselCaption: Component {
    
    let div: Div
    
    public convenience init(_ title: String, _ text: String) {
        self.init {
            Div {
                H5(title)
                P(text)
            }
        }
    }
    
    public init(_ div: () -> Div) {
        self.div = div()
    }
}

extension CarouselCaption: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .carouselCaption)
            .merge(attributes)
    }
}

public class CarouselControl: Component {
    
    public enum Direction: String {
        case prev
        case next
    }
    
    let tag: Tag
    let direction: Direction
    let carouselId: String
    
    public convenience init(_ direction: Direction, carouselId id: String) {
        let text: String
        let icon: String
        let controlDirection: BsClass
        switch direction {
        case .prev:
            text = "Previous"
            icon = "carousel-control-prev-icon"
            controlDirection = .carouselControlPrev
        case .next:
            text = "Next"
            icon = "carousel-control-next-icon"
            controlDirection = .carouselControlNext
        }
        self.init(direction: direction, carouselId: id) {
            Button {
                Span()
                    .class(add: icon)
                    .ariaHidden(true)
                Span(text)
                    .class(add: .visuallyHidden)
            }
            .type(.button)
            .class(add: controlDirection)
        }
    }
    
    public convenience init(direction: Direction, carouselId id: String, button: () -> Button) {
        self.init(direction: direction, carouselId: id, tag: button)
    }
    
    public convenience init(direction: Direction, carouselId id: String, a: () -> A) {
        self.init(direction: direction, carouselId: id, tag: a)
    }
    
    internal required init(direction: Direction, carouselId id: String, tag: () -> Tag) {
        self.direction = direction
        self.carouselId = id
        self.tag = tag()
    }
}

extension CarouselControl: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .dataBsTarget(carouselId)
            .dataBsSlide(direction.rawValue)
            .merge(attributes)
    }
}

public class CarouselIndicator: Component {
    
    let button: Button
    let index: Int
    let isActive: Bool
    let carouselId: String
    
    public static func batch(count: Int,
                             activeIndex: Int = 0,
                             carouselId id: String) -> [CarouselIndicator] {
        guard count > 0 else { return [] }
        let activeIndex = activeIndex >= count ? count - 1 : activeIndex
        var indicators = [CarouselIndicator]()
        for i in 0..<count {
            indicators.append(CarouselIndicator(index: i, isActive: i == activeIndex, carouselId: id) { Button() })
        }
        return indicators
    }

    public init(index: Int,
                isActive: Bool = false,
                carouselId: String,
                button: () -> Button) {
        self.index = index
        self.isActive = isActive
        self.carouselId = carouselId
        self.button = button()
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
            .merge(attributes)
    }
}
