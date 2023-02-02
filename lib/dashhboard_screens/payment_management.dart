import 'package:ajawa_hotel/datasource/order_data_source.dart';
import 'package:ajawa_hotel/datasource/payment_data_source.dart';
import 'package:ajawa_hotel/models/order_model.dart';
import 'package:ajawa_hotel/view/order_viewe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PaymentManagement extends StatefulWidget {
  const PaymentManagement({super.key});

  @override
  State<PaymentManagement> createState() => _PaymentManagementState();
}

class _PaymentManagementState extends State<PaymentManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 670,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: _buildDataGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late PaymentDataSource employeeDataSource;
  List<Order_Model> employeeData = [];

  final getDataFromFireStore =
      FirebaseFirestore.instance.collection('orders').snapshots();
  Widget _buildDataGrid() {
    return StreamBuilder(
      stream: getDataFromFireStore,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimationWidget.hexagonDots(
                  color: Colors.blue, size: 200));
        }
        if (snapshot.hasData) {
          if (employeeData.isNotEmpty) {
            getDataGridRowFromDataBase(DocumentChange<Object?> data) {
              return DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'name', value: data.doc['name']),
                DataGridCell<String>(
                    columnName: 'email', value: data.doc['email']),
                DataGridCell<String>(
                    columnName: 'password', value: data.doc['password']),
                DataGridCell<String>(
                    columnName: 'area', value: data.doc['area']),
              ]);
            }

            for (var data in snapshot.data!.docChanges) {
              if (data.type == DocumentChangeType.modified) {
                if (data.oldIndex == data.newIndex) {
                  employeeDataSource.dataGridRows[data.oldIndex] =
                      getDataGridRowFromDataBase(data);
                }
                employeeDataSource.updateDataGridSource();
              } else if (data.type == DocumentChangeType.added) {
                employeeDataSource.dataGridRows
                    .add(getDataGridRowFromDataBase(data));
                employeeDataSource.updateDataGridSource();
              } else if (data.type == DocumentChangeType.removed) {
                employeeDataSource.dataGridRows.removeAt(data.oldIndex);
                employeeDataSource.updateDataGridSource();
              }
            }
          } else {
            for (var data in snapshot.data!.docs) {
              employeeData.add(Order_Model(
                  uuid: data['uuid'],
                  Status: data['Status'],
                  totalPrice: data['totalPrice'],
                  customerMenuDetail: data['customerMenuDetail'],
                  customerRoomNumber: data['customerRoomNumber'],
                  HotelPrice: data['HotelPrice'],
                  customerName: data['customerName'],
                  OrderAssignHotelName: data['OrderAssignHotelName']));
            }
            employeeDataSource = PaymentDataSource(employeeData);
          }

          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: SfDataGrid(
              source: employeeDataSource,
              columns: getColumnsPayment,
              columnWidthMode: ColumnWidthMode.fill,
              onCellTap: (details) {
                if (details.rowColumnIndex.rowIndex != 0) {
                  final DataGridRow row = employeeDataSource
                      .effectiveRows[details.rowColumnIndex.rowIndex - 1];
                  int index = employeeDataSource.dataGridRows.indexOf(row);
                  var data = snapshot.data!.docs[index];
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => OrderView(data: data)));
                }
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
