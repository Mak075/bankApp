import Foundation
import UIKit


class AtmViewController: UIViewController {
    
    var atm: Location?
    
    @IBOutlet weak var backgroundAtmInf: UIView!
    @IBOutlet weak var atmName: UILabel!
    @IBOutlet weak var atmLocation: UILabel!
    @IBOutlet weak var atmWebsite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundAtmInf.layer.cornerRadius = 10;
        atmName.text = atm?.name
        atmLocation.text = atm?.address
        atmWebsite.text = atm?.website
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

