import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../utils/graphql_request.dart';
import 'stand_edit_page.dart';
import 'stand_new_page.dart';

class StandListePage extends StatefulWidget {
  const StandListePage({Key? key}) : super(key: key);

  @override
  _StandListePageState createState() => _StandListePageState();
}

class _StandListePageState extends State<StandListePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StandNewPage(),
              ));
        },
        elevation: 8,
        child: Icon(
          Icons.add_rounded,
          size: 24,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: RefreshIndicator(
          onRefresh: () {
            setState(() {});
            throw StateError;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                  child: Text(
                    'Liste des stands',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Query(
                    options: QueryOptions(
                        fetchPolicy: FetchPolicy.cacheAndNetwork,
                        document: gql(GraphqlRequest().getAllStands)),
                    builder: (QueryResult result,
                        {VoidCallback? refetch, FetchMore? fetchMore}) {
                      if (result.hasException) {
                        return Text(result.exception.toString());
                      }

                      if (result.isLoading) {
                        return const Text('Loading');
                      }

                      log(result.data.toString());

                      if (result.data?["stands"]?["data"] != null) {
                        var festivalList = result.data?["stands"]?["data"];

                        List<Widget> festivalWidgetsList = festivalList
                            .map<Widget>(
                              (i) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: InkWell(
                                  onTap: () async {
                                    WidgetsBinding.instance
                                        ?.addPostFrameCallback((_) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => StandEditPage(
                                              festivalID: int.parse(
                                                      i["attributes"]
                                                                      ?[
                                                                      "festival"]
                                                                  ?[
                                                                  "data"]?["id"]
                                                              .toString() ??
                                                          "1") ??
                                                  1,
                                              standName: i["attributes"]
                                                          ?["name"]
                                                      .toString() ??
                                                  "festival",
                                              localisation: i["attributes"]
                                                          ?["position"]
                                                      .toString() ??
                                                  "Nantes",
                                              id: int.parse(i["id"]),
                                            ),
                                          ));
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3,
                                          color: Color(0x411D2429),
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 8, 8, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 1, 1, 1),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: Image.network(
                                                'https://images.ladepeche.fr/api/v1/images/view/609bcf4d3e45462ff41a87e6/large/image.jpg?v=1',
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 8, 4, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    i["attributes"]?["name"]
                                                            .toString() ??
                                                        'Festival Name',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color(0xFF0F1113),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 4, 8, 0),
                                                    child: Text(
                                                      i["attributes"]
                                                                  ?["position"]
                                                              .toString() ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF57636C),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 0, 0),
                                                child: Icon(
                                                  Icons.chevron_right_rounded,
                                                  color: Color(0xFF57636C),
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList();

                        return ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: festivalWidgetsList);
                      } else {
                        return Text("no data");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
