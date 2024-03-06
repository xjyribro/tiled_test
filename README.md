# tiled_test

Steps to reproduce error:

1. Install packages: run `flutter pub get` 
2. Generate assets file: run ` dart run build_runner build`
3a. Run app on desktop chrome: `flutter run -d chrome`
3b. Test app on desktop chrome: Press the button "load tile map"
3c. Wait about 10 seconds (large map loading). Loads the map successfully.
4a. Run remote server: `flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0`
4b. Connect device and open chrome. Go to `http://<your_computer_ip>:8080`
4c. Press the button "load tile map". Wait about 10 seconds (large map loading).
4d. Error occurred
