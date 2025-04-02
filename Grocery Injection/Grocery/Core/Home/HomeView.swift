//
//  HomeView.swift
//  Grocery
//
//  Created by olivier geiger on 02/04/2025.
//

import SwiftUI
import SwiftData

enum SortType {
    case none
    case name
    case completed
}

struct HomeView: View {
    
    @Environment(DependencyContainer.self) private var container
    @Environment(DataManager.self) private var dataManager
    @FocusState private var isFocused: Bool
    @State var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sortedDatas) { data in
                    GroceryItemRow(data: data, onDelete: viewModel.onDelete)
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                           Button {
                               viewModel.sortType = .name
                           } label: {
                               Label("Filter alphabetiquement", systemImage: "textformat")
                           }

                           Button {
                               viewModel.sortType = .completed
                           } label: {
                               Label("Filter par statut", systemImage: "checkmark.circle")
                           }
                       } label: {
                           Image(systemName: "arrow.up.arrow.down")
                               .foregroundStyle(.blue)
                       }
                }
            }
            .overlay {
                if viewModel.datas.isEmpty {
                    ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description: Text("Add some items to the shopping list."))
                }
            }
            .safeAreaInset(edge: .bottom) {
                createInputArea()
            }
        }
        .onChange(of: viewModel.shouldClearFocus) { _, newValue in
            if newValue {
                isFocused = false
                viewModel.resetFocusState()
            }
        }
    }
    
    private func createInputArea() -> some View {
        VStack(spacing: 12) {
            TextField("", text: $viewModel.textFieldText)
                .textFieldStyle(.plain)
                .padding(12)
                .background(.tertiary)
                .cornerRadius(12)
                .font(.title.weight(.light))
                .focused($isFocused)
            
            Button {
                viewModel.addNewItem()
            } label: {
                Text("Save")
                    .font(.title2.weight(.medium))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.extraLarge)
        }
        .padding()
        .background(.bar)
    }
}

struct GroceryItemRow: View {
    var data: DataModel
    var onDelete: (DataModel) -> Void
    
    var body: some View {
        Text(data.title)
            .font(.title.weight(.light))
            .padding(.vertical, 2)
            .foregroundStyle(data.isCompleted == false ? Color.primary : Color.accentColor)
            .strikethrough(data.isCompleted)
            .italic(data.isCompleted)
            .swipeActions {
                Button(role: .destructive) {
                    withAnimation {
                        onDelete(data)
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            .swipeActions(edge: .leading) {
                Button("Done", systemImage: data.isCompleted == false ?  "checkmark.circle" : "x.circle") {
                    data.isCompleted.toggle()
                }
                .tint(data.isCompleted == false ? .green : .accentColor)
            }
    }
}

#Preview("Empty List") {
    let container = DevPreview.shared.container
    container.register(DataManager.self, service: DataManager(local: MockLocalPersistance(mocks: [])))
    
    return HomeView(viewModel: HomeViewModel(interactor: CoreInteractor(container: container)))
        .previewEnvironment()
}

#Preview("Mock Data") {
    let viewModel = HomeViewModel(interactor: MockHomeInteractor())

    return HomeView(viewModel: viewModel)
        .previewEnvironment()
}
