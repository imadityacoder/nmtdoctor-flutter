import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:nmt_doctor_app/providers/order_provider.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  const DateTimeSelectionScreen({super.key});

  @override
  _DateTimeSelectionScreenState createState() =>
      _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  DateTime selectedDateTime = DateTime.now(); // Stores both date and time
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final List<DateTime> upcomingDates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Choose Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),

          // Horizontal Date Selector
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingDates.length,
              itemBuilder: (context, index) {
                final date = upcomingDates[index];
                final isSelected = selectedDateTime.year == date.year &&
                    selectedDateTime.month == date.month &&
                    selectedDateTime.day == date.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        selectedDateTime.hour,
                        selectedDateTime.minute,
                      );
                      selectedTime = null; // Reset time on date change
                    });
                    orderProvider.setCollectionDateTime(
                        selectedDateTime); // Update provider
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('E').format(date).toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat('d MMM').format(date),
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Choose Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Time Slots in Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: 12, // 12 time slots (5 AM - 4 PM)
              itemBuilder: (context, index) {
                final int startHour = 8 + index; // Start at 5 AM
                final int endHour = startHour + 1;
                final String timeSlot =
                    "${startHour % 12 == 0 ? 12 : startHour % 12} ${startHour < 12 ? 'AM' : 'PM'} - ${endHour % 12 == 0 ? 12 : endHour % 12} ${endHour < 12 ? 'AM' : 'PM'}";

                final isSelected = selectedTime == timeSlot;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = timeSlot;
                      selectedDateTime = DateTime(
                        selectedDateTime.year,
                        selectedDateTime.month,
                        selectedDateTime.day,
                        startHour,
                        0,
                      );
                    });
                    orderProvider.setCollectionDateTime(
                        selectedDateTime); // Update provider
                  },
                  child: Card(
                    elevation: isSelected ? 4 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        timeSlot,
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                      ),
                      subtitle: const Text("Free"),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: Colors.blue)
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
