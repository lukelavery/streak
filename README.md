<h1 align="center">
  <br>
  <img src="https://github.com/lukelavery/streak/blob/main/assets/streak-logo.png" width="200">
  <br>
  streak
  <br>
</h1>

<div align="center">
  <h4>A habit tracking app coded with Flutter.</h4>
</div>

<table>
  <tr>
     <td>Splash Screen</td>
     <td>Login Screen</td>
     <td>Home Screen</td>
     <td>Activity Screen</td>
  </tr>
  <tr>
    <td><img src="/assets/screenshots/screenshot_splash.jpg" width=270 ></td>
    <td><img src="/assets/screenshots/screenshot_login.jpg" width=270 ></td>
    <td><img src="/assets/screenshots/screenshot_home.jpg" width=270 ></td>
    <td><img src="/assets/screenshots/screenshot_focus.jpg" width=270 ></td>
  </tr>
    <tr>
     <td>Profile Screen</td>
     <td>Search Screen</td>
     <td>Create Habit Screen</td>
     <td>Dark Mode</td>
  </tr>
  <tr>
    <td><img src="/assets/screenshots/screenshot_profile.jpg" width=270 ></td>
    <td><img src="/assets/screenshots/screenshot_search.jpg" width=270 ></td>
    <td><img src="/assets/screenshots/screenshot_custom.jpg" width=270 ></td>
    <td><img src="/assets/screenshots/screenshot_dark.jpg" width=270 ></td>
  </tr>
 </table>

## Project Environment:
```
Flutter 3.13.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision ff5b5b5fa6 (11 days ago) • 2023-08-24 08:12:28 -0500
Engine • revision b20183e040
Tools • Dart 3.1.0 • DevTools 2.25.0
```

 ## Code Flow:
Project is following a feature-first MVC pattern. Riverpod is used for state management. All the UI components are inside views folder. Business logic is handled inside controller folder. Model is used to parse data.
```
└── feature/
    ├── controller/
    │   └── business logic layer
    ├── model/
    │   └── data layer
    ├── view/
    │   └── presentation layer
    ├── services/
    │   └── helper classes
    └── constant
```

 ## More Information:
To learn more about riverpod:<br>
https://codewithandrea.com/videos/flutter-state-management-riverpod/<br>
To learn more about MVC pattern:<br>
https://medium.flutterdevs.com/design-patterns-in-flutter-part-1-c32a3ddb00e2<br>
