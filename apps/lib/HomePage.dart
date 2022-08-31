import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _addFormkey = GlobalKey<FormState>();
  final _updateFormkey = GlobalKey<FormState>();

  final _noteAddTitle = TextEditingController();
  final _noteAddDes = TextEditingController();
  final _noteaddnumber = TextEditingController();

  final _noteUpdateTitle = TextEditingController();
  final _noteUpdateDes = TextEditingController();
  final _noteupdatenumber = TextEditingController();

  Box? notesBox;

  Map<String, dynamic> noteAddMap = {};

  @override
  void initState() {
    notesBox = Hive.box('notes');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Local Database'),
              centerTitle: true,
              //title: Text(widget.title),
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _addFormkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _noteAddTitle,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              label: Text("Enter Your Name"),
                              errorStyle: TextStyle(fontSize: 15),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Note Title";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _noteaddnumber,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              label: Text('Enter Your Number'),
                              errorStyle: TextStyle(fontSize: 15),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Any number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _noteAddDes,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              label: Text('Enter Your Email'),
                              errorStyle: TextStyle(fontSize: 15),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Note Description";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: TextButton(
                                onPressed: () async {
                                  if (_addFormkey.currentState!.validate()) {
                                    final addNoteTitle = _noteAddTitle.text;
                                    final addNoteDetail = _noteAddDes.text;
                                    final addNumber = _noteaddnumber.text;

                                    noteAddMap = {
                                      'title': addNoteTitle,
                                      'number': addNumber,
                                      'description': addNoteDetail,
                                    };

                                    await notesBox!.add(noteAddMap);
                                    _noteAddTitle.clear();
                                    _noteAddDes.clear();
                                    _noteaddnumber.clear();
                                    Fluttertoast.showToast(
                                      msg: "Note Added",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                                child: const Text(
                                  "Add Note",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                )),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                              child: ValueListenableBuilder(
                                  valueListenable:
                                      Hive.box('notes').listenable(),
                                  builder: (context, value, widget) {
                                    return ListView.builder(
                                        itemCount:
                                            notesBox!.keys.toList().length,
                                        itemBuilder: (_, index) {
                                          return Card(
                                            elevation: 5,
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10)),
                                                  Text(
                                                    notesBox!
                                                        .getAt(index)['title']
                                                        .toString(),
                                                  ),
                                                  Text(
                                                    notesBox!
                                                        .getAt(index)['number']
                                                        .toString(),
                                                  ),
                                                  Text(
                                                    notesBox!
                                                        .getAt(index)[
                                                            'description']
                                                        .toString(),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () async {
                                                            showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder: (_) {
                                                                return Dialog(
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20)),
                                                                  ),
                                                                  child: Stack(
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    children: <
                                                                        Widget>[
                                                                      SizedBox(
                                                                        height:
                                                                            450,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(20.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              const SizedBox(
                                                                                height: 50,
                                                                              ),
                                                                              const Text(
                                                                                "Update Note",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontFamily: "Segoe UI", fontWeight: FontWeight.w700, fontSize: 23, color: Color(0xff070707)),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Form(
                                                                                autovalidateMode: AutovalidateMode.always,
                                                                                key: _updateFormkey,
                                                                                child: Column(
                                                                                  children: [
                                                                                    TextFormField(
                                                                                      controller: _noteUpdateTitle..text = notesBox!.getAt(index)['title'].toString(),
                                                                                      decoration: const InputDecoration(
                                                                                      label: Text("Name"),
                                                                                        errorStyle: TextStyle(fontSize: 15),
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value!.isEmpty) {
                                                                                          return "Enter Name";
                                                                                        }
                                                                                        return null;
                                                                                      },
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    TextFormField(
                                                                                      controller: _noteaddnumber..text = notesBox!.getAt(index)['number'].toString(),
                                                                                      decoration: const InputDecoration(
                                                                                       label: Text("Phone Number"),
                                                                                        errorStyle: TextStyle(fontSize: 15),
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value!.isEmpty) {
                                                                                          return "Enter phone number";
                                                                                        }
                                                                                        return null;
                                                                                      },
                                                                                    ),
                                                                                    const SizedBox(height: 10),
                                                                                    TextFormField(
                                                                                      controller: _noteUpdateDes..text = notesBox!.getAt(index)['description'].toString(),
                                                                                      decoration: const InputDecoration(
                                                                                       label: Text("Enter Email"),
                                                                                        errorStyle: TextStyle(fontSize: 15),
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value!.isEmpty) {
                                                                                          return "Enter Email";
                                                                                        }
                                                                                        return null;
                                                                                      },
                                                                                    ),
                                                                                    const SizedBox(height: 10),
                                                                                    SizedBox(
                                                                                      height: 50,
                                                                                      width: 150,
                                                                                      child: ElevatedButton(
                                                                                          onPressed: () async {
                                                                                            if (_updateFormkey.currentState!.validate()) {
                                                                                              final updateNoteTitle = _noteUpdateTitle.text;
                                                                                              final updateNoteDetail = _noteUpdateDes.text;
                                                                                              final updatenumber = _noteaddnumber.text;
                                                                                              Map<String, dynamic> noteUpMap = {
                                                                                                'title': updateNoteTitle,
                                                                                                'description': updateNoteDetail,
                                                                                                'number': updatenumber
                                                                                              };

                                                                                              await notesBox?.putAt(index, noteUpMap);
                                                                                              _noteUpdateTitle.clear();
                                                                                              _noteUpdateDes.clear();
                                                                                              _noteupdatenumber.clear();

                                                                                              Fluttertoast.showToast(
                                                                                                msg: "Note Updated ...",
                                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                                gravity: ToastGravity.TOP,
                                                                                                timeInSecForIosWeb: 1,
                                                                                                backgroundColor: Colors.red,
                                                                                                textColor: Colors.white,
                                                                                                fontSize: 16.0,
                                                                                              );

                                                                                              if (!mounted) {
                                                                                                return;
                                                                                              }
                                                                                              Navigator.pop(context);
                                                                                            }
                                                                                          },
                                                                                          child: const Text("Update Data")),
                                                                                    ),
                                                                                                SizedBox(height: 10,),
                                                                                    SizedBox(
                                                                                      height:50 ,
                                                                                      width: 150,
                                                                                      child: ElevatedButton(
                                                                                        
                                                                                          child: const Text("Close"),
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          }),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                          top:
                                                                              -50,
                                                                          child:
                                                                              CircleAvatar(
                                                                            radius:
                                                                                50,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                                              child: Container(color: Colors.white, child: Image.asset("assets/launcher_icon.png")),
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            color: Colors.green,
                                                          )),
                                                      IconButton(
                                                          onPressed: () async {
                                                            await notesBox!
                                                                .deleteAt(
                                                                    index);
                                                            Fluttertoast
                                                                .showToast(
                                                              msg:
                                                                  "Note Deleted ...",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .TOP,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                            );
                                                          },
                                                          icon: const Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.red,
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }))
                        ],
                      ),
                    )))));
  }
}
