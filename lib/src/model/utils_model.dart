

class UtilsModel {
    List<String> planes;
    List<String> plataforma;

  UtilsModel.fromMapPlan(Map<dynamic, dynamic> data)
      : planes = List.from(data['planes']);

  UtilsModel.fromMapPlat(Map<dynamic, dynamic> data)
      : plataforma = List.from(data['plataforma']);
}

