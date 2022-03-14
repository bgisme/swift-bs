import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CollapseTests: XCTestCase {
    
    func testCollapseButton() throws {
        let id = "collapseExample"
        let content = Div("Some content")
        
        // <a> version
        let tagA = CollapseButton("Link with href", type: .link, contentIds: id).build()
        XCTAssert(tagA.attributeValue(Attribute.role) == BsClass.button.rawValue)
        XCTAssert(tagA.attributeValue("href") == "#\(id)")
        
        // <button> version
        let tagB = CollapseButton("Button with data-bs-target", contentIds: id).build()
        XCTAssert(tagB.attributeValue(.dataBsTarget) == "#\(id)")
        
        // All buttons and convenience inits
        XCTAssert(tagB.attributeValue(.dataBsToggle) == BsClass.collapse.rawValue)
        XCTAssert(tagB.attributeValue(.ariaExpanded) == String(false))

        // Multiple targets
        let multiContents = [
            CollapseContent(id: id, isMultiple: true, content),
            CollapseContent(id: "collapseExample2", isMultiple: true, content)
        ]
        let tagC = CollapseButton("Multi-target", contentIds: multiContents.map{$0.id}).build()
        XCTAssert(tagC.attributeValue(.dataBsTarget) == "." + BsClass.multiCollapse.rawValue)
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
