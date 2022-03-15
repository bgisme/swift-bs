import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class ExtensionTests: XCTestCase {

    func testAddClassesStyles() throws {
        let classes: [BsClass] = [.btn, .btnPrimary]
        let styles: [CssKeyValue] = [.width("100px"), .height("25px")]
        let component = BsButton("Test")
        _ = component.class(add: classes)
        _ = component.style(styles)
        let tag = Button().addClassesStyles(component)
        XCTAssert(tag.has(classes))
        XCTAssert(tag.has(styles))
        
        let emptyClasses: [BsClass] = []
        let emptyStyles: [CssKeyValue] = []
        let componentB = BsButton("Test")
        let tagB = Button()
            .class(emptyClasses)
            .style(emptyStyles)
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "class"}))
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "style"}))
        _ = tagB.addClassesStyles(componentB)
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "class"}))
        XCTAssert(!tagB.node.attributes.contains(where:{$0.key == "style"}))
    }
}
