import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Widget/ColorHelper.dart';
import 'package:untitled1/Widget/UIHelper.dart';
import 'package:untitled1/cubit/cubit.dart';
import 'package:untitled1/model/NoteModel.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {

  @override

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
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
              Text("Add Note",style: TextStyle(color: colorHelper.Black,fontFamily: "Medium",fontSize: 40,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              uiHelper.CustomTextField(1, "Title", titleController),
              uiHelper.CustomTextField(6, "Description", descController),
              uiHelper.CustomButton(
                "Save Note",
                () {
                  String title = titleController.text;
                  String desc = descController.text;
                  if (title == "" || desc == "") {
          
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          
                      content: Row(
                        children: [
                          Icon(Icons.error_outline,color: Colors.white,),
                          SizedBox(width: 30,),
                          Text("Enter Required Field",style: TextStyle(fontFamily: 'regular'),),
                        ],
                      ),
                      backgroundColor: colorHelper.Black,
                      action: SnackBarAction(label: "Ok", onPressed: (){
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }),
                    ));
                  } else {
                    context.read<NoteCubit>().AddData(NoteModel(title: title, desc: desc));
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
