import 'package:flutter/material.dart';

class SearachDetailsVehicle extends StatefulWidget {
  final String? imageName;
  final String? VehicleName;
  final String? VehiceId;
  const SearachDetailsVehicle(
      {super.key, this.imageName, this.VehicleName, this.VehiceId});

  @override
  State<SearachDetailsVehicle> createState() => _SearachDetailsVehicleState();
}

class _SearachDetailsVehicleState extends State<SearachDetailsVehicle> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                widget.VehicleName.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Image.network(
                  "https://pilotbazar.com/storage/vehicles/${widget.imageName}"),
              Text(widget.VehiceId.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
