
import SwiftHtml

extension Tag: Attributable {
    
    public var classes: [String] {
        self.value(.class)?.split(separator: " ").map{ String($0) } ?? []
    }
    
    public func value(_ key: AttributeKey) -> String? {
        node.attributes.first(where: { $0.key == key.rawValue })?.value
    }
    
    @discardableResult
    public func attribute(_ key: AttributeKey, _ value: String?) -> Self {
        self.delete(key)
        return self.attribute(key.rawValue, value)
    }
    
    @discardableResult
    public func delete(_ key: AttributeKey) -> Self {
        self.deleteAttribute(key.rawValue)
    }
}
