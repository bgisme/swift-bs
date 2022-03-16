import SwiftHtml

// MARK: - CLASS and STYLE attribute values

extension Character {
    
    public static let styleSeparator: Character = ";"
    public static let styleKeyValueSeparator: Character = ":"
    public static let classSeparator: Character = " "
}

extension String {
    
    public static let styleSeparator = String(Character.styleSeparator)
    public static let styleKeyValueSeparator = String(Character.styleKeyValueSeparator)
    public static let classSeparator = String(Character.classSeparator)
    
    public static func styleValue(_ styles: [CssKeyValue]) -> String {
        styleValue(styles.map{ (key: $0.key, value: $0.value) })
    }
    
    public static func styleValue(_ styles: [(key: String, value: String)]) -> String {
        let value = styles
            .map{ "\($0.key)\(String.styleKeyValueSeparator)\($0.value)" }
            .joined(separator: String.styleSeparator)
        return value + String.styleSeparator
    }
    
    public static func classValue(_ classes: [BsClass]) -> String {
        Self.classValue(classes.map{ $0.rawValue })
    }
    
    public static func classValue(_ classes: [String]) -> String {
        classes.joined(separator: String.classSeparator)
    }
    
    public var styles: [(key: String, value: String)] {
        self
            .split(separator: Character.styleSeparator)
            .map{ String($0) }
            .split(separator: String.styleKeyValueSeparator)
            .filter{ $0.count == 2 }
            .map({ (key: $0[0], value: $0[1]) })
    }
    
    public var classes: [String] {
        self.split(separator: " ").map({ String($0) })
    }
    
    public var bsClasses: [BsClass] {
        classes.compactMap{ BsClass.init(rawValue: $0) }
    }
    
    public func add(_ classes: [BsClass]) -> String {
        let existing = self.classes
        let merged = existing + classes.map{$0.rawValue}.filter{ !existing.contains($0) }
        return Self.classValue(merged)
    }
    
    public func add(_ styles: [(String, String)]) -> String {
        let existing = self.styles
        // new + unique existing (existing replaced by new with same key)
        let merged = styles + existing.filter{ existing in
            !styles.contains{ style in existing.key == style.0 }
        }
        return String.styleValue(merged)
    }
    
}
 
// MARK: - AttributeValuable

extension String {
    
    public init?(_ `class`: BsClass?) {
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
