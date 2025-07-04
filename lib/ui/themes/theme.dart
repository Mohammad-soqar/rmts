import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xFF2A638B),
      surfaceTint: Color(0xff2a638b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffcce5ff),
      onPrimaryContainer: Color(0xff001e31),
      secondary: Color(0xff4d5c92),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdce1ff),
      onSecondaryContainer: Color(0xff03174b),
      tertiary: Color(0xff485d92),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdae2ff),
      onTertiaryContainer: Color(0xff001946),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff7f9ff),
      onBackground: Color(0xff181c20),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      surfaceVariant: Color(0xffdee3ea),
      onSurfaceVariant: Color(0xff42474e),
      outline: Color(0xff72787e),
      outlineVariant: Color(0xffc2c7ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inverseOnSurface: Color(0xffeef1f6),
      inversePrimary: Color(0xff98ccf9),
      primaryFixed: Color(0xffcce5ff),
      onPrimaryFixed: Color(0xff001e31),
      primaryFixedDim: Color(0xff98ccf9),
      onPrimaryFixedVariant: Color(0xff044b71),
      secondaryFixed: Color(0xffdce1ff),
      onSecondaryFixed: Color(0xff03174b),
      secondaryFixedDim: Color(0xffb6c4ff),
      onSecondaryFixedVariant: Color(0xff344479),
      tertiaryFixed: Color(0xffdae2ff),
      onTertiaryFixed: Color(0xff001946),
      tertiaryFixedDim: Color(0xffb1c5ff),
      onTertiaryFixedVariant: Color(0xff2f4578),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e3e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00476c),
      surfaceTint: Color(0xff2a638b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4479a2),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff304074),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6372aa),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2b4174),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5e73a9),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7f9ff),
      onBackground: Color(0xff181c20),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      surfaceVariant: Color(0xffdee3ea),
      onSurfaceVariant: Color(0xff3e434a),
      outline: Color(0xff5a6066),
      outlineVariant: Color(0xff767b82),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inverseOnSurface: Color(0xffeef1f6),
      inversePrimary: Color(0xff98ccf9),
      primaryFixed: Color(0xff4479a2),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff276088),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6372aa),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4a598f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5e73a9),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff455b8f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e3e8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00253b),
      surfaceTint: Color(0xff2a638b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00476c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0c1e52),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff304074),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff031f51),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2b4174),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7f9ff),
      onBackground: Color(0xff181c20),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdee3ea),
      onSurfaceVariant: Color(0xff1f252a),
      outline: Color(0xff3e434a),
      outlineVariant: Color(0xff3e434a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffdeeeff),
      primaryFixed: Color(0xff00476c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00304b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff304074),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff19295d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2b4174),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff122a5c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e3e8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff98ccf9),
      surfaceTint: Color(0xff98ccf9),
      onPrimary: Color(0xff003350),
      primaryContainer: Color(0xff044b71),
      onPrimaryContainer: Color(0xffcce5ff),
      secondary: Color(0xffb6c4ff),
      onSecondary: Color(0xff1d2d61),
      secondaryContainer: Color(0xff344479),
      onSecondaryContainer: Color(0xffdce1ff),
      tertiary: Color(0xffb1c5ff),
      onTertiary: Color(0xff162e60),
      tertiaryContainer: Color(0xff2f4578),
      onTertiaryContainer: Color(0xffdae2ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff101418),
      onBackground: Color(0xffe0e3e8),
      surface: Color(0xff101418),
      onSurface: Color(0xffe0e3e8),
      surfaceVariant: Color(0xff42474e),
      onSurfaceVariant: Color(0xffc2c7ce),
      outline: Color(0xff8c9198),
      outlineVariant: Color(0xff42474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e8),
      inverseOnSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff2a638b),
      primaryFixed: Color(0xffcce5ff),
      onPrimaryFixed: Color(0xff001e31),
      primaryFixedDim: Color(0xff98ccf9),
      onPrimaryFixedVariant: Color(0xff044b71),
      secondaryFixed: Color(0xffdce1ff),
      onSecondaryFixed: Color(0xff03174b),
      secondaryFixedDim: Color(0xffb6c4ff),
      onSecondaryFixedVariant: Color(0xff344479),
      tertiaryFixed: Color(0xffdae2ff),
      onTertiaryFixed: Color(0xff001946),
      tertiaryFixedDim: Color(0xffb1c5ff),
      onTertiaryFixedVariant: Color(0xff2f4578),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff363a3e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff272a2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9cd0fd),
      surfaceTint: Color(0xff98ccf9),
      onPrimary: Color(0xff001829),
      primaryContainer: Color(0xff6296c0),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbcc9ff),
      onSecondary: Color(0xff001143),
      secondaryContainer: Color(0xff7f8ec8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb7caff),
      onTertiary: Color(0xff00143b),
      tertiaryContainer: Color(0xff7a90c8),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101418),
      onBackground: Color(0xffe0e3e8),
      surface: Color(0xff101418),
      onSurface: Color(0xfff9fbff),
      surfaceVariant: Color(0xff42474e),
      onSurfaceVariant: Color(0xffc6cbd3),
      outline: Color(0xff9ea3aa),
      outlineVariant: Color(0xff7e848a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e8),
      inverseOnSurface: Color(0xff272a2e),
      inversePrimary: Color(0xff064c73),
      primaryFixed: Color(0xffcce5ff),
      onPrimaryFixed: Color(0xff001321),
      primaryFixedDim: Color(0xff98ccf9),
      onPrimaryFixedVariant: Color(0xff003959),
      secondaryFixed: Color(0xffdce1ff),
      onSecondaryFixed: Color(0xff000d37),
      secondaryFixedDim: Color(0xffb6c4ff),
      onSecondaryFixedVariant: Color(0xff233367),
      tertiaryFixed: Color(0xffdae2ff),
      onTertiaryFixed: Color(0xff000f31),
      tertiaryFixedDim: Color(0xffb1c5ff),
      onTertiaryFixedVariant: Color(0xff1d3466),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff363a3e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff272a2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff9fbff),
      surfaceTint: Color(0xff98ccf9),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9cd0fd),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffcfaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbcc9ff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffcfaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb7caff),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101418),
      onBackground: Color(0xffe0e3e8),
      surface: Color(0xff101418),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff42474e),
      onSurfaceVariant: Color(0xfff9fbff),
      outline: Color(0xffc6cbd3),
      outlineVariant: Color(0xffc6cbd3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e8),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002d47),
      primaryFixed: Color(0xffd4e9ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff9cd0fd),
      onPrimaryFixedVariant: Color(0xff001829),
      secondaryFixed: Color(0xffe2e5ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbcc9ff),
      onSecondaryFixedVariant: Color(0xff001143),
      tertiaryFixed: Color(0xffe0e6ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb7caff),
      onTertiaryFixedVariant: Color(0xff00143b),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff363a3e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff272a2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
