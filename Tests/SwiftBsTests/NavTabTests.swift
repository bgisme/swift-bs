import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class NavTabTests: XCTestCase {
    
    func testNav() throws {
        //! IMPLEMENT
        XCTFail()
        
        let tag = NavTab(Ol{}).build()
        XCTAssert(tag.value(.class) == BsClass.nav.rawValue)
    }
}
