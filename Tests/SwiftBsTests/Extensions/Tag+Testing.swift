@testable import SwiftHtml
@testable import SwiftBs

extension Tag {
    
    public func value(_ key: String) -> String? {
        node.attributes.first(where: { $0.key == key })?.value
    }
    
    func hasAttribute(_ attribute: BsAttribute) -> Bool {
        node.attributes.contains(where: { $0.key == attribute.rawValue })
    }
    
    func has(_ classes: [BsClass]) -> Bool {
        guard !classes.isEmpty else { return true }
        guard let classValue = value(.class), !classValue.isEmpty else { return false }
        return classValue.has(classes)
    }
    
    func has(_ styles: [CssKeyValue]) -> Bool {
        guard let styleValue = value(.style) else { return false }
        return styleValue.has(styles.map { String($0) }, ";")
    }    
}
