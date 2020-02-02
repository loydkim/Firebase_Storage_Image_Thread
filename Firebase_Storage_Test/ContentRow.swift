//
//  ContentRow.swift
//  Firebase_Storage_Test
//
//  Created by YOUNGSIC KIM on 2020-01-31.
//  Copyright © 2020 YOUNGSIC KIM. All rights reserved.
//

import SwiftUI
import FirebaseStorage

let userScale:CGFloat = 40
let bottomButtonScale:CGFloat = 30

struct ContentRow: View {
    @State var imageURL = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle.fill").resizable().frame(width: userScale, height: userScale)
                Text(randomString(length: 8)).font(.body).bold()
            }
            if imageURL != "" {
                FirebaseImageView(imageURL: imageURL)
            }
            HStack {
                Image(systemName: "heart.fill").resizable().frame(width: bottomButtonScale, height: bottomButtonScale).foregroundColor(Color.red).padding(6)
                Image(systemName: "message.fill").resizable().frame(width: bottomButtonScale, height: bottomButtonScale).foregroundColor(Color.green).padding(6)
                Image(systemName: "paperplane").resizable().frame(width: bottomButtonScale, height: bottomButtonScale).padding(6)
            }
            
            Text("Liked by Loyd's SwiftUI Lab").font(.body).padding(6)
        }
    }
}

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

struct ContentRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow()
    }
}
