import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CollapseTests: XCTestCase {
    
    func testCollapseButton() throws {
        let id = "collapseExample"
        let content = Div("Some content")
        
        // <a> version
        let tagA = CollapseButton("Link with href", type: .link, contentIds: id).build()
        XCTAssert(tagA.value(.role) == BsClass.button.rawValue)
        XCTAssert(tagA.value("href") == "#\(id)")
        
        // <button> version
        let tagB = CollapseButton("Button with data-bs-target", contentIds: id).build()
        XCTAssert(tagB.value(.dataBsTarget) == "#\(id)")
        
        // All buttons and convenience inits
        XCTAssert(tagB.value(.dataBsToggle) == BsClass.collapse.rawValue)
        if let ariaExpandedValue = tagB.value(.ariaExpanded) {
            XCTAssert(Bool(ariaExpandedValue) == false)
        } else {
            XCTFail()
        }

        // Multiple targets
        let multiContents = [
            CollapseContent(id: id, isMultiple: true, content),
            CollapseContent(id: "collapseExample2", isMultiple: true, content)
        ]
        let tagC = CollapseButton("Multi-target", contentIds: multiContents.map{$0.id}).build()
        XCTAssert(tagC.value(.dataBsTarget) == "." + BsClass.multiCollapse.rawValue)
        XCTAssert(tagC.value(.ariaControls) == multiContents.map{$0.id}.joined(separator: " "))
        let multiTags = multiContents.map{$0.build()}
        var isAllMultiCollapse = true
        for c in multiTags {
            isAllMultiCollapse = c.value(.class)?.has(.multiCollapse) ?? false
            if !isAllMultiCollapse { break }
        }
        XCTAssert(isAllMultiCollapse)
    }
    
    func testCollapseContent() throws {
        let id = "collapseExample"
        let div = Div("Something to look at inside collapse.")
        let tag = CollapseContent(id: id, div).build()
        XCTAssert(tag.value("id") == id)
    }    
}
