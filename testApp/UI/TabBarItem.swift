import Foundation
import UIKit

class CustomTabBarItem: UITabBarItem {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.image = nil
        
        
        //self.backgroundColor = UIColor(ciColor: .black)
        
    }
    
}

