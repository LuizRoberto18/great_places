import 'package:create_places/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/grate_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus lugares"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GratePlaces>(context, listen: false).loadPlaces(),
        builder: (context, AsyncSnapshot snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GratePlaces>(
                builder: (context, gratePlaces, child) => gratePlaces.itemsCount == 0
                    ? child!
                    : ListView.builder(
                        itemCount: gratePlaces.itemsCount,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(gratePlaces.itemByIndex(index).image),
                            ),
                            title: Text(gratePlaces.itemByIndex(index).title),
                            onTap: () {},
                          );
                        },
                      ),
                child: Center(
                  child: Text("Nenhum local cadastrado"),
                ),
              ),
      ),
    );
  }
}
