
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
    public func `class`(insert classes: Utility?..., if condition: Bool = true) -> Self {
        self.class(insert: classes.compactMap{$0}, condition)
    }
    
    @discardableResult
    public func `class`(insert classes: [Utility]?, _ condition: Bool = true) -> Self {
        self.class(insert: classes?.map{$0.rawValue}, condition)
    }
    
    @discardableResult
    public func `class`(insert values: String?..., if condition: Bool = true) -> Self {
        self.class(insert: values.compactMap{$0}, condition)
    }
    
    @discardableResult
    public func `class`(insert values: [String]?, _ condition: Bool = true) -> Self {
        guard condition, let values = values, !values.isEmpty else { return self }
        let value: String
        if let existing = self.value(.class) {
            value = existing.insert(values)
        } else {
            value = String.classValue(values)
        }
        return attribute(.class, value)
    }
    
    @discardableResult
    public func `class`(remove value: Utility?, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return self.class(remove: [value], condition)
    }
    
    @discardableResult
    public func `class`(remove classes: [Utility]?, _ condition: Bool = true) -> Self {
        guard condition,
                let classes = classes,
                !classes.isEmpty,
                let value = self.value(.class) else { return self }
        let reduced = value.remove(classes)
        if reduced.isEmpty {
            return deleteAttribute("class")
        }
        return attribute(.class, reduced)
    }
    
    @discardableResult
    public func style(set styles: CssKeyValue?..., if condition: Bool = true) -> Self {
        self.style(set: styles.compactMap{ $0 }, condition)
    }

    @discardableResult
    public func style(set styles: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        style(set: styles?.map{ ($0.key, $0.value) }, condition)
    }
    
    @discardableResult
    public func style(set styles: [(Key, Value)]?, _ condition: Bool = true) -> Self {
        guard condition, let styles = styles, !styles.isEmpty else { return self }
        let new: String
        if let value = value(.style) {
            new = value.add(styles)
        } else {
            new = String.styleValue(styles)
        }
        return attribute(.style, new)
    }
}

extension Tag {
    
    @discardableResult
    public func ariaAtomic(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.ariaAtomic, String(value), condition)
    }
    
    @discardableResult
    public func ariaControls(_ value: Utility?, _ condition: Bool = true) -> Self {
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
    
    @discardableResult
    public func ariaLive(_ value: Politeness?, _ condition: Bool = true) -> Self {
        attr(.ariaLlive, value?.rawValue, condition)
    }
    
    /// condition == true ... aria-pressed="true"
    /// condition == false ... no aria-pressed
    @discardableResult
    public func ariaPressed(_ value: Bool?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attr(.ariaPressed, String(value))
    }
    
    @discardableResult
    public func ariaSelected(_ value: Bool?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attr(.ariaSelected, String(value))
    }
    
    @discardableResult
    public func ariaValuenow(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.ariaValuenow, value, condition)
    }
    
    @discardableResult
    public func ariaValuemin(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.ariaValuemin, value, condition)
    }

    @discardableResult
    public func ariaValuemax(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.ariaValuemax, value, condition)
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
    public func dataBsAutohide(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.dataBsAutohide, String(value), condition)
    }

    @discardableResult
    public func dataBsBackdrop(_ value: Utility?, _ condition: Bool = true) -> Self {
        attr(.dataBsBackdrop, String(value), condition)
    }
    
    @discardableResult
    public func dataBsBackdrop(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.dataBsBackdrop, String(value), condition)
    }
    
    @discardableResult
    public func dataBsContent(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.dataBsContent, value, condition)
    }
    
    @discardableResult
    public func dataBsContainer(_ value: DataContainer?, _ condition: Bool = true) -> Self {
        attr(.dataBsContainer, value?.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsDelay(_ value: Int?, _ condition: Bool = true) -> Self {
        attr(.dataBsDelay, String(value), condition)
    }

    @discardableResult
    public func dataBsDismiss(_ value: Utility?, _ condition: Bool = true) -> Self {
        attr(.dataBsDismiss, String(value), condition)
    }
    
    @discardableResult
    public func dataBsDisplay(_ value: Utility?, _ condition: Bool = true) -> Self {
        attr(.dataBsDisplay, String(value), condition)
    }
    
    @discardableResult
    public func dataBsHtml(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.dataBsHtml, String(value), condition)
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
    public func dataBsOffset(_ value: Int?, _ condition: Bool = true) -> Self {
        attr(.dataBsOffset, String(value), condition)
    }
    
    @discardableResult
    public func dataBsOriginalTitle(_ value: String?, _ condition: Bool = true) -> Self {
        attr(.dataBsOriginalTitle, value, condition)
    }
    
    @discardableResult
    public func dataBsPlacement(_ value: PopDirection?, _ condition: Bool = true) -> Self {
        attr(.dataBsPlacement, value?.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsRide(_ value: Utility?, _ condition: Bool = true) -> Self {
        attr(.dataBsRide, String(value), condition)
    }
    
    @discardableResult
    public func dataBsScroll(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.dataBsScroll, String(value), condition)
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
    public func dataBsSpy(_ value: Utility?, _ condition: Bool = true) -> Self {
        attr(.dataBsSpy, String(value), condition)
    }
    
    @discardableResult
    public func dataBsTarget(_ value: Utility?, prefix: AttributeValuePrefix = .hash, _ condition: Bool = true) -> Self {
        dataBsTarget(String(value), prefix: prefix, condition)
    }
    
    @discardableResult
    public func dataBsTarget(_ value: String?, prefix: AttributeValuePrefix = .hash, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return attr(.dataBsTarget, prefix.rawValue + value, condition)
    }
    
    @discardableResult
    public func dataBsToggle(_ value: Utility?, _ condition: Bool = true) -> Self {
        attr(.dataBsToggle, String(value), condition)
    }
    
    @discardableResult
    public func dataBsTouch(_ value: Bool?, _ condition: Bool = true) -> Self {
        attr(.dataBsTouch, String(value), condition)
    }
    
    @discardableResult
    public func dataBsTrigger(_ values: Set<Component.PopTrigger>?, _ condition: Bool = true) -> Self {
        attr(.dataBsTrigger, values?.map{$0.rawValue}.joined(separator: " "), condition)
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
