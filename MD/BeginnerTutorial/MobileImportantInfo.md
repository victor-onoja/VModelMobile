## flutter Mobile beginning readme

### first task instructions for mobile devs

To run the clone the Project from github,
open a command prompt or terminal and navigate to the directory where you want to clone the project 
enter the following command:

```
git clone https://github.com/VModel/VModelMobile.git
``` 

then enter the following command to open the VModelMobile folder in the terminal

```
cd ./VModelMobile
```

then please make sure flutter is installed and 
enter the following command to build the application in release mode

```
flutter build apk --split-per-abi  lib/main.dart
```

or enter the following command to run your application in debug mode with the available device

```
flutter run lib/main.dart
```


### File Structure
- [Core](../Docs/FlutterApp/Core/CoreDoc.md)
    - [cache](../Docs/FlutterApp/Core/CoreDoc/Cache.md)
    - [network](../Docs/FlutterApp/Core/CoreDoc/Network.md)
    - [routing](../Docs/FlutterApp/Core/CoreDoc/Routing.md)
    - [utils](../Docs/FlutterApp/Core/CoreDoc/Utilities.md)
- Features
    - authentication
    - archived
    - booking
    - create contract
    - create post
    - dashboard
    - earning
    - help support
    - jobs
    - media option
    - messages
    - notification
    - onboarding
    - reviews
    - saved
    - notification
- Shared
    - common widgets
    - animation
    - booking

