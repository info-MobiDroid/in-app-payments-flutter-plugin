import 'package:flutter/material.dart';
import 'process_payment.dart';

class BuyScreen extends StatefulWidget {
  static BuyScreenState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<BuyScreenState>());
  BuyScreenState createState() => BuyScreenState();
}

class BuyScreenState extends State<BuyScreen> {
  ProcessPayment processPayment;
  bool visible;

  @override
  void initState() {
    super.initState();
    processPayment = ProcessPayment(this);
    visible = true;
  }

  void setVisible() {
    setState(() {
          visible = !visible;
        });
  }

  @override
  Widget build(BuildContext context) =>
    visible ? MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.black.withOpacity(0.5)
      ),
      home: //LayoutBuilder(
      // builder: (context, constraints) =>
      Scaffold(
        body: Center(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(onTap: () {Navigator.pop(context, false);})
        ),
        FittedBox(child:
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft:  const  Radius.circular(20.0),
                          topRight: const  Radius.circular(20.0))
                  ),
            child:
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: _title(),
                ),
                Expanded(
                child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    _ShippingInformation(),
                    _LineDivider(),
                    _PaymentTotal(),
                    _LineDivider(),
                    _RefundInformation(),
                    _payButtons(),
                  ]),
                ),
              ]),
            ),),
          ]),
        ),
      ),
    ) : Container();

    Widget _title() => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FittedBox(
          child:
        Container(
          height: 56,
          width: 56,
          child:
          IconButton(onPressed: (){
            Navigator.pop(context, false);},
            icon: Icon(Icons.close),
            color: Color(0xFFD8D8D8)
          )
        ),),
        Padding(padding: EdgeInsets.only(right: 64)),
        Expanded(
          child: Text(
            "Place your order",
            style: TextStyle(fontSize: 18, fontFamily: 'SF_Pro_Text', fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

  Widget _payButtons() => FittedBox(child:
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Padding(padding: EdgeInsets.only(left: 30)),
      FittedBox(child:
      Container(
        height: 64,
        width: 170,
        child:
        RaisedButton(
          onPressed: (){
            setVisible();
            processPayment.paymentInitialized ? processPayment.onStartCardEntryFlow() : null;
          },
          child: FittedBox(
                child:
                  Text(
                  'Pay with card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  )
                ),
              ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Color(0xFF24988D),
        ),
      ),),
      Padding(padding: EdgeInsets.only(left: 14),),
      FittedBox(child:
      Container(
        width: 170,
        height: 64,
        child:
        RaisedButton(
          onPressed: (){
            Navigator.pop(context, false);
            processPayment.paymentInitialized && (processPayment.applePayEnabled || processPayment.googlePayEnabled) ? 
            (Theme.of(context).platform == TargetPlatform.iOS) ? processPayment.onStartApplePay() : processPayment.onStartGooglePay() : null;
          },
          child: 
            Image(
                image: (Theme.of(context).platform == TargetPlatform.iOS) ? AssetImage("assets/applePayLogo.png") : AssetImage("assets/googlePayLogo.png")
              ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.black,
        ),
      ),),
      Padding(padding: EdgeInsets.only(right: 30),)
    ],
  ));
}

class _ShippingInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(padding: EdgeInsets.only(left: 30)),
        Text(
          "Ship to",
          style: TextStyle(fontSize: 16, fontFamily: 'SF_Pro_Text',color: Color(0xFF24988D)),
        ),
        Padding(padding: EdgeInsets.only(left: 30)),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Lauren Nobel",
              style: TextStyle(fontSize: 16, fontFamily: 'SF_Pro_Text', fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.only(bottom: 6),),
            Text(
              "1455 Market Street\nSan Francisco, CA, 94103",
              style: TextStyle(fontSize: 16, fontFamily: 'SF_Pro_Text', color: Color(0xFF7B7B7B)),
            ),
          ]
        ),
    ],
  );
}

class _LineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Container(
          color: Color(0xFFD8D8D8),
          height: 1, 
          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
        ),
      )
    ],
  );
}

class _PaymentTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(padding: EdgeInsets.only(left: 30)),
        Text(
          "Total",
          style: TextStyle(fontSize: 16, fontFamily: 'SF_Pro_Text',color: Color(0xFF24988D)),
        ),
        Padding(padding:EdgeInsets.only(right: 47)),
        Text(
          "\$1.00",
          style: TextStyle(fontSize: 16, fontFamily: 'SF_Pro_Text', fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
    ],
  );
}

class _RefundInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FittedBox(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 30.0, right: 30.0),
        width: MediaQuery.of(context).size.width - 60,
        child:
          Text(
            "You can refund this transaction through your Square dashboard, go to squareup.com/dashboard.",
            style: TextStyle(fontSize: 12, fontFamily: 'SF_Pro_Text',color: Color(0xFF7B7B7B)),
            maxLines: 2,
          ),
      ),
    ],),
  );
}