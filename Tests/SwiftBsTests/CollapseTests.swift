import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CollapseTests: XCTestCase {
    
    func testCollapseButton() throws {
        let id = "collapseExample"
        let content = Div("Some content")
        let contents = [CollapseContent(id: id, content)]
        
        // <a> version
        let a = A("Link with href").href("#\(id)")
        let tagA = CollapseButton(a, contents: contents).build()
        XCTAssert(tagA.attributeValue(Attribute.role) == BsClass.button.rawValue)
        XCTAssert(tagA.attributeValue("href") == "#\(id)")
        
        // <button> version
        let button = Button("Button with data-bs-target")
        let tagB = CollapseButton(button, contents: contents).build()
        XCTAssert(tagB.attributeValue(.dataBsTarget) == "#\(id)")
        
        // All buttons and convenience inits
        XCTAssert(tagB.attributeValue(.dataBsToggle) == BsClass.collapse.rawValue)
        XCTAssert(tagB.attributeValue(.ariaExpanded) == String(false))
        XCTAssert(tagB.attributeValue(.ariaControls) == id)
        
        // Multiple targets
        let multiContents = contents + [CollapseContent(id: "collapseExample2", content)]
        let tagC = CollapseButton("Multi-target", contents: multiContents).build()
        XCTAssert(tagC.attributeValue(.dataBsTarget) == BsClass.multiCollapse.rawValue)
        XCTAssert(tagC.attributeValue(.ariaControls) == multiContents.map{$0.id}.joined(separator: " "))
        let multiTags = multiContents.map{$0.build()}
        var isAllMultiCollapse = true
        for c in multiTags {
            isAllMultiCollapse = c.classValue?.has(.multiCollapse) ?? false
            if !isAllMultiCollapse { break }
        }
        XCTAssert(isAllMultiCollapse)
    }
    
    func testCollapseContent() throws {
        let id = "collapseExample"
        let tag = CollapseContent(id: id) {
            Div("Something to look at inside collapse.")
        }.build()
        XCTAssert(tag.classValue?.has(.collapse) ?? false)
        XCTAssert(tag.attributeValue("id") == id)
    }
}
