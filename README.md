
# Laporan Praktikum SoalShift_modul1_B02

 1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
`Hint: Base64, Hexdump`

	**Jawab :**
	```bash
	for foto in *
		do
		    base64 -d "$foto" | xxd -r > "$foto-tmp"
		    rm "$foto"
		    mv "$foto-tmp" "$foto"
		done
	```
	> See : [full code](../blob/master/LICENSE)
	
	**Penjelasan :**
	 1. Lakukan ekstrak file nature.zip dan buka folder hasil ekstraksi.
	 2. Lakukan *decode* file-file yang ter-*encode* menggunakan `base64`.
		  ```bash
		  $ base64 -d [nama file] > [output file]
		  ```
		  Akhirnya kita berhasil men-*decode* file tersebut, namun file tersebut tertulis dalam bentuk hexa, sehingga tidak dapat terbuka sebagai gambar seperti semestinya.
	3. Maka kita perlu merubah file hexa tersebut ke dalam binary file, kita dapat menggunakan *command* `xxd`.
		```bash
		$ xxd -r [input file] > [output file]
		``` 	
		*Yeyhh!!* Akhirnya kita mendapatkan foto yang seharusnya.
	4. Namun karena file tersebut terlalu banyak dan tidak memungkinkan untuk melakukan cara tersebut satu persatu. Maka kita harus melakukan cara tersebut dengan cara *looping* dalam file bash.
		```bash
		#!/bin/bash
		for foto in *
			do
				base64 -d "$foto" | xxd -r > "$foto-tmp"
			    rm "$foto"
			    mv "$foto-tmp" "$foto"
			done
		```
		Dengan cara tersebut, setelah melakukan ekstraksi, kita menjalankan file bash tersebut di dalam folder nature. Maka tiap foto di-*decode* lalu di-rename menjadi `[nama foto]-tmp.jpg` lalu foto yang ter-*encode* dihapus menggunakan *command* `rm` dan diganti oleh foto yang sudah kita *decode* menggunakan *command* `mv`.
	5. Setelah file bash selesai, kita dapat menjalankannya menggunakan `cron`. Buka `crontab` :
		```bash
		$ crontab -e
		```
	6. Buat *command* `cron` di `crontab` pada saat pukul 14:14 pada tanggal 14 Februari.
		```bash
		14 14 * 2 5 ~/Desktop/SoalShift_modul1_B02/soal1.sh
		```
	7. Selesai~ pastikan ketika menjalankan file bash tersebut, file tersebut berdampingan dengan file nature.zip
	> See : [full code](../blob/master/LICENSE)
		
		
2. Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file `WA_Sales_Products_2012-14.csv`.
Laporan yang diminta berupa:
a. Tentukan negara dengan penjualan(*quantity*) terbanyak pada tahun 2012.
b. Tentukan tiga product line yang memberikan penjualan(*quantity*)
terbanyak pada soal poin a.
	c. Tentukan tiga *product* yang memberikan penjualan(*quantity*)
terbanyak berdasarkan tiga product line yang didapatkan pada soal
poin b.

	**Jawab :**
	a. Negara dengan penjualan(*quantity*) terbanyak pada tahun 2012 :
	```bash
	$ awk -F "," '{if($7 == "2012") a[$1]+=$10}END{for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr | head -1 | awk -F "-" '{print $2}'	
	```
	b. Tiga *product line* yang memberikan penjualan(*quantity*) terbanyak pada soal poin a :
	```bash
	$ awk -F "," '{if($7=="2012" && $1=="United States") a[$4]+=$10} END {for(v in a)print v}' WA_Sales_Products_2012-14.csv | sort -nr | head -3
	```
	c. Tiga produk yang memberikan penjualan(*quantity*) terbanyak berdasarkan tiga *product line* yang didapatkan pada soal poin b :
	```bash
	$ awk -F "," '{if ($7=="2012" && $1=="United States") a[$4]+=$10} END {for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr | head -3 | awk -F "-" '{print $2}'	
	```
	
	**Penjelasan :** 
	a. Negara dengan penjualan(*quantity*) terbanyak pada tahun 2012 :
	1. Kita akan menggunakan `awk` untuk melakukan *searching*. Gunakan `option` `-F` karena file yang akan kita searching menggunakan *delimiter* berupa `,` sedangkan `awk` *default* menggunakan  ` ` *(space)*.
	2. Pertama-tama `print` semua daftar pada tahun 2012. Dalam file ini tahun berada pada kolom ke-7. 
		```bash
		$ awk -F "," '{if($7 == "2012") print}' WA_Sales_Products_2012-14.csv
		```
		Maka akan keluar seluruh penjualan pada tahun 2012.
	3. Setelah itu, hitung jumlah penjualan pada tiap negara dengan memasukkannya ke dalam *array*, `a[$1]+=$10`. Dalam kasus ini, penjualan(*quantity*) berada di kolom 10 dan nama negara berada pada kolom 1.
	4. Lalu, lakukan iterasi(*looping*) untuk mencetak(print) hasilnya. 
		```bash
		$ awk -F "," '{if($7 == "2012") a[$1]+=$10}END{for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv
		```
		Maka akan keluar, seluruh jumlah penjualan(*quantity*),`a[v]`, beserta nama negaranya,`v`.
	5. Lakukan *sorting* secara *descending*(dari nilai terbesar ke terkecil) dengan command `sort -nr`
		```bash
		$ awk -F "," '{if($7 == "2012") a[$1]+=$10}END{for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr	
		```
	6. Terakhir ambil satu nilai tertinggi saja menggunakan command `head -1`. dan cetak(*print*) nama negaranya saja menggunakan `awk`.
		```bash
		$ awk -F "," '{if($7 == "2012") a[$1]+=$10}END{for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr | head -1 | awk -F "-" '{print $2}'	
		```
		Maka hasil yang ditemukan ialah :
		```
		 United States
		```
	b. Tiga  _product line_  yang memberikan penjualan(_quantity_) terbanyak pada soal poin a :
	1. Masih menggunakan syntax `awk` seperti poin a. Namun dalam kasus ini, kita hanya memperlukan mencetak(*print* negara yang bersangkutan saja sesuai hasil poin a, yaitu `United States`, maka kita akan mengubah kondisi menjadi `if($7=="2012" && $1=="United States")`.
	2. Sekarang kita perlu menghitung penjualan *produk line* pada negara tersebut, menggunakan cara yang sama namun dalam kasus ini kolom *produk line* berada pada kolom 4.
		```bash
		$ awk -F "," '{if ($7=="2012" && $1=="United States") a[$4]+=$10} END {for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv
		```
		Maka akan keluar seluruh *produk line* pada penjualan negara tersebut.
	3. Lalu *sort* secara *descending*(urut dari terbesar ke terkecil), menggunakan *command* `sort -nr`.
		```bash
		$ awk -F "," '{if ($7=="2012" && $1=="United States") a[$4]+=$10} END {for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr
		```
	4. Terakhir `print` tiga teratas menggunakan command `head -3` dan cukup `print` nama _produk line_ nya saja menggunakan `awk`.
		```bash
		$ awk -F "," '{if ($7=="2012" && $1=="United States") a[$4]+=$10} END {for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr | head -3 | awk -F "-" '{print $2}'
		```
		Maka akan tercetak tiga _produk line_ teratas dari poin a, yaitu :
		``` 
		 Personal Accessories
		 Camping Equipment
		 Outdoor Protection
		```
	c. Tiga produk yang memberikan penjualan(_quantity_) terbanyak berdasarkan tiga  _product line_  yang didapatkan pada soal poin b : 
	1. Masih menggunakan syntax `awk` seperti pada poin sebelumnya, namun kali ini menggunakan syntax lebih banyak, dengan menyantumkan _produk line_ pada kolom 4. Lalu, `print` produk pada kolom 6.
		```bash
		$ awk -F "," '{if($7=="2012" && $1=="United States" && ($4=="Personal Accessories" || $4=="Camping Equipment" || $4=="Outdoor Protection")) a[$6]+=$10} END {for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv
		```
	2. Setelah itu lakukan *sort* secara *descending*(dari yang terbesar ke terkecil) dan munculkan tiga produk teratas.
		```bash
		$ awk -F "," '{if($7=="2012" && $1=="United States" && ($4=="Personal Accessories" || $4=="Camping Equipment" || $4=="Outdoor Protection")) a[$6]+=$10} END {for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr | head -3
		```
	3. Terakhir `print` namanya saja menggunakan `awk`.
		```bash
		$ awk -F "," '{if($7=="2012" && $1=="United States" && ($4=="Personal Accessories" || $4=="Camping Equipment" || $4=="Outdoor Protection")) a[$6]+=$10} END {for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr | head -3 | awk -F "-" '{print $2}' 
		```