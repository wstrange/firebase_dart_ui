@JS('firebaseui.auth')
library firebaseui.auth;
import 'package:js/js.dart';
import 'package:func/func.dart';


/// See https://github.com/firebase/firebaseui-web

///
@JS('AuthUI')
class AuthUI {
  external AuthUI(Object fb);

  external start(obj,options);

  external disableAutoSignIn();
}

// Valid values for the credential helper
const GOOGLE_YOLO = "googleyolo"; // Google sign on
const ACCOUNT_CHOOSER = "accountchooser.com";
const NONE = "none";


@JS()
@anonymous
abstract class Callbacks {
  external signInSuccess(Func3<dynamic,dynamic,String,dynamic> signInSuccess);
  external uiShown(VoidFunc0 update);

  external factory Callbacks({uiShown, signInSuccess});
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

  external factory CustomSignInOptions({provider, scopes: const [], customParameters });
}

@anonymous
@JS()
abstract class UIConfig {
  external Callbacks get callbacks;

  external  String get signInSuccessUrl;

  external List<String> get signInOptions;

  // Terms of service URL
  external String get tosUrl;

  // redirect or popup
  external String get signInFlow;
  external factory UIConfig({String signInSuccessUrl,
    String credentialHelper = ACCOUNT_CHOOSER,
    List<dynamic> signInOptions,
    String signInFlow = "redirect",
    String tosUrl,
    callbacks
  });
}