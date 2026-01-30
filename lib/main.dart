import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/cubit/bottom_navigator_cubit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/home/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/packages/salomon_bottom_bar.dart';
import 'package:todo_list/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().requestPermissionToSendNotifications();

  await AwesomeNotifications().initialize(null, notificationChannel);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCupit()),
        BlocProvider(create: (context) => BottomNavigatorCubit()),
      ],
      child: MaterialApp(
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
