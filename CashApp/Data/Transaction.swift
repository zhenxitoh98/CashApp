/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual landmark.
*/

import SwiftUI
import CoreLocation

struct Transaction: Hashable, Codable, Identifiable {
    var id: Int
    var person1: String
    var category: Category
    var person2: String
    var content: String
    var privacy: Privacy
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    enum Category: String, CaseIterable, Codable, Hashable {
        case paid = "paid"
        case charged = "charged"
    }

    enum Privacy: String, CaseIterable, Codable, Hashable {
        case publicOnly = "PublicOnly"
        case privateOnly = "PrivateOnly"
        case friendsOnly = "FriendsOnly"
    }
}

extension Transaction {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}

struct Transaction_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
