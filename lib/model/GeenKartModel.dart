import 'dart:convert';

List<GreenKartModel> greenKartModelFromJson(String str) => List<GreenKartModel>.from(json.decode(str).map((x) => GreenKartModel.fromJson(x)));

String greenKartModelToJson(List<GreenKartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GreenKartModel {
    GreenKartModel({
        this.pName,
        this.pImage,
        this.pId,
        this.pCost,
        this.pAvailability,
        this.pDetails,
        this.pCategory,
    });

    String? pName;
    String? pImage;
    int? pId;
    int? pCost;
    int? pAvailability;
    String? pDetails;
    String? pCategory;

    factory GreenKartModel.fromJson(Map<String, dynamic> json) => GreenKartModel(
        pName: json["p_name"],
        pImage: json["p_image"],
        pId: json["p_id"],
        pCost: json["p_cost"],
        pAvailability: json["p_availability"],
        pDetails: json["p_details"] == null ? null : json["p_details"],
        pCategory: json["p_category"],
    );

    Map<String, dynamic> toJson() => {
        "p_name": pName,
        "p_image": pImage,
        "p_id": pId,
        "p_cost": pCost,
        "p_availability": pAvailability,
        "p_details": pDetails == null ? null : pDetails,
        "p_category": pCategory,
    };
}
