import 'package:angular/angular.dart';
import 'package:firebase_dart_ui/firebase_dart_ui.dart';
import 'package:firebase/firebase.dart' as fb;

// ignore: uri_has_not_been_generated
import 'main.template.dart' as ng;

@Component(
  selector: 'my-app',
  template: '''
    <firebase-auth-ui [uiConfig]="getUIConfig()"></firebase-auth-ui>
    <br/>
    User email: <p>{{userEmail}}</p>
    <button *ngIf="isAuthenticated()" (click)="logout()">Logout</button>
''',
  directives: const [NgIf,FirebaseAuthUIComponent],
  providers: const [],
)
class MyApp {
  void logout() {
    fb.auth().signOut();
  }

  UIConfig getUIConfig() {
    return new UIConfig(
        signInSuccessUrl: '/',
        signInOptions: [
            fb.GoogleAuthProvider.PROVIDER_ID,
            fb.EmailAuthProvider.PROVIDER_ID],
        signInFlow: "redirect",
        tosUrl: '/tos.html');
  }

  bool isAuthenticated() =>  fb.auth().currentUser != null;

  String  get userEmail => fb.auth().currentUser?.email;
}

void main() {
  fb.initializeApp(
    apiKey: "AIzaSyDnUqmvH4XC5v7G_f49qVcP2_ICWuid0io",
    authDomain: "nextplz-f78ac.firebaseapp.com",
    databaseURL: "https://nextplz-f78ac.firebaseio.com",
    storageBucket: "nextplz-f78ac.appspot.com",
  );


  bootstrapStatic(
      MyApp,
      [
        //const Provider(APP_BASE_HREF, useValue: '/'),
        //new Provider(Window, useValue: window),
      ],
      ng.initReflector);
}
