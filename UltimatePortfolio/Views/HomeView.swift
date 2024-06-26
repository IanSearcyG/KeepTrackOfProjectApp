//
//  HomeView.swift
//  UltimatePortfolio
//
//  Created by Ian Searcy-Gardner on 10/9/21.
//

import CoreData
import SwiftUI

struct HomeView: View {
    static let tag: String? = "Home"
    @Binding var selectedView: String? // Inject the binding
    
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: true)], predicate: NSPredicate(format: "closed = false")) var projects: FetchedResults<Project>
    let items: FetchRequest<Item>
    
    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }
    
    init(selectedView: Binding<String?>) {
        self._selectedView = selectedView
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let completedPredicate = NSPredicate(format: "completed = false")
        let openPredicate = NSPredicate(format: "project.closed = false")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [completedPredicate, openPredicate])
        request.predicate = compoundPredicate
        
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.priority, ascending: false)
        ]
        
        request.fetchLimit = 10
        items = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: projectRows) {
                                ForEach(projects, content: ProjectSummaryView.init)
                            }
                            .padding([.horizontal, .top])
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        VStack(alignment: .leading) {
                            ItemListView(title: "Up next", items: items.wrappedValue.prefix(3))
                            ItemListView(title: "More to explore", items: items.wrappedValue.dropFirst(3))
                        }
                        .padding(.horizontal)
                    }
                    
                }
                .background(Color.systemGroupedBackground.ignoresSafeArea())
                .navigationTitle("Home")
                .toolbar {
                    Button("Add Sample Data") {
                        dataController.deleteAll()
                        try? dataController.createSampleData()
                    }
                }
            }
            // Display "Create Your First Project" only if no projects have been created yet
            if projects.isEmpty {
                VStack {
                    Spacer()
                    Text("Create Your First Project")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.selectedView = ProjectsView.openTag // Change the tab on tap
                        }
                    Spacer()
                }
            }
        }
        
    }
}






//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
