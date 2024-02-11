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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tr("options.language"), style: const TextStyle(fontSize: 15),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("🇺🇸", style: TextStyle(fontSize: 24),),
                  Switch(
                    inactiveTrackColor: Colors.grey,
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    thumbColor: MaterialStateProperty.all(Colors.white),
                    value: isFrench,
                    onChanged: (value) {
                      if (value == true) {
                        changeLocale(const Locale("fr"));
                      } else {
                        changeLocale(const Locale("en"));
                      }
                    }
                  ),
                  const Text("🇫🇷", style: TextStyle(fontSize: 24),),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.grey,),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              widget.logout.call();
            },
            child: Text(tr("login.logout"), style: const TextStyle(color: AppColors.alert, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}