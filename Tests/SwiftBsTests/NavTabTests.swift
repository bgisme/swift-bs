import XCTest
@testable import SwiftHtml
@testable import SwiftBs

final class NavTabTests: XCTestCase {
    
    func testNav() throws {
        //! IMPLEMENT
        XCTFail()
        
        let tag = NavTab(type: .ol) {}.build()
        XCTAssert(tag.value(.class) == BsClass.nav.rawValue)
    }
}
