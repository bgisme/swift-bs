//
//  Component+Attributable.swift
//  
//
//  Created by Brad Gourley on 3/16/22.
//

import SwiftHtml

extension Component: Attributable {
    
    public func value(_ key: AttributeKey) -> String? {
        attributes?.first(where: { $0.key == key.rawValue })?.value
    }
    
    @discardableResult
    public func attribute(_ key: AttributeKey, _ value: String?) -> Self {
        self.delete(key)
        let attribute = Attribute(key: key.rawValue, value: value)
        self.attributes = self.attributes != nil ? self.attributes! + [attribute] : [attribute]
        return self
    }
        
    @discardableResult
    public func delete(_ key: AttributeKey) -> Self {
        guard let attributes = self.attributes else { return self }
        self.attributes = attributes.filter{ $0.key != key.rawValue }
        return self
    }
}
