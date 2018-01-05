# firebase_dart_ui

WIP!

A dart wrapper for https://github.com/firebase/firebaseui-web.

Enables an application to user Firebase Authentication. 

See the `example/` application for a demo.


# To enable:

Add this to your index.html <head> section:

```html
<script src="https://www.gstatic.com/firebasejs/4.8.0/firebase.js"></script>
<script src="https://cdn.firebase.com/libs/firebaseui/2.5.1/firebaseui.js"></script>
<link type="text/css" rel="stylesheet" href="https://cdn.firebase.com/libs/firebaseui/2.5.1/firebaseui.css" />
```


# Issues
* There is a T._check type error thrown in dart_sdk.js that is logged to the 
console. The example app appears to work anyways. Suggestions welcome on how to fix this!
* The provider implementations need to be fleshed out (phone provider, for example)
* The signInSuccess callback does not get invoked. JS interop issue. Again - suggestions
welcome.

