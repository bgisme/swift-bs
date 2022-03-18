import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class ExtensionTests: XCTestCase {

    func testAddClassesStyles() throws {
        let classes: [BsClass] = [.btn, .btnPrimary]
        let styles: [CssKeyValue] = [.width("100px"), .height("25px")]
        let component = BsButton { Button("Test") }
        _ = component.class(add: classes)
        _ = component.style(add: styles)
        let tag = Button().merge(component.attributes)
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
        
        let emptyClasses: [BsClass] = []
        let emptyStyles: [CssKeyValue] = []
        let componentB = BsButton { Button("Test") }
        let tagB = Button()
            .class(add: emptyClasses)
            .style(add: emptyStyles)
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "class"}))
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "style"}))
        _ = tagB.merge(componentB.attributes)
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "class"}))
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "style"}))
    }
}
