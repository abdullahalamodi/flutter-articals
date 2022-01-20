import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [types of riverpod]

///1 simple [provider]
///ex :  provider with type string return [name] vale

final nameProvider = Provider<String>((ref) => 'Abdullah');

/// 2 [stateProvider]
/// It's provide a state of T type
///  ex : provider with state of type [int]
final ageStateProvider = StateProvider((ref) => 0);

/// 3 [stateNotifierProvider]
/// it's the most commen use and it's used with
/// stateNotifier  [StateNotifier] package
/// it's helpful when you need to acces the state and perform some logic
///  long away from the widget tree.
/// ex : povider with class [Weight] extends stateNotifier
/// declare class Weight
class Weight extends StateNotifier<double> {
  Weight(state) : super(state);

  void makeDiet() {
    //some logic on state
  }
}

/// declare provider with the class type [Weight]
/// and also the state type [double]
final weightStateNotifierProvider =
    StateNotifierProvider<Weight, double>((ref) => Weight(70));

/// [read riverpod]
///  you can read riverpod from [ref] instatnce.
/// so where I can found ref ?
///1 [inside other providers]
/// ex :  myReaderProvider will read all previous providers

final myReaderProvider = Provider((ref) {
  final String name = ref.watch(nameProvider);
  final int ageState = ref.watch(ageStateProvider);
  final double weightState = ref.read(weightStateNotifierProvider);
});

///2 [inside the  widget class statefull or stateless]
///by using ConsumerWidget with stateless widget
///and ConsumerState with state fullwidget
///
///
///ex : ConsumerWidget with statelessWidget
///
class MyClassWidget extends ConsumerWidget {
  const MyClassWidget({Key? key}) : super(key: key);

  @override

  /// using consumer widget will give you [ref] that you loking for :)
  Widget build(BuildContext context, WidgetRef ref) {
    //then you can read your providers
    final double weightState = ref.watch(weightStateNotifierProvider);

    return Container();
  }
}

/// 3 [inside widget]
/// wrapping wigdet with Consumer
/// ex :
class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override

  /// using consumer widget will give you [ref] that you loking for :)
  Widget build(BuildContext context) {
    //then you can read your providers

    return Container(
      child: Consumer(builder: (_, ref, __) {
        // you have ref to read what you need
        final int ageState = ref.watch(ageStateProvider);
        return Text('data');
      }),
    );
  }
}

/// but, what was we read ??? and it could [whtch] and not [read] ??
/// read provider name it's ok to give me String but,
/// stateProvider and SteteNotifierProvider give me also values ??
///
/// at first maybe you get confused but wait we will explain every thing :)
///
/// first, there are to methods we can use them to read the provider
/// and they are [read] and [watch]
///
/// read method can just read the provider
///  and give us what it is provide (int , string, class ,etc)
///
/// but watch method can read the provider and give us more
/// when we use watch we are watching that provider and when its
/// state change it will notify to what whatching it.
///
/// watch also give us the stateController that holds the state
/// of that provider
///
/// [what is the benefits of get the stateContoller ???]
/// ?????? I can't write on that now :(
///
/// for ex : if we used ref.watch inside a widget
/// and when state changes this widget will rebuild
///
/// so here some info about watch and read
/// 1- use watch or read are the same with simple provider
/// 2- to read the provider with out rebuilds use
///  ref.watch(myProvider.notifier) preferred over
///  ref.read(myProvider) .
/// 3 - ref.watch(myProvider.notifier) will return
///  the stateController that stores myProvider state [without rebuild] your widget.
/// 4- ref.watch(myProvider.state) will return
///  the stateController that stores myProvider state and [still rebuild] your widget
/// 5 - using ConsumerWidget with stateless and ConsimerState with Stateful
/// and also Consumer will not rebuild your widget directuly with out
/// using ref.watch(myProvider)

