//
//  FirebaseImageView.swift
//  Firebase_Storage_Test
//
//  Created by YOUNGSIC KIM on 2020-01-30.
//  Copyright © 2020 YOUNGSIC KIM. All rights reserved.
//

import SwiftUI
import Combine

struct FirebaseImageView: View {
    @ObservedObject var imageLoader:DataLoader
    @State var image:UIImage = UIImage()
    
    init(imageURL: String) {
        imageLoader = DataLoader(urlString:imageURL)
    }

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:300,height:300)
            
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

class DataLoader: ObservableObject {
    @Published var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        getDataFromURL(urlString: urlString)
    }
    
    func getDataFromURL(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

func makeImageFileName() -> String {
    var returnString = ""
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMddHHmmss"
    returnString = "images/image"+formatter.string(from: date)+".jpg"
    return returnString
}
