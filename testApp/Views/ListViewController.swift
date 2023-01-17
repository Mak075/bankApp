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


class ListViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var locationsArray: [Location] = []
    var filteredData: [Location]!
    var dataManager = DataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        dataManager.delegate = self
        dataManager.fetchData()
        
        searchBar.delegate = self
        searchBar.barTintColor = .black // kako staviti costum color u ovom propertiju
        searchBar.searchTextField.backgroundColor = .white
        filteredData = locationsArray
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        
        cell.textLabel?.text = filteredData[indexPath.row].name
        cell.detailTextLabel?.text = filteredData[indexPath.row].address
        cell.imageView?.image = filteredData[indexPath.row].type == "atm" ? UIImage(named: "ic_atm") : UIImage(named: "ic_branch")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (locationsArray[indexPath.row].type == "branch") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BranchViewController") as! BranchViewController
            vc.branch = locationsArray[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AtmViewController") as! AtmViewController
            vc.atm = locationsArray[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // nece filtrirat
        
        filteredData = []
        
            for element in locationsArray {
                if ((element.name?.lowercased().contains(searchText.lowercased())) != nil) {
                    filteredData.append(element)
                }
            }
        
        self.tableView.reloadData()
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
