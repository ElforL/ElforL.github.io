import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:laith_shono/router/pages/error_page.dart';
import 'package:laith_shono/router/pages/home_page.dart';
import 'package:laith_shono/router/pages/project_page.dart';
import 'package:laith_shono/router/pages/unknown_page.dart';

class AnalyticsServices {
  Page? currentPage;

  updatePage(Page page) async {
    if (page == currentPage) return;

    String? screenName;
    if (page is ProjectPage) {
      screenName = 'Project: ${page.project.title}';
    } else if (page is HomePage) {
      screenName = 'Laith Shono';
    } else if (page is UnknownPage) {
      screenName = '404 screen. Route name: "${page.name}"';
    } else if (page is ErrorPage) {
      screenName = '502 screen';
    }

    if (screenName != null) {
      debugPrint('Updating analytics screen...');
      await FirebaseAnalytics.instance.logScreenView(screenName: screenName);
      currentPage = page;
    }
  }
}
