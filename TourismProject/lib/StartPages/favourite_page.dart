import 'package:flutter/material.dart';
import 'package:Guide/popular%20destination/Destinations/HotelTolist.dart';
import 'package:Guide/popular%20destination/Destinations/PlaceTolist.dart';
import 'package:Guide/popular%20destination/Destinations/restTolist.dart';

class FavoriteHotel extends StatelessWidget {
  final List<dynamic> favoriteHotels;

  FavoriteHotel(this.favoriteHotels);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Row(mainAxisSize: MainAxisSize.min, children: [
            Text("Favourite Hotels ",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'MadimiOne',
                  color: Color.fromARGB(255, 121, 155, 228),
                  //fontWeight: FontWeight.bold,
                )),
          ]),
          centerTitle: true,
        ),
      body: ListView.builder(
        itemCount: favoriteHotels.length,
        itemBuilder: (context, index) {
          return HotelListItem(
             favoriteHotels[index],
             index,
            favoriteHotels[index].imagePaths,
          );
        },
      ),
    );
  }
}

class FavoritePlace extends StatelessWidget {
  final List<dynamic> favoriteplaces;

  FavoritePlace(this.favoriteplaces);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Row(mainAxisSize: MainAxisSize.min, children: [
            Text("Favourite Places ",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'MadimiOne',
                  color: Color.fromARGB(255, 121, 155, 228),
                  //fontWeight: FontWeight.bold,
                )),
          ]),
          centerTitle: true,
        ),
      body: ListView.builder(
        itemCount: favoriteplaces.length,
        itemBuilder: (context, index) {
          return PlaceListItem(
             favoriteplaces[index],
             index,
            favoriteplaces[index].imagePaths,
          );
        },
      ),
    );
  }
}

class FavouriteRest extends StatelessWidget {
  final List<dynamic> favouriteRests;

  FavouriteRest(this.favouriteRests);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Row(mainAxisSize: MainAxisSize.min, children: [
            Text("Favourite Restaurants ",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'MadimiOne',
                  color: Color.fromARGB(255, 121, 155, 228),
                  //fontWeight: FontWeight.bold,
                )),
          ]),
          centerTitle: true,
        ),
      body: ListView.builder(
        itemCount: favouriteRests.length,
        itemBuilder: (context, index) {
          return RestListItem(
             favouriteRests[index],
             index,
            favouriteRests[index].imagePaths,
          );
        },
      ),
    );
  }
}