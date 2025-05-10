# 1. PetCare

This presents a comprehensive description of the objectives, target audience, and core functionalities of the PetCare application.

### 1.1 Objective

The application in question primarily aims to assist first-time pet owners in tracking vaccination dates, adopted feeding schedules, weight and size measurements, and the recording of walks with their domestic animals.

### 1.2 Target Audience

The target audience for this application is pet owners, especially beginners.

### 1.3 Main Features

- **Pet Management:** Register pets with photos and basic information such as name, breed, date of birth, and any observations.
- **Vaccination History:** Record the vaccinations already received by your pet, including data such as the registered pet, the name of the vaccine, and the date of application.
- **Walk Log:** Record the history of activities and/or walks taken by the owner with their pet.
- **Feeding and Weight Control:** Track the pet's weight and record their feeding schedule.
- **Medical History:** Record the pet's visits to the veterinarian with information on health status, date of visit, and responsible veterinarian.


### 1.4 Design Examples

Some examples of the interface should be seen below:

<div align=center>
  <img src="https://github.com/user-attachments/assets/82d86eca-ab24-401d-9428-27b76755a72c" alt="fishspot login page" style="width:250px;"/>
  <img src="https://github.com/user-attachments/assets/b861e865-c670-4bc2-96da-15009aeea472" alt="fishspot register page" style="width:250px;"/>
</div>

## 2. Getting Started

This project is a Flutter application.

### 2.1 Prerequisites

Make sure you have Flutter SDK installed on your machine. You can find the installation instructions on the official Flutter website: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

### 2.2 Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/gbramoura/petcare.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd petcare
    ```
3.  Install the dependencies:
    ```bash
    flutter pub get
    ```

### 2.3 Running the App

Connect a physical device or start an emulator/simulator. Then, run the following command:

```bash
flutter run
```

3. Project Structure

```
petcare/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── ... (other project files and folders)
├── linux/
├── macos/
├── test/
├── web/
├── .gitignore
├── pubspec.yaml
└── README.md
```

- android/: Contains the Android-specific code.
- ios/: Contains the iOS-specific code.
- lib/: Contains the main Dart code for the Flutter application.
- main.dart: The entry point of the application.
  - ...: Other Dart files organizing the application logic, UI components, data models, etc.
  - linux/, macos/, web/: Contain platform-specific code for desktop and web support (if implemented).
- test/: Contains the unit and integration tests.
- .gitignore: Specifies intentionally untracked files that Git should ignore.
- pubspec.yaml: The project's configuration file, including dependencies, assets, etc.
- README.md: This file, providing an overview of the project.

## 4. Dependencies

The project uses the following dependencies (defined in pubspec.yaml):

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Add other dependencies here, e.g.:
  # provider: ^6.0.0
  # shared_preferences: ^2.0.0
  # ...

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^2.0.0
```

Please refer to the pubspec.yaml file for the most up-to-date list of dependencies and their versions.

## 5. Contributing

Contributions are welcome! If you'd like to contribute to the development of PetCare, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them.
4. Push your changes to your fork.
5. Submit a pull request.
