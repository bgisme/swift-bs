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
        self.remove(classes.map{ $0.rawValue })
    }
    
    public func remove(_ classes: [String]) -> String {
        self.remove(Set(classes))
    }
    
    public func remove(_ classes: Set<String>) -> String {
        self.classes.filter{ !classes.contains($0) }.joined(separator: " ")
    }
}
