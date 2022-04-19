//
//  MediaManager.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 19.04.22.
//

import UIKit
import FirebaseStorage

protocol MediaManager {
    func uploadProfileImage(withData: Data, for: User, completion: @escaping (String?, Error?) -> Void)
}

class FirebaseMediaManager: MediaManager {
    
    private let storage = Storage.storage()
    private let firebaseStorageLink = "gs://cadet-college-chakwal.appspot.com"
    
    func uploadProfileImage(withData data: Data, for user: User, completion: @escaping (String?, Error?) -> Void) {
        var task: StorageUploadTask!
        let fileName = "UserProfiles/" + user.id + ".jpg"
        let storageReference = storage.reference(forURL: firebaseStorageLink).child(fileName)
        
        task = storageReference.putData(data, metadata: nil) { metadata, error in
            task.removeAllObservers()
            
            // An error occured while uploading the image
            if error != nil {
                completion(nil, error)
                return
            }
            
            // Download the url of uploaded image
            storageReference.downloadURL { url, error in
                // An error occured while downloading URL.
                guard let url = url, error == nil else {
                    completion(nil, error)
                    return
                }
                
                // Return the absolute URL
                completion(url.absoluteString, nil)
            }
        }
    }
    
}
