# XS Life

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## File Structure
Our file structure is bases on feature first. This means for every feature there is an folder.

The main folders within lib/src are:
- common_widgets
  - In this folder you can find the reusable common widgets. This can be something like a button or input field.
- features
  - In this folder you can find all the different widgets. Each widget will contain of 4 different folders/ layers: .
    - Presentation: Widget, state and controllers
    - Applications: Services
    - Domain: Models
    - Data: Repositories, data sources, DTO (data transfer objects)
- routing
  - in this folder the routing should be placed
- utils
  - in this folder the extra custom functions/ utils can be placed

## Init project
- Configure app_settings
- Run flutterfire configure