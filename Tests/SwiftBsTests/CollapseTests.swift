import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CollapseTests: XCTestCase {
    
    func testCollapse() throws {
        //! IMPLEMENT TEST
//        XCTAssert(tag.classValue?.has(.collapse) ?? false)
        XCTFail()
    }
    
    func testCollapseButton() throws {
        let id = "collapseExample"
        let ids = ["collapseExample"]
        let content = Div("Some content")
        
        // <a> version
        let tagA = CollapseButton("Link with href", type: .link, contentIds: ids).build()
        XCTAssert(tagA.attributeValue(Attribute.role) == BsClass.button.rawValue)
        XCTAssert(tagA.attributeValue("href") == "#\(id)")
        
        // <button> version
        let tagB = CollapseButton("Button with data-bs-target", contentIds: ids).build()
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
        let tagC = CollapseButton("Multi-target", contentIds: multiContents.map{$0.id}).build()
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
        XCTAssert(tag.attributeValue("id") == id)
    }    
}
