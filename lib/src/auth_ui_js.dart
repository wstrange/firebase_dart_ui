@JS('firebaseui.auth')
library firebaseui.auth;

import 'package:js/js.dart';
import 'package:firebase/firebase.dart' as fb;

// The following imports reach into the Firebase Dart implementation
import 'package:firebase/src/interop/auth_interop.dart' show AuthJsImpl;
import 'package:firebase/src/interop/firebase_interop.dart' show PromiseJsImpl;


/// Provides JS / Dart interop
/// See https://github.com/firebase/firebaseui-web for the JS API

@JS("AuthUI.getInstance")
external AuthUI getInstance(String appId);

@JS('AuthUI')
class AuthUI {
  // Important - pass fbAuth as a ".jsObject" without the Dart wrapper
  external AuthUI(AuthJsImpl fbAuth, [String appId]);
  external void start(String element, UIConfig config);
  external void disableAutoSignIn();
  external bool isAutoSignInDisabled();
  external bool isPending();
  external bool isPendingRedirect();

  external PromiseJsImpl delete();
  external void reset();
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

// Convenience definitions of below Callback interfaces
typedef SignInAuthResultSuccess = bool Function(fb.UserCredential authResult, String redirectUrl);
typedef SignInSuccess = bool Function(fb.User currentUser, AuthCredential credential, String redirectUrl);
typedef SignInFailure = PromiseJsImpl<void> Function(AuthUIError error);

@JS()
@anonymous
abstract class Callbacks {
  external SignInAuthResultSuccess get signInSuccessWithAuthResult;
  external SignInSuccess get signInSuccess;
  external SignInFailure get signInFailure;
  external void Function() get uiShown;

  external factory Callbacks({
    SignInAuthResultSuccess signInSuccessWithAuthResult,   // <--new in 2.7.0
    SignInSuccess signInSuccess,           // <--deprecated in 2.7.0
    SignInFailure signInFailure,
    void Function() uiShown
  });
}

@JS()
@anonymous
abstract class CustomParameters {}


@JS()
@anonymous
abstract class FacebookCustomParameters extends CustomParameters {
  external String get authType;

  external factory FacebookCustomParameters({authType: 'reauthenticate'});
}

@JS()
@anonymous
abstract class GoogleCustomParameters extends CustomParameters {
  external String get prompt;

  external factory GoogleCustomParameters({prompt: 'select_account'});
}

@JS()
@anonymous
abstract class EmailCustomParameters extends CustomParameters {
  external bool get requireDisplayName;

  external factory EmailCustomParameters({requireDisplayName: true});
}

@JS()
@anonymous
abstract class CustomSignInOptions {
  external String get provider;
  external List<String> get scopes;
  external dynamic get customParameters;

  external factory CustomSignInOptions(
    {provider, scopes: const [], CustomParameters customParameters});
}

@anonymous
@JS()
abstract class UIConfig {
  external List<dynamic> get signInOptions;
  external Callbacks get callbacks;
  external String get signInSuccessUrl;
  external String get signInFlow;   // redirect or popup
  external String get tosUrl;       // Terms of service URL
  external String get privacyPolicyUrl;       // Privacy Url
  external String get credentialHelper;

  external factory UIConfig({
    List<dynamic> signInOptions,
    Callbacks callbacks,
    String signInSuccessUrl,
    String signInFlow = "redirect",
    String tosUrl,
    String privacyPolicyUrl,
    String credentialHelper = ACCOUNT_CHOOSER,
  });
}
