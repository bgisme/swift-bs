//
//  PopoverButton.swift
//  
//
//  Created by Brad Gourley on 3/29/22.
//

import SwiftHtml

public class PopoverButton: Component {
    
    ///@NOTE: Popovers must be initialized via javascript (see Bootstrap documentation)
    public convenience init(_ title: String? = nil,
                            content: String? = nil,
                            direction: PopDirection? = nil,
                            button: () -> Button) {
        self.init(title, content: content, direction: direction, button())
    }
    
    ///@NOTE: Popovers must be initialized via javascript (see Bootstrap documentation)
    public convenience init(_ title: String? = nil,
                            content: String? = nil,
                            direction: PopDirection? = nil,
                            a: () -> A) {
        self.init(title, content: content, direction: direction, a())
    }
    
    private init(_ title: String? = nil,
                 content: String? = nil,
                 direction: PopDirection? = nil,
                 _ tag: Tag) {
        if let title = title {
            _ = tag.title(title)
        }
        _ = tag
            .dataBsContent(content)
            .dataBsToggle(.popover)
            .dataBsContainer(.body)
            .dataBsPlacement(direction)
        super.init(tag)
    }
    
    ///@NOTE: For proper cross-browser and cross-platform behavior, you must use the <a> tag, not the <button> tag
    ///@NOTE: Javascript is required to make this work (see Bootstrap documentation)
    @discardableResult
    public func isClickDismissable(if condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .tabindex(0)
            .dataBsTrigger(.focus)
        return self
    }
}
