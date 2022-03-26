import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CarouselTests: XCTestCase {
    
    /// has id
    /// class contains 'carousel' and 'slide'
    /// data-bs-ride = "carousel"
    func testCarousel() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")].compactMap{$0}
        let id = "id"
        let tag = Carousel(id: id, imgs: [
            Img(src: "", alt: ""),
            Img(src: "", alt: ""),
            Img(src: "", alt: ""),
        ])
            .class(insert: classes)
            .style(set: styles)
            .build()
        if let tagId = tag.id {
            XCTAssert(tagId == id)
        } else {
            XCTFail()
        }
        if let classValue = tag.value(.class) {
            XCTAssert(classValue.has(.carousel))
            XCTAssert(classValue.has(.slide))
        } else {
            XCTFail()
        }
        if let dataBsRide = tag.value(.dataBsRide) {
            XCTAssert(dataBsRide == BsClass.carousel.rawValue)
        } else {
            XCTFail()
        }
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
    
    func testCarouselIsCrossfade() throws {
        let tag = Carousel(id: "id",
                           imgs: [
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                           ])
            .isCrossFadable()
            .build()
        if let classValue = tag.value(.class) {
            XCTAssert(classValue.has(.carouselFade))
        } else {
            XCTFail()
        }
    }
    
    func testCarouselIsAutoplayDisabled() throws {
        let interval = 10000
        let tag = Carousel(id: "id",
                           imgs: [
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                           ])
            .interval(interval)
            .isAutoplayDisabled()
            .build()
        if let dataBsInterval = tag.value(.dataBsInterval) {
            XCTAssert(dataBsInterval == "false")
        } else {
            XCTFail()
        }
        let tagNotDisabled = Carousel(id: "id",
                                      imgs: [
                                        Img(src: "", alt: ""),
                                        Img(src: "", alt: ""),
                                        Img(src: "", alt: ""),
                                      ])
            .interval(interval)
            .build()
        if let dataBsRide = tagNotDisabled.value(.dataBsRide) {
            XCTAssert(dataBsRide == BsClass.carousel.rawValue)
        } else {
            XCTFail()
        }
        if let dataBsInterval = tagNotDisabled.value(.dataBsInterval) {
            XCTAssert(dataBsInterval == String(interval))
        }
    }
    
    func testCarouselIsTouchDisabled() throws {
        let tag = Carousel(id: "id",
                           imgs: [
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                           ])
            .isTouchDisabled()
            .build()
        if let dataBsTouch = tag.value(.dataBsTouch) {
            XCTAssert(dataBsTouch == String(false))
        } else {
            XCTFail()
        }
    }
    
    func testCarouselIsDark() throws {
        let tag = Carousel(id: "id",
                           imgs: [
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                           ])
            .isDark()
            .build()
        if let classValue = tag.value(.class) {
            XCTAssert(classValue.has(.carouselDark))
        } else {
            XCTFail()
        }
    }
    
    func testCarouselInner() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")].compactMap{$0}
        let tag = CarouselInner { Div{} }
            .class(insert: classes)
            .style(set: styles)
        if let classValue = tag.build().value(.class) {
            XCTAssert(classValue.has(.carouselInner))
            XCTAssert(classValue.has(classes))
        } else {
            XCTFail()
        }
        if let styleValue = tag.build().value(.style) {
            XCTAssert(styleValue.has(styles))
        } else {
            XCTFail()
        }
    }
    
    func testCarouselItem() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")].compactMap{$0}
        let tag = CarouselItem(Img(src: "", alt: "Slide 1"),
                               caption: CarouselCaption("caption title", "caption text"),
                               isActive: true,
                               interval: 1)
            .class(insert: classes)
            .style(set: styles)
            .build()
        if let classValue = tag.value(.class) {
            XCTAssert(classValue.has(.carouselItem))
            XCTAssert(classValue.has(.active))
        } else {
            XCTFail()
        }
        if let dataBsInterval = tag.value(.dataBsInterval) {
            XCTAssert(dataBsInterval == "1000")
        } else {
            XCTFail()
        }
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
    
    func testCarouselControl() throws {
        let id = "id"
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")].compactMap{$0}
        let prevTag = CarouselControl(.prev, carouselId: id)
            .class(insert: classes)
            .style(set: styles)
            .build()
        if let classValue = prevTag.value(.class) {
            XCTAssert(classValue.has(.carouselControlPrev))
        } else {
            XCTFail()
        }
        if let dataBsTarget = prevTag.value(.dataBsTarget) {
            XCTAssert(dataBsTarget == "#\(id)")
        } else {
            XCTFail()
        }
        if let dataBsSlide = prevTag.value(.dataBsSlide) {
            XCTAssert(dataBsSlide == CarouselControl.Direction.prev.rawValue)
        } else {
            XCTFail()
        }
        XCTAssert(prevTag.has(classes))
        XCTAssert(prevTag.has(styles))
        let nextTag = CarouselControl(.next, carouselId: id)
            .class(insert: classes)
            .style(set: styles)
            .build()
        if let classValue = nextTag.value(.class) {
            XCTAssert(classValue.has(.carouselControlNext))
        } else {
            XCTFail()
        }
        if let dataBsTarget = nextTag.value(.dataBsTarget) {
            XCTAssert(dataBsTarget == "#\(id)")
        } else {
            XCTFail()
        }
        if let dataBsSlide = nextTag.value(.dataBsSlide) {
            XCTAssert(dataBsSlide == CarouselControl.Direction.next.rawValue)
        } else {
            XCTFail()
        }
        XCTAssert(nextTag.has(classes))
        XCTAssert(nextTag.has(styles))
    }
    
    func testCarouselCaption() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")].compactMap{$0}
        let tag = CarouselCaption("title", "text")
            .class(insert: classes)
            .style(set: styles)
            .build()
        if let classValue = tag.value(.class) {
            XCTAssert(classValue.has(.carouselCaption))
        } else {
            XCTFail()
        }        
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
    
    func testCarouselIndicator() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")].compactMap{$0}
        let id = "id"
        let index = 9
        let tag = CarouselIndicator(index: 9,
                                    isActive: true,
                                    carouselId: id) { Button() }
            .class(insert: classes)
            .style(set: styles)
            .build()
        if let type = tag.value("type") {
            XCTAssert(type == BsClass.button.rawValue)
        } else {
            XCTFail()
        }
        if let dataBsTarget = tag.value(.dataBsTarget) {
            XCTAssert(dataBsTarget == "#\(id)")
        } else {
            XCTFail()
        }
        if let dataBsSlideTo = tag.value(.dataBsSlideTo) {
            XCTAssert(dataBsSlideTo == String(index))
        } else {
            XCTFail()
        }
        if let ariaLabel = tag.value(.ariaLabel) {
            XCTAssert(ariaLabel == "Slide \(index)")
        } else {
            XCTFail()
        }
        if let classValue = tag.value(.class) {
            XCTAssert(classValue.has(.active))
        } else {
            XCTFail()
        }
        if let ariaCurrent = tag.value(.ariaCurrent) {
            XCTAssert(ariaCurrent == String(true))
        }
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
}
