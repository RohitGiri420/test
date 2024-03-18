import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Widget/ColorHelper.dart';
import 'package:untitled1/Widget/UIHelper.dart';
import 'package:untitled1/cubit/State.dart';
import 'package:untitled1/cubit/cubit.dart';
import 'package:untitled1/screen/AddDataScreen.dart';
import 'package:untitled1/screen/UpdateDataScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NoteCubit>().FetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorHelper.white,
      appBar: AppBar(
        backgroundColor: colorHelper.white,
      ),
      body: BlocBuilder<NoteCubit, NoteState>(builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  "My Note",
                  style: TextStyle(
                      color: colorHelper.Black,
                      fontFamily: 'regular',
                      fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 19,
                      ),
                      SizedBox(
                        width: 280,
                      ),
                      Icon(
                        Icons.search,
                        size: 19,
                      ),
                      Icon(
                        Icons.more_vert,
                        size: 19,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                            color: colorHelper.Black,
                            fontFamily: "medium",
                            fontSize: 19),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "View all",
                            style: TextStyle(
                                color: colorHelper.Black, fontFamily: 'medium'),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white)),
                        elevation: 1,
                        child: ListTile(
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          tileColor: Colors.white,
                          onLongPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateDataScreen(
                                    id: state.arrlist[index].id!,
                                  ),
                                ));
                          },
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: colorHelper.grey,
                          ),
                          title: Text(
                            state.arrlist[index].title,
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'medium',
                                color: colorHelper.Black),
                          ),
                          subtitle: Text(
                            state.arrlist[index].desc,
                            style: TextStyle(
                                fontFamily: 'regular',
                                fontSize: 14,
                                color: colorHelper.grey),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<NoteCubit>()
                                        .deleteData(state.arrlist[index].id!);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 17,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.arrlist.length,
                  ),
                ),
              ],
            ),
          );
        } else if (state is ErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return Center(
            child: Text("Crucial error"),
          );
        }
      }),
      floatingActionButton: UiHelper().CustomFloatingActionButton(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDataScreen(),
            ));
      }),
    );
  }
}
