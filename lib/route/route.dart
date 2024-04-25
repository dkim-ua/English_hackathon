import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/route/route.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: StartRoute.page),
    AutoRoute(page: VoiceAssistantRoute.page, path: '/'),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: GeneralRoute.page),
    AutoRoute(page: PersonOfChatRoute.page),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: AccountSettingsRoute.page),
    AutoRoute(page: WordSetRoute.page),
    AutoRoute(page: TrainingRoute.page)
  ];
}