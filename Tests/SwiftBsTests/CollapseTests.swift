import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CollapseTests: XCTestCase {
    
    func testCollapseButton() throws {
        let id = "collapseExample"
        let ids = ["collapseExample"]
        let content = Div("Some content")
        
        // <a> version
        let a = A("Link with href").href("#\(id)")
        let tagA = CollapseButton(a, contentIds: ids).build()
        XCTAssert(tagA.attributeValue(Attribute.role) == BsClass.button.rawValue)
        XCTAssert(tagA.attributeValue("href") == "#\(id)")
        
        // <button> version
        let button = Button("Button with data-bs-target")
        let tagB = CollapseButton(button, contentIds: ids).build()
        XCTAssert(tagB.attributeValue(.dataBsTarget) == "#\(id)")
        
        // All buttons and convenience inits
        XCTAssert(tagB.attributeValue(.dataBsToggle) == BsClass.collapse.rawValue)
        XCTAssert(tagB.attributeValue(.ariaExpanded) == String(false))
        XCTAssert(tagB.attributeValue(.ariaControls) == id)
        
        // Multiple targets
        let multiContents = [
            CollapseContent(id: id, isSibling: true, content),
            CollapseContent(id: "collapseExample2", isSibling: true, content)
        ]
        let multiButton = Button("Multi-target")
        let tagC = CollapseButton(multiButton, contentIds: multiContents.map{$0.id}).build()
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
        let div = Div("Something to look at inside collapse.")
        let tag = CollapseContent(id: id, div).build()
        XCTAssert(tag.classValue?.has(.collapse) ?? false)
        XCTAssert(tag.attributeValue("id") == id)
    }
}
