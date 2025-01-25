








// Container(
//   color: tertiary,
//   child: FutureBuilder<List<UsersModel>>(
//     future: dbService.fetchUsers('STUDENT'),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       }
//
//       if (snapshot.hasError) {
//         print(snapshot.error);
//         return Center(
//             child: Text(
//           'Error: ${snapshot.error}',
//           style: GoogleFonts.robotoMono(),
//         ));
//       }
//
//       if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         return Center(
//             child: Text('No users found.',
//                 style: GoogleFonts.robotoMono()));
//       }
//
//       final users = snapshot.data!;
//
//       return SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         physics: BouncingScrollPhysics(),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             headingTextStyle: GoogleFonts.openSans(
//                 color: secondary,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18),
//             dataTextStyle: GoogleFonts.openSans(color: secondary),
//             columnSpacing: 80,
//             dividerThickness: 0.5,
//             dataRowHeight: 60,
//             columns: _dataColumn(),
//             rows: users
//                 .map((e) => DataRow(cells: [
//                       DataCell(Text(e.name.toString())),
//                       DataCell(Text(e.enrollment_no.toString())),
//                       DataCell(Text(e.email.toString())),
//                       DataCell(Text(e.contact.toString())),
//                       DataCell(Text(e.departmentName.toString())),
//                       DataCell(Text(e.className.toString())),
//                       DataCell(Row(
//                         children: [
//                           IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.edit)),
//                           IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.delete)),
//                         ],
//                       ))
//                     ]))
//                 .toList(),
//           ),
//         ),
//       );
//     },
//   ),
// )












// List<DataColumn> _dataColumn() {
//   return [
//     DataColumn(label: Text('name')),
//     DataColumn(label: Text('enrollment')),
//     DataColumn(label: Text('email')),
//     DataColumn(label: Text('contact')),
//     DataColumn(label: Text('department')),
//     DataColumn(label: Text('class')),
//     DataColumn(label: Text('Edit / Delete'))
//   ];
// }