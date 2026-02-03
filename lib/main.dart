import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/cubit/bottom_navigator_cubit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/home/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/notification/notification_controller.dart';
import 'package:todo_list/packages/salomon_bottom_bar.dart';
import 'package:todo_list/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().initialize(null, notificationChannel);
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
      ],
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        routes: {"home": (context) => Home()},
        theme: ThemeData.dark(),
        title: 'ToDoApp',
        home: Scaffold(
          body: BlocBuilder<BottomNavigatorCubit, BottomNavigatorState>(
            builder: (context, state) {
              if (state.index == 0) {
                return Home();
              } else {
                return const MyCleneder();
              }
            },
          ),
          bottomNavigationBar: MySalomonBottomBar(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
