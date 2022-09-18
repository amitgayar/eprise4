
import 'package:eprise4/app_constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///from : https://gist.github.com/SPodjasek/2f43fe45076976c16d830c749f992a1a

import 'dart:math' show max;


class ExpandableWebView extends StatefulWidget {
  final String url;
  final EdgeInsets padding;

  const ExpandableWebView(
      this.url, {
        Key? key,
        this.padding = const EdgeInsets.all(0),
      }) : super(key: key);

  @override
  _ExpandableWebViewState createState() => _ExpandableWebViewState();
}

class _ExpandableWebViewState extends State<ExpandableWebView> {
  double contentHeight = 0;
  bool loaded = false;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body:
        Container(
            padding: widget.padding,
            width: double.infinity,
            height: max(MediaQuery.of(context).size.height, contentHeight),
            child: Column(
              // alignment: Alignment.topCenter,
              children: [
                _buildWebView(context),
                if (!loaded)
                  const Center(child: CircularProgressIndicator()),
                if (loaded)
                  Container(
                    width: double.infinity,
                      color:Colors.orangeAccent,
                      child: const Text("Status : live      -12 C"))
              ],
            )),
      ),
    );
  }

  Widget _buildWebView(BuildContext context) {
    return SizedBox(
      height:700,
      child: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
            name: 'extents',
            onMessageReceived: (JavascriptMessage message) {
              logPrint.w('[webView/javascriptChannels] ${message.message}');
              setState(() {
                contentHeight = double.parse(message.message);
              });
            },
          )
        },
        onPageFinished: (String url) {
          logPrint.w('[webView/onPageFinished] finished loading "$url"');
          setState(() {
            loaded = true;
          });
        },
        onWebViewCreated: (WebViewController ctrl) {
          logPrint.w('[webView/onWebViewCreated] created');
        },
      ),
    );
  }
}