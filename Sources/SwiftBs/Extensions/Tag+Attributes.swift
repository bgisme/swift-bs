//
//  Tag+Attributes.swift
//  
//
//  Created by BG on 2/19/22.
//

import SwiftHtml

extension Tag {
    
    func attributeValue(_ attribute: BsAttribute) -> String? {
        attributeValue(attribute.rawValue)
    }
    
    func attributeValue(_ name: String) -> String? {
        node.attributes.first(where: { $0.key == name })?.value
    }

    /// Quickly set lots of attributes at once.
    /// It takes a nil parameter because most of the Component functions take nil parameters.
    /// So it's easier to just filter them out here.
    @discardableResult
    public func setAttributes(_ attributes: [Attribute]?, _ condition: Bool = true) -> Self {
        if let attributes = attributes {
            return setAttributes(attributes, condition)
        }
        return self
    }
    
    /// Add Bootstrap specific attributes
    @discardableResult
    public func attributes(add attribute: BsAttribute, _ value: BsClass? = nil, _ condition: Bool = true) -> Self {
        self.attribute(attribute.rawValue, value?.rawValue, condition)
    }
    
    @discardableResult
    private func attribute(_ attribute: BsAttribute, _ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(attribute, value.rawValue, condition)
    }
    
    @discardableResult
    private func attribute(_ attribute: BsAttribute, _ value: String, _ condition: Bool = true) -> Self {
        self.attribute(attribute.rawValue, value, condition)
    }
    
    // MARK: - class and style
    
    /// Add Component classes and styles to class and style
    public func addClassesStyles(_ component: Component) -> Self {
        self.class(add: component.classes)
        if let styles = component.styles, !styles.isEmpty {
            let keyValueStr = styles.map {"\($0.0):\($0.1)"}.joined(separator: ";") + ";"
            return self.style(add: keyValueStr)
        }
        return self
    }
    
    // MARK: - class
    
    public var classValue: String? { attributeValue(.class) }

    /// Replace value of class with variadic BsClass
    public func `class`(_ classes: BsClass?..., if condition: Bool = true) -> Self {
        let classes = classes.compactMap { $0 }
        guard !classes.isEmpty else { return self }
        return self.class(classes)
    }

    /// Replace value of class with array of BsClass
    public func `class`(_ classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard let classes = classes, !classes.isEmpty else { return self }
        return self.class(classes.map {$0.rawValue})
    }
    
    /// Add variadics of BsClass to class
    @discardableResult
    public func `class`(add classes: BsClass?..., if condition: Bool = true) -> Self {
        let classes = classes.compactMap { $0 }
        guard !classes.isEmpty else { return self }
        return self.class(add: classes, condition)
    }
    
    /// Add array of BsClass to class value
    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard let classes = classes, !classes.isEmpty else { return self }
        return self.class(add: classes.map{$0.rawValue}, condition)
    }
    
    // MARK: - style
    
    public var styleValue: String? { attributeValue(.style) }
    
    /// Set value of style attribute with variadic (cleaner code)
    @discardableResult
    public func style(_ keyValues: CssKeyValue?..., if condition: Bool = true) -> Self {
        return style(keyValues.compactMap{$0}, condition)
    }
    
    /// Set vale of style attribute with Array
    @discardableResult
    public func style(_ keyValues: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        guard condition, let keyValues = keyValues, !keyValues.isEmpty else { return self }
        let kvStr = keyValues.map{ String($0) }.joined(separator: ";") + ";"
        return style(kvStr)
    }
    
    /// Add CssKeyValue variadic to style attribute
    @discardableResult
    public func style(add keyValues: CssKeyValue?..., if condition: Bool = true) -> Self {
        let keyValues = keyValues.compactMap { $0 }
        guard !keyValues.isEmpty else { return self }
        return style(add: keyValues, condition)
    }
    
    /// Add array of  CssKeyValue to style attribute
    @discardableResult
    public func style(add keyValues: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        guard let keyValues = keyValues, !keyValues.isEmpty else { return self }
        let kvStr = keyValues.map{ String($0) }.joined(separator: ";") + ";"
        return self.style(add: kvStr, condition)
    }
    
    /// Append string to value of style attribute
    @discardableResult
    public func style(add str: String?, _ condition: Bool = true) -> Self {
        guard condition, let str = str, !str.isEmpty else { return self }
        let updated = self.styleValue != nil ? self.styleValue! + str : str
        return self.style(updated)
    }
    
    /// Remove key:value pair from value of style attribute using CssProperty
    @discardableResult
    public func style(remove key: CssProperty, _ condition: Bool = true) -> Self {
        style(remove: key.rawValue, condition)
    }
    
    /// Remove key:value pair from value of style attribute using String
    @discardableResult
    public func style(remove key: String, _ condition: Bool = true) -> Self {
        guard condition, !key.isEmpty else { return self }
        if let styleValue = styleValue {
            let keyValues = styleValue.split(separator: ";")
            let newKeyValues = keyValues.filter {
                // component key is everything up to first colon
                // do not return if it's less than whole string and matches supplied key
                if let colonIndex = $0.firstIndex(of: ":"),
                   colonIndex != $0.endIndex {
                     return $0[..<colonIndex] != key
                }
                return true
            }.joined(separator: ";") + ";"
            if !newKeyValues.isEmpty {
                _ = style(newKeyValues)
            } else {
                deleteAttribute("style")
            }
        }
        return self
    }
    
    // MARK: - SET Other Attributes
    
    @discardableResult
    public func ariaControls(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.ariaControls(value.rawValue, condition)
    }
    
    @discardableResult
    public func ariaControls(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaControls, value, condition)
    }
    
    /// condition == true ... aria-current="true" condition == false ... no aria-current
    @discardableResult
    public func ariaCurrent(_ condition: Bool = true) -> Self {
        self.attribute(.ariaCurrent, String(condition), condition)
    }
    
    @discardableResult
    public func ariaDescribedBy(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaDescribedby, value, condition)
    }
    
    /// condition == true ... aria-disabled="true"
    /// condition == false ... no aria-disabled
    @discardableResult
    public func ariaDisabled(_ condition: Bool) -> Self {
        return self.attribute(.ariaDisabled, String(condition), condition)
    }
    
    @discardableResult
    public func ariaExpanded(_ value: Bool, _ condition: Bool = true) -> Self {
        self.attribute(.ariaExpanded, String(value), condition)
    }
    
    @discardableResult
    public func ariaLabel(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaLabel, value, condition)
    }
    
    @discardableResult
    public func ariaLabelledBy(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaLabelledBy, value, condition)
    }
    
    @discardableResult
    public func ariaPressed(_ value: Bool, _ condition: Bool = true) -> Self {
        return self.attribute(.ariaPressed, String(value), condition)
    }
    
    @discardableResult
    public func ariaHaspopup(_ value: Bool, _ condition: Bool = true) -> Self {
        return self.attribute(.ariaHaspopup, String(value), condition)
    }
    
    @discardableResult
    public func ariaHidden(_ value: Bool, _ condition: Bool = true) -> Self {
        return self.attribute(.ariaHidden, String(value), condition)
    }
    
    @discardableResult
    public func autoComplete(_ value: Bool, _ condition: Bool = true) -> Self {
        return self.attribute(.autoComplete, String(value), condition)
    }
    
    @discardableResult
    public func checked(_ condition: Bool = true) -> Self {
        flagAttribute(BsAttribute.checked.rawValue, nil, condition)
    }
    
    @discardableResult
    public func dataBsBackdrop(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsBackdrop, value.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsDismiss(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsDismiss, value.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsDisplay(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsDisplay, value.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsInterval(_ value: Int?, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return self.attribute(.dataBsInterval, String(value), condition)
    }
    
    @discardableResult
    public func dataBsInterval(_ value: Bool?, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return self.attribute(.dataBsInterval, String(value), condition)
    }
    
    @discardableResult
    public func dataBsKeyboard(_ value: Bool, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsKeyboard, String(value), condition)
    }
    
    @discardableResult
    public func dataBsRide(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsRide, value.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsSlide(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsSlide, value, condition)
    }
    
    @discardableResult
    public func dataBsSlideTo(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsSlideTo, value, condition)
    }
    
    public enum Prefix: String {
        case hash = "#"
        case dot = "."
    }
    
    @discardableResult
    public func dataBsTarget(_ value: BsClass, prefix: Prefix = .hash, _ condition: Bool = true) -> Self {
        self.dataBsTarget(value.rawValue, prefix: prefix, condition)
    }

    @discardableResult
    public func dataBsTarget(_ value: String, prefix: Prefix = .hash, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsTarget, prefix.rawValue + value, condition)
    }
    
    @discardableResult
    public func dataBsToggle(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsToggle, value.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsTouch(_ value: Bool?, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return self.attribute(.dataBsTouch, String(value), condition)
    }
    
    @discardableResult
    public func dataParent(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.dataParent, "#" + value, condition)
    }
    
    @discardableResult
    public func list(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.list, value, condition)
    }
    
    @discardableResult
    public func minMaxStep(_ min: Int, _ max: Int, _ step: Double, _ condition: Bool = true) -> Self {
        if condition {
            _ = self.min(min)
            _ = self.max(max)
            return self.step(step)
        }
        return self
    }
    
    @discardableResult
    public func min(_ value: Int, _ condition: Bool = true) -> Self {
        self.attribute(.min, String(value), condition)
    }
    
    @discardableResult
    public func max(_ value: Int, _ condition: Bool = true) -> Self {
        self.attribute(.max, String(value), condition)
    }
    
    @discardableResult
    public func multiple(_ condition: Bool = true) -> Self {
        flagAttribute(BsAttribute.multiple.rawValue, nil, condition)
    }
    
    @discardableResult
    public func readOnly(_ condition: Bool = true) -> Self {
        flagAttribute(BsAttribute.readonly.rawValue, nil, condition)
    }
    
    @discardableResult
    public func role(_ role: Attribute.Role, _ condition: Bool = true) -> Self {
        self.attribute(Attribute.role, role.rawValue, condition)
    }
    
    @discardableResult
    public func selected(_ condition: Bool = true) -> Self {
        flagAttribute(BsAttribute.selected.rawValue, nil, condition)
    }
    
    @discardableResult
    public func size(_ value: Int, _ condition: Bool = true) -> Self {
        self.attribute(.size, String(value), condition)
    }
    
    @discardableResult
    public func step(_ value: Double, _ condition: Bool = true) -> Self {
        self.attribute(.step, String(value), condition)
    }
    
    @discardableResult
    public func type(_ type: Attribute.`Type`, _ condition: Bool = true) -> Self {
        self.attribute(Attribute.type, type.rawValue, condition)
    }
    
    @discardableResult
    public func hrefOptional(_ value: String?) -> Self {
        if let value = value {
            return attribute("href", value)
        }
        return self
    }
    
    // MARK: - GET Other Attributes
    
    public var id: String? { node.attributes.first(where: { $0.key == "id" })?.value }
    
}
