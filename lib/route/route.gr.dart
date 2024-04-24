// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:english_hakaton/pages/authDirectory/login_page.dart' as _i4;
import 'package:english_hakaton/pages/authDirectory/register_page.dart' as _i6;
import 'package:english_hakaton/pages/authDirectory/start_page.dart' as _i8;
import 'package:english_hakaton/pages/authDirectory/voise_assistant_bool.dart'
    as _i10;
import 'package:english_hakaton/pages/general/chat/chat_page.dart' as _i2;
import 'package:english_hakaton/pages/general/chat/person_of_chat_page.dart'
    as _i5;
import 'package:english_hakaton/pages/general/general_page.dart' as _i3;
import 'package:english_hakaton/pages/general/profile/settings_page/account_settings_page/account_settings_page.dart'
    as _i1;
import 'package:english_hakaton/pages/general/profile/settings_page/settings_page.dart'
    as _i7;
import 'package:english_hakaton/pages/general/training/training_page.dart'
    as _i9;
import 'package:flutter/material.dart' as _i12;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AccountSettingsRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AccountSettingsPage(),
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ChatPage(
          key: args.key,
          subtitle: args.subtitle,
          chatType: args.chatType,
        ),
      );
    },
    GeneralRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GeneralPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    PersonOfChatRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PersonOfChatPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsPage(),
      );
    },
    StartRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.StartPage(),
      );
    },
    TrainingRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.TrainingPage(),
      );
    },
    VoiceAssistantRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.VoiceAssistantPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AccountSettingsPage]
class AccountSettingsRoute extends _i11.PageRouteInfo<void> {
  const AccountSettingsRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AccountSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountSettingsRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatPage]
class ChatRoute extends _i11.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i12.Key? key,
    required String subtitle,
    required String chatType,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            subtitle: subtitle,
            chatType: chatType,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i11.PageInfo<ChatRouteArgs> page =
      _i11.PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.subtitle,
    required this.chatType,
  });

  final _i12.Key? key;

  final String subtitle;

  final String chatType;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, subtitle: $subtitle, chatType: $chatType}';
  }
}

/// generated route for
/// [_i3.GeneralPage]
class GeneralRoute extends _i11.PageRouteInfo<void> {
  const GeneralRoute({List<_i11.PageRouteInfo>? children})
      : super(
          GeneralRoute.name,
          initialChildren: children,
        );

  static const String name = 'GeneralRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PersonOfChatPage]
class PersonOfChatRoute extends _i11.PageRouteInfo<void> {
  const PersonOfChatRoute({List<_i11.PageRouteInfo>? children})
      : super(
          PersonOfChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'PersonOfChatRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.StartPage]
class StartRoute extends _i11.PageRouteInfo<void> {
  const StartRoute({List<_i11.PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.TrainingPage]
class TrainingRoute extends _i11.PageRouteInfo<void> {
  const TrainingRoute({List<_i11.PageRouteInfo>? children})
      : super(
          TrainingRoute.name,
          initialChildren: children,
        );

  static const String name = 'TrainingRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.VoiceAssistantPage]
class VoiceAssistantRoute extends _i11.PageRouteInfo<void> {
  const VoiceAssistantRoute({List<_i11.PageRouteInfo>? children})
      : super(
          VoiceAssistantRoute.name,
          initialChildren: children,
        );

  static const String name = 'VoiceAssistantRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
