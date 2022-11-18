import 'package:architecture/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

void main() {
  BlocFactory.instance.init();
  final ListBloc listBloc = BlocFactory.instance.get<ListBloc>();
  final TemperatureBloc temperatureBloc =
      BlocFactory.instance.get<TemperatureBloc>();
  final app = MultiBlocProvider(
    providers: [
      BlocProvider<ListBloc>(create: (context) => listBloc),
      BlocProvider<TemperatureBloc>(create: (context) => temperatureBloc),
    ],
    child: const MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bloc Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _skaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _sheetController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _skaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<ListBloc, ListState>(
        bloc: BlocProvider.of<ListBloc>(context),
        builder: (context, state) {
          final bloc = BlocProvider.of<ListBloc>(context);
          if (state is ListInitState) {
            bloc.add(const GetItemsEvent(0));

            return const Center(child: CircularProgressIndicator());
          } else if (state is GotDataState) {

            return buildList(state.data, state.currentPage);
          } else if (state is ItemRemovingState) {

            return buildList(state.data, state.currentPage);
          } else if (state is ItemRemovedState) {

            return buildList(state.data, state.currentPage);
          } else {

            return const Text('Unknown list state');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBottomSheet(context);
        },
        tooltip: 'Get Temperature',
        child: const Icon(Icons.question_mark),
      ),
    );
  }

  Widget buildList(List<ItemModel> data, int currentPage) {
    final bloc = BlocProvider.of<ListBloc>(context);

    return ListView.builder(
      itemCount: data.length + 1,
      itemBuilder: (context, index) {
        if (index < data.length) {
          return ListItem(
            data: data[index],
            onRemove: () {
              bloc.add(RemoveItemEvent(data[index].id));
            },
          );
        } else {
          //preloader
          bloc.add(GetItemsEvent(currentPage + 1));

          return const SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void openBottomSheet(BuildContext context) {
    final bloc = BlocProvider.of<TemperatureBloc>(context);
    bloc.add(GetTemperatureEvent());
    showModalBottomSheet<void>(
      elevation: 2,
      context: context,
      builder: (context) {
        return SizedBox(
            height: 240,
            child: Center(
              child: BlocBuilder<TemperatureBloc, TemperatureState>(
                bloc: BlocProvider.of<TemperatureBloc>(context),
                builder: (context, state) {
                  if (state is RequestingTemperatureState) {
                    return const CircularProgressIndicator();
                  } else if (state is GotTemperatureState) {
                    return Text(
                      'Weather service:\nCurrent temperature is ${state.temperature}°C',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    );
                  } else {
                    return const Text('Unknown service state');
                  }
                },
              ),
            ),);
      },
    );
    /*
    if (_sheetController == null) {
      _sheetController =
          _skaffoldKey.currentState?.showBottomSheet((context) => Container(
              height: 240,
              //color: Colors.greenAccent,
              child: Center(
                  child: BlocBuilder<TemperatureBloc, TemperatureState>(
                bloc: BlocProvider.of<TemperatureBloc>(context),
                builder: (context, state) {
                  if (state is RequestingTemperatureState) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text(
                      "Bottom Sheet",
                      style: TextStyle(fontSize: 32),
                    );
                  }
                },
              ))));
    } else {
      _sheetController?.close();
      _sheetController = null;
    }
     */
  }
}
