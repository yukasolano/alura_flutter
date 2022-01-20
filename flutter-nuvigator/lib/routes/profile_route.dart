import 'package:flutter/src/widgets/framework.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/screens/profile_screen.dart';

class ProfileRoute extends NuRoute {
  @override
  String get path => 'profile';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    print('Parâmetro recebido: ${settings.rawParameters['name']}');
    return ProfileScreen(
      onClose: () => nuvigator.pop(
          'Olá, eu sou um retorno de parâmetro! O valor é ${settings.rawParameters['name']}'),
    );
  }
}
