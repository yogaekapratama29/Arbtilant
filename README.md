# 🌿 Arbtilant — Plant Disease Detection App

**Arbtilant** adalah aplikasi Flutter yang dirancang untuk **mendeteksi penyakit tanaman** melalui **pemindaian daun menggunakan kamera perangkat**.  
Aplikasi ini memanfaatkan model **TensorFlow Lite (TFLite)** untuk melakukan klasifikasi gambar secara *offline* dan memberikan **diagnosis serta saran perawatan tanaman**.

---

## 📘 Ringkasan Proyek
| Informasi | Keterangan |
|------------|-------------|
| **Nama Aplikasi** | Arbtilant |
| **Versi** | 1.0.0+1 |
| **Platform** | Flutter (Android, iOS, Web, Desktop) |
| **Framework** | Flutter SDK ^3.8.1 |
| **Bahasa Pemrograman** | Dart |
| **Tujuan Utama** | Mendeteksi penyakit tanaman dari gambar daun dan memberikan saran perawatan |
| **Tipe ML Model** | TensorFlow Lite (.tflite) |

---

## 📁 Struktur Direktori
Proyek ini menggunakan struktur standar Flutter dengan tambahan folder untuk model AI dan data pendukung.


---

## 🧩 Dependensi Utama
| Paket | Fungsi |
|-------|---------|
| **flutter** | SDK utama |
| **cupertino_icons** | Ikon gaya iOS |
| **camera** | Mengakses kamera perangkat |
| **path_provider** | Menyimpan file di direktori lokal |
| **google_fonts** | Font *Poppins* untuk antarmuka |
| **tflite_flutter** | Menjalankan model TensorFlow Lite |
| **image** | Pemrosesan gambar sebelum inferensi |
| **flutter_lints** | Menjaga kualitas kode |

---

## 🖼️ Assets
| Lokasi | Deskripsi |
|--------|------------|
| `assets/model/model.tflite` | Model TensorFlow Lite untuk klasifikasi daun |
| `assets/model/labels.txt` | Label kelas model: `Sehat`, `Powdery`, `Hawar` |
| `assets/logo.jpg` | Logo aplikasi (splash screen) |
| `assets/virus.png` | Ikon hasil diagnosis |

---

## 🧠 Arsitektur Kode

### `main.dart`
- Titik masuk utama aplikasi.  
- Menginisialisasi `MaterialApp` dengan tema hijau (`deepPurple` untuk aksen).  
- Mengarahkan pengguna ke **SplashScreen**.

---

### 📄 Pages/
#### **splash_screen.dart**
- Menampilkan logo dan nama aplikasi selama 3 detik.  
- Navigasi otomatis ke **HomePage**.

#### **home_page.dart**
- Beranda aplikasi berisi deskripsi singkat fitur.  
- Tombol **"Scan Plant"** untuk menuju halaman pemindaian.  
- Bottom navigation bar (Home, Scan, Library, Profile) — hanya “Scan” yang aktif.

#### **scan.dart**
- Fitur utama aplikasi.
- Menginisialisasi kamera, mengambil foto daun.
- Menjalankan model TFLite untuk klasifikasi.
- Menampilkan hasil diagnosis (label + confidence + saran perawatan) dalam modal bottom sheet.

---

### ⚙️ Controller/
#### **model_controller.dart**
- Mengelola proses pemuatan dan inferensi model ML.
- Memuat file model `.tflite` dan `labels.txt`.
- Melakukan praproses gambar:
  - Resize ke `224x224`
  - Normalisasi piksel
- Menjalankan prediksi dan mengembalikan **3 label teratas** dengan skor kepercayaan (*confidence*).

---

### 🌱 Data/
#### **data_treat.dart**
Berisi saran perawatan berdasarkan hasil diagnosis:
| Indeks | Kelas | Saran Perawatan |
|---------|--------|-----------------|
| 0 | Sehat | Pesan positif |
| 1 | Powdery Mildew | Pangkas daun, siram pagi, jaga sirkulasi udara, gunakan pupuk SNI |
| 2 | Hawar (Downy Mildew) | Pangkas daun terinfeksi, kontrol kelembapan, gunakan fungisida, pupuk sesuai SNI |

---

### 🎨 Core/Constants/
#### **colors.dart**
- Mendefinisikan warna utama aplikasi:
  - `darkGreen = #006400`
  - `mediumGreen = #32CD32`

---

## 🔄 Alur Kerja Aplikasi
1. **Splash Screen:** Menampilkan logo 3 detik.  
2. **Home Page:** Pengguna menekan “Scan Plant”.  
3. **Scan Page:**  
   - Kamera aktif → Ambil foto daun.  
   - Gambar disimpan sementara → Diproses oleh model ML.  
   - Tampilkan hasil klasifikasi & saran perawatan.  

---

## 🌟 Fitur Utama
- 📸 **Deteksi Penyakit Tanaman** menggunakan AI (TFLite)  
- 🤖 **Pemrosesan Offline** tanpa koneksi internet  
- 🎨 **UI Ramah Pengguna** dengan tema hijau alami  
- 🔍 **Integrasi Kamera Real-time**  
- 🧾 **Saran Perawatan Tanaman Otomatis**

---

## 🧩 Kesimpulan
**Arbtilant** adalah aplikasi mobile sederhana namun fungsional untuk mendeteksi penyakit tanaman secara cepat dan akurat.  
Struktur kode yang modular (UI, Controller, Data) membuatnya mudah dikembangkan lebih lanjut, dan pemrosesan **on-device ML** memungkinkan diagnosis tanpa koneksi internet.

> 🌾 Cocok untuk petani, penghobi tanaman, dan praktisi pertanian yang membutuhkan deteksi cepat tanpa ahli lapangan.

---

## 🚀 Cara Menjalankan Proyek
```bash
# Clone repo
git clone https://github.com/username/arbtilant.git
cd arbtilant

# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run
