# firebase_dart_ui


A dart wrapper for [FirebaseUI](https://github.com/firebase/firebaseui-web), a Javascript library
that provides sign on flows.  This library provides an Angular Dart wrapper 
around FirebaseUI. 

A demonstration application is [hosted online here](https://dart-ui-demo.firebaseapp.com/)

# Usage

The Angular component `<firebase-auth-ui>` handles
 [Firebase Authentication](https://firebase.google.com/docs/auth/) for your application.


Add this component
to your landing page for your SPA application.The component is 
visible on the page (display is `block` ) if the user has not been authenticated. The user is presented a dialog with
 the various social login and email providers that have been configured in your Firebase console. Once the user
has authenticated, the components display attribute is set to `none` making it invisible.


# Important

You must add these lines to your index.html `<head>` section:

```html
<script src="https://www.gstatic.com/firebasejs/x.y.z/firebase.js"></script>
<script src="https://cdn.firebase.com/libs/firebaseui/x.y.z/firebaseui.js"></script>
<link type="text/css" rel="stylesheet" href="https://cdn.firebase.com/libs/firebaseui/x.y.z/firebaseui.css" />
```

The `x.y.z` versions above are replaced with the current supported versions. Please see 
the [example/](https://github.com/wstrange/firebase_dart_ui/tree/master/example) application. 


# Running the demo

With DDC:

```
cd example
pub run build_runner serve
# open localhost:8080
```

To use your our own Firebase project to test, you must edit main.dart and
enter in your project credentials. Also edit example/.firebaserc and enter your project name. 

# To build and deploy the example application
 
```
cd example
pub run builder_runner build  --output build
firebase deploy
 ```
 

# Known Issues

* The provider implementations need to be fleshed out (phone provider, for example)

