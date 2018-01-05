# firebase_dart_ui

WIP!

A dart wrapper for https://github.com/firebase/firebaseui-web.

Enables an application to user FirebaseUI Authentication. 

A demo app is [hosted online here](https://dart-ui-demo.firebaseapp.com/)


# Enabling the UI

You must add this to your index.html <head> section:

```html
<script src="https://www.gstatic.com/firebasejs/4.8.0/firebase.js"></script>
<script src="https://cdn.firebase.com/libs/firebaseui/2.5.1/firebaseui.js"></script>
<link type="text/css" rel="stylesheet" href="https://cdn.firebase.com/libs/firebaseui/2.5.1/firebaseui.css" />
```

See the `example/` application.

# Running the demo

With DDC:

```
cd example
pub serve
# open localhost:8080
```

To use your our own firebase project to test, you must edit main.dart and
enter in your project credentials. Also edit example/.firebaserc and enter your project name. 
Build and deploy the example:
 
```
cd example
pub build
firebase deploy
 ```
 

# Issues

* The provider implementations need to be fleshed out (phone provider, for example)
* The signInSuccess callback does not get invoked. JS interop issue. Suggestions
welcome.

