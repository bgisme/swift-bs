import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class SwiftBsTests: XCTestCase {
    
    func testAddProperty() throws {
        let margin = "10px 5px 15px 20px"
        let bkgndColor = "chartreuse"
        let doc = Document {
            Span("a")
                .style(add: .margin(margin), .backgroundColor(bkgndColor))
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="\#(CssProperty.margin.rawValue):\#(margin);\#(CssProperty.backgroundColor.rawValue):\#(bkgndColor);">a</span>"#, html)
    }
    
    func testRemoveProperty() throws {
        let margin = "10px 5px 15px 20px"
        let bkgndColor = "chartreuse"
        let doc = Document {
            Span("a")
                .style(add: .margin(margin))
                .style(add: .backgroundColor(bkgndColor))
                .style(remove: .margin)
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="\#(CssProperty.backgroundColor.rawValue):\#(bkgndColor)">a</span>"#, html)
    }
}
