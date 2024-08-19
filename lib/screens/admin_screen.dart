import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();
  Map<String, File?> _orderImages = {};

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    String url = 'http://192.168.18.32/sertifikasi_jmp2/get_orders.php';

    try {
      var response = await http.get(Uri.parse(url));
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print('Decoded Data: $data');

        setState(() {
          orders = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else {
        print('Failed to load orders: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching orders: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _pickImage(String orderId) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _orderImages[orderId] = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin - Orders',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink.shade200,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? Center(child: Text('No orders found.'))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final orderId = order['order_id'].toString();
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order ID: ${order['order_id']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Divider(color: Colors.pink.shade50),
                            SizedBox(height: 8.0),
                            _buildOrderDetail('Nama', order['nama']),
                            _buildOrderDetail('Alamat', order['alamat']),
                            _buildOrderDetail('No Telepon', order['no_telepon']),
                            _buildOrderDetail('Product ID', order['product_id']),
                            _buildOrderDetail('Jumlah', order['quantity']),
                            _buildOrderDetail('Lokasi', '${order['latitude']}, ${order['longitude']}'),
                            SizedBox(height: 10.0),
                            _buildOpenLocationButton(order['latitude'], order['longitude']),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () => _pickImage(orderId),
                                  child: Text('Take Photo'),
                                ),
                                if (_orderImages.containsKey(orderId) && _orderImages[orderId] != null)
                                  Image.file(
                                    _orderImages[orderId]!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('View Receipt'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade200,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenLocationButton(String latitude, String longitude) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.place_outlined, color: const Color.fromARGB(255, 245, 243, 244)),
          onPressed: () async {
            final String googleMapsUrl =
                'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
            if (await canLaunch(googleMapsUrl)) {
              await launch(googleMapsUrl);
            } else {
              throw 'Could not launch $googleMapsUrl';
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade200,
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
