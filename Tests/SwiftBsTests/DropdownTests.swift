import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class DropdownTests: XCTestCase {
    
    func testDropdown() throws {
        
        //! NEED MORE TESTS
        XCTFail()
        
        let id1 = "id1"
        let tag = Dropdown(id: id1, menuAs: .ul) {
            Button()
        } dropdownItems: {
            DropdownItem { Button("Test") }
        }.build()

        XCTAssert(tag.value(.class)?.has(.btnGroup) ?? false)
    }
}
