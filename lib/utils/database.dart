import 'dart:io';
import 'package:agenda_escolar/models/dia.dart';
import 'package:agenda_escolar/models/jornada.dart';
import 'package:agenda_escolar/models/localizacion.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/models/proyecto.dart';
import 'package:agenda_escolar/models/tarea.dart';
import 'package:agenda_escolar/models/examen.dart';


import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider{
  DBProvider._();
  static final DBProvider db = DBProvider._();

  //String de los nombres de las tablas

  //nombreGenerales
  final String columnId = "id";
  final String columnNombre = "nombre";
  final String columnDescripcion = "descripcion";
  final String columnFechaDeEntrega = "fechaDeEntrega";

  //Tabla: Tarea
  final String tareaTable = "Tarea";
  final String columnIdMateria = "idMateria";
  final String columnAcabado = "acabado";

  //Tabla: Proyecto
  final String proyectoTable = "Proyecto";

  //Tabla: Examen
  final String examenTable = "Examen";

  //Tabla: Profesor
  final String profesorTable = "Profesor";
  final String columnInformacionDeContacto = "informacionDeContacto";

  //Tabla: Materia
  final String materiaTable = "Materia";
  final String columnColor = "color";
  final String columnMismaHora = "mismaHora";
  final String columnMismoSalon = "mismoSalon";

  //Tabla: Localizacion
  final String localizacionTable = "Localizacion";
  final String columnEdificio = "edifico";
  final String columnSalon = "salon";

  //Tabla: Modulo
  final String moduloTable = "Modulo";
  final String columnIdLocalizacion = "idLocalizacion";
  final String columnIdDia = "idDia";
  final String columnHoraDeInicio = "horaDeInicio";
  final String columnHoraDeFinal = "horaDeFinal";

  //Tabla: Dia
  final String diaTable = "Dia";
  final String columnDiaActivo = "diaActivo";
  final String columnIdJornada = "idJornada";

  //Tabla: Jornada
  final String jornadaTable = "Jornada";
  final String columnDuracion = "duracion";
  final String columnNumeroDias = "numeroDias";


  static Database _database;

  Future <Database> get database async{
    if (_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "AgendaEscol.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tareaTable ($columnId INTEGER PRIMARY KEY, $columnIdMateria INTEGER,$columnNombre TEXT,$columnDescripcion TEXT,$columnFechaDeEntrega TEXT,$columnAcabado INTEGER, FOREIGN KEY ($columnIdMateria) REFERENCES $materiaTable($columnId))");
      await db.execute("CREATE TABLE $proyectoTable ($columnId INTEGER PRIMARY KEY, $columnIdMateria INTEGER,$columnNombre TEXT,$columnDescripcion TEXT,$columnFechaDeEntrega TEXT,$columnAcabado INTEGER, FOREIGN KEY ($columnIdMateria) REFERENCES $materiaTable($columnId))");
      await db.execute("CREATE TABLE $examenTable ($columnId INTEGER PRIMARY KEY, $columnIdMateria INTEGER,$columnDescripcion TEXT,$columnFechaDeEntrega TEXT,$columnAcabado INTEGER, FOREIGN KEY ($columnIdMateria) REFERENCES $materiaTable($columnId))");
      await db.execute("CREATE TABLE $materiaTable ($columnId INTEGER PRIMARY KEY, $columnNombre TEXT, $columnMismaHora INTEGER,$columnMismoSalon INTEGER,$columnColor INTEGER)");
      await db.execute("CREATE TABLE $localizacionTable ($columnId INTEGER PRIMARY KEY, $columnSalon TEXT)");
      await db.execute("CREATE TABLE $jornadaTable ($columnId INTEGER PRIMARY KEY,$columnDuracion INTEGER, $columnNumeroDias INTEGER)");
      await db.execute("CREATE TABLE $diaTable ($columnId INTEGER PRIMARY KEY)");
      await db.execute("CREATE TABLE $moduloTable ($columnId INTEGER PRIMARY KEY, $columnIdMateria INTEGER, $columnIdLocalizacion INTEGER, $columnIdDia INTEGER, $columnHoraDeInicio TEXT, $columnHoraDeFinal TEXT, FOREIGN KEY ($columnIdMateria) REFERENCES $materiaTable($columnId), FOREIGN KEY ($columnIdLocalizacion) REFERENCES $localizacionTable($columnId) ,FOREIGN KEY ($columnIdDia) REFERENCES $diaTable($columnId))");
      for(int i = 1 ; i < 8; i++){
        Dia temp = Dia(id:i);
        nuevoDia(temp);
      }
    });
  }

  //CRUD Materia

  nuevaMateria(Materia materia) async{
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into $materiaTable ($columnNombre,$columnMismaHora,$columnColor)"
        " VALUES (?,?, ?)",
        [materia.nombre,materia.mismaHora, materia.color]);
    return raw;
  }

  nuevaMateriaM(Materia materia)async{
    final db = await database;
    await db.insert(materiaTable, materia.toJson());
  }

  obtenerIdMaxMateria()async{
    final db = await database;
    var table = await db.rawQuery("SELECT * FROM $materiaTable ORDER BY id DESC LIMIT 1");
    if(table.isEmpty){
      return 1;
    }
    else{
      print(table[table.length - 1]["id"].toString() + "aaaaaaa");
      return table[0]["id"];
    }
  }

  obtenerMateria(int id) async{
    final db = await database;
    var res= await db.query(materiaTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Materia.fromJson(res.first) : Null ;
  }

  obtenerTodasLasMaterias() async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $materiaTable");
    List<Materia> lista = List<Materia>(); 
    for(int i = 0 ; i < res.length; i++){
      Materia temp = Materia.fromJson(res[i]);
      lista.add(temp);
    }
    return lista;
  }

  actualizarMateria(Materia materia) async{
    final db = await database;
    await db.update(materiaTable, materia.toJson(),where: "id = ?", whereArgs: [materia.id]);
  }

  eliminarMateria(int id)async{
    final db = await database;
    db.delete(materiaTable,where: "id = ?", whereArgs: [id]);
  }

  //CRUD Tarea

  nuevaTarea(Tarea tarea) async{
    final db = await database;
    await db.insert(tareaTable, tarea.toJson());
  }

  obtenerTarea(int id) async{
    final db = await database;
    var res= await db.query(tareaTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Tarea.fromJson(res.first) : Null ;
  }

  obtenerTodasLasTareas() async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $tareaTable");
    List<Tarea> lista = List<Tarea>(); 
    for(int i = 0 ; i < res.length; i++){
      Tarea temp = Tarea.fromJson(res[i]);
      lista.add(temp);
    }
    return lista;
  }

  actualizarTarea(Tarea tarea) async{
    final db = await database;
    await db.update(tareaTable, tarea.toJson(),where: "id = ?", whereArgs: [tarea.id]);
  }

  eliminarTarea(int id)async{
    final db = await database;
    db.delete(tareaTable,where: "id = ?", whereArgs: [id]);
  }

  //CRUD Proyecto

  nuevaProyecto(Proyecto proyecto) async{
    final db = await database;
    await db.insert(proyectoTable, proyecto.toJson());
  }

  obtenerProyecto(int id) async{
    final db = await database;
    var res= await db.query(proyectoTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Proyecto.fromJson(res.first) : Null ;
  }

  obtenerTodosLosProyectos() async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $proyectoTable");
    List<Proyecto> lista = List<Proyecto>(); 
    for(int i = 0 ; i < res.length; i++){
      Proyecto temp = Proyecto.fromJson(res[i]);
      lista.add(temp);
    }
    return lista;
  }

  actualizarProyecto(Proyecto proyecto) async{
    final db = await database;
    await db.update(proyectoTable, proyecto.toJson(),where: "id = ?", whereArgs: [proyecto.id]);
  }

  eliminarProyecto(int id)async{
    final db = await database;
    db.delete(proyectoTable,where: "id = ?", whereArgs: [id]);
  }

  //CRUD  Examen
  nuevaExamen(Examen examen) async{
    final db = await database;
    await db.insert(examenTable, examen.toJson());
  }

  obtenerExamen(int id) async{
    final db = await database;
    var res= await db.query(examenTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Examen.fromJson(res.first) : Null ;
  }

  obtenerTodosLosExamenes() async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $examenTable");
    List<Examen> lista = List<Examen>(); 
    for(int i = 0 ; i < res.length; i++){
      Examen temp = Examen.fromJson(res[i]);
      lista.add(temp);
    }
    return lista;
  }

  actualizarExamen(Examen examen) async{
    final db = await database;
    await db.update(examenTable, examen.toJson(),where: "id = ?", whereArgs: [examen.id]);
  }

  eliminarExamen(int id)async{
    final db = await database;
    db.delete(examenTable,where: "id = ?", whereArgs: [id]);
  }

  //CRUD Localizacion

  nuevaLocalizacion(Localizacion localizacion) async{
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 FROM $materiaTable");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into $localizacionTable (id,$columnSalon)"
        " VALUES (?,?)",
        [id, localizacion.salon]);
    return raw;
  }

  obtenerLocalizacion(int id) async{
    final db = await database;
    var res= await db.query(localizacionTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Localizacion.fromJson(res.first) : Null ;
  }

  obtenerTodasLasLocalizaciones() async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $localizacionTable");
    List<Localizacion> lista = List<Localizacion>(); 
    for(int i = 0 ; i < res.length; i++){
      Localizacion temp = Localizacion.fromJson(res[i]);
      lista.add(temp);
    }
    return lista;
  }

  actualizarLocalizacion(Localizacion localizacion) async{
    final db = await database;
    await db.update(localizacionTable, localizacion.toJson(),where: "id = ?", whereArgs: [localizacion.id]);
  }

  eliminarLocalizacion(int id)async{
    final db = await database;
    db.delete(localizacionTable,where: "id = ?", whereArgs: [id]);
  }

  //CRUD Modulo

  nuevaModulo(Modulo modulo) async{
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 FROM $moduloTable");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into $Modulo($columnId,$columnIdMateria,$columnIdLocalizacion,$columnIdDia,$columnHoraDeInicio,$columnHoraDeFinal)"
        " VALUES (?,?,?,?,?,?)",
        [id,modulo.idMateria,modulo.idLocalizacion,modulo.idDia, modulo.horaDeInicio, modulo.horaDeFinal]);
    return raw;

  }

  obtenerModulo(int id) async{
    final db = await database;
    var res= await db.query(moduloTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Modulo.fromJson(res.first) : Null ;
  }

  obtenerTodosLosModulos() async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $moduloTable");
    List<Modulo> lista = List<Modulo>(); 
    for(int i = 0 ; i < res.length; i++){
      Modulo temp = Modulo.fromJson(res[i]);
      lista.add(temp);
    }
    return lista;
  }

  obtenerTodosLosModulosPorMateria(int idMateria)async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $moduloTable where $columnIdMateria = $idMateria");
    List<Modulo> lista = List<Modulo>(); 
    for(int i = 0 ; i < res.length; i++){
      Modulo temp = Modulo.fromJson(res[i]);
      lista.add(temp);
    }
    return lista;
  }

  actualizarModulo(Modulo modulo) async{
    final db = await database;
    await db.update(moduloTable, modulo.toJson(),where: "id = ?", whereArgs: [modulo.id]);
  }

  eliminarModulo(int id)async{
    final db = await database;
    db.delete(moduloTable,where: "id = ?", whereArgs: [id]);
  }

  eliminarModulosPorMateria(Materia materia)async{
    final db = await database;
    db.rawDelete("Delete from $moduloTable where $columnIdMateria = ${materia.id}"); 
  }

  //CRUD Dia

  nuevoDia(Dia dia) async{
    final db = await database;
    await db.insert(diaTable, dia.toJson());
  }

  obtenerDia(int id) async{
    final db = await database;
    var res= await db.query(diaTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Dia.fromJson(res.first) : Null ;
  }

  actualizarDia(Dia dia) async{
    final db = await database;
    await db.update(diaTable, dia.toJson(),where: "id = ?", whereArgs: [dia.id]);
  }

  eliminarDia(int id)async{
    final db = await database;
    db.delete(diaTable,where: "id = ?", whereArgs: [id]);
  }

  //CRUD Jornada

  nuevaJornada(Jornada jornada) async{
    final db = await database;
    await db.insert(jornadaTable, jornada.toJson());
  }

  obtenerJornada(int id) async{
    final db = await database;
    var res= await db.query(jornadaTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Jornada.fromJson(res.first) : Null ;
  }

  actualizarJornada(Jornada jornada) async{
    final db = await database;
    await db.update(jornadaTable, jornada.toJson(),where: "id = ?", whereArgs: [jornada.id]);
  }

  eliminarJornada(int id)async{
    final db = await database;
    db.delete(jornadaTable,where: "id = ?", whereArgs: [id]);
  }

}