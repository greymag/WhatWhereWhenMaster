import 'package:flutter/widgets.dart';

/// Конфигурация приложения.
class AppConfig extends InheritedWidget {
  /// Возвращает конфигурацию по контексту.
  static AppConfig of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AppConfig>()!;
  }

  /// URL remote API.
//  final String apiUrl;

  /// Демонстрационная версия.
  ///
  /// В демонстрационную версию может включаться нерабочий или
  /// незаконченный функционал, например верстка экранов.
  final bool isDemo;

  const AppConfig({
    super.key,
    /*@required this.apiUrl, */ required super.child,
    this.isDemo = false,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
