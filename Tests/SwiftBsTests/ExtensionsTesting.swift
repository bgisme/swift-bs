import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class ExtensionsTesting: XCTestCase {

    func testAddClassesStyles() throws {
        let classes: [BsClass] = [.btn, .btnPrimary]
        let styles: [CssKeyValue] = [.width("100px"), .height("25px")]
        let component = BsButton("Test")
        _ = component.class(add: classes)
        _ = component.style(styles)
        let tag = Button().addClassesStyles(component)
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
    }
}
