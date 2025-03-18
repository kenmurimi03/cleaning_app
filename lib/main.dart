import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/connection_test.dart';
import 'package:cleansafi/sign_in.dart';
import 'package:cleansafi/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
  checkFirebase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const GetStartedPage(),
        debugShowCheckedModeBanner: false);
  }
}

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 63),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/cleansafi.png',
                  height: 140,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '''Start to make a cleaning reservation now with professionals who clean right, everytime!.''',
              style: TextStyle(
                color: AppTheme.kBlackColor,
                fontSize: 17,
                fontFamily: 'Graphik',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/getstarted.jpeg',
              height: 140,
              width: double.infinity,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8),
              child: MaterialButton(
                color: AppTheme.pickerColor3,
                minWidth: double.infinity,
                height: 36,
                elevation: 3,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'sign up',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: AppTheme.kBackgroundColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Helvetica Neue',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: MaterialButton(
                color: AppTheme.pickerColor3,
                minWidth: double.infinity,
                height: 36,
                elevation: 3,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        backgroundColor: AppTheme.kBackgroundColor,
                        child: SignInDialog(),
                      );
                    },
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'sign in',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: AppTheme.kBackgroundColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Helvetica Neue',
                  ),
                ),
              ),
            ),

            // PrimaryButton(
            //   onPressed: () =>
            //       GoRouter.of(context).push('${OnspaceRouter.signUp}/0'),
            //   title: 'Sign Up with Email',
            //   isGoogle: false,
            //   disabled: false,
            // ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
