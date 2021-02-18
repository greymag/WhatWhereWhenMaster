import 'package:flutter/widgets.dart';

/// Конфигурация приложения.
class AppConfig extends InheritedWidget {
  /// Возвращает конфигурацию по контексту.
  static AppConfig of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AppConfig>();
  }

  /// URL remote API.
//  final String apiUrl;

  /// Демонстрационная версия.
  ///
  /// В демонстрационную версию может включаться нерабочий или
  /// незаконченный фукнционал, например верстка экранов.
  final bool isDemo;

  const AppConfig({
    Key key,
    /*@required this.apiUrl, */ @required Widget child,
    this.isDemo = false,
  })  :
        //assert(apiUrl != null),
        assert(isDemo != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
