class UtilsModel {
  List<String> planes;
  List<String> plataforma;
  List<String> departamentos;
  List<String> limaprovincias;
  List<String> cuscoprovincias;
  List<String> limadistritos;
  List<String> cuscodistritos;
  List<String> vendedores;
  List<String> grupo;
  List<String> tecnicos;
  Map seguimiento;

  UtilsModel.fromMapPlan(Map<dynamic, dynamic> data)
      : planes = List.from(data['planes']);

  UtilsModel.fromMapPlat(Map<dynamic, dynamic> data)
      : plataforma = List.from(data['plataforma']);

  UtilsModel.fromMapubicaciones(Map<dynamic, dynamic> data)
      : departamentos = List.from(data['departamentos']),
        limaprovincias = List.from(data['provincias-lima']),
        cuscoprovincias = List.from(data['provincias-cusco']),
        limadistritos = List.from(data['distritos-lima']),
        cuscodistritos = List.from(data['distritos-cusco']);

  UtilsModel.fromMappersonal(Map<dynamic, dynamic> data)
      : grupo = List.from(data['grupos']),
        tecnicos = List.from(data['tecnicos']);

  UtilsModel.fromMapVendedor(Map<dynamic, dynamic> data)
      : vendedores = List.from(data['vendedor']);

  UtilsModel.fromMapseguimiento(Map<dynamic, dynamic> data)
      : seguimiento = data['seguimiento'];
}

class Seguimiento {
  String color;
  String etiqueta;

  Seguimiento.fromMapseguimiento(Map<dynamic, dynamic> data)
      : color = data['color'],
        etiqueta = data['etiqueta'];
}
