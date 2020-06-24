//
//  QRCodeGenerator.swift
//  CashApp
//
//  Created by Samuel Toh on 6/2/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct QrCodeGenerator: View {
    @State var firstname: String
    @State var lastname: String
    @State var username: String
    @State var status: String
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            Image(uiImage: generateQRCode(from: "\(firstname)\n\(lastname)\n\(username)\n\(status)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct QrCodeGenerator_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeGenerator(firstname: "Anonymous", lastname: "test", username: "test", status: "")
    }
}
