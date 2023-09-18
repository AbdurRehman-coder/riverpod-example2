import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp(),),
  );

}

extension OptionalInfixAddition<T extends num> on T?{
  T? operator +(T? other){
    final shadow = this;
    if(shadow != null){
      return shadow + (other ?? 0) as T;
    }else{
      return null;
    }
  }

}

void test1() {
  final int? int1 = 1;
  final int int2 = 2;
  final result = int1 + int2; // the "+" is a infix operator
  print('result: $result');
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}


class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   test1();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks Riverpod',style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text(date.toIso8601String(),
          //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),
          // Text(date.toIso8601String()),
        ],
      ),
    );
  }
}

