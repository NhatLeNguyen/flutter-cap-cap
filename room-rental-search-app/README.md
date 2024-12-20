# Room Rental Search App

## Overview
The Room Rental Search App is designed to facilitate the search and rental of rooms. Users can submit posts for available rooms, view a list of posts, and filter them based on their payment and approval status.

## Features
- **Post Submission**: Users can submit new posts with details such as title and description.
- **Post List**: A comprehensive list of posts that can be filtered by:
  - Approved
  - Unpaid
  - Paid but Unapproved
- **Payment Integration**: Users can initiate payment for unpaid posts directly from the post list.

## Project Structure
```
room-rental-search-app
├── lib
│   ├── main.dart                  # Entry point of the application
│   ├── models
│   │   └── post.dart              # Defines the Post model
│   ├── screens
│   │   ├── home_screen.dart       # Main interface of the app
│   │   ├── post_submission_screen.dart # Form for submitting new posts
│   │   └── post_list_screen.dart   # Displays a list of posts with filters
│   ├── widgets
│       ├── post_item.dart         # Represents a single post in the list
│       └── filter_buttons.dart     # Provides buttons for filtering posts
├── pubspec.yaml                   # Configuration file for Dart and Flutter
└── README.md                      # Documentation for the project
```

## Setup Instructions
1. Clone the repository:
   ```
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```
   cd room-rental-search-app
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the application:
   ```
   flutter run
   ```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.