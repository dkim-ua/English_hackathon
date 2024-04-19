// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:english_hakaton/pages/authDirectory/login_page.dart' as _i3;
import 'package:english_hakaton/pages/authDirectory/register_page.dart' as _i5;
import 'package:english_hakaton/pages/authDirectory/start_page.dart' as _i6;
import 'package:english_hakaton/pages/general/chat/chat_page.dart' as _i1;
import 'package:english_hakaton/pages/general/general_page.dart' as _i2;
import 'package:english_hakaton/pages/general/chat/person_of_chat_page.dart' as _i4;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ChatPage(
          subtitle: args.subtitle,
          chatType: args.chatType,
        ),
      );
    },
    GeneralRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.GeneralPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    PersonOfChat.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PersonOfChat(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RegisterPage(),
      );
    },
    StartRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.StartPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ChatPage]
class ChatRoute extends _i7.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required dynamic subtitle,
    required dynamic chatType,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            subtitle: subtitle,
            chatType: chatType,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i7.PageInfo<ChatRouteArgs> page =
      _i7.PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    required this.subtitle,
    required this.chatType,
  });

  final dynamic subtitle;

  final dynamic chatType;

  @override
  String toString() {
    return 'ChatRouteArgs{subtitle: $subtitle, chatType: $chatType}';
  }
}

/// generated route for
/// [_i2.GeneralPage]
class GeneralRoute extends _i7.PageRouteInfo<void> {
  const GeneralRoute({List<_i7.PageRouteInfo>? children})
      : super(
          GeneralRoute.name,
          initialChildren: children,
        );

  static const String name = 'GeneralRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PersonOfChat]
class PersonOfChat extends _i7.PageRouteInfo<void> {
  const PersonOfChat({List<_i7.PageRouteInfo>? children})
      : super(
          PersonOfChat.name,
          initialChildren: children,
        );

  static const String name = 'PersonOfChat';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RegisterPage]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.StartPage]
class StartRoute extends _i7.PageRouteInfo<void> {
  const StartRoute({List<_i7.PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
