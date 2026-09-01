import 'package:budgify/core/constants/constants.dart';
import 'package:budgify/features/expense_tracker/viewmodel/riverpod/in_app_web_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/view/widgets/reusable_app_bar.dart';


class GoogleFormInAppWebView extends ConsumerStatefulWidget {
  const GoogleFormInAppWebView({super.key});

  @override
  ConsumerState<GoogleFormInAppWebView> createState() => _GoogleFormInAppWebViewState();
}

class _GoogleFormInAppWebViewState extends ConsumerState<GoogleFormInAppWebView> {
  InAppWebViewController? webViewController;



  @override
  Widget build(BuildContext context,) {
    final progress = ref.watch(inAppWebViewProvider);
    return Scaffold(
      appBar: ReusableAppBar(
        text: "Feedback Form",
        isCenterText: false,
      ),
      body: _buildWebView(progress: progress)
    );
  }

  Widget _buildWebView(
      {required double progress}) {
    final provider = ref.read(inAppWebViewProvider.notifier);
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(AppConstants.googleFeedbackFormUrl)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onProgressChanged: (controller, progressValue) {
            provider.updateProgress(progressValue / 100);
          },
          // onLoadStop: (controller, url) {
          //   if (kDebugMode) {
          //     print("Finished loading: $url");
          //   }
          // },
        ),
        if (progress < 1.0) LinearProgressIndicator(value: progress),
        if(progress <0.8) Center(child: CircularProgressIndicator(),)
      ],
    );
  }
}
