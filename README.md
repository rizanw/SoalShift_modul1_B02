# SoalShift_modul1_B02

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.<br>
Hint: Base64, Hexdump<br>
**Jawab**<br>
base64 -d 47585565_1762021997276664_506951051663446410_n.jpg | xxd -r > file <br>
awk -F "," 'BEGIN {if (NR!=1) {print}} { max=0 } $10 > max { max=$10; } END { print }' WA_Sales_Products_2012-14.csv <br>
awk -F, ‘{if($7==“2012”) a[$1]+=$10;} END{for i in a print a[i] print i}’ | sort -nr | head -n 18 <br>
awk -F, ‘{if($7==“2012”) a[$1]+=$10;} END{for i in a print a[i] print i}’ WA_Sales_Products_2012-14.csv | sort -nr | head -n 1 <br>
**Penjelasan**<br>
base64 -d 47585565_1762021997276664_506951051663446410_n.jpg ==> untuk men-decode gambar<br>
xxd -r > file ==> operasi reverse, mengubah hexdump menjadi binary. Hasil output dikirim ke file.<br>
awk -F "," ==> -F adalah field separator(pemisah bidang) dalam hal inipemisahnyaialah tanda koma (,).<br>
