import Foundation

struct LocationData {
    
    let locations: [Location]
    
    init(json: [String: Any]) {
        let data = json["data"] as? [[String: Any]]
        
        self.locations = data?.map({ element in
            return Location(json: element )
        }) as? [Location] ?? []
    }
}

struct Location {
    
    let id: Int?
    let name: String?
    let address: String?
    let phone: String?
    let email: String?
    let website: String?
    let type: String?
    let coordinates: Coordinate?
    let workingPeriod: [WorkingPeriod]?
    
    init(json: [String: Any]) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.address = json["address"] as? String
        self.phone = json["phone"] as? String
        self.email = json["email"] as? String
        self.website = json["website"] as? String
        self.type = json["type"] as? String
        self.coordinates = Coordinate(json: json["location"] as? [String: Any] ?? [:])
        
        let workingPeriodData = json["working_hours"] as? [[String: Any]]
        
        self.workingPeriod = workingPeriodData?.map ({ element in
            return WorkingPeriod(json: element)
        }) as? [WorkingPeriod] ?? []
    }
}

struct Coordinate {
    let locationLat: Double?
    let locationLong: Double?
    
    init(json: [String: Any]) {
        self.locationLat = json["lat"] as? Double
        self.locationLong = json["long"] as? Double
    }
}


struct WorkingPeriod {
    let day: Int?
    let startingHour: Int?
    let startingMinute: Int?
    let endingHour: Int?
    let endingMinute: Int?
    
    init(json: [String: Any]) {
        self.day = json["day"] as? Int
        self.startingHour = json["start_hours"] as? Int
        self.startingMinute = json["start_minutes"] as? Int
        self.endingHour = json["end_hours"] as? Int
        self.endingMinute = json["end_minutes"] as? Int
    }
}

