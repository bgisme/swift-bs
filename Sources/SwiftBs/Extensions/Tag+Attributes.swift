//
//  Tag+Attributes.swift
//  
//
//  Created by BG on 2/19/22.
//

import SwiftHtml 

extension Tag {
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
    
    @discardableResult
    private func attributeOnly(_ attribute: BsAttribute, _ condition: Bool = true) -> Self {
        self.flagAttribute(attribute.rawValue, nil, condition)
    }
    
    // MARK: - Attribute Shortcuts
    
    @discardableResult
    public func ariaControls(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.ariaControls(value.rawValue, condition)
    }
    
    @discardableResult
    public func ariaControls(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaControls, value, condition)
    }
    
    /// Note: Only need ariaCurrent attribute when the value = "true"... so no need for serparate value parameter
    @discardableResult
    public func ariaCurrent(_ condition: Bool = true) -> Self {
        self.attribute(.ariaCurrent, String(condition), condition)
    }
    
    @discardableResult
    public func ariaExpanded(_ value: String? = nil, _ condition: Bool = true) -> Self {
        self.attribute(.ariaExpanded, value ?? String(condition), condition)
    }
    
    @discardableResult
    public func ariaLabelledBy(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaLabelledBy, value, condition)
    }
    
    @discardableResult
    public func ariaDescribedBy(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaDescribedby, value, condition)
    }
    
    @discardableResult
    public func ariaDisabled(_ value: Bool, _ condition: Bool = true) -> Self {
        return self.attribute(.ariaDisabled, String(value), condition)
    }
    
    @discardableResult
    public func ariaPressed(_ value: Bool, _ condition: Bool = true) -> Self {
        return self.attribute(.ariaPressed, String(value), condition)
    }
    
    @discardableResult
    public func autoComplete(_ value: Bool, _ condition: Bool = true) -> Self {
        return self.attribute(.autoComplete, String(value), condition)
    }
    
    @discardableResult
    public func checked(_ condition: Bool = true) -> Self {
        self.attributeOnly(.checked, condition)
    }
    
    @discardableResult
    public func dataParent(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.dataParent, "#" + value, condition)
    }
    
    @discardableResult
    public func dataTarget(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.dataTarget(value.rawValue, condition)
    }
    
    @discardableResult
    public func dataTarget(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.dataTarget, "#" + value, condition)
    }
    
    @discardableResult
    public func dataToggle(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(.dataToggle, value.rawValue, condition)
    }
    
    @discardableResult
    public func disabled(_ condition: Bool = true) -> Self {
        _ = self.attributeOnly(.disabled, condition)
        if condition {
            _ = self.ariaDisabled(condition)
        }
        return self
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
        self.attributeOnly(.multiple, condition)
    }
    
    @discardableResult
    public func readOnly(_ condition: Bool = true) -> Self {
        self.attributeOnly(.readonly, condition)
    }
    
    @discardableResult
    public func role(_ role: Attribute.Role, _ condition: Bool = true) -> Self {
        self.attribute(Attribute.role, role.rawValue, condition)
    }
    
    @discardableResult
    public func selected(_ condition: Bool = true) -> Self {
        self.attributeOnly(.selected, condition)
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
}
