# firebase_dart_ui


A dart wrapper for [FirebaseUI](https://github.com/firebase/firebaseui-web), a Javascript library
that provides sign on flows.  This library provides an Angular Dart wrapper 
around FirebaseUI. 

A demo app is [hosted online here](https://dart-ui-demo.firebaseapp.com/)

The Angular component `<firebase-auth-ui>` handles
 [Firebase Authentication](https://firebase.google.com/docs/auth/) for your application.


The component is visible when the user has not been authenticated. It presents a dialog with
 the various social login and email providers that have been configured. Once the user
has authenticated, the components display attribute is set to `none`.  Embed this component
on your landing page for your SPA application.


# Important

You must add these lines to your index.html `<head>` section:

```html
<script src="https://www.gstatic.com/firebasejs/4.8.1/firebase.js"></script>
<script src="https://cdn.firebase.com/libs/firebaseui/2.5.1/firebaseui.js"></script>
<link type="text/css" rel="stylesheet" href="https://cdn.firebase.com/libs/firebaseui/2.5.1/firebaseui.css" />
```

See the [example/](https://github.com/wstrange/firebase_dart_ui/tree/master/example) application.

# Running the demo

With DDC:

```
cd example
pub serve
# open localhost:8080
```

To use your our own Firebase project to test, you must edit main.dart and
enter in your project credentials. Also edit example/.firebaserc and enter your project name. 

Build and deploy the example:
 
```
cd example
pub build
firebase deploy
 ```
 

# Known Issues

* The provider implementations need to be fleshed out (phone provider, for example)
* The signInSuccess callback does not get invoked. JS interop issue. Suggestions
welcome.
