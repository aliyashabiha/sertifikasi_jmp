import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sertifikasi_jmp/map_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(
            "https://cdn-1.timesmedia.co.id/images/2022/09/17/pantai-papuma-jember.jpg",
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pantai Papuma",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 5),
                    Text("Jember, Jawa Timur",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    SizedBox(width: 2),
                    Text(
                      '4.3',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 28),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 30,
                      color: Color(0xff0500FE),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'CALL',
                      style: TextStyle(color: Color(0xff0500FE)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.navigation,
                      size: 30,
                      color: Color(0xff0500FE),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ROUTE',
                      style: TextStyle(color: Color(0xff0500FE)),
                    ),
                    GestureDetector(
                          onTap: () async {
                            if (Platform.isWindows) {
                              await launchUrl(
                                Uri.parse(
                                    "https://maps.app.goo.gl/pKvjxK5Xi4DjvyYq9"),
                              );
                            } else
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapPage(),
                                ),
                              );
                          },
                        ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.share,
                      size: 30,
                      color: Color(0xff0500FE),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'SHARE',
                      style: TextStyle(color: Color(0xff0500FE)),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Pantai Papuma adalah sebuah pantai yang menjadi tempat wisata di Kabupaten Jember,Provinsi Jawa Timur, Indonesia.  Nama Papuma sendiri sebenarnya adalah sebuah singkatan  dari “Pasir Putih Malikan. Pantai papuma berada di Desa Lojejer,  Kecamatan  uluhan, Kabupaten Jember. Pantai papuma adalah salah satu pantai yang cukup populer dan terkenal di Jember. Walaupun jarak sekitar 40 kilometer cukup jauh dari pusat kota Jember. Namun, keindahan pasir putih Malikan ini cukup eksotis dan mampu menarik perhatian wisatawan lokal hingga mancanegara untuk datang kesana.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10),
                Text(
                  'Pantai Papuma mulai dibuka secara resmi sejak tahun 1994, namun pada tahun 1998 wisata pantai di Jember yang ini baru mulai ramai dikunjungi oleh wisatawan. Menurut sejarah, dulu pada zaman penjajahan Jepang hutan yang ada di sekitar pantai Papuma ini dijadikan sebagai markas dan benteng Jepang ketika perang.',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}