import Foundation
import UIKit

protocol AtmDataStore {
    func storeAtm(_ dataManager: ListViewController, atm: Location)
    func didFailWithError(error: Error)
}

protocol BranchDataStore {
    func storeBranch(_ dataManager: ListViewController, branch: Location)
    func didFailWithError(error: Error)
}


class ListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var locationsArray: [Location] = []
    var dataManager = DataManager()
    // var delegateBranch: BranchDataStore?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        dataManager.delegate = self
        dataManager.fetchData()
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        
        cell.textLabel?.text = locationsArray[indexPath.row].name
        cell.detailTextLabel?.text = locationsArray[indexPath.row].address
        cell.imageView?.image = locationsArray[indexPath.row].type == "atm" ? UIImage(named: "ic_atm") : UIImage(named: "ic_branch")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (locationsArray[indexPath.row].type == "branch") {
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var vc = storyboard.instantiateViewController(withIdentifier: "BranchViewController") as! BranchViewController
            vc.branch = locationsArray[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        } else {
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var vc = storyboard.instantiateViewController(withIdentifier: "AtmViewController") as! AtmViewController
            vc.atm = locationsArray[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension ListViewController: DataManagerDelegate {
    
    func storeLocations(_ dataManager: DataManager, locations: [Location]) {
        DispatchQueue.main.async {
            self.locationsArray = locations
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
