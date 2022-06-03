
import SwiftHtml

public class Carousel: Component {
    
    public convenience init(id: String,
                            controls: Bool = false,
                            indicators: Bool = false,
                            @TagBuilder carouselItems: () -> [Tag]) {
        let carouselItems = carouselItems()
        let indicators = indicators ? CarouselIndicator.batch(count: carouselItems.count, carouselId: id) : nil
        let controls = controls ? [CarouselControl(.prev, carouselId: id), CarouselControl(.next, carouselId: id)] : nil
        let div = Div {
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
        }
        self.init(id: id, div)
    }
    
    private init(id: String, _ div: Div) {
        div
            .id(id)
            .class(insert: .carousel, .slide)
            .dataBsRide(.carousel)
        
        super.init(div)
    }
    
    @discardableResult
    public func interval(_ milliseconds: Int, _ condition: Bool = true) -> Self {
        tag
            .dataBsInterval(milliseconds, condition)
        return self
    }
    
    @discardableResult
    public func isCrossFadable(if condition: Bool = true) -> Self {
        tag
            .class(insert: .carouselFade, if: condition)
        return self
    }
    
    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        tag
            .class(insert: .carouselDark, if: condition)
        return self
    }
    
    @discardableResult
    public func isAutoplayDisabled(if condition: Bool = true) -> Self {
        tag
            .dataBsInterval(false, condition)
        return self
    }
    
    @discardableResult
    public func isTouchDisabled(if condition: Bool = true) -> Self {
        tag
            .dataBsTouch(false, condition)
        return self
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
