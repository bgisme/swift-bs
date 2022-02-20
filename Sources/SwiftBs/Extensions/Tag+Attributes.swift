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
    
    // MARK: - Attribute Shortcuts
    
    private func attribute(_ attribute: BsAttribute, _ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(attribute, value.rawValue, condition)
    }
    
    private func attribute(_ attribute: BsAttribute, _ value: String, _ condition: Bool = true) -> Self {
        self.attribute(attribute.rawValue, value, condition)
    }
    
    private func attributeOnly(_ attribute: BsAttribute, _ condition: Bool = true) -> Self {
        self.flagAttribute(attribute.rawValue, nil, condition)
    }
    
    public func ariaControls(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.ariaControls(value.rawValue, condition)
    }
    
    public func ariaControls(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaControls, value, condition)
    }
    
    /// Note: Only need ariaCurrent attribute when the value = "true"... so no need for serparate value parameter
    public func ariaCurrent(_ condition: Bool = true) -> Self {
        self.attribute(.ariaCurrent, String(condition), condition)
    }
    
    public func ariaExpanded(_ value: String? = nil, _ condition: Bool = true) -> Self {
        self.attribute(.ariaExpanded, value ?? String(condition), condition)
    }
    
    public func ariaLabelledBy(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaLabelledBy, value, condition)
    }
    
    public func ariaDescribedBy(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.ariaDescribedby, value, condition)
    }
    
    public func ariaDisabled(_ condition: Bool = true) -> Self {
        self.attribute(.ariaDisabled, BsClass.disabled.rawValue, condition)
    }
    
    public func checked(_ condition: Bool = true) -> Self {
        self.attributeOnly(.checked, condition)
    }
    
    public func dataBsParent(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsParent, "#" + value, condition)
    }
    
    public func dataBsTarget(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.dataBsTarget(value.rawValue, condition)
    }
    
    public func dataBsTarget(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsTarget, "#" + value, condition)
    }
    
    public func dataBsToggle(_ value: BsClass, _ condition: Bool = true) -> Self {
        self.attribute(.dataBsToggle, value.rawValue, condition)
    }
    
    public func disabled(_ condition: Bool = true) -> Self {
        self.attributeOnly(.disabled, condition)
    }
    
    public func list(_ value: String, _ condition: Bool = true) -> Self {
        self.attribute(.list, value, condition)
    }
    
    public func minMaxStep(_ min: Int, _ max: Int, _ step: Double, _ condition: Bool = true) -> Self {
        if condition {
            _ = self.min(min)
            _ = self.max(max)
            return self.step(step)
        }
        return self
    }
    
    public func min(_ value: Int, _ condition: Bool = true) -> Self {
        self.attribute(.min, String(value), condition)
    }
    
    public func max(_ value: Int, _ condition: Bool = true) -> Self {
        self.attribute(.max, String(value), condition)
    }
    
    public func multiple(_ condition: Bool = true) -> Self {
        self.attributeOnly(.multiple, condition)
    }
    
    public func readOnly(_ condition: Bool = true) -> Self {
        self.attributeOnly(.readonly, condition)
    }
    
    public func role(_ role: Attribute.Role, _ condition: Bool = true) -> Self {
        self.attribute(Attribute.role, role.rawValue, condition)
    }
    
    public func selected(_ condition: Bool = true) -> Self {
        self.attributeOnly(.selected, condition)
    }
    
    public func size(_ value: Int, _ condition: Bool = true) -> Self {
        self.attribute(.size, String(value), condition)
    }
    
    public func step(_ value: Double, _ condition: Bool = true) -> Self {
        self.attribute(.step, String(value), condition)
    }
    
    public func type(_ type: Attribute.`Type`, _ condition: Bool = true) -> Self {
        self.attribute(Attribute.type, type.rawValue, condition)
    }
    
    public func hrefOptional(_ value: String?) -> Self {
        if let value = value {
            return attribute("href", value)
        }
        return self
    }
}
