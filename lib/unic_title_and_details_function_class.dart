class FeatureDetailPair {
  final String featureTitle;
  final List<String> detailTitles;

  FeatureDetailPair(this.featureTitle, this.detailTitles);
}

List<FeatureDetailPair> extractFeatureDetails(List<dynamic> vehicleFeatures) {
  Map<String, List<String>> featureDetailsMap = {};

  for (var feature in vehicleFeatures) {
    String featureTitle = feature['feature']['title']??'None';
    String detailTitle = feature['detail']?['title']??'None';

    if (!featureDetailsMap.containsKey(featureTitle)) {
      featureDetailsMap[featureTitle] = [];
    }

    // Add the detail title only if it's not already present
    if (!featureDetailsMap[featureTitle]!.contains(detailTitle)) {
      featureDetailsMap[featureTitle]?.add(detailTitle);
    }
  }

  // Convert the map to a list of FeatureDetailPair objects
  List<FeatureDetailPair> result = featureDetailsMap.entries
      .map((entry) => FeatureDetailPair(entry.key, entry.value))
      .toList();

  return result;
}