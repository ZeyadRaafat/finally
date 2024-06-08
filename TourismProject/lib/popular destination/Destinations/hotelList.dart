import 'hotel.dart';
import './Alex/hotels.dart';
import './Cairo/hotels.dart';
import './LuxorAswan/hotels.dart';
import './Hurghada/hotels.dart';
import './Sinai/hotels.dart';
import './Siwa/hotels.dart';


List<Hotel> hotels = []
 ..addAll(alexHotels)
 ..addAll(cairoHotels)
 ..addAll(hurghadaHotels)
 ..addAll(luxorAswanHotels)
 ..addAll(sinaiHotels)
 ..addAll(siwaHotels);