import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      //  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        //tilePadding: EdgeInsets.all(10.0),
        title: Container(
            // margin: EdgeInsets.all(10.0),
            //    padding: EdgeInsets.only(bottom: 12.0),
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "hello1",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                const Text(
                  'hello2',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              "hello3",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  fontSize: 14),
            )
          ],
        )),
        children: <Widget>[
          // Column(
          //   children: order.items.map((e) {
          //     return OrderProductTile(e);
          //   }).toList(),
          // ),
          //  Text(" ok"),
          if (true)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => Text('Home4'));
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Recuar'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Avançar'),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context, builder: (_) => Text('Home4'));
                    },
                    child: const Text('Endereço'),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
