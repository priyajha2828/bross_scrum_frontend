// import 'package:flutter/material.dart';
//
// void showBoardBottomSheet(BuildContext context, {required String spaceName}) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.white,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(20),
//       ),
//     ),
//     builder: (context) {
//       return SizedBox(
//         height: MediaQuery.of(context).size.height * 0.6,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 12),
//
//             /// Drag Handle
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// Search Field
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search for a board",
//                   prefixIcon: const Icon(Icons.search),
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 "Boards in app1",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             /// Current Board
//             ListTile(
//               tileColor: Colors.grey.shade100,
//               leading: Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.deepOrange,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.album,
//                   color: Colors.white,
//                 ),
//               ),
//               title: const Text(
//                 "SCRUM board",
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               onTap: () {},
//             ),
//
//             const SizedBox(height: 20),
//
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 "Other recent boards",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             Expanded(
//               child: ListView(
//                 children: [
//                   ListTile(
//                     leading: Container(
//                       width: 48,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         color: Colors.cyan,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(
//                         Icons.edit_note,
//                         color: Colors.white,
//                       ),
//                     ),
//                     title: const Text("A3 board"),
//                     subtitle: const Text("App 3"),
//                     onTap: () {},
//                   ),
//
//                   ListTile(
//                     leading: Container(
//                       width: 48,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         color: Colors.purple,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(
//                         Icons.dashboard,
//                         color: Colors.white,
//                       ),
//                     ),
//                     title: const Text("Kanban board"),
//                     subtitle: const Text("App 4"),
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }