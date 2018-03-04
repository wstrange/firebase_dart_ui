import 'package:angular/angular.dart';
import 'auth_ui_js.dart';
import 'package:firebase/firebase.dart' as fb;
/// Component that wrap the Firebase Javascript Auth UI library
@Component(
  selector: 'firebase-auth-ui',
  templateUrl: 'firebase_auth_ui_component.html',
  directives: const [NgIf],
  providers: const [],
)
class FirebaseAuthUIComponent  {
  AuthUI _authUI;
  bool authenticated = false;

  @Input()
  UIConfig uiConfig;

  @Input()
  bool disableAutoSignIn = false;

  FirebaseAuthUIComponent() {
    _auth = fb.auth();
    //print("DEBUG FirebaseAuthUIComponent created auth=$_auth");
    _init(_auth);
  }

  fb.Auth _auth;

  void _init(fb.Auth auth) {
    //print("DEBUG auth= ${auth.app.options.apiKey}  user=${auth.currentUser}");
    // See if there is an existing instance
    var a = getInstance(auth.app.name);

    if (a != null) {
      _authUI = a;
      //print("Debug - ${auth.app.name} options = ${auth.app.options} auth ui = ${_authUI}");
    }
    // otherwise create a new instance.
    if (_authUI == null) {
      _authUI = new AuthUI(auth.jsObject);
    }

    //print("DEBUG auth ui $_authUI uiConfig is ${uiConfig}");

    fb.auth().onAuthStateChanged.listen((user) {
      // print("DEBUG User state changed $user");
      authenticated = false;
      if (user != null) {
        authenticated = true;
        // print("DEBUG Authenticated user = ${user.toJson()}");
      } else {
        _start();
      }
    });
  }


  void _start() {
    // print("Starting the UI");
    if (disableAutoSignIn) _authUI.disableAutoSignIn();
    _authUI.start('#firebaseui-auth-container', uiConfig);
  }

  // If the user is authenticated return 'none' to hide the UI element,
  // otherwise return 'block'
  String displayStyle() {
    //print("Check display = ${fb.auth().currentUser}");
    return fb.auth().currentUser == null ? "block" : "none";
  }

}
