import 'dart:async';
import 'package:angular/angular.dart';
import 'package:firebase_dart_ui/firebase_dart_ui.dart';
import 'package:firebase/firebase.dart' as fb;

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

  // Example SignInSuccess callback handler
  void signInSuccess(fb.User currentUser, AuthCredential credential, redirectUrl) {
    print("sigin in success $currentUser $credential $redirectUrl");
    print("user display name = ${currentUser.displayName}");
    // The credential returned here is that of the provider (e.g. google)
    // and is NOT the firebase credential.
    // If the user is already authenticated at firebase, the credential
    // may not be set when the page is loaded.  If you want to access the
    // credential (for example, to make API calls directly with the provider)
    // You may have to force the user to login. That will cause the user to
    // be redirected to the provider, and the access token / id token will be
    // set.
    if( credential != null) {
      print(
        """
        provider: ${credential.providerId} 
        access token:  ${credential.accessToken}
        idToken: ${credential.idToken}""");

        providerAccessToken = credential.accessToken;
    }
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


      // You can provide callbacks for signIn, etc.
      // You may not need these unless you want to capture the access token
      // or id token that a provider returns. It may be sufficient
      // to test for the firebase current user being non null.
      var callbacks = new Callbacks(
          uiShown: allowInterop(() => print("UI shown callback")),
          signInSuccess: allowInterop( signInSuccess ),
          signInFailure: allowInterop(() => print("Sigin in failure")));

      _uiConfig = new UIConfig(
          signInSuccessUrl: '/',
          signInOptions: [
            googleOptions,
            fb.EmailAuthProvider.PROVIDER_ID,
            //fb.GithubAuthProvider.PROVIDER_ID
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

  bootstrapStatic(
      MyApp,
      [
        //const Provider(APP_BASE_HREF, useValue: '/'),
        //new Provider(Window, useValue: window),
      ],
      ng.initReflector);
}
