import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tries/core/app_theme.dart';
import 'package:flutter_tries/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'injection_container.dart' as di ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Posts app',
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Posts"),
          ),
          body: const Center(
            child: Text('Ohayo sekai'),
          ),
        ),
      ),
    );
  }
}
