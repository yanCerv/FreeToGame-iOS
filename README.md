 FreeToGame iOS

iOS client for the FreeToGame API that displays a list of free-to-play games and their details. Built with Swift 6, using only native frameworks (no third-party SDKs).

---

## 🌟 Main Features

- **MVVM Architecture**  
  Clear separation between Model, View, and ViewModel to keep code clean and maintainable.
  Separation NetworkLayer to provide services for testing and consume.

- **Network Layer with URLSession With Combine and Swift Concurrency**  
  - All HTTPS calls are made with `URLSession` using Combine with `async/await` Workaround client.  
  - `HomeClient` and other providers use a `Request` protocol to abstract networking logic.  
  - Centralized error handling with `ErrorHandler` and an `actor` that provides in-memory image caching.

- **Swift 6 and Strict Concurrency**  
  - Each ViewModel and each `fetch` method is annotated with `@MainActor` when needed.  
  - No deprecated APIs or external libraries—everything is provided by iOS by default.

- **Image Caching in Memory**  
  A `CachedImage` component uses an `actor` plus `NSCache` to store and reuse `UIImage` objects, avoiding repeated downloads of the same URL.

- **Screens and Flow**  
  - **MainTabView**: Main container with a `TabView` and navigation (`NavigationStack`).  
  - **HomeView**: List of sections (Trending, Most Played, New Releases, And Random Recommendations), each with horizontal scrolling.  
  - **SelectedGenreListView**: 2-column grid showing games for a selected genre.  
  - **GameDetailView**: Detail view with an expanded image (using `matchedGeometryEffect`), description, screenshots, and minimum system requirements shown in a sheet.  
