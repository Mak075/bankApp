import Foundation
import UIKit


class BranchViewController: UITableViewController {
    
    var branch: Location?
    
    
    @IBOutlet weak var phoneBackground: UIView!
    @IBOutlet weak var workHoursBackground: UIView!
    @IBOutlet weak var addressBackground: UIView!
    @IBOutlet weak var meetingRequestBackground: UIView!
    @IBOutlet weak var webSiteBackground: UIView!
    
    
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchLocation: UILabel!
    @IBOutlet weak var branchPhoneNumber: UILabel!
    @IBOutlet weak var branchOpenClosedStatus: UILabel!
    @IBOutlet weak var branchAddress: UILabel!
    @IBOutlet weak var branchEmail: UILabel!
    @IBOutlet weak var branchWebLink: UILabel!
    
    func getWorkingStatus() {
        
        let date = Date()
        let calendar = Calendar.current
        let calendarComponents = calendar.dateComponents([.weekday, .hour, .minute], from: date)
        
        if let workingPeriod = branch?.workingPeriod, let tempDay = workingPeriod.first(where: { period in
            return period.day == calendarComponents.weekday
        }) {
            
            
            if (Int(tempDay.startingHour!) <= Int(calendarComponents.hour!) && Int(tempDay.startingMinute!) <= Int(calendarComponents.minute!) ||
                Int(tempDay.endingHour!) >= Int(calendarComponents.hour!) && Int(tempDay.endingMinute!) >= Int(calendarComponents.minute!)
            ) {
                branchOpenClosedStatus.text = "Open"
            }   else {
                branchOpenClosedStatus.text = "Closed"
            }
            
            
        }  else {
            branchOpenClosedStatus.text = "Closed"
          }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneBackground.layer.cornerRadius = 10
        workHoursBackground.layer.cornerRadius = 10
        addressBackground.layer.cornerRadius = 10
        meetingRequestBackground.layer.cornerRadius = 10
        webSiteBackground.layer.cornerRadius = 10
        
        getWorkingStatus()
        
        branchName.text = branch?.name
        branchLocation.text = branch?.address
        branchPhoneNumber.text = branch?.phone
        branchAddress.text = branch?.address
        branchEmail.text = branch?.email
        branchWebLink.text = branch?.website
    }
    
    @IBAction func sendToDetailViewController(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.branchDetail = branch
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
