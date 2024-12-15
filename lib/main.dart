import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_application_1/pages/splash_page.dart';
import 'package:getwidget/getwidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

// void main() {
//   runApp(
//     // MultiProvider(
//     // providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
//     // child: DevicePreview(builder: (context) => const MyApp()),
//     // )
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int initialPage = 0;
  late List<Widget> slideList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Moving MediaQuery.of(context) to didChangeDependencies
    slideList = slides();
  }

  List<Widget> slides() {
    double screenWidth = MediaQuery.of(context).size.width;

    return [
      // Slide 1: Welcome
      GFImageOverlay(
        width: screenWidth,
        padding: const EdgeInsets.all(16),
        color: Colors.orange,
        image: const NetworkImage(
            'https://raw.githubusercontent.com/aqmal101/background-image/234d91159c620bd72e7bacfe43e703f2b4a10ae5/woman-listen-music.jpg'),
        boxFit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        borderRadius: BorderRadius.circular(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70.0, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 31,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'What kind of music you listen to?',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Slide 2: Pop Music
      Container(
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage(
                'https://raw.githubusercontent.com/aqmal101/background-image/refs/heads/main/billie-elish.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pop Music',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enjoy the upbeat rhythms and catchy melodies of the latest pop hits that are sure to lift your spirits.',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
      // Slide 3: Classical & Instrumental Music
      Container(
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage(
                'https://raw.githubusercontent.com/aqmal101/background-image/refs/heads/main/classical.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Classical & Instrumental Music',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Experience tranquility and beauty through classical and instrumental melodies that transport you to a peaceful state of mind.',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
      // Slide 4: Anime, Game, and Lofi Music
      Container(
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage(
                'https://raw.githubusercontent.com/aqmal101/background-image/refs/heads/main/anime.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Anime, Game, and Lofi Music',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter a fantasy world with anime music, enjoy soundtracks from your favorite games, and find serenity in the calming beats of lofi.',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GFIntroScreen(
            color: Colors.transparent,
            slides: slideList,
            currentIndex: initialPage,
            pageController: _pageController,
            pageCount: slideList.length,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.green,
              child: GFIntroScreenBottomNavigationBar(
                doneButton: SizedBox(
                  child: GFButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SplashPage(), // Navigate to SplashPage
                        ),
                      );
                    },
                    text: "GO",
                    textColor: GFColors.DANGER,
                    textStyle: TextStyle(fontSize: 18),
                    color: Colors.white,
                    elevation: 0, // Optional: Remove shadow for a flatter look
                  ),
                ),
                skipButton: SizedBox(
                  child: GFButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SplashPage(), // Navigate to SplashPage
                        ),
                      );
                    },
                    text: "SKIP",
                    textColor: GFColors.DANGER,
                    textStyle: TextStyle(fontSize: 18),
                    color: Colors.white,
                    elevation: 0, // Optional: Remove shadow for a flatter look
                  ),
                ),
                pageController: _pageController,
                pageCount: slideList.length,
                currentIndex: initialPage,
                onForwardButtonTap: () {
                  if (initialPage == slideList.length - 1) {
                    // Navigate to login/register screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyApp(), // Change to your desired screen
                      ),
                    );
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                onBackButtonTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                navigationBarColor: Colors.white,
                showDivider: false,
                inactiveColor: Colors.grey,
                activeColor: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
