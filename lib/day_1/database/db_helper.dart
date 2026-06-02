import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project_nobody/day_1/models/user_model_sql.dart'; // Sesuaikan path ini jika merah

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expert.db'); // Nama database barumu

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            email TEXT UNIQUE,
            noHp TEXT,
            asalKota TEXT
          )
        ''');
      },
    );
  }

  // 1. Fungsi Create (Simpan Data Baru)
  Future<bool> registerUser(UserModelSql pengguna) async {
    final db = await database;
    try {
      await db.insert('users', pengguna.toMap());
      return true;
    } catch (e) {
      return false; // Gagal jika email duplikat atau error lain
    }
  }

  // 2. Fungsi Read (Ambil Semua Data untuk ListView)
  Future<List<UserModelSql>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query('users');
    return results.map((map) => UserModelSql.fromMap(map)).toList();
  }

  // 3. Fungsi Delete (Hapus Data)
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // 4. Fungsi Login (Masih dipertahankan agar Tugas 6 kamu gak error)
  Future<UserModelSql?> loginUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'users',
      where:
          'email = ?', // Karena di form baru password dihilangkan, disesuaikan saja
      whereArgs: [email],
    );

    if (results.isNotEmpty) {
      return UserModelSql.fromMap(results.first);
    }
    return null;
  }
}
