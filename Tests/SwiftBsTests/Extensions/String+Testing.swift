@testable import SwiftHtml
@testable import SwiftBs

extension String {
    
    func has(_ bsClass: BsClass) -> Bool {
        return has([bsClass])
    }
    
    func has(_ classes: [BsClass]) -> Bool {
        return has(classes.map{ $0.rawValue }, " ")
    }
    
    func has(_ values: [String], _ separatedBy: String) -> Bool {
        let components = components(separatedBy: separatedBy).filter{!$0.isEmpty}
        for value in values {
            if !components.contains(where: {$0 == value}) {
                return false
            }
        }
        return true
    }
}
