const googleApiKey = 'AIzaSyBVSMxkCh-NnU8vWBBHzxGobSYDqwWiotI';

class LocationMap {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    return "https://maps.googleapis.com/maps/api/staticmap?"
        "${latitude ?? ""},${longitude ?? ""}&zoom=13&size=600x300&maptype=roadmap"
        "&markers=color:red%7Clabel:A%7C${latitude ?? ""},${longitude ?? ""}"
        "&key=$googleApiKey";
  }
}
