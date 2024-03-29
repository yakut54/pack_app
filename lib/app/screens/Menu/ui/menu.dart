import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pack_app/app/bloc/pack_bloc.dart';
import '/app/router/export.dart';
import 'list_tile_widget.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final bool isPhone = false;
  final PackBloc _packBloc = PackBloc(GetIt.I<APackRepo>());
  Pack? pack;

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
    }
    _packBloc.add(LoadPack());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<PackBloc, PackState>(
            bloc: _packBloc,
            builder: (context, state) {
              return Column(
                children: [
                  if (isPhone)
                    Header(
                      packTitle: pack != null ? pack!.title : '...Loading',
                      packSubtitle: pack != null ? pack!.subtitle : '...Loading',
                      backgroundImg: pack != null ? pack!.backgroundImg : 'bg_01',
                    )
                  else
                    Header(
                      packTitle: state is PackLoaded ? state.pack.title : '...Loading',
                      packSubtitle: state is PackLoaded ? state.pack.subtitle : '...Loading',
                      backgroundImg: state is PackLoaded ? state.pack.backgroundImg : 'bg_01',
                    ),
                  if (state is! PackLoaded)
                    const Text('...Загрузка')
                  else
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: isPhone ? pack!.sessions.length : state.pack.sessions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LayoutBuilder(builder: (context, constraints) {
                          double width = MediaQuery.of(context).size.width;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 3,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                constraints: const BoxConstraints(
                                  maxWidth: 800,
                                  minHeight: 80,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F3FF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.47),
                                      blurRadius: 2,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: ListTileWidget(
                                  width: width,
                                  sessions: isPhone ? pack!.sessions : state.pack.sessions,
                                  index: index,
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
