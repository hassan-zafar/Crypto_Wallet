import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../backend/all_backends.dart';
import 'cust_prog_ind.dart';

class KHeader extends StatelessWidget {
  const KHeader({
    Key? key,
    required this.body,
    this.title,
    this.floatingActionButton,
    this.isLoading = false,
    this.hasWillPop = false,
    this.args,
    this.extra1 = '',
    this.extra2 = '',
  }) : super(key: key);

  final List<String>? title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool isLoading;
  final bool hasWillPop;
  final Map<String, String>? args;
  final String extra1;
  final String extra2;
  @override
  Widget build(BuildContext context) {
    // AllBackEnds _allBackEnds = AllBackEnds();
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: const CustProgIndicator(),
      child: WillPopScope(
        onWillPop:  null,
        child: Scaffold(
          floatingActionButton: floatingActionButton,
          appBar: title != null
              ? AppBar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  title: Text(
                    extra1 +
                        // _allBackEnds.multiTranslation(context, title!,
                        //     args: args)! +
                        extra2,
                  ),
                )
              : null,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(child: body),
          ),
        ),
      ),
    );
  }
}
