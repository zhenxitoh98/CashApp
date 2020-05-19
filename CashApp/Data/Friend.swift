/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual landmark.
*/

import SwiftUI
import CoreLocation

struct Friend: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var username: String
    fileprivate var imageName: String
}

extension Friend {
    var image: Image {
        ImageStore.shared.image(name: imageName).renderingMode(.original)
    }
}

struct Friend_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
