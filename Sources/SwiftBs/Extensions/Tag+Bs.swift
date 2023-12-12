//
//  Tag+Bs.swift
//
//
//  Created by BG on 2/15/22.
//

/*
 
 Component is the base class for all other components.
 
 It is essentially a wrapper for Tag classes.
 
 It contains a Tag.
 
 It facilitates editing the class and style attributes.
 
 And it renders with TagBuilder.
 
 In simple components it just wraps a Tag, applying Bootstrap slugs to the class attribute.
 
 For example:
 
 BsButton { A("Title").href("#") }
 
 ...adds "btn" to the class and sets a few other attributes.
 
 In more complex components, where the component is always a Div or a Nav, for instance, the Tag is declared internally to save extra lines and indentations. And to avoid function name ambiguity.

 */

import SwiftHtml

extension Tag {
    
    @discardableResult
    public func alignItems(_ value: AlignItems, _ condition: Bool = true) -> Self {
        self.class(insert: value.class, if: condition)
    }

    @discardableResult
    public func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        if let value = value {
            return self.class(insert: value.backgroundClass, if: condition)
        } else {
            return self.class(remove: ColorTheme.allCases.map{$0.backgroundClass}, condition)
        }
    }
    
    @discardableResult
    public func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        if let value = value {
            return self.class(insert: value.borderClass, if: condition)
        } else {
            return self.class(remove: ColorTheme.allCases.map{$0.borderClass})
        }
    }
    
    /* This extension on Tag is intended solely for the purposes of allowing a <span>
     around a disabled button or other basic elements to handle popovers. There's a forwarding
     func on Component, from where the call will most likely originate. */
    ///@NOTE: Do not set isHTML = true if worried about XSS attacks.
    public enum PopTrigger: String {
        case focus  /// popover opens after click on button, closes after click outside button
        case hover  /// popover opens while hovering, close while not
        case click  /// popover toggles open and closed with clicks on button
    }
    
    @discardableResult
    public func popover(_ title: String? = nil,
                        content: String? = nil,
                        isHTML: Bool = false,
                        direction: PopDirection? = nil,
                        triggers: Set<PopTrigger>? = nil,
                        condition: Bool = true) -> Self {
        guard condition else { return self }
        if let title = title {
            self.title(title)
        }
        self
            .dataBsContent(content)
            .dataBsToggle(.popover)
            .dataBsContainer(.body)
            .dataBsPlacement(direction)
            .dataBsHtml(isHTML)
        if let triggers = triggers {
            self
                .tabindex(0)
                .dataBsTrigger(triggers)
        }
        return self
    }
    
    @discardableResult
    public func tooltip(_ title: String,
                        isHTML: Bool = false,
                        direction: PopDirection? = nil,
                        _ condition: Bool = true) -> Self {
        self
            .title("")
            .dataBsOriginalTitle(title)
            .dataBsToggle(.tooltip)
            .dataBsHtml(isHTML, isHTML) // second isHTML... do not add tag unless true
        if let direction = direction {
             self
                .dataBsPlacement(direction, condition)
        }
        return self
    }
}
