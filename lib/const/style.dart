import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var accent = const Color(0xFF18A5FD);
var accentLight = const Color(0xFF66ACE9);
var heading = const Color(0xFF0F1641);
var text = const Color(0xFFAAAAAA);
var icon = const Color(0xFFB8BCCB);
var background = const Color(0xFFF8FAFB);
var white = const Color(0xFFFFFFFF);
var black = const Color(0xFF000000);

//textstyles
TextStyle heading1 = GoogleFonts.poppins(
    fontWeight: FontWeight.bold, color: heading, fontSize: 20);
TextStyle heading2 = GoogleFonts.poppins(
    fontWeight: FontWeight.bold, color: heading, fontSize: 18);
TextStyle heading3 = GoogleFonts.poppins(
    fontWeight: FontWeight.bold, color: heading, fontSize: 16);
TextStyle heading4 = GoogleFonts.poppins(
    fontWeight: FontWeight.bold, color: heading, fontSize: 14);

//sizebox
var large = 50.0;
var meduim = 30.0;
var small = 16.0;
var xsmall = 10.0;

TextStyle p1 = GoogleFonts.poppins(
  color: text,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);

TextStyle p2 = GoogleFonts.poppins(
  color: text,
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
);
TextStyle p3 = GoogleFonts.poppins(
  color: text,
  fontSize: 10.0,
  fontWeight: FontWeight.w400,
);
TextStyle pBold = GoogleFonts.poppins(
  color: white,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
TextStyle pLocation = GoogleFonts.poppins(
  color: white,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
