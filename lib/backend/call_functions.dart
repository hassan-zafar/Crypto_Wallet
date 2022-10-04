import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../helpers/colors.dart';
import '../widget/trns_text.dart';
import 'localization.dart';

abstract class BaseFunction {
  launchUrlFxn(url);
  showSnacky(String msg, bool isSuccess, BuildContext context,
      {Map<String, String>? args, String extra2});

  toggleSwitch(
    bool value,
    BuildContext context,
    Function(bool) onChanged,
  );

  showPicker(
    BuildContext context, {
    List<dynamic>? children,
    Function(int?)? onSelectedItemChanged,
    Function(String?)? onChanged,
    bool hasTrns = true,
  });

  showPopUp(
    BuildContext context,
    Widget content,
    List<CupertinoButton> iosActions,
    List<TextButton> androidActions, {
    IconData icon,
    String msg,
    Color color,
    bool barrierDismissible = true,
  });

  showModalBarAction(
    BuildContext context,
    Widget child,
    List<CupertinoActionSheetAction> action,
  );
  showModalBar(
    BuildContext context,
    Widget content, {
    bool isDismissible,
  });

  String? translation(context, String key, {Map<String, String>? args});
  String? multiTranslation(context, List<String> keys,
      {Map<String, String>? args});
}

class CallFunctions implements BaseFunction {
  @override
  launchUrlFxn(url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  @override
  showSnacky(String msg, bool isSuccess, BuildContext context,
      {Map<String, String>? args, String extra2 = ""}) {
        Tooltip(
          message: msg,
          child: Icon(
            isSuccess ? Icons.check : Icons.error,
            color: isSuccess ? Colors.green : Colors.red,
          ),
        );
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: TrnsText(title: msg, extra2: extra2, args: args),
    //   backgroundColor: isSuccess ? green : red,
    // ));
  }

  @override
  toggleSwitch(
    bool value,
    BuildContext context,
    Function(bool) onChanged,
  ) {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        activeColor: Theme.of(context).primaryColor,
        value: value,
        onChanged: onChanged,
      );
    } else {
      return Switch(
        value: value,
        onChanged: onChanged,
        activeColor: white,
      );
    }
  }

  @override
  showPicker(BuildContext context,
      {List<dynamic>? children,
      Function(int?)? onSelectedItemChanged,
      Function(String?)? onChanged,
      bool hasTrns = true}) {
    Platform.isIOS
        ? showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: CupertinoPicker(
                  useMagnifier: true,
                  magnification: 1.3,
                  onSelectedItemChanged: onSelectedItemChanged,
                  itemExtent: 32.0,
                  children: children!.map((value) {
                    assert(value != null);
                    return hasTrns
                        ? TrnsText(
                            title: value!,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          )
                        : Text(
                            value.toUpperCase(),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          );
                  }).toList(),
                ),
              );
            })
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 200,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: const Icon(Ionicons.ios_arrow_down),
                    underline: Container(),
                    hint: const TrnsText(title: 'Select'),
                    items: children!.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: hasTrns
                            ? TrnsText(title: value!)
                            : Text(
                                value.toUpperCase(),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                              ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
          );
  }

  @override
  showModalBarAction(
    BuildContext context,
    Widget child,
    List<CupertinoActionSheetAction> action,
  ) {
    Platform.isIOS
        ? showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              actions: action,
              cancelButton: CupertinoActionSheetAction(
                child: const TrnsText(title: 'Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        : showModalBottomSheet(context: context, builder: (_) => child);
  }

  @override
  showPopUp(
    BuildContext context,
    Widget content,
    List<CupertinoButton> iosActions,
    List<TextButton> androidActions, {
    String? msg,
    IconData? icon,
    Color? color,
    bool barrierDismissible = true,
  }) {
    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: barrierDismissible,
            context: context,
            builder: (_) => CupertinoAlertDialog(
              content: content,
              title: icon != null
                  ? Icon(
                      icon,
                      color: color,
                      size: 30,
                    )
                  : msg != null
                      ? Text(
                          msg,
                          style: TextStyle(color: color),
                        )
                      : null,
              actions: iosActions,
            ),
          )
        : showDialog(
            barrierDismissible: barrierDismissible,
            context: context,
            builder: (_) => AlertDialog(
              content: content,
              title: icon != null
                  ? Icon(
                      icon,
                      color: color,
                      size: 30,
                    )
                  : msg != null
                      ? Text(
                          msg,
                          style: TextStyle(color: color),
                        )
                      : null,
              actions: androidActions,
            ),
          );
  }

  @override
  showModalBar(
    BuildContext context,
    Widget content, {
    bool? isDismissible,
  }) {
    Platform.isIOS
        ? showCupertinoModalBottomSheet(
            isDismissible: isDismissible ?? true,
            context: context,
            builder: (_) => Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: content,
            ),
          )
        : showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: isDismissible ?? true,
            context: context,
            builder: (_) => Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: content,
            ),
          );
  }

  @override
  String? translation(context, String key, {Map<String, String>? args}) {
    return AppLocalizations.of(context)!.translate(key, args: args);
  }

  @override
  String? multiTranslation(context, List<String> keys,
      {Map<String, String>? args}) {
    List strList = [];

    for (String key in keys) {
      String str = AppLocalizations.of(context)!.translate(key, args: args)!;

      strList.add(str);
    }
    return strList.join(' ');
  }
}
