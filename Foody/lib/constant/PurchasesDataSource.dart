import 'package:flutter/material.dart';
import 'package:foody/model/modelFake/ChartDataGridPurchases.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PurchasesDataSource  extends DataGridSource {

  List<DataGridRow> dataGridRows = [];
  late BuildContext context;


  PurchasesDataSource({required List<ChartDataGridPurchases> purchases , required context}) {

    this.context = context;

    dataGridRows = purchases
        .map<DataGridRow>((dataGridRow) => DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
          DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
          DataGridCell<int>(columnName: 'quantity', value: dataGridRow.quantity),
          DataGridCell<double>(columnName: 'price', value: dataGridRow.price),
          DataGridCell<double>(columnName: 'discount', value: dataGridRow.discount),
    ]))
        .toList();
  }



  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {

          return Container(
              alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'price')
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                dataGridCell.value.toString(),
                style: TextStyle(color: dataGridCell.columnName == 'price' ?  Colors.red[300] : Theme.of(context).textTheme.bodyText1!.color),
                overflow: TextOverflow.ellipsis,
              ));

        }).toList());
  }
}