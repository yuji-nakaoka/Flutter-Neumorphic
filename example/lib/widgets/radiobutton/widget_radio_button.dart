import 'package:example/lib/Code.dart';
import 'package:example/lib/ThemeConfigurator.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RadioButtonWidgetPage extends StatefulWidget {
  RadioButtonWidgetPage({Key? key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<RadioButtonWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(
          title: "Radios",
          actions: <Widget>[
            ThemeConfigurator(),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _DefaultWidget(),
              CircleRadios(),
              _EnabledDisabledWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  late int groupValue;

  Widget _buildCode(BuildContext context) {
    return Code("""
int groupValue;

NeumorphicRadio(
    groupValue: groupValue
    value: 1991,
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text("2012"),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          ..._buildNeumorphicRadios(),
        ],
      ),
    );
  }

  List<Widget> _buildNeumorphicRadios() {
    final years = [1991, 2000, 2012];

    return years.map((year) {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: NeumorphicRadio<int>(
          value: year,
          groupValue: groupValue,
          onChanged: (value) =>
              setState(() => groupValue = value ?? groupValue),
          padding: const EdgeInsets.all(8.0),
          child: Text("$year"),
        ),
      );
    }).toList();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class CircleRadios extends StatefulWidget {
  @override
  createState() => _CircleRadiosState();
}

class _CircleRadiosState extends State<CircleRadios> {
  late String groupValue;

  Widget _buildCode(BuildContext context) {
    return Code("""
String groupValue;

NeumorphicRadio(
    groupValue: groupValue
    style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
    value: "A",
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text("A"),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Circle",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          ..._buildNeumorphicRadios(),
        ],
      ),
    );
  }

  List<Widget> _buildNeumorphicRadios() {
    final values = ["A", "B", "C"];

    return values.map((value) {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: NeumorphicRadio<String>(
          style: const NeumorphicRadioStyle(
            boxShape: NeumorphicBoxShape.circle(),
          ),
          groupValue: groupValue,
          value: value,
          onChanged: (val) => setState(() => groupValue = val ?? groupValue),
          padding: const EdgeInsets.all(18.0),
          child: Text(value),
        ),
      );
    }).toList();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _EnabledDisabledWidget extends StatefulWidget {
  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  late int groupValue;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          _buildLabel("Enabled :", context),
          const SizedBox(width: 12),
          _buildNeumorphicRadio(value: 1, label: "First"),
          const SizedBox(width: 24),
          _buildLabel("Disabled :", context),
          const SizedBox(width: 12),
          _buildNeumorphicRadio(value: 2, label: "Second", isEnabled: false),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
    );
  }

  Widget _buildNeumorphicRadio({
    required int value,
    required String label,
    bool isEnabled = true,
  }) {
    return NeumorphicRadio<int>(
      isEnabled: isEnabled,
      groupValue: groupValue,
      value: value,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Text(label),
      onChanged: isEnabled
          ? (val) => setState(() => groupValue = val ?? groupValue)
          : null,
    );
  }

  Widget _buildCode(BuildContext context) {
    return Code("""
int groupValue;

NeumorphicRadio(
     isEnabled: false,
     groupValue: groupValue,
     value: 2,
     onChanged: (value) {
       setState(() {
         isChecked = value;
       });
     },
     child: Text("Second"),
),
""");
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}
