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

FR5: Data Queue Management
FR5.1 The system shall maintain an internal queue to store wheel-speed data produced by the ABS sensor.

FR5.2 The system shall allow adding new wheel-speed entries to this queue.

FR5.3 The system shall allow removing the oldest wheel-speed entry from the queue.

FR5.4 The system shall provide a way to determine the number of entries currently in the queue.

FR6: Internal Buffer Handling for Insert Operations

FR6.1 When adding new wheel-speed data, the system shall store the data in an internal buffer if space is available.

FR6.2 If the internal buffer becomes full, the system shall automatically write all buffered wheel-speed data to persistent storage (e.g., disk).

FR6.3 After successfully writing buffered data to persistent storage, the system shall reset the internal buffer to accept new entries.

FR7: Internal Buffer Handling for Remove Operations

FR7.1 When removing wheel-speed data, the system shall return the oldest entry available in the internal buffer.

FR7.2 If the internal buffer is empty while data remains in persistent storage, the system shall automatically load the oldest stored wheel-speed data back into the internal buffer.

FR7.3 Once the data is loaded into the internal buffer, the system shall allow removal operations to proceed normally.


ABS ECU Data Queue

FR1: Wheel-Speed Data Input

FR1.1 The system shall receive wheel-speed data from the ABS sensor module.

FR1.2 Each wheel-speed data entry shall include a timestamp of type long and a wheel-speed value.

FR2: Data Queue Structure

FR2.1 The system shall maintain a circular buffer to store wheel-speed data entries.

FR2.2 The circular buffer shall function as a leaky queue, where old data is overwritten automatically when necessary.

FR2.3 The system shall not require explicit removal of data from the buffer.

FR3: Data Insertion into Queue

FR3.1 The system shall insert each new wheel-speed data entry into the next available position in the circular buffer.

FR3.2 If the insertion position reaches the end of the buffer, the system shall wrap around to the beginning of the buffer.

FR3.3 When the buffer becomes full, the system shall overwrite the oldest wheel-speed data entry with new incoming data.

FR3.4 The system shall ensure that the most recent wheel-speed data is always retained in the buffer.

FR4: Data Availability for Consumers

FR4.1 The system shall make wheel-speed data available to multiple internal ABS ECU consumers, including braking logic, traction control, and stability systems.

FR4.2 The system shall ensure that consumers can read data without impacting the buffer’s insertion behavior.

FR4.3 The system shall allow consumers to access data in chronological order.

FR5: Time Marker Handling

FR5.1 The system shall associate each wheel-speed data entry with a timestamp representing the time of measurement.

FR5.2 The system shall preserve the ordering of timestamps during buffer insertion and wraparound.

