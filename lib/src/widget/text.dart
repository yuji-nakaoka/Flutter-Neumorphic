import 'dart:ui' as ui show FontFeature;

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/src/decoration/neumorphic_text_decorations.dart';

import '../../flutter_neumorphic.dart';
import '../theme/neumorphic_theme.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

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
    //  Color? color,
    //  Color? backgroundColor,
    // Paint? foreground,
    //  Paint? background,
    //  Color? decorationColor,
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
          //  color: color,
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

  NeumorphicText(
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
    final NeumorphicStyle style = (this.style ?? NeumorphicStyle())
        .copyWithThemeIfNull(theme)
        .applyDisableDepth();

    return _NeumorphicText(
      textStyle: (this.textStyle ?? NeumorphicTextStyle()),
      textAlign: this.textAlign,
      text: this.text,
      duration: this.duration,
      style: style,
      curve: this.curve,
    );
  }
}

class _NeumorphicText extends material.StatefulWidget {
  final String text;
  final NeumorphicStyle style;
  final TextStyle textStyle;
  final Duration duration;
  final Curve curve;
  final TextAlign textAlign;

  _NeumorphicText({
    Key? key,
    required this.duration,
    required this.curve,
    required this.textAlign,
    required this.style,
    required this.textStyle,
    required this.text,
  }) : super(key: key);

  @override
  __NeumorphicTextState createState() => __NeumorphicTextState();
}

class __NeumorphicTextState extends material.State<_NeumorphicText> {
  @override
  Widget build(BuildContext context) {
    final TextPainter _textPainter = TextPainter(
        textDirection: TextDirection.ltr, textAlign: this.widget.textAlign);
    final textStyle = this.widget.textStyle;
    _textPainter.text = TextSpan(
      text: this.widget.text,
      style: this.widget.textStyle,
    );

    return LayoutBuilder(builder: (context, constraints) {
      _textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);
      final double width = _textPainter.width;
      final double height = _textPainter.height;

      return DefaultTextStyle(
        style: textStyle,
        child: AnimatedContainer(
          duration: this.widget.duration,
          curve: this.widget.curve,
          foregroundDecoration: NeumorphicTextDecoration(
            isForeground: true,
            textStyle: textStyle,
            textAlign: widget.textAlign,
            renderingByPath: true,
            style: this.widget.style,
            text: this.widget.text,
          ),
          child: SizedBox(
            width: width,
            height: height,
          ),
        ),
      );
    });
  }
}
