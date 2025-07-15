import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PlutogridTableSection extends StatelessWidget {
  const PlutogridTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFF9F9F9)),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 220,
      width: double.infinity,
      child: PlutoGrid(
        columns: plutoColumns,
        rows: plutoRows,
        mode: PlutoGridMode.readOnly,

        configuration: PlutoGridConfiguration(
          
          columnSize: const PlutoGridColumnSizeConfig(
            autoSizeMode: PlutoAutoSizeMode.scale,
           
            resizeMode: PlutoResizeMode.pushAndPull,
          ),
          style: PlutoGridStyleConfig(
            
            gridBorderColor: Color(0xFFF9F9F9),
            gridBackgroundColor: Colors.white,
            rowColor: Colors.white,
            activatedColor: const Color(0xFFF5F5F5).withValues(alpha: 0.5),
            cellTextStyle: const TextStyle(fontSize: 13, color: Colors.black),
            columnTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black,
            ),
            columnHeight: 44,
            rowHeight: 38,
            enableColumnBorderVertical: true,
            enableGridBorderShadow: false,
            
            
          ),
        ),
        onLoaded: (event) {},
        onChanged: (event) {},
      ),
    );
  }
}

List<PlutoRow> get plutoRows => [
  PlutoRow(
    cells: {
      'number': PlutoCell(value: '1'),
      'item': PlutoCell(
        value: 'خدمات صياgderyewyewyrwryewryewryewyewywyewنة 90-90',
      ),
      'unit': PlutoCell(value: 'حبة'),
      'qty': PlutoCell(value: '1'),
      'free_qty': PlutoCell(value: '0'),
      'price': PlutoCell(value: '48.70'),
      'vat_percent': PlutoCell(value: '15%'),
      'vat_value': PlutoCell(value: '7.30'),
      'total': PlutoCell(value: '56.00'),
    },
  ),
  PlutoRow(
    cells: {
      'number': PlutoCell(value: '2'),
      'item': PlutoCell(value: 'خدمات صيانة 90-90'),
      'unit': PlutoCell(value: 'حبة'),
      'qty': PlutoCell(value: '1'),
      'free_qty': PlutoCell(value: '0'),
      'price': PlutoCell(value: '48.70'),
      'vat_percent': PlutoCell(value: '15%'),
      'vat_value': PlutoCell(value: '7.30'),
      'total': PlutoCell(value: '56.00'),
    },
  ),
  PlutoRow(
    cells: {
      'number': PlutoCell(value: '3'),
      'item': PlutoCell(value: 'خدمات صيانة 90-90'),
      'unit': PlutoCell(value: 'حبة'),
      'qty': PlutoCell(value: '1'),
      'free_qty': PlutoCell(value: '0'),
      'price': PlutoCell(value: '48.70'),
      'vat_percent': PlutoCell(value: '15%'),
      'vat_value': PlutoCell(value: '7.30'),
      'total': PlutoCell(value: '56.00'),
    },
  ),
  
];
List<PlutoColumn> get plutoColumns => [
   PlutoColumn(
    title: 'الإجمالي',
    field: 'total',
    type: PlutoColumnType.text(),
    width: 80,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),
   PlutoColumn(
    title: 'قيمة ضريبة',
    field: 'vat_value',
    type: PlutoColumnType.text(),
    width: 70,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'ضريبة %',
    field: 'vat_percent',
    type: PlutoColumnType.text(),
    width: 70,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),
 PlutoColumn(
    title: 'السعر',
    field: 'price',
    type: PlutoColumnType.text(),
    width: 70,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'الكمية المجانية',
    field: 'free_qty',
    type: PlutoColumnType.text(),
    width: 90,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),
 
  PlutoColumn(
    title: 'الكمية',
    field: 'qty',
    type: PlutoColumnType.text(),
    width: 60,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'الوحدة',
    field: 'unit',
    type: PlutoColumnType.text(),
    width: 70,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),
   PlutoColumn(
    title: 'اسم الصنف',
    field: 'item',
    type: PlutoColumnType.text(),
    width: 160,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),

   PlutoColumn(
    title: '#',
    field: 'number',
    type: PlutoColumnType.text(),
    width: 50,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: Color(0xFFDC292F),
  ),
];
