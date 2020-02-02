//
//  ContentView.swift
//  Firebase_Storage_Test
//
//  Created by YOUNGSIC KIM on 2020-01-29.
//  Copyright © 2020 YOUNGSIC KIM. All rights reserved.
//

import SwiftUI
import FirebaseStorage
import Combine

let FILE_NAME = "images/imageFileTest.jpg"

struct ContentView: View {
    @State var shown = false
    @State var imageURLList = [String]()
    
    var body: some View {
        VStack{
            Button(action: { self.shown.toggle() }) {
                Text("Upload Image").font(.title).bold()
            }.sheet(isPresented: $shown) {
                imagePicker(shown: self.$shown,imageURLList: self.$imageURLList)
                 }.padding(10).background(Color.purple).foregroundColor(Color.white).cornerRadius(20)
            
            List(imageURLList, id: \.self) { item in
                ContentRow(imageURL: item)
            }
        }.onAppear(perform: listOfImageFile).animation(.spring())
    }
    
    func listOfImageFile() {
        let storageReference = Storage.storage().reference().child("images/")
        storageReference.listAll { (result, error) in
          if error != nil {
              // Handle any errors
              print((error?.localizedDescription)!)
              return
          }
            
          for prefix in result.prefixes {
            // The prefixes under storageReference.
            // You may call listAll(completion:) recursively on them.
            print("prefix is \(prefix)")
          }
          for item in result.items {
            // The items under storageReference.
            print("items is \(item)")
            self.loadImageFromFirebase(imagePath: item.fullPath)
          }
        }
    }
    
    func loadImageFromFirebase(imagePath: String) {
        let storage = Storage.storage().reference(withPath: imagePath)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            let urlString = "\(url!)"
            self.imageURLList.append(urlString)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

