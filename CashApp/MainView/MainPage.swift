import SwiftUI

//enum Privacy: String, CaseIterable {
//    case Image(systemName: ), privateOnly, friendOnly
//}

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
//    @EnvironmentObject var session: SessionStore
    @State var showSheetView = false
    @State private var selectedTab = 1
    
    
    var body: some View {

//        ZStack {
            NavigationView {
                VStack {
                    picker
                    
                    List {
//                    ForEach(userData.transactions) { transactions in
                    // Crash happens here when foreach is used
                        if selectedTab == 0 {
                            NavigationLink(destination: TransactionDetail(transaction: transactionData[0])) {
                                TransactionRow(transaction: transactionData[0])
                            }
                        } else if selectedTab == 2 {
                            NavigationLink(destination: TransactionDetail(transaction: transactionData[2])) {
                                TransactionRow(transaction: transactionData[2])
                            }
                        } else {
                            NavigationLink(destination: TransactionDetail(transaction: transactionData[1])) {
                                TransactionRow(transaction: transactionData[1])
                            }
                        }
                    }
                .navigationBarTitle("Feed")
//                .navigationBarItems(trailing:
//                        Button (action: {
//                            self.showSheetView.toggle()
//                            }) {
//                        Image(systemName: "square.and.pencil")
//                            .imageScale(.large)
//                        }.sheet(isPresented: $showSheetView) {
//                            SendPayment(showSheetView: self.$showSheetView)
//                        }
//                    )
        }
            }
//        }.animation(.spring())

    }
    
    
    private var picker: some View {
        Picker(selection: $selectedTab, label: Text("")) {
            Image(systemName: "globe").tag(0)
            Image(systemName: "person.2.fill").tag(1)
            Image(systemName: "person.fill").tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
