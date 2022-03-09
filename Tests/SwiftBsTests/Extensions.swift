//
//  File.swift
//  
//
//  Created by Brad Gourley on 3/9/22.
//

@testable import SwiftHtml
@testable import SwiftBs

extension Tag {
    
    func has(_ classes: [BsClass]) -> Bool {
        guard let value = firstChildAttributeValue("class") else { return false }
        for `class` in classes {
            if !value.containsOneInstanceOf(`class`) {
                return false
            }
        }
        return true
    }
    
    func has(_ styles: [CssKeyValue]) -> Bool {
        guard let value = firstChildAttributeValue("style") else { return false }
        for style in styles {
            if !value.containsOneInstanceOf(String(style)) {
                return false
            }
        }
        return true
    }
    
    func firstChildAttributeValue(_ attribute: BsAttribute) -> String? {
        firstChildAttributeValue(attribute.rawValue)
    }
    
    func firstChildAttributeValue(_ name: String) -> String? {
        firstChildAttribute(name)?.value
    }
    
    func firstChildAttribute(_ attribute: BsAttribute) -> Attribute? {
        firstChildAttribute(attribute.rawValue)
    }
    
    func firstChildAttribute(_ name: String) -> Attribute? {
        children.first?.node.attributes.first(where: { $0.key == name })
    }
}

extension String {
    
    func containsOneInstanceOf(_ `class`: BsClass) -> Bool {
        self.containsOneInstanceOf(`class`.rawValue)
    }
    
    func containsOneInstanceOf(_ substring: String) -> Bool {
        self.countInstances(of: substring) == 1
    }
    
    func countInstances(of bsClass: BsClass) -> Int {
        countInstances(of: bsClass.rawValue)
    }
    
    /// stringToFind must be at least 1 character.
    func countInstances(of stringToFind: String) -> Int {
        assert(!stringToFind.isEmpty)
        var count = 0
        var searchRange: Range<String.Index>?
        while let foundRange = range(of: stringToFind, options: [], range: searchRange) {
            count += 1
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
        }
        return count
    }
}
