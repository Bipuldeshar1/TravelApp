import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_3/const/style.dart';

class Cart extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const Cart(
      {required this.image,
      required this.name,
      required this.price,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
        color: black,
        borderRadius: BorderRadius.circular(26),
      ),
      width: 150,
      height: 10,
      margin: const EdgeInsets.only(right: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 0, 0.75),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF18A5FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 68,
                      height: 36,
                      child: Center(
                        child: Text(
                          'Rs$price',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'asa',
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
