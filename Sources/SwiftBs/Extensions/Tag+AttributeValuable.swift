
import SwiftHtml

extension Tag: AttributeValuable {
    
    @discardableResult
    public func attributeFlag(_ key: AttributeKey, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        return flagAttribute(key.rawValue)
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
        self.class(remove: value != nil ? [value!] : nil, condition)
    }
    
    @discardableResult
    public func `class`(remove classes: [Utility]?, _ condition: Bool = true) -> Self {
        self.class(remove: classes?.map{ $0.rawValue }, condition)
    }
    
    @discardableResult
    public func `class`(remove classes: Set<Utility>?, _ condition: Bool = true) -> Self {
        self.class(remove: classes != nil ? Array(classes!) : nil, condition)
    }
        
    @discardableResult
    public func `class`(remove classes: [String]?, _ condition: Bool = true) -> Self {
        self.class(remove: classes != nil ? Set(classes!) : nil, condition)
    }
    
    @discardableResult
    public func `class`(remove classes: Set<String>?, _ condition: Bool = true) -> Self {
        guard condition,
              let classes = classes,
              !classes.isEmpty,
              let existing = self.value(.class) else { return self }
        let reduced = existing.remove(classes)
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
        attribute(.ariaAtomic, String(value), condition)
    }
    
    @discardableResult
    public func ariaControls(_ value: Utility?, _ condition: Bool = true) -> Self {
        attribute(.ariaControls, String(value), condition)
    }
    
    @discardableResult
    public func ariaControls(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.ariaControls, value, condition)
    }
    
    /// condition == true ... aria-current="true" condition == false ... no aria-current
    @discardableResult
    public func ariaCurrent(_ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attribute(.ariaCurrent, String(condition))
    }
    
    @discardableResult
    public func ariaDescribedBy(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.ariaDescribedby, value, condition)
    }
    
    /// condition == true ... aria-disabled="true"
    /// condition == false ... no aria-disabled
    @discardableResult
    public func ariaDisabled(_ condition: Bool) -> Self {
        guard condition else { return self }
        return attribute(.ariaDisabled, String(condition))
    }
    
    @discardableResult
    public func ariaExpanded(_ value: Bool?, _ condition: Bool = true) -> Self {
        return attribute(.ariaExpanded, String(value), condition)
    }
    
    /// condition == true ... aria-hidden="true"
    /// condition == false ... no aria-hidden
    @discardableResult
    public func ariaHidden(_ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attribute(.ariaHidden, String(condition))
    }
    
    @discardableResult
    public func ariaLabel(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.ariaLabel, value, condition)
    }

    @discardableResult
    public func ariaLabelledBy(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.ariaLabelledBy, value, condition)
    }
    
    @discardableResult
    public func ariaLive(_ value: Politeness?, _ condition: Bool = true) -> Self {
        attribute(.ariaLlive, value?.rawValue, condition)
    }
    
    /// condition == true ... aria-pressed="true"
    /// condition == false ... no aria-pressed
    @discardableResult
    public func ariaPressed(_ value: Bool?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attribute(.ariaPressed, String(value))
    }
    
    @discardableResult
    public func ariaSelected(_ value: Bool?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attribute(.ariaSelected, String(value))
    }
    
    @discardableResult
    public func ariaValuenow(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.ariaValuenow, value, condition)
    }
    
    @discardableResult
    public func ariaValuemin(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.ariaValuemin, value, condition)
    }

    @discardableResult
    public func ariaValuemax(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.ariaValuemax, value, condition)
    }
    
    @discardableResult
    public func autoComplete(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.autoComplete, String(value), condition)
    }
        
    @discardableResult
    public func contentEditable(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.contentEditable, String(value), condition)
    }
    
    @discardableResult
    public func dataBsAutohide(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.dataBsAutohide, String(value), condition)
    }

    @discardableResult
    public func dataBsBackdrop(_ value: Utility?, _ condition: Bool = true) -> Self {
        attribute(.dataBsBackdrop, String(value), condition)
    }
    
    @discardableResult
    public func dataBsBackdrop(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.dataBsBackdrop, String(value), condition)
    }
    
    @discardableResult
    public func dataBsContent(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.dataBsContent, value, condition)
    }
    
    @discardableResult
    public func dataBsContainer(_ value: DataContainer?, _ condition: Bool = true) -> Self {
        attribute(.dataBsContainer, value?.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsDelay(_ value: Int?, _ condition: Bool = true) -> Self {
        attribute(.dataBsDelay, String(value), condition)
    }

    @discardableResult
    public func dataBsDismiss(_ value: Utility?, _ condition: Bool = true) -> Self {
        attribute(.dataBsDismiss, String(value), condition)
    }
    
    @discardableResult
    public func dataBsDisplay(_ value: Utility?, _ condition: Bool = true) -> Self {
        attribute(.dataBsDisplay, String(value), condition)
    }
    
    @discardableResult
    public func dataBsHtml(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.dataBsHtml, String(value), condition)
    }
    
    @discardableResult
    public func dataBsInterval(_ value: Int?, _ condition: Bool = true) -> Self {
        attribute(.dataBsInterval, String(value), condition)
    }
    
    @discardableResult
    public func dataBsInterval(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.dataBsInterval, String(value), condition)
    }

    @discardableResult
    public func dataBsKeyboard(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.dataBsKeyboard, String(value), condition)
    }
    
    @discardableResult
    public func dataBsOffset(_ value: Int?, _ condition: Bool = true) -> Self {
        attribute(.dataBsOffset, String(value), condition)
    }
    
    @discardableResult
    public func dataBsOriginalTitle(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.dataBsOriginalTitle, value, condition)
    }
    
    @discardableResult
    public func dataBsPlacement(_ value: PopDirection?, _ condition: Bool = true) -> Self {
        attribute(.dataBsPlacement, value?.rawValue, condition)
    }
    
    @discardableResult
    public func dataBsRide(_ value: Utility?, _ condition: Bool = true) -> Self {
        attribute(.dataBsRide, String(value), condition)
    }
    
    @discardableResult
    public func dataBsScroll(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.dataBsScroll, String(value), condition)
    }

    @discardableResult
    public func dataBsSlide(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.dataBsSlide, value, condition)
    }

    @discardableResult
    public func dataBsSlideTo(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.dataBsSlideTo, value, condition)
    }

    @discardableResult
    public func dataBsSpy(_ value: Utility?, _ condition: Bool = true) -> Self {
        attribute(.dataBsSpy, String(value), condition)
    }
    
    @discardableResult
    public func dataBsTarget(_ value: Utility?, prefix: AttributeValuePrefix = .hash, _ condition: Bool = true) -> Self {
        dataBsTarget(String(value), prefix: prefix, condition)
    }
    
    @discardableResult
    public func dataBsTarget(_ value: String?, prefix: AttributeValuePrefix = .hash, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return attribute(.dataBsTarget, prefix.rawValue + value, condition)
    }
    
    @discardableResult
    public func dataBsTitle(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.dataBsTitle, value, condition)
    }
    
    @discardableResult
    public func dataBsToggle(_ value: Utility?, _ condition: Bool = true) -> Self {
        attribute(.dataBsToggle, String(value), condition)
    }
    
    @discardableResult
    public func dataBsTouch(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.dataBsTouch, String(value), condition)
    }
    
    @discardableResult
    public func dataBsTrigger(_ values: Set<PopTrigger>?, _ condition: Bool = true) -> Self {
        attribute(.dataBsTrigger, values?.map{$0.rawValue}.joined(separator: " "), condition)
    }
    
    @discardableResult
    public func dataParent(_ value: String?, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        return attribute(.dataParent, "#" + value, condition)
    }
    
    @discardableResult
    public func draggable(_ value: Bool?, _ condition: Bool = true) -> Self {
        attribute(.draggable, String(value), condition)
    }
    
    @discardableResult
    public func list(_ value: String?, _ condition: Bool = true) -> Self {
        attribute(.list, value, condition)
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
        attribute(.min, String(value), condition)
    }
    
    @discardableResult
    public func max(_ value: Int?, _ condition: Bool = true) -> Self {
        attribute(.max, String(value), condition)
    }

    @discardableResult
    public func multiple(_ condition: Bool = true) -> Self {
        attributeFlag(.multiple, condition)
    }

    @discardableResult
    public func readOnly(_ condition: Bool = true) -> Self {
        attributeFlag(.readonly, condition)
    }
    
    @discardableResult
    public func role(_ value: Attribute.Role?, _ condition: Bool = true) -> Self {
        return attribute(.role, String(value), condition)
    }
    
    @discardableResult
    public func size(_ value: Int?, _ condition: Bool = true) -> Self {
        attribute(.size, String(value), condition)
    }

    @discardableResult
    public func step(_ value: Double?, _ condition: Bool = true) -> Self {
        attribute(.step, String(value), condition)
    }
    
    @discardableResult
    public func type(_ value: Attribute.`Type`?, _ condition: Bool = true) -> Self {
        attribute(.type, String(value), condition)
    }
    
    @discardableResult
    public func deleteAttribute(_ key: AttributeKey?, _ condition: Bool = true) -> Self {
        guard let key = key else { return self }
        return self.deleteAttribute(key.rawValue, condition)
    }
}

// MARK: - AttributeValuable

extension String {
    
    public init(_ `class`: Utility) {
        self.init(`class`.rawValue)
    }
    
    public init?(_ `class`: Utility?) {
        guard let `class` = `class` else { return nil }
        self.init(`class`.rawValue)
    }
    
    public init?(_ int: Int?) {
        guard let int = int else { return nil }
        self.init(int)
    }
    
    public init?(_ bool: Bool?) {
        guard let bool = bool else { return nil }
        self.init(bool)
    }
    
    public init?(_ role: Attribute.Role?) {
        guard let role = role else { return nil }
        self.init(role.rawValue)
    }
    
    public init?(_ double: Double?) {
        guard let double = double else { return nil }
        self.init(double)
    }
    
    public init?(_ type: Attribute.`Type`?) {
        guard let type = type else { return nil }
        self.init(type.rawValue)
    }
}
