# Fokus Pomodoro 🍅⚡

Aplikasi timer Pomodoro modern dan responsif berbasis Progressive Web App (PWA). Setiap tugas memiliki durasi fokus dan istirahat mandiri, dilengkapi dengan sistem otentikasi aman (SHA-256), Dashboard Admin, integrasi Database Supabase Cloud, dan analisis produktivitas komprehensif.

## ✨ Fitur Utama

- **⏱️ Timer Pomodoro Dinamis**: Pengaturan durasi fokus dan istirahat per tugas dengan lingkaran animasi dan hitungan mundur real-time.
- **✅ Ceklis Penyelesaian Tugas**: Tombol ceklis di sebelah kiri kartu tugas untuk menyelesaikan tugas lebih awal sebelum waktu habis, dengan pencatatan durasi riil.
- **📊 Persentase Progres Berjalan**: Indikator persentase real-time (contoh: 10 menit dari 25 menit = 40%) beserta bar progres visual.
- **🔐 Otentikasi Pengguna & Enkripsi SHA-256**: Login & Register dengan username dan password yang di-hash aman menggunakan algoritma SHA-256 (Web Crypto API).
- **🛡️ Dashboard Administrator**:
  - Akun admin bawaan: **username:** `admin` | **password:** `admin123`
  - Ringkasan total pengguna, total waktu fokus, dan total sesi.
  - Tabel kelola pengguna dengan fitur **Cek User** (melihat detail tugas dan riwayat sesi pengguna) dan hapus pengguna.
- **⚡ Integrasi Database Supabase Cloud**:
  - Dukungan database cloud Supabase (`@supabase/supabase-js`).
  - Skema SQL siap pakai di berkas `supabase-schema.sql`.
  - Sinkronisasi otomatis dengan fallback offline ke Local Database.
- **📈 Analisis & Grafik Blok**: Visualisasi aktivitas per hari, minggu, bulan, dan tahun.
- **🌓 Mode Tampilan**: Pilihan tema Terang dan Gelap yang otomatis mengikuti preferensi sistem atau manual.
- **📱 PWA & Dukungan Offline**: Dapat diinstal di desktop (Windows/Mac) maupun perangkat mobile (Android/iOS).

---

## 🚀 Menjalankan Aplikasi Secara Lokal

Aplikasi berbasis web statis (HTML, Vanilla CSS, dan JavaScript). Untuk menjalankan:

```bash
# Menggunakan Python
python -m http.server 8080

# Atau menggunakan Node.js / npx
npx serve .
```

Buka peramban di `http://localhost:8080`.

---

## 🗄️ Menghubungkan ke Supabase Database

1. Buka dashboard proyek di [supabase.com](https://supabase.com).
2. Masuk ke menu **SQL Editor**, buka berkas [`supabase-schema.sql`](supabase-schema.sql) dari repositori ini, lalu klik **Run**.
3. Buka menu **Project Settings > API**, salin **Project URL** dan **Anon / Public Key**.
4. Di aplikasi Fokus Pomodoro, klik tombol **Supabase** di bilah atas, masukkan URL dan Anon Key, lalu klik **Simpan & Hubungkan**.

---

## 👤 Akun Admin Bawaan

| Role | Username | Password |
|---|---|---|
| Administrator | `admin` | `admin123` |

*Password di-hash secara otomatis menggunakan SHA-256.*

---

## 📦 Lisensi

Open Source - dibuat untuk meningkatkan fokus dan produktivitas harian.
