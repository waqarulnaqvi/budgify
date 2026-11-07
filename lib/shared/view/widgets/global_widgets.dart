import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

Future<void> openUrl(
    {required String url,
      required BuildContext context,
      bool isExternal = false,
      String label = "Unable to open!"}) async {
  try {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri) || isExternal) {
      await launchUrl(uri,
          mode: isExternal
              ? LaunchMode.externalApplication
              : LaunchMode.platformDefault);
    } else {
      if (context.mounted) {
        IconSnackBar.show(context,
            label: label, snackBarType: SnackBarType.alert);
      }
    }
  } catch (e) {
    if (context.mounted) {
      IconSnackBar.show(context,
          label: "The link cannot be opened!", snackBarType: SnackBarType.fail);
    }
  }
}

Image staticImage(
        {required String assetName,
        double? width,
        double? height,
        Color? color,
        BoxFit fit = BoxFit.cover}) =>
    Image.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );

SizedBox spacerH([double height = 20]) => SizedBox(height: height);

SizedBox spacerW([double width = 20]) => SizedBox(width: width);


String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();
  return "$day/$month/$year";
}

String formatCalendarDate(DateTime date) {
  final month = DateFormat('MMMM').format(date);
  final year = date.year.toString();
  return "$month, $year";
}

DateTime parseDate(String date) {
  final parts = date.split('/');
  return DateTime(
    int.parse(parts[2]), // Year
    int.parse(parts[1]), // Month
    int.parse(parts[0]), // Day
  );
}

///For the My Budget Page
DateTime getDateTimeFromString(String date) {
  List<String> dateList = date.split(' | ');
  var amPm = dateList[1].split(' ')[1];
  var hour = int.parse(dateList[1].split(':')[0]);

 if(amPm =="PM" && hour != 12)
    {
    hour = hour + 12;
    }
  var dateTime = DateTime(
    int.parse(dateList[0].split('/')[0]),
    int.parse(dateList[0].split('/')[1]),
    int.parse(dateList[0].split('/')[2]),
    hour,
    int.parse(dateList[1].split(':')[1]),
    int.parse(dateList[1].split(':')[2].substring(0, 2)),
  );
  return dateTime;
}