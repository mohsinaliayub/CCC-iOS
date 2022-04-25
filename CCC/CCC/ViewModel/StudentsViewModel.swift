//
//  StudentsViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation
import UIKit

class StudentsViewModel: ObservableObject {
    
    let profileImagePlaceholder = "person.crop.circle"
    
    @Published var students: [Student] = []
    @Published var studentPhoto: UIImage?
    
    private let studentsManager: StudentsManager
    private let authManager: AuthManager
    private let mediaManager: MediaManager
    private let resultsManager: ResultsManager
    
    init(authManager: AuthManager, studentsManager: StudentsManager, mediaManager: MediaManager) {
        self.studentsManager = studentsManager
        self.authManager = authManager
        self.mediaManager = mediaManager
        self.resultsManager = FirebaseDbResultsManager()
    }
    
    func fetchStudents() {
        guard let signedInUserId = authManager.signedInUserId else { return }
        
        studentsManager.fetchStudents(for: signedInUserId) { students, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.students = students
        }
    }
    
    func downloadImage(with link: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: link) else { return }
        
        mediaManager.downloadProfileImage(withUrl: url) { downloadedImage, mediaError in
            if let downloadedImage = downloadedImage {
                completion(downloadedImage)
                return
            }
            
            completion(nil)
        }
    }
    
    func getStudentDetailsViewModel(student: Student) -> StudentDetailViewModel {
        StudentDetailViewModel(student: student, resultsManager: resultsManager)
    }
    
}
