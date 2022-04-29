import 'dart:async'; // new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:flutter/material.dart';
import 'package:hyper_garage_sale/activity/NewPostActivity.dart';
import 'package:hyper_garage_sale/activity/PostDetailActivity.dart';
import 'package:hyper_garage_sale/utility/authentication.dart';
import 'package:hyper_garage_sale/utility/widgets.dart';
import 'package:provider/provider.dart'; // new

import 'activity/BrowsePostsActivity.dart';
import 'activity/ImageDisplayActivity.dart';
import 'utility/firebase_options.dart'; // new

// entrance for the whole project
void main() {
  // Integrate Authentication
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of project
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hyper Garage Sale',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const ItemDisplayPage(),
        home: const HomePage(),
        initialRoute: '/',
        routes: {
          '/viewItemList': (context) => const ItemDisplayPage(),
          '/postNewItem': (context) => const PostNewItemPage(),
          '/viewPostDetail': (context) => const PostDetailPage(),
          '/viewFullScreenImage': (context) => const FullScreenImagePage(),
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
      ),
      body: ListView(
        children: <Widget>[
          // Image.asset('assets/codelab.png'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, 'October 30'),
          const IconAndDetail(Icons.location_city, 'San Francisco'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Authentication(
              email: appState.email,
              loginState: appState.loginState,
              startLoginFlow: appState.startLoginFlow,
              verifyEmail: appState.verifyEmail,
              signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              cancelRegistration: appState.cancelRegistration,
              registerAccount: appState.registerAccount,
              signOut: appState.signOut,
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          const Paragraph(
            'Join us for a day full of Firebase Workshops and Pizza!',
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  const Header('Discussion'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/viewItemList',
                          arguments: appState.itemInfoLists);
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
 * ApplicationState class
 */
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<DocumentReference> addInfoToItemView(
      String name, String price, String description, String path) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('storage')
        .add(<String, dynamic>{
      'name': name,
      'price': price,
      'description': description,
      'path': path,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userName': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        // start the subscription from Firebase
        _firebaseItemSubscription = FirebaseFirestore.instance
            .collection('storage')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _itemInfoLists = [];
          for (final document in snapshot.docs) {
            _itemInfoLists.add(
              ItemPostInfo(
                name: document.data()['name'] as String,
                price: document.data()['price'] as String,
                description: document.data()['description'] as String,
                path: document.data()['path'] as String,
              ),
            );
          }
          print('In main');
          print(_itemInfoLists.length);
          print(_itemInfoLists[0].name);
          print(_itemInfoLists[1].name);
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        // end subscription from Firebase
        _itemInfoLists = [];
        _firebaseItemSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  // Set subscription and getter for data in Firebase
  StreamSubscription<QuerySnapshot>? _firebaseItemSubscription;
  List<ItemPostInfo> _itemInfoLists = [];
  List<ItemPostInfo> get itemInfoLists => _itemInfoLists;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
