//
//  Tag+AttributeValuable.swift
//  
//
//  Created by Brad Gourley on 3/16/22.
//

import SwiftHtml

extension Tag: AttributeValuable {
    
    @discardableResult
    public func attr(_ key: AttributeKey, _ value: String?, _ condition: Bool = true) -> Self {
        guard condition, let value = value else { return self }
        return attribute(key, value)
    }

    @discardableResult
    public func attrFlag(_ key: AttributeKey, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attribute(key, nil)
    }

    @discardableResult
    public func `class`(add classes: BsClass?..., if condition: Bool = true) -> Self {
        self.class(add: classes.compactMap{ $0 }, condition)
    }

    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard condition, let classes = classes, !classes.isEmpty else { return self }
        let value: String
        if let existing = self.value(.class) {
            value = existing.add(classes)
        } else {
            value = String.classValue(classes)
        }
        return attribute(.class, value)
    }

    @discardableResult
    public func style(add styles: CssKeyValue?..., if condition: Bool = true) -> Self {
        self.style(add: styles.compactMap{ $0 }, condition)
    }

    @discardableResult
    public func style(add styles: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        style(add: styles?.map{ ($0.key, $0.value) }, condition)
    }
    
    @discardableResult
    public func style(add styles: [(Key, Value)]?, _ condition: Bool = true) -> Self {
        guard condition, let styles = styles, !styles.isEmpty else { return self }
        let new: String
        if let value = value(.style) {
            new = value.add(styles)
        } else {
            new = String.styleValue(styles)
        }
        return attribute(.style, new)
    }
    
    @discardableResult
    public func ariaControls(_ value: BsClass?, _ condition: Bool = true) -> Self {
        attr(.ariaControls, String(value), condition)
    }
    
    @discardableResult
    public func ariaControls(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.ariaControls, value, condition)
    }
    
    /// condition == true ... aria-current="true" condition == false ... no aria-current
    @discardableResult
    public func ariaCurrent(_ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attr(.ariaCurrent, String(condition))
    }
    
    @discardableResult
    public func ariaDescribedBy(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.ariaDescribedby, value, condition)
    }
    
    /// condition == true ... aria-disabled="true"
    /// condition == false ... no aria-disabled
    @discardableResult
    public func ariaDisabled(_ condition: Bool) -> Self {
        guard condition else { return self }
        return attr(.ariaDisabled, String(condition))
    }
    
    @discardableResult
    public func ariaExpanded(_ value: Bool?, _ condition: Bool = true) -> Self {
        return attr(.ariaExpanded, String(value), condition)
    }
    
    /// condition == true ... aria-hidden="true"
    /// condition == false ... no aria-hidden
    @discardableResult
    public func ariaHidden(_ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attr(.ariaHidden, String(condition))
    }
    
    @discardableResult
    public func ariaLabel(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.ariaLabel, value, condition)
    }

    @discardableResult
    public func ariaLabelledBy(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.ariaLabelledBy, value, condition)
    }
    
    /// condition == true ... aria-pressed="true"
    /// condition == false ... no aria-pressed
    @discardableResult
    public func ariaPressed(_ value: Bool?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attr(.ariaPressed, String(value))
    }
    
    @discardableResult
    public func autoComplete(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.autoComplete, String(value), condition)
    }
    
    /// flag attribute ... condition == true ... checked
    @discardableResult
    public func checked(_ condition: Bool = true) -> Self {
        attrFlag(.checked, condition)
    }

    @discardableResult
    public func dataBsBackdrop(_ value: BsClass?, _ condition: Bool = true) -> Self {
        attr(.dataBsBackdrop, String(value), condition)
    }
    
    @discardableResult
    public func dataBsDismiss(_ value: BsClass?, _ condition: Bool = true) -> Self {
        attr(.dataBsDismiss, String(value), condition)
    }
    
    @discardableResult
    public func dataBsDisplay(_ value: BsClass?, _ condition: Bool = true) -> Self {
        attr(.dataBsDisplay, String(value), condition)
    }
    
    @discardableResult
    public func dataBsInterval(_ value: Int?, _ condition: Bool = true) -> Self {
        attr(.dataBsInterval, String(value), condition)
    }
    
    @discardableResult
    public func dataBsInterval(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.dataBsInterval, String(value), condition)
    }

    @discardableResult
    public func dataBsKeyboard(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.dataBsKeyboard, String(value), condition)
    }
    
    @discardableResult
    public func dataBsRide(_ value: BsClass?, _ condition: Bool = true) -> Self {
        attr(.dataBsRide, String(value), condition)
    }

    @discardableResult
    public func dataBsSlide(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.dataBsSlide, value, condition)
    }

    @discardableResult
    public func dataBsSlideTo(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.dataBsSlideTo, value, condition)
    }

    
    @discardableResult
    public func dataBsTarget(_ value: BsClass?, prefix: AttributeValuePrefix = .hash, _ condition: Bool = true) -> Self {
        dataBsTarget(String(value), prefix: prefix, condition)
    }
    
    @discardableResult
    public func dataBsTarget(_ value: String?, prefix: AttributeValuePrefix = .hash, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return attr(.dataBsTarget, prefix.rawValue + value, condition)
    }
    
    @discardableResult
    public func dataBsToggle(_ value: BsClass?, _ condition: Bool = true) -> Self {
        attr(.dataBsToggle, String(value), condition)
    }
    
    @discardableResult
    public func dataBsTouch(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.dataBsTouch, String(value), condition)
    }
    
    @discardableResult
    public func dataParent(_ value: String?, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return attr(.dataParent, "#" + value, condition)
    }
    
    @discardableResult
    public func list(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.list, value, condition)
    }
    
    @discardableResult
    public func minMaxStep(_ value: (min: Int, max: Int, step: Double)?, _ condition: Bool = true) -> Self {
        guard condition, let value = value else { return self }
        min(value.min)
        max(value.max)
        return step(value.step)
    }

    @discardableResult
    public func min(_ value: Int?, _ condition: Bool = true) -> Self {
        attr(.min, String(value), condition)
    }
    
    @discardableResult
    public func max(_ value: Int?, _ condition: Bool = true) -> Self {
        attr(.max, String(value), condition)
    }

    @discardableResult
    public func multiple(_ condition: Bool = true) -> Self {
        attrFlag(.multiple, condition)
    }

    @discardableResult
    public func readOnly(_ condition: Bool = true) -> Self {
        attrFlag(.readonly, condition)
    }
    
    @discardableResult
    public func role(_ value: Attribute.Role?, _ condition: Bool = true) -> Self {
        return attr(.role, String(value), condition)
    }
    
    @discardableResult
    public func selected(_ condition: Bool = true) -> Self {
        attrFlag(.selected, condition)
    }

    @discardableResult
    public func size(_ value: Int?, _ condition: Bool = true) -> Self {
        attr(.size, String(value), condition)
    }

    @discardableResult
    public func step(_ value: Double?, _ condition: Bool = true) -> Self {
        attr(.step, String(value), condition)
    }
    
    @discardableResult
    public func type(_ value: Attribute.`Type`?, _ condition: Bool = true) -> Self {
        attr(.type, String(value), condition)
    }
}
