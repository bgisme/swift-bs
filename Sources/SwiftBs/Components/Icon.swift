
import SwiftHtml

public class Icon: Component {
        
    public init(_ name: IconName) {
        let tag = I().class("bi \(name.rawValue)")
        super.init(tag)
    }
}
