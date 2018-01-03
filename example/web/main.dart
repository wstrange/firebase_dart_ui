import 'dart:async';
import 'package:angular/angular.dart';
import 'package:firebase_dart_ui/firebase_dart_ui.dart';
import 'package:firebase/firebase.dart' as fb;

// ignore: uri_has_not_been_generated
import 'main.template.dart' as ng;

@Component(
  selector: 'my-app',
  template: '''
  
  <div *ngIf="!isAuthenticated()">
        <p>Login</p>
    </div>
    
    <firebase-auth-ui [uiConfig]="getUIConfig()"></firebase-auth-ui>
    
    <br/>
    <div *ngIf="isAuthenticated()">
      Authenticated!
      <p>User email: {{userEmail}}  Display Name: {{displayName}}</p>
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
      var googParms = new GoogleCustomParameters(prompt: 'select_account');
      var goog = new CustomSignInOptions(provider: fb.GoogleAuthProvider.PROVIDER_ID,
          scopes: ['email', 'https://www.googleapis.com/auth/plus.login'],
          customParameters: googParms);

     _uiConfig = new UIConfig(
          signInSuccessUrl: '/',
          signInOptions: [
            goog,
            fb.EmailAuthProvider.PROVIDER_ID],
          //signInFlow: "redirect",
          signInFlow: "popup",

          tosUrl: '/tos.html');
    }
    return _uiConfig;
  }

  bool isAuthenticated() =>  fb.auth().currentUser != null;
  String  get userEmail => fb.auth().currentUser?.email;
  String  get displayName => fb.auth().currentUser?.displayName;
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
