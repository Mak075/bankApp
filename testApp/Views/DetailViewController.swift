import Foundation
import UIKit

class DetailViewController: UITableViewController {
    
    var branchDetail: Location?
    
    var days: Int = 0
    
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchLocation: UILabel!
    @IBOutlet weak var mondayTime: UILabel!
    @IBOutlet weak var tuesdayTime: UILabel!
    @IBOutlet weak var wednesdayTime: UILabel!
    @IBOutlet weak var thursdayTime: UILabel!
    @IBOutlet weak var fridayTime: UILabel!
    @IBOutlet weak var saturdayTime: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        branchName.text = branchDetail?.name
        branchLocation.text = branchDetail?.address
        organizeTimePerDay()
        
    }
    
    @IBAction func switchToBranchView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func organizeTimePerDay() {
        
        var arrayOfTimes = [[String]]()
            
        for day in branchDetail?.workingPeriod ?? [] {
            guard
            var startingHour = day.startingHour,
            var startingMinute = day.startingMinute,
            var endingHour = day.endingHour,
            var endingMinute = day.endingMinute
            else {
                fatalError("error with convertng on hours and minutes")
            }
            
            let startingTime = String(format: "%02d:%02d", startingHour, startingMinute)
            let endingTime = String(format: "%02d:%02d", endingHour, endingMinute)
            
            arrayOfTimes.append([startingTime, endingTime])
            days += 1
        }
        
        
        // Nemoguce je kroz 2 for petlje vrtiti jer IBoutlet UILabel ne moze biti niz na kojem se moze usnimit vrijednost, volio bi znat ima li bolje rijesenje jer sam vidio da ipak postoji niz [UILabel]
        
        if ((arrayOfTimes[0][0]) != "") {
            mondayTime.text = "\(arrayOfTimes[0][0]) - \(arrayOfTimes[0][1])"
        }   else {
            mondayTime.text = "Zatvoreno"
        }
        
        if ((arrayOfTimes[1][0]) != "") {
            tuesdayTime.text = "\(arrayOfTimes[1][0]) - \(arrayOfTimes[1][1])"
        }   else {
            tuesdayTime.text = "Zatvoreno"
        }
        
        if ((arrayOfTimes[2][0]) != "") {
            wednesdayTime.text = "\(arrayOfTimes[2][0]) - \(arrayOfTimes[2][1])"
        }   else {
            wednesdayTime.text = "Zatvoreno"
        }
        
        
        var isThursdayValid = arrayOfTimes.indices.contains([3][0])
        
        if (isThursdayValid == true) {
            thursdayTime.text = "\(arrayOfTimes[3][0]) - \(arrayOfTimes[3][1])"
        }   else {
            thursdayTime.text = "Zatvoreno"
        }
        
        var isFridayValid = arrayOfTimes.indices.contains([4][0])
        
        if (isFridayValid == true) {
            fridayTime.text = "\(arrayOfTimes[4][0]) - \(arrayOfTimes[4][1])"
        }   else {
            fridayTime.text = "Zatvoreno"
        }
        
        var isSaturdayValid = arrayOfTimes.indices.contains([5][0])
        
        if (isSaturdayValid == true) {
            saturdayTime.text = "\(arrayOfTimes[5][0]) - \(arrayOfTimes[5][1])"
        }   else {
            saturdayTime.text = "Zatvoreno"
        }
    }
}

