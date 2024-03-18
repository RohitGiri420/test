import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Widget/ColorHelper.dart';
import 'package:untitled1/Widget/UIHelper.dart';
import 'package:untitled1/cubit/cubit.dart';
import 'package:untitled1/model/NoteModel.dart';

class UpdateDataScreen extends StatefulWidget {
  int id;
  UpdateDataScreen({required this.id,super.key});

  @override
  State<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  @override

  @override
  Widget build(BuildContext context) {
    TextEditingController utitleController = TextEditingController();
    TextEditingController udescController = TextEditingController();
    UiHelper uiHelper = UiHelper();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorHelper.white,
      ),
      backgroundColor: colorHelper.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 30,),
              Text("Update Note",style: TextStyle(color: colorHelper.Black,fontFamily: "Medium",fontSize: 40,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              uiHelper.CustomTextField(1, "Title", utitleController),
              uiHelper.CustomTextField(6, "Description", udescController),
              uiHelper.CustomButton(
                "Save Changes",
                    () {
                  String title = utitleController.text;
                  String desc = udescController.text;
                  if (title == "" || desc == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.error_outline,color: Colors.white,),
                          SizedBox(width: 30,),
                          Text("Enter Required Field",style: TextStyle(fontFamily: 'regular'),),
                        ],
                      ),
                      action: SnackBarAction(label: "Ok", onPressed: (){
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }),
                    ));
                  } else {
                    context.read<NoteCubit>().UpdateData(NoteModel(title: title, desc: desc,id: widget.id));
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
