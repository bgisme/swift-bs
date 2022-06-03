
public protocol Sizable {
    
    @discardableResult
    func size(_ value: Size?, _ condition: Bool) -> Self
}
