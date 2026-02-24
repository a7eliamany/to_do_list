import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/cubit/Theme/theme_cupit.dart';
import 'package:todo_list/cubit/Theme/theme_state.dart';
import 'package:todo_list/cubit/bottom_navigator/bottom_navigator_cubit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/services/local_storage.dart';
import 'package:todo_list/views/deleted_task_page.dart';
import 'package:todo_list/views/home/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/notification/notification_controller.dart';
import 'package:todo_list/pages.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await AwesomeNotifications().requestPermissionToSendNotifications();
  await AwesomeNotifications().initialize(
    null,
    TaskCategoryConfig.notificationChannel,
  );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCupit()),
        BlocProvider(create: (context) => BottomNavigatorCubit()),
        BlocProvider(create: (context) => ThemeCupit()),
      ],
      child: BlocBuilder<ThemeCupit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: MyApp.navigatorKey,
            routes: {
              "home": (context) => Home(),
              "DeletedTasksPage": (context) => DeletedTasksPage(),
            },
            theme: state.darkMode ? ThemeData.dark() : ThemeData.light(),
            title: 'ToDoApp',
            home: Scaffold(body: Pages()),

            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
