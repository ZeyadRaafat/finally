import 'restaurant.dart';
import './Alex/rest.dart';
import './Cairo/rest.dart';
import './LuxorAswan/rest.dart';
import './Hurghada/rest.dart';
import './Sinai/rest.dart';
import './Siwa/rest.dart';


List<Rest> rests=[]
 ..addAll(alexRests)
 ..addAll(cairoRests)
 ..addAll(hurghadaRests)
 ..addAll(luxorAswanRests)
 ..addAll(sinaiRests)
 ..addAll(siwaRests);