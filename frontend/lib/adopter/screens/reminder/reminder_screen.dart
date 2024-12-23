// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fur_get_me_not/adopter/bloc/reminder/reminder_bloc.dart';
// import 'package:fur_get_me_not/adopter/bloc/reminder/reminder_event.dart';
// import 'package:fur_get_me_not/adopter/bloc/reminder/reminder_state.dart';
// import 'package:fur_get_me_not/adopter/repositories/reminder/reminder_repository.dart'; // Import ReminderRepository
// import 'package:fur_get_me_not/adopter/models/reminder/reminder.dart';

// class ReminderScreen extends StatelessWidget {
//   const ReminderScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ReminderBloc(ReminderRepository())
//         ..add(LoadReminders()), // Initialize locally
//       child: Scaffold(
//         body: BlocBuilder<ReminderBloc, ReminderState>(
//           builder: (context, state) {
//             if (state is ReminderLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ReminderLoaded) {
//               final reminders = state.reminders;
//               return ListView.builder(
//                 itemCount: reminders.length,
//                 itemBuilder: (context, index) {
//                   final reminder = reminders[index];
//                   return ListTile(
//                     title: Text(reminder.title),
//                     subtitle: Text(reminder.reminderDate.toString()),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () {
//                             Navigator.pushNamed(context, '/update_reminder',
//                                 arguments: reminder);
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             context
//                                 .read<ReminderBloc>()
//                                 .add(DeleteReminder(reminder.id));
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else if (state is ReminderError) {
//               return Center(child: Text(state.message));
//             } else {
//               return const Center(child: Text('No reminders found.'));
//             }
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/add_reminder');
//           },
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }
