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

class Counter extends StateNotifier<int?>{
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state+ 1;
  void reset() => state = null;
  int? get value => state;
}

final counterProvider = StateNotifierProvider<Counter, int?>((ref) => Counter());


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
    print('build...');
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child){
            final count = ref.watch(counterProvider);
            final text = count == null ? 'Press me' : count.toString();
            return Text(text);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            // when we have void func inside another void func we can tear-off that func
              onPressed: ref.read(counterProvider.notifier).increment, // function tear-off
              child: const Text('counter increment'),
          ),
          SizedBox(height: 20,),
          TextButton(
            // when we have void func inside another void func we can tear-off that func
            onPressed: ref.read(counterProvider.notifier).reset, // function tear-off
            child: const Text('reset increment'),
          ),
          const SizedBox(height: 20,),
          Consumer(
            builder: (context, ref, child) {
              final data = ref.watch(checkBoxesProvider);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                  itemBuilder: (context, index){
                  return  CheckboxListTile(
                    title: Text('Checkbox 1'),
                    value: data[index],
                    onChanged: (bool? value) {
                   ref.read(checkBoxesProvider.notifier).updateBoxes(index,);
                    },
                  );
                  },
              );
            }
          )
        ],
      ),
    );
  }
}


/// Update checkboxes through Riverpod

final checkBoxesProvider = StateNotifierProvider<CheckBoxNotifier, List<bool>>((ref) => CheckBoxNotifier());

class CheckBoxNotifier extends StateNotifier<List<bool>>{
  CheckBoxNotifier() : super(List.generate(3, (index) => false));

  void updateBoxes (int? index,){
    state[index!] = !state[index];
    state = [...state];
  }
}