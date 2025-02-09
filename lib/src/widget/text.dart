import 'dart:ui' as ui show FontFeature;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic/src/decoration/neumorphic_text_decorations.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

import 'dart:ui' as ui;

class NeumorphicTextStyle extends TextStyle {
  const NeumorphicTextStyle({
    bool inherit = true,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    List<ui.FontFeature>? fontFeatures,
    TextDecoration? decoration,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    // Color? color,
    // Color? backgroundColor,
    // Paint? foreground,
    // Paint? background,
    // Color? decorationColor,
    // TextDecorationStyle? decorationStyle,
    //double? decorationThickness,
    List<Shadow>? shadows,
    List<ui.FontVariation>? fontVariations,
    TextOverflow? overflow,
    TextLeadingDistribution? leadingDistribution,
  }) : super(
          inherit: inherit,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          locale: locale,
          fontFeatures: fontFeatures,
          decoration: decoration,
          debugLabel: debugLabel,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          package: package,
          // color: color,
          // backgroundColor: backgroundColor,
          // foreground: foreground,
          // background: background,
          // decorationColor: decorationColor,
          // decorationStyle: decorationStyle,
          // decorationThickness: decorationThickness,
          shadows: shadows,
          fontVariations: fontVariations,
          overflow: overflow,
          leadingDistribution: leadingDistribution,
        );

  @override
  NeumorphicTextStyle copyWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    Paint? foreground,
    Paint? background,
    String? debugLabel,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    List<ui.FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    List<ui.FontVariation>? fontVariations,
    FontWeight? fontWeight,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    double? letterSpacing,
    Locale? locale,
    TextOverflow? overflow,
    String? package,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    double? wordSpacing,
  }) {
    return NeumorphicTextStyle(
      inherit: inherit ?? this.inherit,
      // color: color ?? this.color,
      // backgroundColor: backgroundColor ?? this.backgroundColor,
      // foreground: foreground ?? this.foreground,
      // background: background ?? this.background,
      // decorationColor: decorationColor ?? this.decorationColor,
      // decorationStyle: decorationStyle ?? this.decorationStyle,
      // decorationThickness: decorationThickness ?? this.decorationThickness,
      debugLabel: debugLabel ?? this.debugLabel,
      decoration: decoration ?? this.decoration,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      fontVariations: fontVariations ?? this.fontVariations,
      fontWeight: fontWeight ?? this.fontWeight,
      height: height ?? this.height,
      leadingDistribution: leadingDistribution ?? this.leadingDistribution,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      locale: locale ?? this.locale,
      overflow: overflow ?? this.overflow,
      shadows: shadows ?? this.shadows,
      textBaseline: textBaseline ?? this.textBaseline,
      wordSpacing: wordSpacing ?? this.wordSpacing,
    );
  }
}

@immutable
class NeumorphicText extends StatelessWidget {
  final String text;
  final NeumorphicStyle? style;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final Curve curve;
  final Duration duration;

  const NeumorphicText(
    this.text, {
    Key? key,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.style,
    this.textAlign = TextAlign.center,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    final neumorphicStyle = (style ?? NeumorphicStyle())
        .copyWithThemeIfNull(theme)
        .applyDisableDepth();

    return _NeumorphicText(
      textStyle: textStyle ?? const NeumorphicTextStyle(),
      textAlign: textAlign,
      text: text,
      duration: duration,
      style: neumorphicStyle,
      curve: curve,
    );
  }
}

class _NeumorphicText extends StatefulWidget {
  final String text;
  final NeumorphicStyle style;
  final TextStyle textStyle;
  final Duration duration;
  final Curve curve;
  final TextAlign textAlign;

  const _NeumorphicText({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.textAlign,
    required this.style,
    required this.duration,
    required this.curve,
  }) : super(key: key);

  @override
  __NeumorphicTextState createState() => __NeumorphicTextState();
}

class __NeumorphicTextState extends State<_NeumorphicText> {
  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: widget.textAlign,
      text: TextSpan(text: widget.text, style: widget.textStyle),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);
        return DefaultTextStyle(
          style: widget.textStyle,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            foregroundDecoration: NeumorphicTextDecoration(
              isForeground: true,
              textStyle: widget.textStyle,
              textAlign: widget.textAlign,
              renderingByPath: true,
              style: widget.style,
              text: widget.text,
            ),
            child: SizedBox(
              width: textPainter.width,
              height: textPainter.height,
            ),
          ),
        );
      },
    );
  }
}
