import 'package:flutter/material.dart';

class CustomCardHome extends StatelessWidget {
  String img;
  String price;
  String title;
  String des;

  CustomCardHome({super.key, 
    required this.img,
    required this.price,
    required this.title,
    required this.des,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Shadow spread radius
              blurRadius: 6, // Shadow blur radius
              offset: const Offset(0, 3), // Shadow offset
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey[200]!,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Hero(
                    tag: const Text('aaa'),
                    child: Image(
                      height: 150,
                      width: 150,
                      image: NetworkImage(img),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  width: 150,
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              title,

                              //title
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        des,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'RS $price',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
