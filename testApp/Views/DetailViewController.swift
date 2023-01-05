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
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.branchDetail?.workingPeriod?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath)

        
        guard
        var startingHour = branchDetail?.workingPeriod?[indexPath.row].startingHour,
        var startingMinute = branchDetail?.workingPeriod?[indexPath.row].startingMinute,
        var endingHour = branchDetail?.workingPeriod?[indexPath.row].endingHour,
        var endingMinute = branchDetail?.workingPeriod?[indexPath.row].endingMinute
        else {
            fatalError("error with convertng on hours and minutes")
        }
        
        let dateFormatter = DateFormatter()
        var timeStart = dateFormatter.date(from: "\(startingHour):\(startingMinute)")!
        var timeEnd = dateFormatter.date(from: "\(endingHour):\(endingMinute)")!
        dateFormatter.dateFormat = "hh:mm"
        
        var stringTimeStart = dateFormatter.string(from: timeStart)
        var stringTimeEnd = dateFormatter.string(from: timeEnd)
        print(timeStart, timeEnd)
        
        var startingTime = "\(startingHour):\(startingMinute)"
        var endingTime = "\(endingHour):\(endingMinute)"

        
        cell.textLabel?.text = days[indexPath.row]
       // cell.detailTextLabel?.text = "\(startingHour):\(startingMinute) - \(endingHour):\(endingMinute)"
                
        return cell
    }
}
