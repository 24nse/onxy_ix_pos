import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/features/home/data/local/mock_products.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CartList extends HookWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    final productDataSource = useMemoized((){
      return ProductDataSource(productData: mockProducts,
      
      );
    });
    return SfDataGrid(
        source: productDataSource,
          rowHeight: 70,
      columnWidthMode: ColumnWidthMode.fill,
      gridLinesVisibility: GridLinesVisibility.none,
      headerGridLinesVisibility: GridLinesVisibility.none,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text('ID'),
            ),
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Name'),
            ),
          ),
          GridColumn(
            columnName: 'designation',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Designation', overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: 'salary',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Salary'),
            ),
          ),
        ],
      );
    // return Column(
    //   children: [
    //     ListView.separated(
    //       separatorBuilder: (context, index) => Divider(
    //         color: Colors.grey.shade300,
    //         height: 5,
    //       ),
    //       itemCount: mockProducts.length,
    //       itemBuilder: (context, index) {
    //         return Container(
    //           decoration: BoxDecoration(
    //             color: Colors.grey.shade100,
    //           ),
    //           child: ListTile(
    //             leading: CircleAvatar(
    //               backgroundImage: NetworkImage(mockProducts[index].image
    //             ),),
    //             title: Text(mockProducts[index].name),
                
    //             trailing: Row(
                  
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                  Text('\$${mockProducts[index].price.toStringAsFixed(2)}'),
    //                  SizedBox(width: 8), 
        
    //                  Text('\$${mockProducts[index].price.toStringAsFixed(2)}'),
    //                                   SizedBox(width: 8), 
        
    //                  Text('\$${mockProducts[index].price.toStringAsFixed(2)}'),
    //                 IconButton(
    //                   icon: Icon(Icons.remove),
    //                   onPressed: () {
    //                     // Handle remove from cart
    //                   },
    //                 ),
    //                  Text('1'),
    //                    IconButton(
    //                   icon: Icon(Icons.add),
    //                   onPressed: () {
    //                     // Handle remove from cart
    //                   },
    //                 ),   IconButton(
    //                   icon: Icon(Icons.delete),
    //                   onPressed: () {
    //                     // Handle remove from cart
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ],
    // );
  }
}

class ProductDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  ProductDataSource({required List<Product> productData}) {
    _productData =
        productData
            .map<DataGridRow>(
              (e) => DataGridRow(
                cells: [
                  DataGridCell<int>(columnName: 'id', value: int.parse(e.id)),
                  DataGridCell<String>(columnName: 'name', value: e.name),
                  DataGridCell<String>(
                    columnName: 'designation',
                    value: e.category,
                  ),
                  DataGridCell<int>(columnName: 'salary', value: e.price.toInt()),
                ],
              ),
            )
            .toList();
  }

  List<DataGridRow> _productData = [];

  @override
  List<DataGridRow> get rows => _productData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells:
          row.getCells().map<Widget>((e) {
            return Container(
              
              alignment: Alignment.center,
              padding: EdgeInsets.all(8.0),
              child: Text(e.value.toString()),
            );
          }).toList(),
    );
  }
}