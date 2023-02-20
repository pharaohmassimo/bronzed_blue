import 'package:bronzed_blue/main.dart';
import 'package:bronzed_blue/repository.dart';
import 'package:bronzed_blue/show_users.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({
    Key? key,
  }) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

bool loading = false;
late bool _mail;

final emailController = TextEditingController();

final nameController = TextEditingController();

bool _emptyEmail = false;

bool _emptyName = false;

String _email = '';

String _name = '';

class _AddUserState extends State<AddUser> {
  @override
  void initState() {
    setState(() {
      _mail = false;

      _emptyEmail = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                  visible: loading,
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 200,
                      ),
                      Center(child: Text('Adding User, Please Wait')),
                    ],
                  )),
              Visibility(
                visible: loading == false ? true : false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 20, right: 10, bottom: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Add New User",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: width - 20,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                setState(() {
                                  _name = value.trim();
                                });
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                errorText: _emptyName ? 'Required' : null,
                                hintStyle: const TextStyle(fontSize: 13),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: "Username",
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: const EdgeInsets.all(8),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: width - 20,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) => !input!.contains('@')
                                  ? "Email address should be valid"
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                  print(_email);
                                });
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                errorText: _emptyEmail ? 'Required' : null,
                                hintStyle: const TextStyle(fontSize: 13),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: "Enter Email",
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: const EdgeInsets.all(8),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            _onAddButtonPressed();
                          },
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                side: BorderSide(color: Colors.black)),
                          ),
                          child: Container(
                            width: width * 0.3,
                            child: const Center(
                              child: Text(
                                'Add ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateEmail() {
    var reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (reg.hasMatch(emailController.text)) {
      return true;
    } else if (emailController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _validateName() {
    if (nameController.text.length > 6) {
      return true;
    } else if (nameController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void _onAddButtonPressed() async {
    ApiRepository apiRepository = ApiRepository();

    if (_validateName() &&
        _validateEmail() &&
        (emailController.text.isNotEmpty && nameController.text.isNotEmpty)) {
      //call logic here

      setState(() {
        loading = true;
      });

      try {
        var response = await apiRepository.addUser(
            email: emailController.text, name: nameController.text);

        if (response.messages == 'User Added') {
          setState(() {
            loading = false;
          });

          //move to next page

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ShowLists()));
        } else {
          setState(() {
            loading = false;
          });
          AlertDialog(
            scrollable: true,
            contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            title: const Text(
              "User Login Failed",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            content: Text(response.messages),
            actions: const <Widget>[],
          );
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
          title: const Text(
            "User Login Failed",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          content: Text(e.toString()),
          actions: const <Widget>[],
        );
      }
    } else if (emailController.text.isEmpty && nameController.text.isEmpty) {
      setState(() {
        _emptyEmail = true;
        _emptyName = true;
      });
    } else if (emailController.text.isEmpty) {
      setState(() {
        _emptyEmail = true;
      });
    } else if (nameController.text.isEmpty) {
      setState(() {
        _emptyName = true;
      });
    } else {}
  }
}
