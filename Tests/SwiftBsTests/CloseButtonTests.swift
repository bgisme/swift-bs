import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CloseButtonTests: XCTestCase {
    
    func testCloseButton() throws {
        let classes: [BsClass] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")]
        let tag = CloseButton(isDisabled: true, isWhite: true)
            .class(add: classes)
            .style(styles)
            .build()
        if let classValue = tag.firstChildAttributeValue("class") {
            print("\r\rclassValue = \(classValue)\r\r")
            XCTAssert(classValue.containsOneInstanceOf(.btnClose))
            XCTAssert(classValue.containsOneInstanceOf(.btnCloseWhite))
        } else {
            XCTFail()
        }
        if let ariaLabel = tag.firstChildAttributeValue(.ariaLabel) {
            XCTAssert(ariaLabel == "Close")
        } else {
            XCTFail()
        }
        XCTAssert(tag.firstChildAttribute(.disabled) != nil)
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
}
