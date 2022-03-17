import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class DropdownTests: XCTestCase {
    
    func testDropdown() throws {
        
        //! NEED MORE TESTS
        XCTFail()
        
        let id1 = "id1"
        let tag = Dropdown(id: id1) { id, isSplit, direction, menuAlign in
            DropdownButton(Button(),
                           id: id,
                           direction: direction,
                           isSplit: isSplit,
                           menuAlign: menuAlign)
        } menu: { id, isDark, align in
            DropdownMenu(toggler: id, isDark: isDark, align: align) {
                DropdownItem("Test")
            }
        }.build()
        XCTAssert(tag.value(.class)?.has(.btnGroup) ?? false)
    }
}
