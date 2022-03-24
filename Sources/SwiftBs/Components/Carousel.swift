//
//  Carousel.swift
//  
//
//  Created by Brad Gourley on 3/8/22.
//

import SwiftHtml

public class Carousel: Component {
    
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
                  carouselItems: { items })
    }
    
    public convenience init(id: String,
                            interval milliseconds: Int? = nil,
                            controls: Bool = false,
                            indicators: Bool = false,
                            isCrossFade: Bool = false,
                            isAutoplayDisabled: Bool = false,
                            isTouchDisabled: Bool = false,
                            isDark: Bool = false,
                            @TagBuilder carouselItems: () -> [Tag]) {
        let carouselItems = carouselItems()
        let indicators = indicators ? CarouselIndicator.batch(count: carouselItems.count, carouselId: id) : nil
        let controls = controls ? [CarouselControl(.prev, carouselId: id), CarouselControl(.next, carouselId: id)] : nil
        self.init(id: id,
                  interval: milliseconds,
                  isCrossFade: isCrossFade,
                  isAutoplayDisabled: isAutoplayDisabled,
                  isTouchDisabled: isTouchDisabled,
                  isDark: isDark,
                  contents: {
            if let indicators = indicators {
                Div {
                    indicators.map { $0 }
                }
                .class(insert: .carouselIndicators)
            }
            CarouselInner {
                carouselItems
                if let controls = controls {
                    controls.map { $0 }
                }
            }
        })
    }
    
    public convenience init(id: String,
                            interval milliseconds: Int?,
                            isCrossFade: Bool,
                            isAutoplayDisabled: Bool,
                            isTouchDisabled: Bool,
                            isDark: Bool,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(id: id,
                  interval: milliseconds,
                  isCrossFade: isCrossFade,
                  isAutoplayDisabled: isAutoplayDisabled,
                  isTouchDisabled: isTouchDisabled,
                  isDark: isDark,
                  div)
    }
    
    private init(id: String,
                interval milliseconds: Int?,
                isCrossFade: Bool,
                isAutoplayDisabled: Bool,
                isTouchDisabled: Bool,
                isDark: Bool,
                _ tag: Tag) {
        tag
            .id(id)
            .class(insert: .carousel, .slide)
            .dataBsInterval(milliseconds)
            .class(insert: .carouselFade, if: isCrossFade)
            .class(insert: .carouselDark, if: isDark)
            .dataBsRide(.carousel)
            .dataBsInterval(false, isAutoplayDisabled)
            .dataBsTouch(false, isTouchDisabled)
        
        super.init(tag)
    }
}

public class CarouselInner: Component {
        
    /// contents ... CarouselItems
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .carouselInner)
        
        super.init(div)
    }
}

public class CarouselItem: Component {
    
    public convenience init(_ img: Img,
                            caption: CarouselCaption? = nil,
                            isActive: Bool = false,
                            interval seconds: Int? = nil) {
        self.init(isActive: isActive, interval: seconds) {
            img
            if let caption = caption {
                caption
            }
        }
    }
    
    /// contents ... anything
    public convenience init(isActive: Bool = false,
                            interval milliseconds: Int? = nil,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(isActive: isActive, interval: milliseconds, div)
    }
    
    public init(isActive: Bool,
                interval milliseconds: Int?,
                _ div: Div) {
        div
            .class(insert: .carouselItem)
            .class(insert: .active, if: isActive)
            .dataBsInterval(milliseconds)
        
        super.init(div)
    }
}

public class CarouselCaption: Component {
        
    public convenience init(_ title: String, _ text: String) {
        let div = Div {
            H5(title)
            P(text)
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .carouselCaption)

        super.init(div)
    }
}

public class CarouselControl: Component {
    
    public enum Direction: String {
        case prev
        case next
    }
    
    public convenience init(_ direction: Direction,
                            carouselId id: String) {
        let text: String
        let icon: BsClass
        let controlDirection: BsClass
        switch direction {
        case .prev:
            text = "Previous"
            icon = .carouselControlPrevIcon
            controlDirection = .carouselControlPrev
        case .next:
            text = "Next"
            icon = .carouselControlNextIcon
            controlDirection = .carouselControlNext
        }
        let button = Button {
            Span()
                .class(insert: icon)
                .ariaHidden(true)
            Span(text)
                .class(insert: .visuallyHidden)
        }
        .type(.button)
        .class(insert: controlDirection)

        self.init(direction: direction, carouselId: id, button)
    }
    
    public convenience init(direction: Direction,
                            carouselId id: String,
                            button: () -> Button) {
        self.init(direction: direction, carouselId: id, button())
    }
    
    public convenience init(direction: Direction,
                            carouselId id: String,
                            a: () -> A) {
        self.init(direction: direction, carouselId: id, a())
    }
    
    private init(direction: Direction,
                 carouselId id: String,
                 _ tag: Tag) {
        tag
            .dataBsTarget(id)
            .dataBsSlide(direction.rawValue)

        super.init(tag)
    }
}

public class CarouselIndicator: Component {
    
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

    public convenience init(index: Int,
                            isActive: Bool = false,
                            carouselId id: String,
                            button: () -> Button) {
        self.init(index: index, isActive: isActive, carouselId: id, button())
    }
    
    public init(index: Int,
                isActive: Bool,
                carouselId id: String,
                _ button: Button) {
        button
            .type(.button)
            .dataBsTarget(id)
            .dataBsSlideTo(String(index))
            .ariaLabel("Slide \(index)")
            .class(insert: .active, if: isActive)
            .ariaCurrent(isActive)
        
        super.init(button)
    }
}
