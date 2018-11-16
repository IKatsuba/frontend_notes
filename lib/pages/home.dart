import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<FilterChangeEvent> _changeController =
      StreamController<FilterChangeEvent>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FnDrawer(),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverToBoxAdapter(
                    child: FnBar(actions: <Widget>[GithubButton()])),
              ),
            ];
          },
          body: SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  key: PageStorageKey<String>('name'),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverToBoxAdapter(
                      child: Filter(
                        onChange: (event) {
                          _changeController.add(event);
                        },
                      ),
                    ),
                    SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: NewsList(
                          changes: _changeController.stream,
                        )),
                  ],
                );
              },
            ),
          )),
      // child: Column(
      //   children: <Widget>[
      //     Filter(
      //       onChange: (event) {
      //         _changeController.add(event);
      //       },
      //     ),
      //     NewsList(
      //       changes: _changeController.stream,
      //     )
      //   ],
      // ),
    );
  }
}
