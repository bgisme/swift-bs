import AppKit
extension Array {
    
    func contains<T:Equatable>(_ items: [T]) -> Bool {
        for item in items {
            if !self.contains(where: {$0 as! T == item}) {
                return false
            }
        }
        return true
    }
}
