# tiled_test

Steps to reproduce error:

1. Install packages: run `flutter pub get` 
2. Generate assets file: run ` dart run build_runner build`
3. Run app on desktop chrome: `flutter run -d chrome`
4. Test app on desktop chrome: Press the button "load tile map"
5. Wait about 10 seconds (large map loading). Loads the map successfully.
6. Run remote server: `flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0`
7. Connect device and open chrome. Go to `http://<your_computer_ip>:8080`
8. Press the button "load tile map". Wait about 10 seconds (large map loading).
9. Error occurred
