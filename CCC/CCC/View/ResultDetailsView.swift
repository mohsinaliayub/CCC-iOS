//
//  ResultDetailsView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import SwiftUI

struct ResultDetailsView: View {
    
    let result: StudentResult
    @Environment(\.dismiss) private var dismiss
    
    init(result: StudentResult) {
        self.result = result
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(named: "AppBackgroundColor")
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TableRow(text1: String(localized: "Subject"),
                         text2: String(localized: "Total Marks"),
                         text3: String(localized: "Obt. Marks"), fontWeight: .medium)
                    .font(.system(.title2, design: .rounded))
                Divider()
                
                ForEach(result.subjectResults) { subjectResult in
                    TableRow(text1: subjectResult.subjectName,
                             text2: "\(subjectResult.totalMarks)",
                             text3: "\(subjectResult.obtainedMarks)")
                        .font(.system(.title2, design: .rounded))
                        .padding(.vertical, 8)
                    Divider()
                }
                
                TableRow(text1: "", text2: "\(result.totalMarks)", text3: "\(result.obtainedMarks)",
                         fontWeight: .semibold)
                    .font(.system(.title2, design: .rounded))
                    .padding(.vertical, 8)
                
                Divider()
                
                remarksAndClass
            }
            .padding(.top, 20)
            .padding(.horizontal, 4)
        }
        .navigationBarBackButtonHidden(true)
        .background(AppConstants.Colors.appBackgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("", systemImage: "chevron.left")
                        .font(.system(.title2, design: .rounded))
                }
            }
            
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(result.termName).font(.headline).fontWeight(.bold)
                    Text(result.timestamp.shortDateString).font(.subheadline)
                }
            }
        }
    }
    
    var remarksAndClass: some View {
        VStack {
            HStack {
                Text(String(localized: "Remarks:"))
                    .font(.title2)
                    
                Spacer()
                Text(result.remarks)
                    .fontWeight(.medium)
            }
            .font(.system(.title2, design: .rounded))
            .padding(.horizontal)
            .padding(.top, 4)
            
            HStack {
                Text(String(localized: "Class:"))
                    .font(.title2)
                    
                Spacer()
                Text(result.studentClass)
                    .fontWeight(.medium)
            }
            .font(.system(.title2, design: .rounded))
            .padding(.horizontal)
            .padding(.top, 1)
        }
    }
}

struct TableRow: View {
    
    let text1: String
    let text2: String
    let text3: String
    
    var fontWeight: Font.Weight? = nil
    
    var body: some View {
        HStack {
            Text(text1)
                .fontWeight(fontWeight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 4)
            
            Text(text2)
                .fontWeight(fontWeight)
                .frame(maxWidth: .infinity)
            
            Text(text3)
                .fontWeight(fontWeight)
                .frame(maxWidth: .infinity)
        }
    }
}

struct ResultDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let math = SubjectResult(subjectName: "Mathematics", totalMarks: 40, obtainedMarks: 40)
        let physics = SubjectResult(subjectName: "Physics", totalMarks: 40, obtainedMarks: 40)
        let chemistry = SubjectResult(subjectName: "Chemistry", totalMarks: 40, obtainedMarks: 32)
        let urdu = SubjectResult(subjectName: "Urdu", totalMarks: 40, obtainedMarks: 34)
        let english = SubjectResult(subjectName: "English", totalMarks: 40, obtainedMarks: 38)
        let pakSt = SubjectResult(subjectName: "Pak Studies", totalMarks: 40, obtainedMarks: 37)
        
        let subjectResults = [math, physics, chemistry, urdu, english, pakSt]
        let result = StudentResult(studentId: "student.id", studentClass: "12",
                                   positionInClass: 1, termName: "September Term", timestamp: Date(),
                                   remarks: "1st position", passed: true, subjectResults: subjectResults)
        
        NavigationView {
            ResultDetailsView(result: result)
        }
    }
}
