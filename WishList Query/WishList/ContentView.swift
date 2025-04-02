//
//  ContentView.swift
//  WishList
//
//  Created by olivier geiger on 02/04/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [WishModel]
    @State private var isAlertShowing: Bool = false
    @State private var textfieldText: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions {
                            Button("Delete",role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }
            }
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView("Empty wish list", systemImage: "heart.circle", description: Text("Add your first wish by tapping the plus (+) button in the top right corner."))
                }
            }
            .alert("Create a new wish", isPresented: $isAlertShowing) {
                VStack {
                    TextField("Enter a new wish", text: $textfieldText)
                    
                    Button {
                        let newWish = WishModel(title: textfieldText)
                        modelContext.insert(newWish)
                        textfieldText = ""
                        isAlertShowing.toggle()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                
                if wishes.isEmpty != true {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                    }
                }
            }
            .navigationBarTitle("Wish List")
        }
    }
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: WishModel.self, inMemory: true)
}

#Preview("List with Sample Data") {
    let container = try! ModelContainer(for: WishModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(WishModel(title: "Master SwiftData"))
    container.mainContext.insert(WishModel(title: "Master SwiftUI"))
    container.mainContext.insert(WishModel(title: "Master Dependency Injection"))
    container.mainContext.insert(WishModel(title: "Master Core Data"))
    
    return ContentView()
        .modelContainer(container)
}
