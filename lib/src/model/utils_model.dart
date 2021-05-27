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
}

// UtilsModel.fromMapDep(Map<dynamic, dynamic> data)
//     : departamentos = List.from(data['departamentos']);

// UtilsModel.fromMapprovlima(Map<dynamic, dynamic> data)
//     : limaprovincias = List.from(data['provincias-Lima']);

// UtilsModel.fromMapprovcusco(Map<dynamic, dynamic> data)
//     : cuscoprovincias = List.from(data['provincias-Cusco']);

// UtilsModel.fromMapdislima(Map<dynamic, dynamic> data)
//     : limadistritos = List.from(data['distritos-Lima']);

// UtilsModel.fromMapdiscusco(Map<dynamic, dynamic> data)
//     : cuscodistritos = List.from(data['distritos-Cusco']);
