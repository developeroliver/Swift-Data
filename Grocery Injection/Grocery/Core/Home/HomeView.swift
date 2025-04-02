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
            VStack {
                groceryListView()
            }
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    sortMenuView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                inputAreaView()
            }
            .onChange(of: viewModel.shouldClearFocus) { _, newValue in
                if newValue {
                    isFocused = false
                    viewModel.resetFocusState()
                }
            }
        }
    }
    
    /// ✅ Sous-vue : Menu de tri
    private func sortMenuView() -> some View {
        Menu {
            Button {
                viewModel.sortType = .name
            } label: {
                Label("Filtrer alphabétiquement", systemImage: "textformat")
            }

            Button {
                viewModel.sortType = .completed
            } label: {
                Label("Filtrer par statut", systemImage: "checkmark.circle")
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
                .foregroundStyle(.blue)
        }
    }

    /// ✅ Sous-vue : Liste des courses
    private func groceryListView() -> some View {
        List {
            ForEach(viewModel.sortedDatas) { data in
                groceryItemRow(data: data)
            }
        }
        .overlay {
            if viewModel.datas.isEmpty {
                ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description: Text("Add some items to the shopping list."))
            }
        }
    }

    /// ✅ Sous-vue : Élément de la liste
    private func groceryItemRow(data: DataModel) -> some View {
        Text(data.title)
            .font(.title.weight(.light))
            .padding(.vertical, 2)
            .foregroundStyle(data.isCompleted == false ? Color.primary : Color.accentColor)
            .strikethrough(data.isCompleted)
            .italic(data.isCompleted)
            .swipeActions {
                Button(role: .destructive) {
                    withAnimation {
                        viewModel.onDelete(data)
                    }
                } label: {
                    Label("Supprimer", systemImage: "trash")
                }
            }
            .swipeActions(edge: .leading) {
                Button {
                    data.isCompleted.toggle()
                } label: {
                    Label("Terminé", systemImage: data.isCompleted ? "x.circle" : "checkmark.circle")
                }
                .tint(data.isCompleted ? .accentColor : .green)
            }
    }

    /// ✅ Sous-vue : Zone de saisie
    private func inputAreaView() -> some View {
        VStack(spacing: 12) {
            TextField("Ajouter un élément", text: $viewModel.textFieldText)
                .textFieldStyle(.plain)
                .padding(12)
                .background(.tertiary)
                .cornerRadius(12)
                .font(.title.weight(.light))
                .focused($isFocused)
            
            Button {
                viewModel.addNewItem()
            } label: {
                Text("Enregistrer")
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

#Preview("Empty List") {
    HomeView(viewModel: HomeViewModel(interactor: CoreInteractor(container: DevPreview.shared.container)))
        .previewEnvironment()
}

#Preview("Mock Data") {
    let viewModel = HomeViewModel(interactor: MockHomeInteractor())

    return HomeView(viewModel: viewModel)
        .previewEnvironment()
}
