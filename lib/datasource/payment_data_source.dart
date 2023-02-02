import 'package:ajawa_hotel/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PaymentDataSource extends DataGridSource {
  PaymentDataSource(this.employeeData) {
    _buildDataRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<Order_Model> employeeData;

  void _buildDataRow() {
    dataGridRows = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              // DataGridCell<String>(columnName: 'uuid', value: e.uuid),
              DataGridCell<String>(columnName: 'uuid', value: e.uuid),
              DataGridCell<String>(
                  columnName: 'HotelPrice', value: e.HotelPrice),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(
    DataGridRow row,
  ) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

List<GridColumn> get getColumnsPayment {
  //   DataGridCell<String>(columnName: 'uid', value: e.id),
  // DataGridCell<String>(columnName: 'name', value: e.name),
  // DataGridCell<String>(columnName: 'gender', value: e.gender),
  // DataGridCell<String>(columnName: 'email', value: e.email),
  // DataGridCell<String>(columnName: 'dob', value: e.dob),
  // DataGridCell<String>(columnName: 'phoneNumber', value: e.phone),
  return <GridColumn>[
    GridColumn(
        columnName: 'uuid',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Order ID'))),
    GridColumn(
        columnName: 'HotelPrice',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Hotel Price',
              overflow: TextOverflow.ellipsis,
            ))),
  ];
}
