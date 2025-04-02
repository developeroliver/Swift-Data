# Swift Data Demo Project

This repository demonstrates how to effectively use Swift Data, Apple's modern persistence framework introduced in iOS 17. It showcases a practical implementation in a grocery list application built with SwiftUI.

## About Swift Data

Swift Data is Apple's declarative data modeling framework that makes it easy to persist app data. It provides a seamless way to define your data model, persist it, and query it, all using pure Swift code.

### Key Features of Swift Data:

- **Declarative Model Definition**: Define your data models using Swift macros
- **SwiftUI Integration**: Built to work smoothly with SwiftUI and the Swift concurrency model
- **Schema Migration**: Handles schema changes with automatic migration support
- **Powerful Queries**: Filter, sort, and transform your data with simple, type-safe queries
- **Preview Support**: Easy data mocking for SwiftUI previews

### Basic Usage Example:

```swift
// Define your model
@Model
class GroceryItem {
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
    }
}

// Use in a SwiftUI view
struct GroceryListView: View {
    @Query var items: [GroceryItem]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List(items) { item in
            Text(item.title)
        }
    }
    
    func addItem(title: String) {
        let newItem = GroceryItem(title: title)
        modelContext.insert(newItem)
    }
}
```

## Advanced Architecture Implementation

This project goes beyond basic Swift Data usage to demonstrate a robust application architecture with the following features:

### Dependency Injection with Environment

The project shows how to leverage SwiftUI's environment to inject dependencies, making your code more modular, testable, and maintainable:

```swift
// Define container
class DependencyContainer {
    func register<T>(_ type: T.Type, service: T) {
        // Implementation
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        // Implementation
    }
}

// Access in views
struct ContentView: View {
    @Environment(DependencyContainer.self) private var container
    // Use container to get dependencies
}
```

### MVVM with Protocol-Oriented Design

The application follows the MVVM (Model-View-ViewModel) pattern, enhanced with protocol-oriented programming:

- **Models**: Swift Data models representing app data
- **Views**: SwiftUI views that display data
- **ViewModels**: Classes that manage business logic and data transformations
- **Protocols**: Interfaces defining behavior contracts between components

Example:

```swift
protocol DataServiceProtocol {
    func fetchItems() -> [DataModel]
    func saveItem(_ item: DataModel)
}

class HomeViewModel {
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    // Implementation
}
```

### Interactor Pattern

The project uses the Interactor pattern to handle complex business logic and coordinate between different parts of the app:

```swift
protocol CoreInteractorProtocol {
    func fetchGroceryItems() -> [DataModel]
    func addNewItem(title: String)
    func deleteItem(_ item: DataModel)
}

class CoreInteractor: CoreInteractorProtocol {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    // Implementation
}
```

## Preview & Testing Support

The architecture enables easy preview and testing with mock data:

```swift
#Preview("Mock Data") {
    let mockPersistence = MockLocalPersistance(mocks: DataModel.mocks)
    let mockDataManager = DataManager(service: SwiftDataDatasource(), local: mockPersistence)
    
    let mockContainer = DependencyContainer()
    mockContainer.register(DataManager.self, service: mockDataManager)

    let mockInteractor = CoreInteractor(container: mockContainer)

    return HomeView(viewModel: HomeViewModel(interactor: mockInteractor))
        .environment(DependencyContainer.self, mockContainer)
        .environment(DataManager.self, mockDataManager)
}
```

## Getting Started

1. Clone the repository
2. Open the project in Xcode 15 or later
3. Build and run the application
4. Explore the code to learn how Swift Data is integrated with dependency injection and MVVM architecture

## Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+
