class UtilsModel {
  List<String> planes;
  List<String> plataforma;
  Map ubicaciones;
  List<String> tecnicos;
  Map seguimiento;
  List<dynamic> planes2;

  UtilsModel.fromMapPlan(Map<dynamic, dynamic> data)
      : planes = List.from(data['planes']);

  UtilsModel.fromMapPlat(Map<dynamic, dynamic> data)
      : plataforma = List.from(data['plataforma']);

  UtilsModel.fromMapubicaciones(Map<dynamic, dynamic> data)
      : ubicaciones = data['ubicaciones'];

  UtilsModel.fromMappersonal(Map<dynamic, dynamic> data)
      : tecnicos = List.from(data['tecnicos']);

  UtilsModel.fromMapseguimiento(Map<dynamic, dynamic> data)
      : seguimiento = data['seguimiento'];
}
