//
//  ResultsView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var resultsViewModel: ResultsViewModel
    
    var body: some View {
        List(resultsViewModel.results, id: \.id) { result in
            ZStack {
                NavigationLink(destination: ResultDetailsView()) {
                    EmptyView()
                }
                .opacity(0)
                
                ResultInfoBasic(result: result)
            }
        }
        .task {
            resultsViewModel.fetchResults()
        }
    }
}

struct ResultInfoBasic: View {
    
    let result: StudentResult
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(result.termName)
                    .font(.system(.title, design: .rounded))
                Text(result.remarks)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                HStack {
                    Text("Marks:")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                    Text("\(result.obtainedMarks) / \(result.totalMarks)")
                        .font(.system(.body, design: .rounded))
                }
                .padding(.vertical, 8)
            }
            
            Spacer()
            
            Text(result.timestamp.shortDateString)
                .font(.system(.callout, design: .rounded))
                .foregroundColor(.secondary)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let student = Student(parentId: "", firstName: "John", lastName: "Doe", rollNumber: "1636", cnic: "3720148895404", photoUrlString: "", currentClass: "12")
        let resultsVM = ResultsViewModel(student: student, resultsManager: FirebaseDbResultsManager())
        
        ResultsView(resultsViewModel: resultsVM)
        
        ResultInfoBasic(result: resultsVM.testStudentResult)
            .previewLayout(.sizeThatFits)
    }
}
