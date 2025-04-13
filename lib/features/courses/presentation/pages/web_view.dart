import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_application_3/core/widgets/custom_snack_bar.dart';

class WebViewScreenBody extends StatefulWidget {
  const WebViewScreenBody({super.key, required this.url});
  final String url;

  @override
  State<WebViewScreenBody> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreenBody> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onReceivedError: (controller, request, error) {
            CustomSnackBar.show(
              context: context,
              message: 'Failed to load page: ${error.description}',
            );
          },
          onReceivedHttpError: (controller, request, response) {
            CustomSnackBar.show(
              context: context,
              message: 'HTTP error ${response.statusCode}.',
            );
          },
        ),
      ),
    );
  }
}
