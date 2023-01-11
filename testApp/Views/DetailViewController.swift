import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var branchDetail: Location?
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchLocation: UILabel!
    @IBOutlet weak var weekTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekTable.dataSource = self
        weekTable.delegate = self
        
        branchName.text = branchDetail?.name
        branchLocation.text = branchDetail?.address
    }
    
    @IBAction func switchToBranchView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.branchDetail?.workingPeriod?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath)

        guard
        let startingHour = branchDetail?.workingPeriod?[indexPath.row].startingHour,
        let startingMinute = branchDetail?.workingPeriod?[indexPath.row].startingMinute,
        let endingHour = branchDetail?.workingPeriod?[indexPath.row].endingHour,
        let endingMinute = branchDetail?.workingPeriod?[indexPath.row].endingMinute
        else {
            fatalError("error with convertng on hours and minutes")
        }

        
        
        let startingTime = String(format: "%02d:%02d", startingHour, startingMinute)
        let endingTime = String(format: "%02d:%02d", endingHour, endingMinute)

        
        cell.textLabel?.text = days[indexPath.row]
        cell.detailTextLabel?.text = "\(startingTime) - \(endingTime)"
                
        return cell
    }
}
