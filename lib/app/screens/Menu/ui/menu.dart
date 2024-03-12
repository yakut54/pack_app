import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pack_app/app/bloc/pack_bloc.dart';
import '/app/imports/all_imports.dart';
import 'list_tile_widget.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final bool isPhone = true;
  final PackBloc _packBloc = PackBloc(GetIt.I<APackRepo>());
  Pack? pack;
  bool isStarted = false;

  Future<bool> _checkConnect() async {
    bool b = await connectivity();
    return b;
  }

  void _readData() async {
    final dataJson = await DefaultAssetBundle.of(context).loadString('assets/json/data.json');
    pack = await PackRepo().getPacksFromJson(dataJson);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _checkConnect().then((value) => print('Connect $value'));

    if (isPhone) {
      _readData();
    } else {
      _packBloc.add(LoadPack());
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (!isStarted) {
      Timer(const Duration(seconds: 2), () {
        isStarted = true;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<PackBloc, PackState>(
            bloc: _packBloc,
            builder: (context, state) {
              // return state is PackLoaded && isStarted
              return pack != null && isStarted
                  ? Column(
                      children: [
                        Header(
                          packTitle: pack != null ? pack!.title : '...Loading',
                          packSubtitle: pack != null ? pack!.subtitle : '...Loading',
                          backgroundImg: pack != null ? pack!.backgroundImg : 'bg_01',
                        ),
                        // Header(
                        //   packTitle: state.pack.title,
                        //   packSubtitle: state.pack.subtitle,
                        //   backgroundImg: state.pack.backgroundImg,
                        // ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: pack!.sessions.length,
                          // itemCount: state.pack.sessions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return LayoutBuilder(builder: (context, constraints) {
                              double width = MediaQuery.of(context).size.width;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 0,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: double.infinity,
                                    constraints: const BoxConstraints(
                                      maxWidth: 800,
                                      minHeight: 80,
                                    ),
                                    child: ListTileWidget(
                                      width: width,
                                      // sessions: state.pack.sessions[index],
                                      session: pack!.sessions[index],
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    )
                  : const SplashScreen();
            },
          ),
        ),
      ),
    );
  }
}
