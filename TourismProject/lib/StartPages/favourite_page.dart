import 'package:flutter/material.dart';
import 'package:new_project/popular%20destination/Destinations/HotelTolist.dart';
import 'package:new_project/popular%20destination/Destinations/PlaceTolist.dart';
import 'package:new_project/popular%20destination/Destinations/restTolist.dart';

class FavoriteHotel extends StatelessWidget {
  final List<dynamic> favoriteHotels;

  FavoriteHotel(this.favoriteHotels);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Hotels'),
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
        title: Text('Favorite Places'),
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
        title: Text('Favorite Restaurants'),
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