//
//  HomeView.swift
//  WishList
//
//  Created by olivier geiger on 02/04/2025.
//

import SwiftUI
import SwiftData

enum SortType {
    case none
    case name
}

struct HomeView: View {
    
    @Environment(DependencyContainer.self) private var container
    @Environment(DataManager.self) private var dataManager
    @State var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.datas) { data in
                    Text(data.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                viewModel.onDelete(data)
                            }
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                
                if viewModel.datas.isEmpty != true {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(viewModel.datas.count) wish\(viewModel.datas.count > 1 ? "es" : "")")
                    }
                }
            }
            .navigationBarTitle("Wish List")
            .overlay {
                if viewModel.datas.isEmpty {
                    ContentUnavailableView("Empty wish list", systemImage: "heart.circle", description: Text("Add your first wish by tapping the plus (+) button in the top right corner."))
                }
            }
            .alert("Create a new wish", isPresented: $viewModel.isAlertShowing) {
                VStack {
                    TextField("Enter a new wish", text: $viewModel.textfieldText)
                    
                    Button {
                        viewModel.addNewItem()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

#Preview("Empty List") {
    HomeView(viewModel: HomeViewModel(interactor: CoreInteractor(container: DevPreview.shared.container)))
        .previewEnvironment()
}

#Preview("Mock Data") {
    let viewModel = HomeViewModel(interactor: MockHomeInteractor())

    return HomeView(viewModel: viewModel)
        .previewEnvironment()
}
