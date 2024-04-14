import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  String img;
  String price;
  String title;
  String des;

  VoidCallback? onpresss;
  CustomCard({super.key, 
    required this.img,
    required this.price,
    required this.title,
    required this.des,
    required this.onpresss,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Shadow spread radius
              blurRadius: 5, // Shadow blur radius
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
            Container(
              // width: double.infinity,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Hero(
                      tag: const Text('aaa'),
                      child: Image(
                        height: 120,
                        width: 120,
                        image: NetworkImage(img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: SizedBox(
                            width: 225,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: onpresss, icon: const Icon(Icons.menu))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            des, //des
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          price,
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
            ),
          ],
        ),
      ),
    );
  }
}
