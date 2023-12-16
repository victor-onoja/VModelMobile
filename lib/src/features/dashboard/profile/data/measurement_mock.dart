class MeasurementObjectModel {
  final String? title;
  final String? label;
  MeasurementObjectModel({this.title, this.label});
}

List<MeasurementObjectModel> measurementModelList() => [
      MeasurementObjectModel(title: "5'11", label: "Height"),
      MeasurementObjectModel(title: "38", label: "Chest"),
      MeasurementObjectModel(title: "36", label: "Weight"),
      MeasurementObjectModel(title: "Brown", label: "Hair"),
      MeasurementObjectModel(title: "Brown", label: "Eyes")
    ];
