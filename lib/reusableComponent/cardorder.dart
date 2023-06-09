import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';

class OrderCard extends StatelessWidget {
  String img;
  String price;
  String title;
  String cname;
  String pnum;
  String email;
  VoidCallback onpresss;

  OrderCard({
    required this.img,
    required this.price,
    required this.title,
    required this.cname,
    required this.pnum,
    required this.email,
    required this.onpresss,
  });

  @override
  Widget build(BuildContext context) {
    // Step 6: Customize the order widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Shadow spread radius
              blurRadius: 5, // Shadow blur radius
              offset: Offset(0, 3), // Shadow offset
            )
          ],
        ),
        height: 150,
        child: Row(
          children: [
            const SizedBox(
              width: 6,
            ),
            Container(
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(20),
                //put image here
              ),
              width: 150,
              child: ClipRRect(
                child: Image(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: xsmall,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        title,
                        style: heading1,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    InkWell(onTap: onpresss, child: Icon(Icons.menu)),
                  ],
                ),
                Text(
                  'Rs ${price}',
                  style: p1,
                ),
                Text(
                  'order by:',
                  style: heading1,
                ),
                Container(
                  width: 150,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    cname,
                    style: p1,
                  ),
                ),
                Text(
                  email,
                  style: p1,
                ),
                Text(
                  pnum,
                  style: p1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
