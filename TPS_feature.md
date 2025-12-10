## Case Study: Tire Pressure Monitoring in a Multi-Sensor Automotive System

Modern vehicles use Tire Pressure Monitoring Systems (TPMS) to measure both tire pressure and tire temperature so that several subsystems can respond appropriately. In one vehicle platform, two different modules rely on this data:

- The Driver Display Module, which shows the driver real-time tire pressure and temperature.
- The Chassis Control Module, which uses the same data for functions such as stability control, traction control, and ABS tuning.

Both modules were originally designed with the assumption that tire data would be provided in kilopascals (kPa) for pressure and degrees Celsius (°C) for temperature.

----
### Introduction of Multiple Sensor Vendors

As the vehicle line expanded, the procurement team began sourcing TPMS sensors from different vendors. Each vendor provided hardware that behaved differently and exposed different programmatic interfaces:

#### Sensor Variant A – Apex Tire Sensor

- Reports pressure in PSI, returned as a floating-point value.
- Reports temperature in °C, also as a float.

#### Sensor Variant B – RoadMaster TPMS Node

- Reports pressure as an integer scaled value (kPa × 10).
- Reports temperature in °F.

#### Future-Proofing Requirement

Management has indicated that additional sensor suppliers may be added in upcoming releases, and each might use different formats, communication protocols, or units.

----
## Design Challenges

Currently, the Driver Display Module and Chassis Control Module each expect exactly the same interface:

- A pressure value in kPa (integer).
- A temperature value in °C (integer).

The introduction of new sensor vendors has created a dilemma:

- The application logic of the two clients should not change when the underlying sensor hardware changes.
- Each sensor vendor uses different units and formats.
- Additional vendors may be added later.

If you examine the scenario closely, several questions naturally arise:

- How can we prevent client modules from depending on vendor-specific sensor formats?
- How can a future sensor with yet another interface be integrated without rewriting the Driver Display or Chassis Control logic?
- Where should unit conversions (PSI→kPa, °F→°C, scaling removal, etc.) take place?
- What design approach allows for multiple sensor types while keeping the rest of the system stable?
- How can we maintain a single, consistent interface for the modules that consume this data?
