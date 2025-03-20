import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentProvider with ChangeNotifier {
  bool isProcessing = false;
  String paymentStatus = "Not Started";

  // Function to initiate UPI payment via URL scheme
  Future<void> payWithUPI({
    required String upiId,
    required String name,
    required String amount,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    try {
      isProcessing = true;
      paymentStatus = "Processing UPI Payment...";
      notifyListeners();

      final transactionRef = "NMT${DateTime.now().millisecondsSinceEpoch}";

      // Create UPI URL
      final uriString =
          'upi://pay?pa=$upiId&pn=$name&tr=$transactionRef&am=$amount&cu=INR';
      final uri = Uri.parse(uriString);

      // Check if the URI can be launched
      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(uri);
        if (launched) {
          paymentStatus = "UPI App Launched Successfully!";
          onSuccess();
        } else {
          paymentStatus = "Failed to Launch UPI App!";
          onFailure();
        }
      } else {
        paymentStatus = "No UPI App Found!";
        onFailure();
      }
    } catch (e) {
      paymentStatus = "UPI Error: $e";
      onFailure();
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  // Function to pay using Google Pay
  Future<void> payWithGooglePay(String amount) async {
    try {
      isProcessing = true;
      paymentStatus = "Processing Google Pay Payment...";
      notifyListeners();

      final paymentItems = [
        PaymentItem(
          label: 'Total',
          amount: amount,
          status: PaymentItemStatus.final_price,
        )
      ];

      // Load Google Pay configuration
      final paymentConfiguration =
          await PaymentConfiguration.fromAsset('google_pay_config.json');

      // Create Google Pay client with configuration map
      final googlePayClient = Pay({
        PayProvider.google_pay: paymentConfiguration,
      });

      try {
        // Check if Google Pay is available
        final canPay = await googlePayClient.userCanPay(
          PayProvider.google_pay,
        );

        if (canPay) {
          // Start payment process
          final result = await googlePayClient.showPaymentSelector(
            PayProvider.google_pay,
            paymentItems,
          );

          if (result.isNotEmpty) {
            paymentStatus = "Google Pay Payment Successful!";
          } else {
            paymentStatus = "Google Pay Payment Cancelled";
          }
        } else {
          paymentStatus = "Google Pay not available on this device";
        }
      } on PlatformException catch (e) {
        paymentStatus = "Google Pay Platform Error: ${e.message}";
      }
    } catch (e) {
      paymentStatus = "Google Pay Error: $e";
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  // Function to initiate PhonePe Payment (simplified for testing)
  Future<void> payWithPhonePe({
    required String merchantId,
    required String transactionId,
    required String amount,
  }) async {
    try {
      isProcessing = true;
      paymentStatus = "Processing PhonePe Payment...";
      notifyListeners();

      // Create a PhonePe URL for web redirect (simplified approach)
      final uri = Uri.parse(
          'https://mercury-t2.phonepe.com/transact/pay?merchantId=$merchantId&transactionId=$transactionId&amount=${double.parse(amount) * 100}&redirectUrl=https://your-server.com/callback');

      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          paymentStatus = "PhonePe App Launched Successfully!";
        } else {
          paymentStatus = "Failed to Launch PhonePe App!";
        }
      } else {
        paymentStatus = "PhonePe App Not Found!";
      }
    } catch (e) {
      paymentStatus = "PhonePe Error: $e";
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }
}
