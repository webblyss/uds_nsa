import 'package:flutter/material.dart';

class MobileView extends StatefulWidget {
  @override
  _MobileViewState createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  String _error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Password Reset",
          style: TextStyle(fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              showError(),
              new SizedBox(
                height: 100.0,
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: new Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty || value == '') {
                              return 'Please enter email';
                            }
                            String emailValid =
                                (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            RegExp regExp = new RegExp(emailValid);
                            if (!regExp.hasMatch(value)) {
                              return 'Email is not valid';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            emailController.text = newValue;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.all(20),
                            labelText: "Enter Email",
                            labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w600),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                        ),
                      ],
                    ),
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RaisedButton(
                      color: Colors.pink,
                      onPressed: () async {
                        final form = _formKey.currentState;
                        // if (form.validate()) {
                        //   form.save();
                        //   try {
                        //     await FirebaseAuth.instance
                        //         .sendPasswordResetEmail(
                        //       email: emailController.text,
                        //     )
                        //         .then(
                        //       (value) {
                        //         return Flushbar(
                        //           flushbarPosition: FlushbarPosition.BOTTOM,
                        //           flushbarStyle: FlushbarStyle.FLOATING,
                        //           reverseAnimationCurve: Curves.decelerate,
                        //           forwardAnimationCurve: Curves.elasticOut,
                        //           borderRadius: 10.0,
                        //           blockBackgroundInteraction: true,
                        //           backgroundColor: Colors.red,
                        //           boxShadows: [
                        //             BoxShadow(
                        //                 color: Colors.blue[800],
                        //                 offset: Offset(0.0, 2.0),
                        //                 blurRadius: 3.0)
                        //           ],
                        //           backgroundGradient: LinearGradient(
                        //               colors: [Colors.blueGrey, Colors.black]),
                        //           isDismissible: true,
                        //           dismissDirection:
                        //               FlushbarDismissDirection.HORIZONTAL,
                        //           messageText: Text(
                        //               "Follow the link sent to ${emailController.text} to reset your password",
                        //               style: TextStyle(
                        //                   fontSize: 15.0, color: Colors.white,),),
                        //         )..show(context);
                                
                        //       },
                        //     );
                            
                        //   } on FirebaseAuthException catch (e) {
                        //     print(e.message);
                        //     setState(() {
                        //       this.emailController.text = '';
                        //       _error = e.message;
                        //     });
                        //   }
                        // }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Send Link',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showError() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: Icon(
                Icons.error,
              ),
            ),
            Expanded(
              child: Text(
                _error,
                maxLines: 3,
                style: TextStyle(fontSize: 13.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    this.emailController.text = '';
                    _error = null;

                    
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: 0.0,
    );
  }
}