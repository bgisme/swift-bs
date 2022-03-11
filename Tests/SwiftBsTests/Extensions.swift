//
//  File.swift
//  
//
//  Created by Brad Gourley on 3/9/22.
//

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

extension String {
    
    func has(_ bsClass: BsClass) -> Bool {
        return has([bsClass])
    }
    
    func has(_ classes: [BsClass]) -> Bool {
        return has(classes.map{ $0.rawValue }, " ")
    }
    
    func has(_ values: [String], _ separatedBy: String) -> Bool {
        let components = components(separatedBy: separatedBy)
        for value in values {
            if !components.contains(where: {$0 == value}) {
                return false
            }
        }
        return true
    }
}
