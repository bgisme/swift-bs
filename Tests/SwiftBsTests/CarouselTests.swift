import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CarouselTests: XCTestCase {
    
    /// has id
    /// class contains 'carousel' and 'slide'
    /// data-bs-ride = "carousel"
    func testCarousel() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")]
        let id = "id"
        let tag = Carousel(id: id, imgs: [
            Img(src: "", alt: ""),
            Img(src: "", alt: ""),
            Img(src: "", alt: ""),
        ])
            .class(add: classes)
            .style(styles)
            .build()
        if let tagId = tag.firstChildAttributeValue("id") {
            XCTAssert(tagId == id)
        } else {
            XCTFail()
        }
        if let classValue = tag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.carousel))
            XCTAssert(classValue.containsOneInstanceOf(.slide))
        } else {
            XCTFail()
        }
        if let dataBsRide = tag.firstChildAttributeValue(.dataBsRide) {
            XCTAssert(dataBsRide == BsClass.carousel.rawValue)
        } else {
            XCTFail()
        }
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
    
    func testCarouselIsCrossfade() throws {
        let tag = Carousel(id: "id",
                           isCrossFade: true,
                           imgs: [
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                           ]).build()
        if let classValue = tag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.carouselFade))
        } else {
            XCTFail()
        }
    }
    
    func testCarouselIsAutoplayDisabled() throws {
        let interval = 10000
        let tag = Carousel(id: "id",
                           interval: interval,
                           isAutoplayDisabled: true,
                           imgs: [
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                           ]).build()
        if let dataBsInterval = tag.firstChildAttributeValue(.dataBsInterval) {
            XCTAssert(dataBsInterval == "false")
        } else {
            XCTFail()
        }
        let tagNotDisabled = Carousel(id: "id",
                                      interval: interval,
                                      imgs: [
                                        Img(src: "", alt: ""),
                                        Img(src: "", alt: ""),
                                        Img(src: "", alt: ""),
                                      ]).build()
        if let dataBsRide = tagNotDisabled.firstChildAttributeValue(.dataBsRide) {
            XCTAssert(dataBsRide == BsClass.carousel.rawValue)
        } else {
            XCTFail()
        }
        if let dataBsInterval = tagNotDisabled.firstChildAttributeValue(.dataBsInterval) {
            XCTAssert(dataBsInterval == String(interval))
        }
    }
    
    func testCarouselIsTouchDisabled() throws {
        let tag = Carousel(id: "id",
                           isTouchDisabled: true,
                           imgs: [
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                           ]).build()
        if let dataBsTouch = tag.firstChildAttributeValue(.dataBsTouch) {
            XCTAssert(dataBsTouch == String(false))
        } else {
            XCTFail()
        }
    }
    
    func testCarouselIsDark() throws {
        let tag = Carousel(id: "id",
                           isDark: true,
                           imgs: [
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                            Img(src: "", alt: ""),
                           ]).build()
        if let classValue = tag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.carouselDark))
        } else {
            XCTFail()
        }
    }
    
    func testCarouselInner() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")]
        let tag = CarouselInner(Div())
            .class(add: classes)
            .style(styles)
            .build()
        if let classValue = tag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.carouselInner))
        } else {
            XCTFail()
        }
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
    
    func testCarouselItem() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")]
        let tag = CarouselItem(Img(src: "", alt: "Slide 1"),
                               caption: CarouselCaption("caption title", "caption text"),
                               isActive: true,
                               interval: 1)
            .class(add: classes)
            .style(styles)
            .build()
        if let classValue = tag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.carouselItem))
            XCTAssert(classValue.containsOneInstanceOf(.active))
        } else {
            XCTFail()
        }
        if let dataBsInterval = tag.firstChildAttributeValue(.dataBsInterval) {
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
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")]
        let prevTag = CarouselControl(Button(), direction: .prev, carouselId: id)
            .class(add: classes)
            .style(styles)
            .build()
        if let classValue = prevTag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.carouselControlPrev))
        } else {
            XCTFail()
        }
        if let dataBsTarget = prevTag.firstChildAttributeValue(.dataBsTarget) {
            XCTAssert(dataBsTarget == "#\(id)")
        } else {
            XCTFail()
        }
        if let dataBsSlide = prevTag.firstChildAttributeValue(.dataBsSlide) {
            XCTAssert(dataBsSlide == CarouselControl.Direction.prev.rawValue)
        } else {
            XCTFail()
        }
        XCTAssert(prevTag.has(classes))
        XCTAssert(prevTag.has(styles))
        let nextTag = CarouselControl(Button(), direction: .next, carouselId: id)
            .class(add: classes)
            .style(styles)
            .build()
        if let classValue = nextTag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.carouselControlNext))
        } else {
            XCTFail()
        }
        if let dataBsTarget = nextTag.firstChildAttributeValue(.dataBsTarget) {
            XCTAssert(dataBsTarget == "#\(id)")
        } else {
            XCTFail()
        }
        if let dataBsSlide = nextTag.firstChildAttributeValue(.dataBsSlide) {
            XCTAssert(dataBsSlide == CarouselControl.Direction.next.rawValue)
        } else {
            XCTFail()
        }
        XCTAssert(nextTag.has(classes))
        XCTAssert(nextTag.has(styles))
    }
    
    func testCarouselCaption() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")]
        let tag = CarouselCaption("title", "text")
            .class(add: classes)
            .style(styles)
            .build()
        if let classValue = tag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.carouselCaption))
        } else {
            XCTFail()
        }        
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
    
    func testCarouselIndicator() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")]
        let id = "id"
        let index = 9
        let tag = CarouselIndicator(button: Button(),
                                    index: 9,
                                    isActive: true,
                                    carouselId: id)
            .class(add: classes)
            .style(styles)
            .build()
        if let type = tag.firstChildAttributeValue("type") {
            XCTAssert(type == BsClass.button.rawValue)
        } else {
            XCTFail()
        }
        if let dataBsTarget = tag.firstChildAttributeValue(.dataBsTarget) {
            XCTAssert(dataBsTarget == "#\(id)")
        } else {
            XCTFail()
        }
        if let dataBsSlideTo = tag.firstChildAttributeValue(.dataBsSlideTo) {
            XCTAssert(dataBsSlideTo == String(index))
        } else {
            XCTFail()
        }
        if let ariaLabel = tag.firstChildAttributeValue(.ariaLabel) {
            XCTAssert(ariaLabel == "Slide \(index)")
        } else {
            XCTFail()
        }
        if let classValue = tag.firstChildAttributeValue("class") {
            XCTAssert(classValue.containsOneInstanceOf(.active))
        } else {
            XCTFail()
        }
        if let ariaCurrent = tag.firstChildAttributeValue(.ariaCurrent) {
            XCTAssert(ariaCurrent.containsOneInstanceOf(String(true)))
        }
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
}
