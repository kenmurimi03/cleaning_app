import 'package:cleansafi/cleaner_dialog.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/service_one.dart';
import 'package:cleansafi/service_three.dart';
import 'package:cleansafi/service_two.dart';
import 'package:cleansafi/you_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.currentIndex});

  final int? currentIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  void filterForm() {}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndexNotifier,
      builder: (context, currentIndex, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            shadowColor: AppTheme.kSecondaryGreyColor,
            backgroundColor: AppTheme.kBackgroundColor,
            surfaceTintColor: AppTheme.kBackgroundColor,
            elevation: 3,
            leadingWidth: 20,
            automaticallyImplyLeading: false,
            title: Image.asset(
              'assets/cleansafi.png',
              height: 90,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: SizedBox(
                  width: 120,
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
                            child: CleanerDialog(),
                          );
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Be a cleaner',
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
              ),
            ],
          ),
          body: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              canvasColor: AppTheme.kBackgroundColor,
              appBarTheme: const AppBarTheme(
                color: AppTheme.kAppBarThemeColor,
              ),
              colorScheme: ColorScheme.fromSwatch(
                accentColor: AppTheme.kAppBarThemeColor,
              ),
            ),
            home: ListView(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/clean1.0.png',
                      height: 140,
                    ),
                    const Text(
                      '''This includes general indoor cleaning without laundry included''',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kAccent10GreyColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Helvetica Neue',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
                            MaterialPageRoute(
                                builder: (context) => ServicesPage()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Book Now',
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
                    Image.asset(
                      'assets/clean2.0.png',
                      height: 140,
                    ),
                    const Text(
                      '''This includes laundry and ironing done on the premises''',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kAccent10GreyColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Helvetica Neue',
                        decoration: TextDecoration.none,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicestwoPage()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Book Now',
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
                    Image.asset(
                      'assets/clean3.0.png',
                      height: 140,
                    ),
                    const Text(
                      '''This includes general outdoor garden and lawns maintenance''',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kAccent10GreyColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Helvetica Neue',
                        decoration: TextDecoration.none,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesthreePage()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Book Now',
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
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: currentIndexNotifier,
            builder: (context, currentIndex, _) {
              return BottomNavigationBar(
                selectedIconTheme: const IconThemeData(
                  color: AppTheme.kBlackColor,
                ),
                selectedItemColor: Colors.black,
                backgroundColor: AppTheme.kBackgroundColor,
                currentIndex: currentIndex,
                unselectedLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Helvetica Neue',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
                selectedLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Helvetica Neue',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
                onTap: (int index) {
                  currentIndexNotifier.value = index;
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            currentIndex == 0
                                ? 'assets/active_home_tab_icon.svg'
                                : 'assets/inactive_home_tab_icon.svg',
                          ),
                        ),
                      ),
                    ),
                    label: 'home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: SizedBox.shrink(),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => YouPage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            currentIndex == 3
                                ? 'assets/active_you_tab_icon.svg'
                                : 'assets/inactive_you_tab_icon.svg',
                          ),
                        ),
                      ),
                    ),
                    label: 'you',
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
