import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ppbl2026/chart/bar_chart_example.dart';
import 'package:ppbl2026/chart/line_chart_example.dart';
import 'package:ppbl2026/chart/pie_chart_example.dart';
import 'package:ppbl2026/chart/scatter_chart_example.dart';
import 'package:ppbl2026/shared_preference/form_input.dart';
import 'package:ppbl2026/sqlite/view/form_input.dart';
import 'package:ppbl2026/sqlite/view/input_rekening.dart';
import 'package:ppbl2026/state/simple_stateful.dart';
import 'package:provider/provider.dart';
import 'package:ppbl2026/state/keranjang_provider.dart';
import 'package:ppbl2026/state/wishlist_provider.dart';

import 'chart/area_chart_example.dart';
import 'chart/radar_chart_example.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


void main()   {

  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => KeranjangProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: MaterialApp(
        home: InputRekening(),
      ), // The widget tree that needs access to the providers
    ),

  );
}
