# SoalShift_modul1_B02

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.<br>
Hint: Base64, Hexdump<br>
**Jawab**<br>
base64 -d 47585565_1762021997276664_506951051663446410_n.jpg | xxd -r > file <br>
**Penjelasan**<br>
base64 -d 47585565_1762021997276664_506951051663446410_n.jpg ==> untuk men-decode gambar<br>
xxd -r > file ==> operasi reverse, mengubah hexdump menjadi binary. Hasil output dikirim ke file.<br>
