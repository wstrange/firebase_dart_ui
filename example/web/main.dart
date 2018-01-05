import 'dart:async';
import 'package:angular/angular.dart';
import 'package:firebase_dart_ui/firebase_dart_ui.dart';
import 'package:firebase/firebase.dart' as fb;

import 'package:js/js.dart';

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
      <button (click)="logout()">Logout</button>
    </div>
     
    
''',
  directives: const [NgIf,FirebaseAuthUIComponent],
  providers: const [],
)
class MyApp {

  UIConfig _uiConfig;

  Future<Null> logout() async {
    await fb.auth().signOut();
  }

  
  UIConfig getUIConfig() {
    if(  _uiConfig == null ) {
      var goog = new CustomSignInOptions(provider: fb.GoogleAuthProvider.PROVIDER_ID,
          scopes: ['email', 'https://www.googleapis.com/auth/plus.login'],
          customParameters:  new GoogleCustomParameters(prompt: 'select_account')
      );

      // The signInSuccess callback is not working...
      var callbacks =  new Callbacks(
          uiShown: allowInterop( () => print("UI shown!!"))
          //signInSuccess: allowInterop( (a,b,c) => print("siginin called"))
    );

     _uiConfig = new UIConfig(
          signInSuccessUrl: '/',
          signInOptions: [
            goog,
            fb.EmailAuthProvider.PROVIDER_ID,
            fb.GithubAuthProvider.PROVIDER_ID],
          signInFlow: "redirect",
          //signInFlow: "popup",
          credentialHelper: GOOGLE_YOLO,
          tosUrl: '/tos.html',
          callbacks: callbacks
      );
    }
    return _uiConfig;
  }

  bool isAuthenticated() =>  fb.auth().currentUser != null;
  String  get userEmail => fb.auth().currentUser?.email;
  String  get displayName => fb.auth().currentUser?.displayName;
  Map<String,dynamic>  get userJson => fb.auth().currentUser?.toJson();
}

void main() {
  var app = fb.initializeApp(
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
