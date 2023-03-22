# Multiple Barcode, QR Code and DataMatrix Scan

A Flutter barcode scanner project for scanning multiple barcode, QR code and DataMatrix.

## Getting Started

1. Apply for a [trial license](https://www.dynamsoft.com/customer/license/trialLicense?product=dbr) of Dynamsoft Barcode Reader and update the `LICENSE-KEY` in `lib/scanner_screen.dart`.
    ```dart
    await DCVBarcodeReader.initLicense(
          'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
    ```

2. Run the project.
    ```bash
    flutter run
    ```