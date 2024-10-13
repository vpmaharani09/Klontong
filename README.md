# Klontong - Grocery and Supermarket Product Management

**Klontong** is a simple and efficient CRUD (Create, Read, Update, Delete) application designed to manage products in grocery stores and supermarkets. The app provides a seamless interface for adding, updating, listing, and deleting products, offering an easy way to keep track of inventory.

## Sample APK 
- [Here](https://github.com/vpmaharani09/Klontong/blob/main/klontong.apk)

## Features

- **Product Management**: Add new products, update product details, view product lists, and delete items no longer in stock.
- **User-Friendly Interface**: Intuitive design that allows quick navigation and management of products.

## Tech Stack

- **Flutter**: The frontend is built using Flutter, allowing a responsive and beautiful UI for both mobile and web platforms.
- **Dio**: All communication with the backend API is handled via Dio, which provides powerful features such as request interceptors, custom error handling, and support for different data formats.
- **Cubit (Bloc)**: The application uses Cubit for state management, ensuring that all business logic and UI states are managed efficiently. This leads to a more predictable and testable app architecture.
- **flutter_gen**: This package is used as an asset generator, which makes it easier to manage assets such as images, fonts, and other resources in the app. By using `flutter_gen`, all asset paths are automatically generated, reducing the likelihood of runtime errors due to mistyped paths.
- **Flutter Version Management (FVM)**: The application uses FVM to manage Flutter versions, ensuring flexibility and consistency when using different Flutter versions for the project.

## Error Monitoring with Sentry

We have integrated **Sentry** into the Klontong application to capture and track errors that occur during usage. Sentry helps us to monitor crashes and bugs in real-time, providing us with detailed reports, including stack traces, logs, and device information. This allows for quick diagnosis and resolution of issues.

### Sentry Setup

To use Sentry in the app, we follow these steps:

1. Install the Sentry Flutter SDK.
2. Configure Sentry to capture both unhandled exceptions and custom errors in the app.
3. Use Sentry for capturing errors during API requests handled by Dio and state changes managed by Cubit.

With Sentry, we capture:

- **API Errors**: All failed network requests or responses handled by Dio.
- **State Management Errors**: Any errors occurring during Cubit state changes are logged for review.

## Technical Overview

### State Management with Cubit

The app uses **Cubit**, which is a lightweight version of Bloc, to manage states throughout the application. Cubit allows the application to:

- Separate business logic from the UI.
- Have predictable state transitions.
- Easily test each state change.

We utilize Cubit for managing product-related states, such as adding, deleting, and updating products. Cubit ensures that the UI stays updated with the latest product information and provides a clear flow of data between the app’s components.

### REST API Integration with Dio

**Dio** is used for making API calls to the backend. It provides:

- Support for interceptors for request/response manipulation.
- Custom error handling.
- Timeout handling to improve the app's network reliability.

We use Dio for all CRUD operations related to products, such as:

- Fetching the product list.
- Creating new products.
- Updating existing products.
- Deleting products.

### Asset Management with flutter_gen

The **flutter_gen** package is used to automatically generate asset classes for all resources (images, fonts, etc.). This ensures that asset paths are strongly typed and reduces errors that might occur due to incorrect paths in the code.

### Flutter Version Management (FVM)

For flexibility and consistency, the **Klontong** app uses **Flutter Version Management (FVM)** to manage the Flutter version used in the project. This allows different developers to use the same version of Flutter across different environments without affecting their global Flutter installations.

## Getting Started

To run the Klontong application:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/klontong.git
   ```
2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Use the specified Flutter version with FVM:
   ```bash
   fvm use
   ```
4. Run fluttergen to generate the asset files:
   ```bash
   fluttergen
   ```
   If fluttergen is not installed, you can install it globally using this command:
   ```bash
   dart pub global activate flutter_gen 4.1.6
   ```
5. Run the app:
   ```bash
   flutter run
   ```

### Changes:

- Added the use of **Flutter Version Management (FVM)** for managing different Flutter versions.
- Updated the "Getting Started" section to include the steps for using FVM and running `fluttergen`.
- Included the installation command for `fluttergen` if it’s not already installed.

Let me know if there’s anything else you'd like to add!
