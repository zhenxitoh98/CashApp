//
//  TransactionDetail.swift
//  HelloWorld
//
//  Created by Samuel Toh on 5/7/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct TransactionDetail: View {
    @EnvironmentObject var userData: UserData
    @State private var comment = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var value : CGFloat = 0
    @State private var showingActionSheet = false
    
    @FetchRequest(entity: Post.entity(),
                  sortDescriptors: [])

    var posts: FetchedResults<Post>
    var transaction: Transaction
         
    var body: some View {
        VStack (alignment: .leading) {
            transactionPost.padding(.top, 20).padding(.leading, 20).padding(.trailing, 20)
            
            List {
                ForEach(posts) { post in
                    Text("\(post.comments)")

                }.onDelete { indexSet in
                    for index in indexSet {
                        self.managedObjectContext.delete(self.posts[index])
                    }
                }
            }
            
            commentSection
            
        }.resignKeyboardOnDragGesture()
    .navigationBarTitle("Payment", displayMode: .inline)
    }
    
    
    
    private var commentSection: some View {
        HStack {
            TextField("Comment here", text: $comment)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(5)

            Button (action: {
                UIApplication.shared.endEditing(true)
                guard self.comment != "" else {return}
                let newComment = Post(context: self.managedObjectContext)
                newComment.id = UUID()
                newComment.comments = self.comment
                newComment.username = self.transaction.person2
                self.comment = ""
                
                do {
                    try self.managedObjectContext.save()
                        print("Order saved.")
                    } catch {
                        print(error.localizedDescription)
                    }
            }) {
                Text("Comment").padding(.trailing, 10)
            }
        }
        .background(Color(red: 220/255, green: 220/255, blue: 220/255))
        .offset(y: -self.value)
        .animation(.spring())
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti ) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.value = height - 85
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti ) in

                self.value = 0
            }
        }
    }
    
    
    private var transactionPost: some View {
        HStack {
            transaction.image
                .resizable()
                .frame(width: 50, height: 60)
                .clipShape(Circle())
                .padding(.bottom, 70)
            
            VStack (alignment: .leading, spacing: 1) {
                HStack {
                    Text(transaction.person1 + " " + transaction.category.rawValue + " " + transaction.person2)
                        .font(.system(size: 12))
                    
                    Spacer()
                    
                    Text("+ $45.00")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 65 / 255, green: 130 / 255, blue: 69 / 255))
                        .bold()
                }
                HStack {
                    Text("3h")
                        .fontWeight(.light)
                        .font(.system(size: 10))
                    
                    Image(systemName: "lock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                }
            
                VStack (alignment: .leading, spacing: 20) {
                    Text(transaction.content)
                        .font(.system(size: 12))
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    
                    Divider()
                    HStack {

                        Image(systemName: "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                    }
                    Divider()
                }
            }
        }
    }
}

struct TransactionDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return TransactionDetail(transaction: transactionData[0]).environment(\.managedObjectContext, context)
    }
}
