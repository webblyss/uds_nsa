import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'menu.dart';

class StudentPortal extends StatefulWidget {
  final String url;
  final String name;

  const StudentPortal({Key key, this.url, this.name}) : super(key: key);

  @override
  _StudentPortalState createState() => _StudentPortalState();
}

class _StudentPortalState extends State<StudentPortal> {
  int position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  JavascriptChannel snackBarJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "SnackBarJSChannel",
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(message.message),
            ),
          );
        });
  }

  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Menu(_controller.future, () => _favorites),
          ],
        ),
        floatingActionButton: _bookmarkButton(),
        bottomNavigationBar: NavigationControls(_controller.future),
        body: IndexedStack(
          index: position,
          children: <Widget>[
            Builder(
              builder: (context) {
                return WebView(
                  key: _key,
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  javascriptChannels: <JavascriptChannel>[
                    snackBarJavascriptChannel(context)
                  ].toSet(),
                  onPageFinished: doneLoading,
                  onPageStarted: startLoading,
                );
              },
            ),
            Container(
                child: Center(
              child: Center(child: Image.asset('assets/images/loading.gif'))
            ))
          ],
        ));
  }

  _bookmarkButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
              _favorites.add(url);
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Saved $url for later reading.')),
              );
            },
            child: Icon(Icons.favorite),
          );
        }
        return Container();
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webControlsFuture);
  final Future<WebViewController> _webControlsFuture;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _webControlsFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;

        return Container(
          color: Colors.pink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        if (await controller.canGoBack()) {
                          controller.goBack();
                        } else {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("No Back history Item"),
                            ),
                          );
                        }
                      },
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        if (await controller.canGoForward()) {
                          controller.goForward();
                        } else {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("No Forward history Item"),
                            ),
                          );
                        }
                      },
              ),
              IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        showUserModel(context, controller);
                      },
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        controller.reload();
                      },
              ),
            ],
          ),
        );
      },
    );
  }

  showUserModel(BuildContext context, WebViewController controller) {
    controller.evaluateJavascript(
        'SnackBarJSChannel.postMessage("User Agent : " + navigator.userAgent)');
  }
}
