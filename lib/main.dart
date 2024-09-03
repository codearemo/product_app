import 'package:assessment/core/resolvers/app_start_up.dart';
import 'package:assessment/core/resolvers/init_dependencies.dart';
import 'package:assessment/home/ui/screens/home.dart';
import 'package:assessment/modules/products/presentation/bloc/product_module_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();

  await AppSetUp().initStorage(serviceLocator.get());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<ProductModuleBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => child!,
        child: MaterialApp(
          title: 'Stackbuld Products',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AppHome(),
        ),
      ),
    );
  }
}
