import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
          iconSize: 15,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          "http://44.242.96.167/foodapp/public/images/dishes/image49175.jpg",
                          width: 80,
                          height: 80,
                          fit:BoxFit.fill,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:6),
                        child: Text(
                            "2 States",
                            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,
                                fontFamily: "Proxima_Nova_ScOsf_Bold")),
                      ),
                      Container(
                          margin: EdgeInsets.only(top:5),
                          child:Text(
                              "Old Jodhpur",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily:'Proxima_Nova_Alt_Light',
                                  color: Colors.black54,fontWeight: FontWeight.bold)
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Divider(
                  color: Colors.grey
              ),
            ),
            Expanded(
              child: ListView.builder(itemCount:4,itemBuilder: (context,index){
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top:10,left: 10),
                              child: Image.asset("assets/images/veg.png",width: 15,height: 15)
                          ),
                          Container(
                            margin: EdgeInsets.only(top:10,left: 10),
                            child: Text(
                                "Pizza Onion",
                                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500,
                                    fontFamily: "Proxima_Nova_Bold")),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 30,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color:Colors.deepOrange,
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                  },
                                  child:  Container(
                                    child:Image.asset("assets/images/add.png",width: 13,height: 13),
                                    padding: EdgeInsets.all(6),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                      "1",
                                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500,
                                          fontFamily: "Proxima_Nova_Bold")),
                                ),
                                GestureDetector(
                                  onTap:() async {
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(6),
                                      child:Image.asset("assets/images/less.png",width: 13,height: 13)
                                  ),
                                )

                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:10,right: 20),
                            child: Text(
                                "Pizza Onion",
                                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500,
                                    fontFamily: "Proxima_Nova_Bold")),
                          ),
                        ],
                      )


                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
