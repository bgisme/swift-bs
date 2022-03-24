//
//  Scrollspy.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

import SwiftHtml

public class Scrollspy: Component {
    
    private static func hrefed(_ a: () -> A, _ id: String) -> A {
        let a = a()
        _ = a.href("#\(id)")
        return a
    }
    
    public static func navLink(scrollspyItemId id: String,
                               isActive: Bool = false,
                               isDisabled: Bool = false,
                               isDropdown: Bool = false,
                               aligns: [(Location, Breakpoint)]? = nil,
                               fills: Set<Breakpoint>? = nil,
                               _ a: () -> A) -> NavLink {
        return NavLink(isActive: isActive,
                       isDisabled: isDisabled,
                       isDropdown: isDropdown,
                       aligns: aligns,
                       fills: fills) { hrefed(a, id) }
    }
    
    public static func listGroupItem(scrollspyItemId id: String,
                                     isActive: Bool = false,
                                     isDisabled: Bool = false,
                                     _ a: () -> A) -> ListGroupItem {
        return ListGroupItem(isActive: isActive, isDisabled: isDisabled) { hrefed(a, id) }
    }
    
    public static func dropdownItem(scrollspyItemId id: String,
                                    isActive: Bool = false,
                                    isDisabled: Bool = false,
                                    _ a: () -> A) -> DropdownItem {
        DropdownItem(isActive: isActive, isDisabled: isDisabled) { hrefed(a, id)}
    }
    
    public init(navId: String, offset: Int = 0, _ div: Div) {
        _ = div
            .dataBsSpy(.scroll)
            .dataBsTarget(navId)
            .dataBsOffset(offset)
            .tabindex(0)
        
        super.init(div)
    }
}
