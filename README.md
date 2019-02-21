# SoalShift_modul1_B02

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.<br>
Hint: Base64, Hexdump<br>
**Jawab**<br>
base64 -d 47585565_1762021997276664_506951051663446410_n.jpg | xxd -r > *-new.jpg <br>
**Penjelasan**<br>
base64 -d 47585565_1762021997276664_506951051663446410_n.jpg ==> untuk men-decode gambar<br>
xxd -r > file ==> program reverse untuk mengubah hexdump menjadi binary. Hasil output dikirim ke file.<br>

2. Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:
a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun
2012.
b. Tentukan tiga product line yang memberikan penjualan(quantity)
terbanyak pada soal poin a.
c. Tentukan tiga product yang memberikan penjualan(quantity)
terbanyak berdasarkan tiga product line yang didapatkan pada soal
poin b.
**Jawab**<br>
a.<br>
awk -F "," 'BEGIN{ if ($7=="2012") a[$1]+=$10} END {for(x in a) print a[x] " " x}' WA_Sales_Products_2012-14.csv | sort -n | tail -1
b.<br>
awk -F ',' '{ if ($7=="2012" && $1=="United States") a[$4]+=$10} END {for(x in a)print a[x] " " x}' WA_Sales_Products_2012-14.csv | sort -n | tail -3
c.<br>
awk -F ',' '{ if ($7=="2012" && $1=="United States" && ($4=="Outdoor Protection" || $4=="Camping Equipment" || $4=="Personal Accessories")) a[$6]+=$10} END {for(x in a)print a[x] " " x}' WA_Sales_Products_2012-14.csv | sort -n | tail -3
