import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  Position? _currentPosition;
  bool _isSubmitting = false;

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {});

    if (_currentPosition != null) {
      final String googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}';
      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    }
  }

  Future<void> _submitOrder(Product product, int quantity) async {
    setState(() {
      _isSubmitting = true;
    });

    final url =
        Uri.parse('http://192.168.18.32/sertifikasi_jmp2/submit_order.php');
    final response = await http.post(
      url,
      body: {
        'nama': _nameController.text,
        'alamat': _addressController.text,
        'no_telepon': _phoneController.text,
        'latitude': _currentPosition?.latitude.toString() ?? '',
        'longitude': _currentPosition?.longitude.toString() ?? '',
        'product_id': product.id.toString(),
        'quantity': quantity.toString(),
      },
    );

    setState(() {
      _isSubmitting = false;
    });

    if (response.statusCode == 200 &&
        response.body.contains('Order placed successfully')) {
      Navigator.of(context).pop();
    } else {
      print('Failed to submit order: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Product product = args['product'];
    final int quantity = args['quantity'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink.shade200,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi Anda',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade200,
                ),
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: _nameController,
                label: 'Nama',
                hintText: 'Masukkan nama lengkap',
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: _addressController,
                label: 'Alamat',
                hintText: 'Masukkan alamat lengkap',
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: _phoneController,
                label: 'No Telepon',
                hintText: 'Masukkan nomor telepon',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _getCurrentLocation,
                  icon: Icon(Icons.location_on),
                  label: Text('Tentukan Lokasimu'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade200,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _currentPosition != null
                  ? Center(
                      child: Text(
                        'Lokasi: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}',
                        style: TextStyle(color: Colors.green.shade400),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Lokasi tidak ditemukan',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 10),
              _isSubmitting
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () => _submitOrder(product, quantity),
                      child: Text('Pesan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade200,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(
          color: Colors.pink.shade400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.pink.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.pink.shade400,
          ),
        ),
        fillColor: Colors.pink.shade50,
        filled: true,
      ),
      keyboardType: keyboardType,
    );
  }
}
