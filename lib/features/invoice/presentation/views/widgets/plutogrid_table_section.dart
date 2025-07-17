
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_models/cubits/invoice_cubit.dart';

class PlutogridTableSection extends StatelessWidget {
  const PlutogridTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        List<PlutoRow> rows = [];
        if (state is InvoiceLoaded) {

          rows = state.invoice.items.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final item = entry.value;
            return PlutoRow(
              cells: {
                'number': PlutoCell(value: index.toString()),
                'item': PlutoCell(value: item.name),
                'unit': PlutoCell(value: item.unit),
                'qty': PlutoCell(value: item.quantity.toString()),
                'free_qty': PlutoCell(value: item.freeQuantity.toString()),
                'price': PlutoCell(value: item.price.toStringAsFixed(2)),
                'vat_percent': PlutoCell(
                  value: '${(item.vatPercent * 100).toStringAsFixed(0)}%',
                ),
                'vat_value': PlutoCell(value: item.vatValue.toStringAsFixed(2)),
                'total': PlutoCell(value: item.total.toStringAsFixed(2)),
              },
            );
          }).toList();

        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFF9F9F9)),
            borderRadius: BorderRadius.circular(8),
          ),
          height: 220,
          width: double.infinity,
          child: PlutoGrid(
            key: ValueKey(rows.length),
            columns: plutoColumns,
            rows: rows,
            mode: PlutoGridMode.readOnly,
            configuration: PlutoGridConfiguration(
              columnSize: const PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.scale,
                resizeMode: PlutoResizeMode.pushAndPull,
              ),
              style: PlutoGridStyleConfig(
                gridBorderColor: const Color(0xFFF9F9F9),
                gridBackgroundColor: Colors.white,
                rowColor: Colors.white,
                activatedColor: const Color(0xFFF5F5F5).withValues(alpha: 0.5),
                cellTextStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontFamily: 'Cairo',
                ),
                columnTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Cairo',
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
      },
    );
  }
}

List<PlutoColumn> get plutoColumns => [
  PlutoColumn(
    title: '#',
    field: 'number',
    type: PlutoColumnType.text(),
    width: 50,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'اسم الصنف',
    field: 'item',
    type: PlutoColumnType.text(),
    width: 160,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'الوحدة',
    field: 'unit',
    type: PlutoColumnType.text(),
    width: 70,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'السعر',
    field: 'price',
    type: PlutoColumnType.text(),
    width: 70,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'الكمية',
    field: 'qty',
    type: PlutoColumnType.text(),
    width: 60,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'الكمية المجانية',
    field: 'free_qty',
    type: PlutoColumnType.text(),
    width: 90,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'ضريبة %',
    field: 'vat_percent',
    type: PlutoColumnType.text(),
    width: 70,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'قيمة ضريبة',
    field: 'vat_value',
    type: PlutoColumnType.text(),
    width: 70,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
  PlutoColumn(
    title: 'الإجمالي',
    field: 'total',
    type: PlutoColumnType.text(),
    width: 80,
    titleTextAlign: PlutoColumnTextAlign.center,
    textAlign: PlutoColumnTextAlign.center,
    backgroundColor: const Color(0xFFDC292F),
  ),
].reversed.toList();
