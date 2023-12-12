
import SwiftHtml

extension Tag {
    
    public var id: String? { attributes?.first(where: { $0.key == "id" })?.value }
    
//    @discardableResult
//    public func id(_ value: String?, _ condition: Bool = true) -> Self {
//        guard condition, let value = value else { return self }
//        self.id(value)
//        return self
//    }
    
    @discardableResult
    public func onDoubleClick(_ value: String?, _ condition: Bool = true) -> Self {
        guard let value = value, condition else { return self }
        return attribute(.ondblclick, value)
    }

    @discardableResult
    public func onDragStart(_ value: String?, _ condition: Bool = true) -> Self {
        guard let value = value, condition else { return self }
        return attribute(.ondragstart, value)
    }

    
//    public func merge(_ attributes: [Attribute]?) -> Self {
//        guard let attributes = attributes else { return self }
//        for attribute in attributes {
//            switch attribute.key {
//            case AttributeKey.class.rawValue:
//                // merge
//                if let value = attribute.value {
//                    let classes = value.classes
//                    self.class(insert: classes)
//                }
//            case AttributeKey.style.rawValue:
//                // merge
//                if let new = attribute.value {
//                    if let existing = value(.style) {
//                        let merged = existing.add(new.styles)
//                        self.attribute(.style, merged)
//                    } else {
//                        self.attribute(.style, new)
//                    }
//                }
//            default:
//                // replace
//                self.deleteAttribute(attribute.key)
//                self.attribute(attribute.key, attribute.value)
//            }
//        }
//        return self
//    }
}
