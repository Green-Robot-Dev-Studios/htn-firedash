import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Selector extends StatelessWidget {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  PickResult selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map Place Picer Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Load Google Map"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlacePicker(
                          apiKey: "AIzaSyCGVcSAa5cERtHrOJvb0T01jIuBPjeqATw",
                          initialPosition: Selector.kInitialPosition,
                          useCurrentLocation: true,
                          selectInitialPosition: true,

                          usePlaceDetailSearch: false,
                          onPlacePicked: (result) {
                            print(result);
                          },
                          //forceSearchOnZoomChanged: true,
                          //automaticallyImplyAppBarLeading: false,
                          //autocompleteLanguage: "ko",
                          //region: 'au',
                          //selectInitialPosition: true,
                          selectedPlaceWidgetBuilder:
                              (_, selectedPlace, state, isSearchBarFocused) {
                            print(
                                "state: $state, isSearchBarFocused: $isSearchBarFocused");
                            return FloatingCard(
                              bottomPosition:
                                  0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                              leftPosition: 0.0,
                              rightPosition: 0.0,
                              width: 500,
                              borderRadius: BorderRadius.circular(12.0),
                              child: RaisedButton(
                                child: Text("Pick Here"),
                                onPressed: () {
                                  // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                  //            this will override default 'Select here' Button.
                                },
                              ),
                            );
                          },
                          pinBuilder: (context, state) {
                            return Icon(Icons.pin_drop);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              selectedPlace == null
                  ? Container()
                  : Text(selectedPlace.formattedAddress ?? ""),
            ],
          ),
        ));
  }
}
