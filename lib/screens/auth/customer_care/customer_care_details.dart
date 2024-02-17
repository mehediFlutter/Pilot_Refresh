import 'package:flutter/material.dart';

class CustomerCareAmount extends StatefulWidget {
  const CustomerCareAmount({super.key});

  @override
  State<CustomerCareAmount> createState() => _CustomerCareAmountState();
}

class _CustomerCareAmountState extends State<CustomerCareAmount> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Table(
              border: TableBorder.all(), // Add borders to the table
              children: [
                TableRow(
                  children: [
                    TableCell(child: Text('Cell 1')),
                    TableCell(child: Text('Cell 2')),
                    TableCell(child: Text('Cell 3')),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Text('Cell 4')),
                    TableCell(child: Text('Cell 5')),
                    TableCell(child: Text('Cell 6')),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
