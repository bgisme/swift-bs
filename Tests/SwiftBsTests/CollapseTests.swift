import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class CollapseTests: XCTestCase {
    
    func testCollapseButton() throws {
        let id = "collapseExample"
        let content = Div("Some content")
        
        // <a> version
        let tagA = CollapseButton(contentIds: [id]) {
            A("Link with href").href("#")
        }.build()
        XCTAssert(tagA.value(.role) == BsClass.button.rawValue)
        XCTAssert(tagA.value("href") == "#\(id)")
        
        // <button> version
        let tagB = CollapseButton(contentIds: [id]) {
            A("Button with data-bs-target").href("#")
        }.build()
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
            CollapseContent(id: id, isMultiple: true) { content },
            CollapseContent(id: "collapseExample2", isMultiple: true) { content }
        ]
        let tagC = CollapseButton(contentIds: multiContents.compactMap{$0.tag.value(.id)}) {
            Button("Multi-target")
        }.build()
        XCTAssert(tagC.value(.dataBsTarget) == "." + BsClass.multiCollapse.rawValue)
        XCTAssert(tagC.value(.ariaControls) == multiContents.compactMap{$0.tag.value(.id)}.joined(separator: " "))
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
        let tag = CollapseContent(id: id) {
            Div("Something to look at inside collapse.")
        }.build()
        XCTAssert(tag.value("id") == id)
    }    
}
