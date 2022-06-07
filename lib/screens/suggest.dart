import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SuggestionBox extends StatefulWidget {
  @override
  _SuggestionBoxState createState() => _SuggestionBoxState();
}

class _SuggestionBoxState extends State<SuggestionBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  String subject;
  String complain;
  void _launchEmail(String emailID) async {
    var url =
        'mailto:$emailID?subject= Complains and Suggestions&body=${descriptionController.text}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: 400,
              height: 400,
              child: Image.asset(
                "assets/images/feedbackImage.png",
                fit: BoxFit.contain,
              )),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Complains",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            top: 40,
            left: 20,
          ),
          Positioned(
            child: IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp,color:Colors.white),
              onPressed: () {
                _luanchWhatsapp(number: "+233546468048", message: "");
              },
            ),
            top: 40,
            right: 20,
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.85,
            minChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrolController) {
              return Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)),
                    ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                controller: descriptionController,
                                style: Theme.of(context).textTheme.bodyText1,
                                onChanged: (value) {
                                  complain = value;
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Write your Complains here',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: FloatingActionButton(
                      onPressed: () {
                        if (descriptionController.text == null ||
                            descriptionController.text == '') {
                          BotToast.showText(text: "Enter Message");
                        } else {
                          _launchEmail("udsnsa6@gmail.com");
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.pinkAccent,
                    ),
                    top: -30,
                    right: 30,
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }


}
  Future<void> _luanchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("failed");
  }