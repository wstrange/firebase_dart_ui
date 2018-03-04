@JS('firebaseui.auth')
library firebaseui.auth;

import 'package:js/js.dart';
import 'package:func/func.dart';
import 'package:firebase/firebase.dart' as fb;

/// Provides JS / Dart interop
/// See https://github.com/firebase/firebaseui-web for the JS API

@JS("AuthUI.getInstance")
external AuthUI getInstance(String appId);

@JS('AuthUI')
class AuthUI {
  external AuthUI(Object fb);
  external start(obj, options);
  external disableAutoSignIn();
  external reset();
}

// Valid values for the credential helper
const GOOGLE_YOLO = "googleyolo"; // Google sign on
const ACCOUNT_CHOOSER = "accountchooser.com";
const NONE = "none";

@JS()
@anonymous
abstract class AuthCredential {
  external String get accessToken;
  external String get providerId;
  external String get idToken;
}

@JS()
@anonymous
abstract class AuthUIError {
  external String get code;
  // currently not mapped. Do we really need it?
  // external dynamic get credential;
}

@JS()
@anonymous
abstract class Callbacks {
  // signInSuccess(currentUser, credential, redirectUrl)
  external void signInSuccess(
      VoidFunc3Opt1<fb.User, AuthCredential, String> sss);

  external void signInFailure(VoidFunc1<AuthUIError> e);

  external uiShown(VoidFunc0 update);

  external factory Callbacks({signInSuccess, signInFailure, uiShown});
}

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
@anonymous
abstract class CustomSignInOptions {
  external String get provider;
  external List<String> get scopes;
  external dynamic get customParameters;

  external factory CustomSignInOptions(
      {provider, scopes: const [], customParameters});
}

@anonymous
@JS()
abstract class UIConfig {
  external Callbacks get callbacks;

  external String get signInSuccessUrl;

  external List<String> get signInOptions;

  // Terms of service URL
  external String get tosUrl;

  // redirect or popup
  external String get signInFlow;
  external factory UIConfig(
      {String signInSuccessUrl,
      String credentialHelper = ACCOUNT_CHOOSER,
      List<dynamic> signInOptions,
      String signInFlow = "redirect",
      String tosUrl,
      callbacks});
}
