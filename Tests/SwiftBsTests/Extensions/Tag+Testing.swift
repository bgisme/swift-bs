@testable import SwiftHtml
@testable import SwiftBs

extension Tag {
    
    func hasAttribute(_ attribute: BsAttribute) -> Bool {
        node.attributes.contains(where: { $0.key == attribute.rawValue })
    }
    
    func has(_ classes: [BsClass]) -> Bool {
        guard !classes.isEmpty else { return true }
        guard let classValue = classValue, !classValue.isEmpty else { return false }
        return classValue.has(classes)
    }
    
    func has(_ styles: [CssKeyValue]) -> Bool {
        guard let styleValue = styleValue else { return false }
        return styleValue.has(styles.map { String($0) }, ";")
    }    
}
