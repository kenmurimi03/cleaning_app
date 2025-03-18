import 'package:firebase_core/firebase_core.dart';

void checkFirebase() async {
  try {
    await Firebase.initializeApp();
    print("🔥 Firebase is connected!");
  } catch (e) {
    print("❌ Firebase initialization failed: $e");
  }
}
