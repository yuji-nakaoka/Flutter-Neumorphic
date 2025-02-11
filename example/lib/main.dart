import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'main_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: const Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: const Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NeumorphicFloatingActionButton(
        child: const Icon(Icons.add, size: 30),
        onPressed: () {},
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NeumorphicButton(
              onPressed: () {
                print("onClick");
              },
              style: const NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.favorite_border,
                color: _iconsColor(context),
              ),
            ),
            NeumorphicButton(
              margin: const EdgeInsets.only(top: 12),
              onPressed: () {
                final theme = NeumorphicTheme.of(context);
                if (theme != null) {
                  theme.themeMode =
                      theme.isUsingDark ? ThemeMode.light : ThemeMode.dark;
                }
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Toggle Theme",
                style: TextStyle(color: _textColor(context)),
              ),
            ),
            NeumorphicButton(
              margin: const EdgeInsets.only(top: 12),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return FullSampleHomePage();
                }));
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Go to full sample",
                style: TextStyle(color: _textColor(context)),
              ),
            ),
            NeumorphicText(
              "Use Text Theme",
              textStyle: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Color? _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme?.isUsingDark ?? false) {
      return theme?.current?.accentColor;
    }
    return null;
  }

  Color _textColor(BuildContext context) {
    return NeumorphicTheme.isUsingDark(context) ? Colors.white : Colors.black;
  }
}
