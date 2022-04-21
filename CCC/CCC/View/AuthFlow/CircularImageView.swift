//
//  CircularImageView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct CircularImageView: View {
    
    let image: UIImage?
    let placeholderSystemImageName: String
    var imageHeight = Constants.imageViewHeight
    var imageWidth = Constants.imageViewWidth
    
    var body: some View {
        imageView
    }
    
    var imageView: some View {
        let imageToDisplay: Image
        
        if let profileImage = image {
            imageToDisplay = Image(uiImage: profileImage)
        } else {
            imageToDisplay = Image(systemName: placeholderSystemImageName)
        }
        
        return imageToDisplay
            .resizable()
            .frame(width: imageWidth, height: imageHeight)
            .scaledToFill()
            .clipShape(Circle())
            .foregroundColor(.gray)
    }
    
    struct Constants {
        static let imageViewHeight: CGFloat = 150
        static let imageViewWidth: CGFloat = 150
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularImageView(image: nil, placeholderSystemImageName: "person")
    }
}
