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
    
    public static func classValue(_ classes: [Utility]) -> String {
        Self.classValue(classes.map{ $0.rawValue })
    }
    
    public static func classValue(_ classes: [String]) -> String {
        classes.joined(separator: String.classSeparator)
    }
    
    public var styles: [(key: String, value: String)] {
        return self
            .split(separator: Character.styleSeparator)
            .map{ String($0)
                .split(separator: Character.styleKeyValueSeparator)
                .map{ String($0) }
            }
            .filter{ $0.count == 2 }
            .map({ (key: $0[0], value: $0[1]) })
    }
    
    public var classes: [String] {
        self.split(separator: " ").map({ String($0) })
    }
    
    public var bsClasses: [Utility] {
        classes.compactMap{ Utility.init(rawValue: $0) }
    }
    
    public func insert(_ values: [String]) -> String {
        // add values sequentially in case order of classes critical for css
        var classes = self.classes
        for value in values {
            if !classes.contains(value) { classes.append(value) }
        }
        return Self.classValue(classes)
    }
    
    public func add(_ styles: [(String, String)]) -> String {
        let existing = self.styles
        // new + unique existing (existing replaced by new with same key)
        let merged = styles + existing.filter{ existing in
            !styles.contains{ style in existing.key == style.0 }
        }
        return String.styleValue(merged)
    }
    
    public func remove(_ classes: [Utility]) -> String {
        let strClasses = classes.map{ $0.rawValue }
        return self.classes.filter{ !strClasses.contains($0) }.joined(separator: " ")
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
