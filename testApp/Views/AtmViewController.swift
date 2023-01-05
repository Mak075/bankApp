import Foundation
import UIKit


class AtmViewController: UIViewController {
    
    var atm: Location?
    
    @IBOutlet weak var atmName: UILabel!
    @IBOutlet weak var atmLocation: UILabel!
    @IBOutlet weak var atmWebsite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atmName.text = atm?.name
        atmLocation.text = atm?.address
        atmWebsite.text = atm?.website
    }
}

