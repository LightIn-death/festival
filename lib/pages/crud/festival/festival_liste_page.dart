import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../utils/graphql_request.dart';
import 'festival_edit_page.dart';
import 'festival_new_page.dart';

class FestivalListePage extends StatefulWidget {
  const FestivalListePage({Key? key}) : super(key: key);

  @override
  _FestivalListePageState createState() => _FestivalListePageState();
}

class _FestivalListePageState extends State<FestivalListePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FestivalNewPage(),
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
                    'Festival list',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Query(
                    options: QueryOptions(
                        fetchPolicy: FetchPolicy.cacheAndNetwork,
                        document: gql(GraphqlRequest().publicData)),
                    builder: (QueryResult result,
                        {VoidCallback? refetch, FetchMore? fetchMore}) {
                      if (result.hasException) {
                        return Text(result.exception.toString());
                      }

                      if (result.isLoading) {
                        return const Text('Loading');
                      }



                      if (result.data?["festivals"]?["data"] != null) {
                        var festivalList = result.data?["festivals"]?["data"];

                        List<Widget> festivalWidgetsList = festivalList
                            .map<Widget>(
                              (i) => Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                child: InkWell(
                                  onTap: () async {

                                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                                       Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FestivalEditPage(
                                              dateDebut: i["attributes"]
                                              ?["date_start"]
                                                  .toString() ??
                                                  DateTime.now().toString(),
                                              dateFin: i["attributes"]?["date_end"]
                                                  .toString() ??
                                                  DateTime.now().toString(),
                                              festivalName: i["attributes"]?["name"]
                                                  .toString() ??
                                                  "festival",
                                              localisation: i["attributes"]
                                              ?["localisation"]
                                                  .toString() ??
                                                  "Nantes",
                                              id: int.parse(i["id"]),
                                            ),
                                          ))
                                      ;
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
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      8, 8, 4, 0),
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
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(0, 4, 8, 0),
                                                    child: Text(
                                                      i["attributes"]
                                                                  ?["date_start"]
                                                              .toString() ??
                                                          'date',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color: Color(0xFF57636C),
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
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 12, 4, 8),
                                                child: Text(
                                                  i["attributes"]?["date_end"]
                                                          .toString() ??
                                                      "nb_jour",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF0F1113),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.normal,
                                                  ),
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
