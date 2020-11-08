class TermsModel {
  TermsModel({
    this.termsAndConditions,
  });

  final String termsAndConditions;

  factory TermsModel.fromMap(Map<String, dynamic> json) => TermsModel(
    termsAndConditions: json["termsAndConditions"] == null ? null : json["termsAndConditions"],
  );
}
