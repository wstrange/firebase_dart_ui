import 'dart:async';
import 'package:angular/angular.dart';
import 'package:firebase_dart_ui/firebase_dart_ui.dart';
import 'package:firebase/firebase.dart' as fb;

import 'package:firebase/src/interop/es6_interop.dart';

import 'package:js/js.dart';

import 'dart:js';

// ignore: uri_has_not_been_generated
import 'main.template.dart' as ng;

@Component(
  selector: 'my-app',
  template: '''

  <div *ngIf="!isAuthenticated()">
        <p>Login</p>
    </div>

    <firebase-auth-ui [disableAutoSignIn]="true" [uiConfig]="getUIConfig()"></firebase-auth-ui>

    <br/>
    <div *ngIf="isAuthenticated()">
      Authenticated!
      <p>User email: {{userEmail}}  Display Name: {{displayName}}</p>
      <p>User Json: {{userJson}}</p>
      <p>Provider Access Token
      (may not be present unless session is new) : {{providerAccessToken}}</p>
      <button (click)="logout()">Logout</button>
    </div>


''',
  directives: const [NgIf, FirebaseAuthUIComponent],
  providers: const [],
)
class MyApp {
  UIConfig _uiConfig;

  Future<Null> logout() async {
    await fb.auth().signOut();
    providerAccessToken = "";
  }

  // todo: We need to create a nicer wrapper for the sign in callbacks.
  PromiseJsImpl<void> signInFailure(AuthUIError authUiError) {
    // nothing to do;
    return new PromiseJsImpl<void>(() => print("SignIn Failure"));
  }

  // Example SignInSuccess callback handler
  bool signInSuccess(fb.UserCredential authResult, String redirectUrl) {
    print(
        "sign in  success. ProviderID =  ${authResult.credential.providerId}");
    print("Info= ${authResult.additionalUserInfo}");

    // returning false gets rid of the double page load (no need to redirect to /)
    return false;
  }

  /// Your Application must provide the UI configuration for the
  /// AuthUi widget. This is where you configure the providers and options.
  UIConfig getUIConfig() {
    if (_uiConfig == null) {
      var googleOptions = new CustomSignInOptions(
          provider: fb.GoogleAuthProvider.PROVIDER_ID,
          scopes: ['email', 'https://www.googleapis.com/auth/plus.login'],
          customParameters:
              new GoogleCustomParameters(prompt: 'select_account'));

      var gitHub = new CustomSignInOptions(
          provider: fb.GithubAuthProvider.PROVIDER_ID,
          // sample below of asking for additional scopes.
          // See https://developer.github.com/apps/building-oauth-apps/scopes-for-oauth-apps/
          scopes: [/*'repo', 'gist' */]);

      var callbacks = new Callbacks(
          uiShown: allowInterop(() => print("UI shown callback")),
          signInSuccessWithAuthResult: allowInterop(signInSuccess),
          signInFailure: allowInterop(signInFailure));

      _uiConfig = new UIConfig(
          signInSuccessUrl: '/',
          signInOptions: [
            googleOptions,
            fb.EmailAuthProvider.PROVIDER_ID,
            gitHub
          ],
          signInFlow: "redirect",
          //signInFlow: "popup",
          credentialHelper: ACCOUNT_CHOOSER,
          tosUrl: '/tos.html',
          callbacks: callbacks);
    }
    return _uiConfig;
  }

  bool isAuthenticated() => fb.auth().currentUser != null;
  String get userEmail => fb.auth().currentUser?.email;
  String get displayName => fb.auth().currentUser?.displayName;
  Map<String, dynamic> get userJson => fb.auth().currentUser?.toJson();

  // If the provider gave us an access token, we put it here.
  String providerAccessToken = "";
}

void main() {
  fb.initializeApp(
    apiKey: "AIzaSyDPrD6QfOfRutNAUBqC0sJs51kaUia3xzg",
    authDomain: "dart-ui-demo.firebaseapp.com",
    databaseURL: "https://dart-ui-demo.firebaseio.com",
    storageBucket: "dart-ui-demo.appspot.com",
  );
  runApp(ng.MyAppNgFactory);
}
