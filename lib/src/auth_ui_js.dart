@JS('firebaseui.auth')
library firebaseui.auth;
import 'package:js/js.dart';

/// See https://github.com/firebase/firebaseui-web

///
@JS('AuthUI')
class AuthUI {
  external AuthUI(Object fb);

  external start(obj,options);

  external disableAutoSignIn();
}

const GOOGLE_YOLO = "googleyolo";
const ACCOUNT_CHOOSER = "accountchooser.com";

@JS()
@anonymous
abstract class FacebookCustomParameters {
  external String get authType;

  external factory FacebookCustomParameters({authType: 'reauthenticate'});
}

@JS()
@anonymous
abstract class GoogleCustomParameters {
  external String get prompt;

  external factory GoogleCustomParameters({prompt: 'select_account'});
}

@JS()
abstract class CustomSignInOptions {
  external String get provider;
  external List<String> get scopes;
  external dynamic get customParameters;
}

@anonymous
@JS()
abstract class UIConfig {
  external  String get signInSuccessUrl;

  external List<String> get signInOptions;

  // Terms of service URL
  external String get tosUrl;

  // redirect or popup
  external String get signInFlow;
  external factory UIConfig({String signInSuccessUrl = "/",
    String credentialHelper = ACCOUNT_CHOOSER,
    List<dynamic> signInOptions,
    String signInFlow = "redirect",
    String tosUrl});
}