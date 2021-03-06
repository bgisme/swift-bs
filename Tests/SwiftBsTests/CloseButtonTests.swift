import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CloseButtonTests: XCTestCase {
    
    func testCloseButton() throws {
        let classes: [Utility] = [.mt3, .bgPrimary]
        let styles: [CssKeyValue] = [.marginTop("3"), .backgroundColor("blue")].compactMap{$0}
        let tag = CloseButton(dismiss: .modal)
            .isDisabled()
            .isWhite()
            .class(insert: classes)
            .style(set: styles)
            .build()
        if let classValue = tag.value(.class) {
            XCTAssert(classValue.has(.btnClose))
            XCTAssert(classValue.has(.btnCloseWhite))
        } else {
            XCTFail()
        }
        if let ariaLabel = tag.value(.ariaLabel) {
            XCTAssert(ariaLabel == "Close")
        } else {
            XCTFail()
        }
        XCTAssert(tag.has(.disabled))
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
}
