import 'package:flutter/material.dart';
import '../../../values/values.dart';
import '../../../widgets/custom_button.dart';

class PaymentFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
          backgroundColor: AppColors.whiteShade3,
          title: Text('Booking Confirmation',
              style: TextStyle(
                color: AppColors.deepsea,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.deepsea),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment Details', style: TextStyle(fontSize: 20,color: AppColors.Tenne)),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: TextStyle(fontSize: 18)),
                          Text('3000 EGP',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Bank Card Number'),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Expiry Date'),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(labelText: 'CVV'),
                            keyboardType: TextInputType.number,
                          ))
                        ],
                      ),
                      SizedBox(height: 25),
                      CustomButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Process payment
                            }
                          },
                          title: 'Pay Now',
                          color: AppColors.deepsea,
                          textStyle: (TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )))
                    ]))));
  }
}
