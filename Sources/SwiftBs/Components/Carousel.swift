
import SwiftHtml

open class Carousel: Div {
            
    public convenience init(id: String,
                            controls: Bool = false,
                            indicators: Bool = false,
                            @TagBuilder items: () -> [CarouselItem]) {
        let items = items()
        let indicators = indicators ? CarouselIndicator.batch(count: items.count, carouselId: id) : nil
        let controls = controls ? [CarouselControl(.prev, carouselId: id), CarouselControl(.next, carouselId: id)] : nil
        self.init(id: id) {
            if let indicators = indicators {
                Div {
                    indicators.map { $0 }
                }
                .class(insert: .carouselIndicators)
            }
            CarouselInner {
                Tag {
                    items
                }
                if let controls = controls {
                    controls.map { $0 }
                }
            }
        }
    }
    
    public init(id: String,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .id(id)
            .class(insert: .carousel, .slide)
            .dataBsRide(.carousel)
    }
    
    @discardableResult
    public func interval(_ milliseconds: Int, _ condition: Bool = true) -> Self {
        self.dataBsInterval(milliseconds, condition)
    }
    
    @discardableResult
    public func isCrossFadable(if condition: Bool = true) -> Self {
        self.class(insert: .carouselFade, if: condition)
    }
    
    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        self.class(insert: .carouselDark, if: condition)
    }
    
    @discardableResult
    public func isAutoplayDisabled(if condition: Bool = true) -> Self {
        self.dataBsInterval(false, condition)
    }
    
    @discardableResult
    public func isTouchDisabled(if condition: Bool = true) -> Self {
        self.dataBsTouch(false, condition)
    }
}

open class CarouselInner: Div {
        
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .carouselInner)
    }
}

open class CarouselItem: Div {
        
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
    
    public init(isActive: Bool = false,
                interval milliseconds: Int? = nil,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .carouselItem)
            .class(insert: .active, if: isActive)
            .dataBsInterval(milliseconds)
    }
}

open class CarouselCaption: Div {
            
    public convenience init(_ title: String, _ text: String) {
        self.init {
            H5(title)
            P(text)
        }
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .carouselCaption)
    }
}

open class CarouselControl: Tag {
    
    public enum Kind: String {
        case a
        case button
    }
    
    public enum Direction: String {
        case prev
        case next
    }
    
    public convenience init(_ direction: Direction,
                            carouselId id: String) {
        let text: String
        let icon: Utility
        let controlDirection: Utility
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
        self.init(direction: direction, carouselId: id) {
            Button {
                Span()
                    .class(insert: icon)
                    .ariaHidden(true)
                Span(text)
                    .class(insert: .visuallyHidden)
            }
            .type(.button)
            .class(insert: controlDirection)
        }
    }
    
    public init(_ kind: Kind = .button,
                direction: Direction,
                carouselId id: String,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .dataBsTarget(id)
            .dataBsSlide(direction.rawValue)
    }
}

open class CarouselIndicator: Button {
        
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
                isActive: Bool,
                carouselId id: String,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .type(.button)
            .dataBsTarget(id)
            .dataBsSlideTo(String(index))
            .ariaLabel("Slide \(index)")
            .class(insert: .active, if: isActive)
            .ariaCurrent(isActive)
    }
}
