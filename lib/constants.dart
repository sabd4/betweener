import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// =============   endpoints   ============
const baseUrl = 'http://www.osamapro.online/api';
const loginUrl = '$baseUrl/login';
const linksUrl = '$baseUrl/links';
const searchUrl = '$baseUrl/search';
const followUrl = '$baseUrl/follow';

// ============= STYLE CONSTS ==============

const kScaffoldColor = Color(0xffFDFDFD);
const kRedColor = Color(0xffA90606);

const kPrimaryColor = Color(0xff2D2B4E);
const kSecondaryColor = Color(0xffFFD465);
const kOnSecondaryColor = Color(0xff784E00);
const kDangerColor = Color(0xffF56C61);

// Low Opacity Colors
const kLinksColor = Color(0xff807D99);
const kLightPrimaryColor = Color(0xffE7E5F1);
const kLightSecondaryColor = Color(0xffFFE6A6);
const kLightDangerColor = Color(0xffFEE2E7);
const kOnLightDangerColor = Color(0xff783341);
const kOnLightDangerFontColor = Color(0xff9B6A73);

// ============= FONT CONSTS ==============

const profileText =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16);
const spacingText = const TextStyle(
  letterSpacing: 3.0,
  color: kPrimaryColor,
);
// =============  CONSTS ==============
const spinkit = SpinKitThreeBounce(
  color: kPrimaryColor,
  size: 20.0,
);
