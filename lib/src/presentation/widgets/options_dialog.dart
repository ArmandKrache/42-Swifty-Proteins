import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/utils/resources/debouncer.dart';

class OptionsDialog extends StatefulWidget {
  final Function logout;

  const OptionsDialog({
    super.key,
    required this.logout,
  });

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {

  @override
  void initState() {
    super.initState();
  }

  void changeLocale(Locale newLocale) async {
    await context.setLocale(newLocale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = context.locale;
    bool isFrench = locale.languageCode == 'fr';

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(tr("options.options")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(tr("options.language")),
              Switch(
                value: isFrench,
                onChanged: (value) {
                  if (value == true) {
                    changeLocale(const Locale("fr"));
                  } else {
                    changeLocale(const Locale("en"));
                  }
                }
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              widget.logout.call();
            },
            child: Text(tr("login.logout"), style: const TextStyle(color: AppColors.alert),),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            appRouter.pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}