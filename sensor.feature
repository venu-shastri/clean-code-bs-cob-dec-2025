Functional Requirements for ABS Sensor
FR1: Wheel Speed Value Management

FR1.1 The system shall store a data element representing the current wheel speed measured by the ABS sensor.

FR1.2 The system shall allow reading the current wheel speed.

FR1.3 The system shall allow updating the wheel speed using an integer value.

FR2: Update Frequency Management

FR2.1 The system shall maintain a data element representing how frequently the ABS sensor updates wheel speed data.

FR2.2 The system shall allow retrieving the current update frequency.

FR2.3 The system shall allow modifying the update frequency using an integer value.

FR3: Filter Frequency Management

FR3.1 The system shall store a data element representing the filter frequency used to smooth ABS sensor signals.

FR3.2 The system shall allow retrieving the current filter frequency.

FR3.3 The system shall allow updating the filter frequency using an integer value.

FR4 : Acquire Values
Consider an ABS sensor whose underlying hardware interface can differ between vehicle platforms. 
In one vehicle, obtaining the wheel-speed value may require reading from a memory-mapped register, waiting for the sensor to stabilize, and then reading from another address. 
In another vehicle, the same wheel-speed value may be provided through a port-mapped interface. 
The ABS controller should not need to know these hardware-specific details. 
Requiring such knowledge would make the braking system more fragile, tightly coupled to specific hardware, and much harder to maintain or adapt across different vehicle models.

