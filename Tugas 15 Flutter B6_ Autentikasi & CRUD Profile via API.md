## **Tugas 15 Flutter: Autentikasi & CRUD Profile via API**

### **1\. Tujuan Pembelajaran**

* **Write Operations:** Peserta mampu melakukan pengiriman data ke server menggunakan metode **POST** (Register/Login) dan **PUT** (Update Profile).
* **Token-Based Auth:** Memahami cara menangkap dan menggunakan *Bearer Token* dari API untuk mengakses data yang diproteksi.
* **State Management:** Mengelola perubahan data profil secara dinamis menggunakan `TextEditingController` dan `setState`.
* **Secure Networking:** Mengimplementasikan *Interceptor* pada Dio untuk menyertakan otorisasi secara otomatis di setiap request.

---

### **2\. Makna Tugas**

Hampir seluruh aplikasi profesional memerlukan fitur akun pengguna. Tugas ini mensimulasikan alur nyata pendaftaran pengguna, proses masuk (*login*), hingga perubahan profil mandiri. Peserta akan belajar bahwa data di internet bersifat privat, sehingga diperlukan "kunci" (token) untuk membaca atau mengubah informasi tersebut.

---

### **3\. Instruksi Umum**

Bangunlah aplikasi Flutter yang terhubung dengan server **MobilePro** untuk mengelola data akun. Pastikan alur navigasi berjalan sesuai dengan urutan proses autentikasi yang benar.

**Wajib Menggunakan:** Package `dio`, `retrofit`, `flutter_secure_storage`, dan API Endpoint yang telah disediakan.

**Base URL:** `https://appabsensi.mobileprojp.com`

> ⚠️ **Perhatian:** Pastikan semua service (termasuk `AuthService` dan `ApiService`) menggunakan base URL yang sama, yaitu `https://appabsensi.mobileprojp.com`. Jangan menggunakan URL lama seperti `absensib1.mobileprojp.com`.

---

### **4\. Detail Teknis & Alur Tugas**

#### **4.1 Arsitektur Wajib**

##### `dio_client.dart` — DioClient dengan Interceptor

```dart
import 'package:dio/dio.dart';
import 'package:project_nobody/day_1/services/token_services.dart';

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://appabsensi.mobileprojp.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );

  // Interceptor otomatis menyisipkan Bearer Token ke setiap request
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  return dio;
}
```

> **Keuntungan Interceptor:** Karena `dio_client.dart` sudah menyisipkan Bearer Token secara otomatis via interceptor, endpoint yang membutuhkan auth (getProfile, updateProfile) TIDAK perlu lagi menerima parameter `@Header("Authorization")` secara eksplisit di `ApiService`.

##### `token_services.dart` — TokenStorage (sudah tersedia)

Gunakan class `TokenStorage` untuk menyimpan dan membaca token secara konsisten:

```dart
// Simpan token setelah login berhasil
await TokenStorage.saveToken(token);

// Baca token (digunakan oleh interceptor)
final token = await TokenStorage.getToken();

// Hapus token saat logout
await TokenStorage.clearToken();
```

---

#### **4.2 API Endpoints (dari Postman Collection ABSENSI PPKD B3)**

##### `POST /api/register`

**Headers:** `Accept: application/json`

**Body (raw JSON):**

```json
{
  "name": "Budi",
  "email": "budi@example.com",
  "password": "Password123!",
  "jenis_kelamin": "L",
  "profile_photo": "data:image/png;base64,<base64_string>",
  "batch_id": 1,
  "training_id": 1
}
```

> Nilai `jenis_kelamin`: `"L"` (Laki-laki) atau `"P"` (Perempuan).
> Field `profile_photo` bersifat opsional saat register — bisa diisi dengan placeholder base64 minimal.

**Response sukses (200):**

```json
{
  "message": "Register berhasil",
  "data": {
    "token": "<bearer_token>",
    "user": { "id": 1, "name": "Budi", "..." }
  }
}
```

---

##### `POST /api/login`

**Headers:** `Accept: application/json`

**Body (raw JSON):**

```json
{
  "email": "budi@example.com",
  "password": "Password123!"
}
```

**Response sukses (200):**

```json
{
  "message": "Login berhasil",
  "data": {
    "token": "<bearer_token>",
    "user": {
      "id": 1,
      "name": "Budi",
      "email": "budi@example.com",
      "jenis_kelamin": "L",
      "profile_photo": "users/foto.jpg",
      "batch_id": "1",
      "training_id": "1"
    }
  }
}
```

> **Catatan Model:** Field `batch_id` dan `training_id` dari server dapat berupa `String` atau `int`. Gunakan custom `fromJson` converter di `UserModel`:
>
> ```dart
> int? _stringToInt(dynamic value) {
>   if (value == null) return null;
>   if (value is int) return value;
>   if (value is String) return int.tryParse(value);
>   return null;
> }
> ```

---

##### `GET /api/profile`

**Headers:** `Authorization: Bearer <token>` *(disisipkan otomatis oleh interceptor)*

**Response sukses (200):**

```json
{
  "message": "...",
  "data": {
    "id": 1,
    "name": "Budi",
    "email": "budi@example.com",
    "jenis_kelamin": "L",
    "profile_photo": "users/foto.jpg",
    "batch_id": "1",
    "training_id": "1",
    "email_verified_at": null
  }
}
```

> Field `profile_photo` adalah path relatif. Untuk menampilkan gambar, bangun URL lengkap:
>
> ```dart
> final photoUrl = photo.startsWith('http')
>     ? photo
>     : 'https://appabsensi.mobileprojp.com/storage/$photo';
> ```

---

##### `PUT /api/profile` — Update Data & Foto Profil

**Headers:** `Authorization: Bearer <token>` *(otomatis dari interceptor)*

**Body (raw JSON)** — dapat menyertakan satu atau lebih field:

```json
{
  "name": "Budi Updated",
  "email": "budi_new@example.com",
  "password": "NewPassword123!",
  "jenis_kelamin": "L",
  "batch_id": 1,
  "training_id": 1,
  "profile_photo": "data:image/png;base64,<base64_string>"
}
```

> **Update foto dilakukan via endpoint yang SAMA** (`PUT /api/profile`), cukup sertakan field `profile_photo` berisi string base64 dalam body. **Tidak ada endpoint terpisah `/api/profile/photo`.**
> Field `password` bersifat opsional — kosongkan jika tidak ingin mengubah password.

**Response sukses (200):**

```json
{
  "message": "Profile updated successfully",
  "data": { "..." }
}
```

---

#### **4.3 `ApiService` yang Direkomendasikan**

Karena interceptor sudah menangani Authorization, definisikan `ApiService` seperti berikut (hapus parameter `@Header` yang redundan):

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/auth_response.dart';
import '../models/login_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://appabsensi.mobileprojp.com")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/api/register")
  Future<LoginResponse> register(@Body() Map<String, dynamic> body);

  @POST("/api/login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  // Tidak perlu @Header Authorization — sudah ditangani interceptor
  @GET("/api/profile")
  Future<AuthResponse> getProfile();

  // Tidak perlu @Header Authorization — sudah ditangani interceptor
  // Satu endpoint untuk update data DAN foto profil
  @PUT("/api/profile")
  Future<AuthResponse> updateProfile(@Body() Map<String, dynamic> body);
}
```

> Setelah mengubah `ApiService`, jalankan: `dart run build_runner build --delete-conflicting-outputs`

---

#### **4.4 Alur Kerja Aplikasi (User Flow)**

1. **Register:** User mengisi form (Nama, Email, Password, Jenis Kelamin, Batch ID, Training ID) → `POST /api/register` → Navigasi ke halaman Login.
2. **Login:** User memasukkan Email & Password → `POST /api/login` → Simpan token via `TokenStorage.saveToken(token)` → Navigasi ke halaman Profil.
3. **Get Profile:** Setelah login, fetch `GET /api/profile` (token otomatis via interceptor) → Tampilkan data profil.
4. **Edit Profile:** User mengubah data → `PUT /api/profile` dengan body berisi field yang diubah.
5. **Edit Foto Profil:** User memilih foto dari galeri → Convert ke base64 → Sertakan field `profile_photo` di body `PUT /api/profile`.
6. **Logout:** Hapus token via `TokenStorage.clearToken()` → Kembali ke halaman Login.

---

### **5\. Checklist Implementasi**

| Fitur | Spesifikasi Teknis |
| :---- | :---- |
| **Form Login & Register** | Gunakan `TextFormField` dengan validasi. Kirim data menggunakan `ApiService` via Dio. |
| **Auth Handling** | Simpan token dari response login menggunakan `TokenStorage.saveToken()`. Jangan simpan token manual ke `FlutterSecureStorage` dengan key berbeda. |
| **DioClient Interceptor** | Gunakan `createDioClient()` dari `dio_client.dart` — interceptor otomatis menyisipkan Bearer Token. Endpoint profil TIDAK perlu `@Header` Authorization. |
| **Profile Dashboard** | Tampilkan data user (Nama, Email, Jenis Kelamin, Batch ID, Training ID, Foto Profil) menggunakan `FutureBuilder` atau `setState`. Bangun URL foto dengan prefix `https://appabsensi.mobileprojp.com/storage/` jika bukan URL lengkap. |
| **Update Profile** | Gunakan `PUT /api/profile` untuk update data maupun foto. Gabungkan dalam satu request jika keduanya berubah. |
| **Update Foto** | Gunakan `image_picker` untuk memilih foto. Convert ke base64 dengan prefix `data:image/png;base64,`. Kirim via field `profile_photo` di `PUT /api/profile`. |
| **Modern UI** | Tampilkan `CircularProgressIndicator` saat request berlangsung. |

---

### **6\. Hal-hal yang Perlu Dihindari (Common Pitfalls)**

| Salah | Benar |
| :---- | :---- |
| Menggunakan base URL `absensib1.mobileprojp.com` | Selalu gunakan `appabsensi.mobileprojp.com` |
| Menambah `@Header("Authorization")` ke setiap method ApiService | Andalkan interceptor di `createDioClient()` |
| Membuat endpoint terpisah `/api/profile/photo` | Gabungkan `profile_photo` ke body `PUT /api/profile` |
| Menyimpan token dengan key berbeda-beda di FlutterSecureStorage | Gunakan `TokenStorage` secara konsisten |
| Tidak menangani `batch_id`/`training_id` sebagai String dari server | Gunakan `_stringToInt` converter di `UserModel` |
| Memanggil `getProfile("Bearer $token")` secara manual | Cukup `apiService.getProfile()` — token sudah di-inject |

---

### **7\. Bonus / Tantangan (Opsional)**

* **Token Persistence:** Gunakan `TokenStorage` agar user tidak perlu login ulang saat aplikasi ditutup. Cek token saat `initState` di splash/main dan langsung navigasi ke ProfilePage jika token masih ada.
* **Detail User:** Tambahkan navigasi untuk melihat detail informasi akun secara lebih lengkap.
* **Clean UI:** Gunakan desain yang modern dengan *Custom Shapes*, *Shadows*, dan skema warna yang menarik.
* **Optimistic Update:** Perbarui UI lokal segera setelah `PUT /api/profile` sukses tanpa perlu fetch ulang dari server.
