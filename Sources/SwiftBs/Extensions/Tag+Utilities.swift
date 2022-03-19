//
//  Tag+Utilities.swift
//  
//
//  Created by Brad Gourley on 3/16/22.
//

import SwiftHtml

extension Tag {
    
    @discardableResult
    public func hrefOptional(_ value: String?) -> Self {
        if let value = value {
            return attribute("href", value)
        }
        return self
    }
    
    public var id: String? { node.attributes.first(where: { $0.key == "id" })?.value }
    
//    public func merge(_ attributes: [Attribute]?) -> Self {
//        guard let attributes = attributes else { return self }
//        for attribute in attributes {
//            switch attribute.key {
//            case AttributeKey.class.rawValue:
//                // merge
//                if let value = attribute.value {
//                    let classes = value.classes
//                    _ = self.class(insert: classes)
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
