import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class ExtensionTests: XCTestCase {

    func testAddClassesStyles() throws {
        let classes: [BsClass] = [.btn, .btnPrimary]
        let styles: [CssKeyValue] = [.width("100px"), .height("25px")]
        let component = BsButton { Button("Test") }
        _ = component.class(insert: classes)
        _ = component.style(set: styles)
        let tag = Button()
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
        
        let emptyClasses: [BsClass] = []
        let emptyStyles: [CssKeyValue] = []
        let tagB = Button()
            .class(insert: emptyClasses)
            .style(set: emptyStyles)
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "class"}))
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "style"}))
    }
}
