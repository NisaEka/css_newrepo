import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LisensiScreen extends StatelessWidget {
  const LisensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopBar(
        leading: CustomBackButton(
          onPressed: () => Get.back(),
        ),
        title: "Lisensi",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Text("THE FOLLOWING SETS FORTH ATTRIBUTION "
                "NOTICES FOR THIRD PARTY SOFTWARE THAT MAY "
                "BE CONTAINED IN PORTIONS OF THIS PRODUCT"),
            SizedBox(height: 8),
            Text("-----"),
            SizedBox(height: 8),
            // const Text("The following components are licensed under ___ reproduced below:"),
            // const SizedBox(height: 8),
            Text("* cupertino_icons , Copyright (c) 2016 Vladimir Kharlampidi"),
            Text("* get , Copyright (c) 2019 Jonny Borges"),
            Text("* dio ,  Copyright (c) 2018 Wen Du (wendux)"
                "\nCopyright (c) 2022 The CFUG Team"),
            Text("* form_validator , Copyright (c) 2020 Misir Jafarov"),
            Text("* device_info_plus , Copyright 2017 The Chromium Authors."),
            Text("* flutter_secure_storage , Copyright 2017 German Saprykin"),
            Text("* intl , Copyright 2013, the Dart project authors."),
            Text("* flutter_svg , Copyright (c) 2018 Dan Field"),
            Text("* dropdown_search , Copyright (c) 2020 Salim Lachdhaf"),
            Text("* lottie , Copyright © 2021 Design Barn Inc."),
            Text("* package_info_plus , Copyright 2017 The Chromium Authors."),
            Text("* geocoding , Copyright (c) 2018 Baseflow"),
            Text("* geolocator , Copyright (c) 2018 Baseflow"),
            Text("* marquee , Copyright (c) 2018 Marcel Garus"),
            Text("* pinput , Copyright (c) 2022 Tornike Kurdadze"),
            Text("* connectivity_plus , Copyright 2017 The Chromium Authors."),
            Text("* flutter_slidable , Copyright (c) 2018 Romain Rastel"),
            Text("* cached_network_image , Copyright (c) 2018 Rene Floor"),
            Text(
                "* flutter_barcode_scanner , Copyright (c) 2019 Amol Gangadhare"),
            Text("* google_maps_flutter , Copyright 2013 The Flutter Authors"),
            Text("* collection , Copyright 2015, the Dart project authors."),
            Text("* screenshot , Copyright (c) 2018 Sachin Ganesh"),
            Text("* multi_select_flutter , Copyright (c) 2020, Chris Botha"),
            Text("* path_provider , Copyright 2013 The Flutter Authors."),
            Text("* image_picker , Copyright 2013 The Flutter Authors."),
            Text("* flutter_html , Copyright (c) 2019 Matthew Whitaker"),
            Text("* firebase_messaging , Copyright 2017 The Chromium Authors."),
            Text("* flutter_local_notifications , Copyright 2018 Michael Bui."),
            Text("* webview_flutter, Copyright 2013 The Flutter Authors."),
            Text(
                "* infinite_scroll_pagination , Copyright (c) 2021 Edson Bueno"),
            Text("* bubble , Copyright 2019 Dunaev Victor (nashol)"),
            Text("* share_plus, Copyright 2017, the Flutter project authors."),
            Text("* permission_handler , Copyright (c) 2018 Baseflow"),
            Text("* url_launcher , Copyright 2013 The Flutter Authors."),
            Text("* carousel_slider , Copyright (c) 2017 serenader"),
            Text("* flutter_hooks , Copyright (c) 2018 Remi Rousselet"),
            Text("* logger , Copyright (c) 2019 Simon Leier"
                "\nCopyright (c) 2019 Harm Aarts"
                "\nCopyright (c) 2023 Severin Hamader"),
            Text(
                "* firebase_crashlytics , Copyright 2019 The Chromium Authors."),
            Text("* file_picker , Copyright (c) 2018 Miguel Ruivo"),
            Text("* fl_chart , Copyright (c) 2022 Flutter 4 Fun"),
            Text("* photo_view , Copyright 2020 Renan C. Araújo"),
            Text("* firebase_core , Copyright 2017 The Chromium Authors."),
            Text("* dotted_line, Copyright 2019 umechanhika"),
            Text(
                "* fading_edge_scrollview , Copyright (c) 2019, Mikhail Ponkin"),
            SizedBox(height: 8),
            Text("* barcode"),
            Text("* barcode_widget"),
            Text("* pdf"),
            Text("* printing"),
            Text("* google_fonts"),
            Text("Apache License"
                "\nVersion 2.0, January 2004"
                "\nhttp://www.apache.org/licenses/"
                "\nTERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION"
                "\n1. Definitions.")
          ],
        ),
      ),
    );
  }
}
