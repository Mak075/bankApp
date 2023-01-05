import Foundation

protocol DataManagerDelegate {
    func storeLocations(_ dataManager: DataManager, locations: [Location])
    func didFailWithError(error: Error)
}

struct DataManager {

    var delegate: DataManagerDelegate?
    // var delegateAtm: AtmDataStore?
    
    
    func fetchData() {
        let urlString = "https://abctechgroup.z16.web.core.windows.net/dummy/data/locations.json"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create URL session
            let session = URLSession(configuration: .default)
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in

                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if let data = self.parseJSON(safeData) {
                        // print(data.locations)
                        self.delegate?.storeLocations(self, locations: data.locations)
                    }
                }
            }

            task.resume()
        }
    }


    func parseJSON(_ locationData: Data) -> LocationData? {
        var receivedData: [String: Any]?
        
        if let rData = try? JSONSerialization.jsonObject(with: locationData, options: []) as? [String: Any] {
            receivedData = rData
        }
        return LocationData(json: receivedData ?? [:])
    }
}





