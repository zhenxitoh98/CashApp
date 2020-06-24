//
//  TransactionDetail.swift
//  HelloWorld
//
//  Created by Samuel Toh on 5/7/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import CodeScanner
import UIKit
import LinkPresentation
import MessageUI

struct Profile: View {
    @State private var selectedTab = 1
    @State private var isShowingScanner = false
    @State private var showShareSheet = false
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    
    @EnvironmentObject var userData: UserData
    
    var transaction: Transaction
    
    var body: some View {
        
        NavigationView {
            VStack {
                picker

                if selectedTab == 0 {
                    QrCodeScanner()
                } else if selectedTab == 1 {
                    MyCode
                }
            }
            .navigationBarTitle(Text("Profile"))
            .navigationBarItems(trailing: share)
        }
    }
    

    
    private var picker: some View {
        Picker(selection: $selectedTab, label: Text("")) {
            Text("Scan").tag(0)
            Text("My Code").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private var share: some View {
        Button(action: shareButton) {
            Image(systemName: "square.and.arrow.up")
        }
    }
    
    private var MyCode: some View {
        VStack {
                    
            printOut(transaction: transactionData[0])
            

            
            Spacer()

        }
    }
    
    func shareButton() {
        showShareSheet.toggle()
        
        let image = NavigationView {
            printOut(transaction: transactionData[0])
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .frame(width: 350, height: 750).asImage()
        
        let av = UIActivityViewController(activityItems: [ItemDetailSource(name:"Samuel Toh", image: image)], applicationActivities: nil)

        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        

        
    }
    
}


extension View {
    public func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        let image = controller.view.asImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
    public func asImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(transaction: transactionData[1])
    }
}
