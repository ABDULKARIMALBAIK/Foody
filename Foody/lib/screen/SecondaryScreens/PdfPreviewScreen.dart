import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/model/modelFake/Spice.dart';
import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget{


  List<FoodTable> carts = [];


  PdfPreviewScreen(List<FoodTable> carts){
    this.carts = carts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: PdfPreview(
          canChangeOrientation: false,
        loadingWidget: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
        onPrinted: (context) => print('print the pdf file'),
        build: (format) => _generatePdf(format, context)
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, BuildContext context) async {

    //Init pdf components
    pw.Document pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.montserratRegular();

    PdfImage logoImage = await fetchLogoPdf(pdf);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (contextPage) {
          return pw.Container(
              width: double.infinity,
              height: double.infinity,
              child: pw.Column(
                children: [
                  //////////////////////// * PDF title * ////////////////////////
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.FittedBox(
                      child: pw.Text(
                          AppLocalizations.of(context)!.translate('checkout_print_page_title'),
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 18,
                          )
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  //////////////////////// * PDF image * ////////////////////////
                  //Add here image (center)????
                  //////////////////////// * PDF recipes * ////////////////////////
                  pw.FittedBox(
                    child: pw.Text(
                        AppLocalizations.of(context)!.translate('checkout_print_page_recipes'),
                        style: pw.TextStyle(
                          font: font,
                          fontSize: 16,
                        )
                    ),
                  ),
                  //////////////////////// * PDF items * ////////////////////////
                  pw.ListView.builder(
                    itemCount: carts.length,
                    itemBuilder: (contextRecipe , index){
                      return pw.Column(
                          children: [
                            //////////////////////// * PDF name recipe * ////////////////////////
                            pw.SizedBox(height: 10),
                            pw.Row(
                                children: [
                                  pw.FittedBox(
                                    child: pw.Text(
                                        AppLocalizations.of(context)!.translate('checkout_print_page_recipe_name'),
                                        style: pw.TextStyle(
                                          font: font,
                                          fontSize: 14,
                                        )
                                    ),
                                  ),
                                  pw.SizedBox(width: 2),
                                  pw.FittedBox(
                                    child: pw.Text(
                                        carts[index].name,
                                        style: pw.TextStyle(
                                          font: font,
                                          fontSize: 12,
                                        )
                                    ),
                                  ),
                                ]
                            ),
                            //////////////////////// * PDF size recipe * ////////////////////////
                            pw.SizedBox(height: 2),
                            pw.Row(
                                children: [
                                  pw.FittedBox(
                                    child: pw.Text(
                                        AppLocalizations.of(context)!.translate('checkout_print_page_recipe_size'),
                                        style: pw.TextStyle(
                                          font: font,
                                          fontSize: 12,
                                        )
                                    ),
                                  ),
                                  pw.SizedBox(width: 2),
                                  pw.FittedBox(
                                    child: pw.Text(
                                        getSize(carts[index].size),
                                        style: pw.TextStyle(
                                          font: font,
                                          fontSize: 12,
                                        )
                                    ),
                                  ),
                                ]
                            ),
                            //////////////////////// * PDF num recipe * ////////////////////////
                            pw.SizedBox(height: 2),
                            pw.Row(
                              children: [
                                pw.FittedBox(
                                  child: pw.Text(
                                      AppLocalizations.of(context)!.translate('checkout_print_page_recipe_num'),
                                      style: pw.TextStyle(
                                        font: font,
                                        fontSize: 12,
                                      )
                                  ),
                                ),
                                pw.SizedBox(width: 2),
                                pw.FittedBox(
                                  child: pw.Text(
                                      carts[index].quantity.toString(),
                                      style: pw.TextStyle(
                                        font: font,
                                        fontSize: 12,
                                      )
                                  ),
                                ),
                              ],
                            ),
                            //////////////////////// * PDF spices recipe * ////////////////////////
                            pw.SizedBox(height: 2),
                            pw.Row(
                                children: [
                                  pw.FittedBox(
                                    child: pw.Text(
                                        AppLocalizations.of(context)!.translate('checkout_print_page_recipe_spices'),
                                        style: pw.TextStyle(
                                          font: font,
                                          fontSize: 12,
                                        )
                                    ),
                                  ),
                                  pw.SizedBox(width: 2),
                                  pw.FittedBox(
                                    child: pw.Text(
                                        getSpicesPDF(context , carts[index]),
                                        style: pw.TextStyle(
                                          font: font,
                                          fontSize: 12,
                                        )
                                    ),
                                  ),
                                ]
                            ),
                            //////////////////////// * PDF price recipe * ////////////////////////
                            pw.SizedBox(height: 2),
                            pw.Row(
                                children: [
                                  pw.FittedBox(
                                    child: pw.Text(
                                        AppLocalizations.of(context)!.translate('checkout_print_page_recipe_price'),
                                        style: pw.TextStyle(
                                          font: font,
                                          fontSize: 12,
                                        )
                                    ),
                                  ),
                                  pw.SizedBox(width: 2),
                                  pw.FittedBox(
                                    child: pw.Text(
                                        getPricePDF(context , carts[index]),
                                        style: pw.TextStyle(
                                          font: font,
                                          fontSize: 12,
                                        )
                                    ),
                                  ),
                                ]
                            ),
                            //////////////////////// * Divider * ////////////////////////
                            pw.Divider(),

                          ]
                      );
                    },
                  ),
                  //////////////////////// * PDF total recipes * ////////////////////////
                  pw.SizedBox(height: 8),
                  pw.Row(
                      children: [
                        pw.FittedBox(
                          child: pw.Text(
                              AppLocalizations.of(context)!.translate('checkout_print_page_recipe_total_price'),
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 16,
                              )
                          ),
                        ),
                        pw.SizedBox(width: 2),
                        pw.FittedBox(
                          child: pw.Text(
                              getPriceTotalPDF(context),
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 12,
                              )
                          ),
                        ),
                      ]
                  ),
                ],
              )
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<PdfImage> fetchLogoPdf(pdf) async {

    ByteData _bytes = await rootBundle.load('images/foody_logo.png');
    Uint8List logoBytes = _bytes.buffer.asUint8List();
    PdfImage _logoImage;

    _logoImage = PdfImage.file(
      pdf.document,
      bytes: logoBytes,
    );

    return _logoImage;
  }

  String getSpicesPDF(BuildContext context , FoodTable cart) {

    print('start get spices');
    print('cart of spices: ${cart.spices}');
    String spices = '';

    //Get data and convert it to list
    var data = jsonDecode(cart.spices) as List<dynamic>;
    List<Spice> listSpices = data.map((model) => Spice.fromJson(model)).toList();
    print('finish json decode');

    //Loop to add all spices
    listSpices.forEach((spice) {
      spices += '${spice.name} ${spice.price}\$ , ';
    });
    print('finish get spices');
    print('spices: $spices');

    return spices;

  }

  String getPricePDF(BuildContext context , FoodTable cart) {

    ////////////////////////////////Spices section
    double spices = 0.0;

    //Get data and convert it to list
    var data = jsonDecode(cart.spices) as List<dynamic>;
    List<Spice> listSpices = data.map((model) => Spice.fromJson(model)).toList();


    //calc all spices
    listSpices.forEach((spice) {
      spices +=  spice.price;
    });


    ////////////////////////////////Size section
    double sizeCount = 0; //Small
    switch(cart.size){
      case 1 :{
        sizeCount = 0;
        print('Small Size is selected !');
        break;
      }
      case 2 :{
        sizeCount = 200;
        print('Medium Size is selected !');
        break;
      }
      case 3 :{
        sizeCount = 400;
        print('Large Size is selected !');
        break;
      }
      default :{
        sizeCount = 0;
        print('Default Small Size is selected !');
        break;
      }
    }

    ////////////////////////////////Calc all section
    double totalPrice = double.parse(cart.newPrice) * cart.quantity;
    totalPrice += spices + sizeCount;
    print('pdf price is $totalPrice');


    return totalPrice.toStringAsFixed(2);
  }

  String getPriceTotalPDF(BuildContext context) {

    ////////////////////////////////Spices section
    double spices = 0.0;

    //Get data and convert it to list
    for(FoodTable cart in carts){

      var data = jsonDecode(cart.spices) as List<dynamic>;
      List<Spice> listSpices = data.map((model) => Spice.fromJson(model)).toList();


      //calc all spices
      listSpices.forEach((spice) {
        spices +=  spice.price;
      });
    }


    ////////////////////////////////Size section
    double sizeCount = 0; //Small

    for(FoodTable cart in carts){
      switch(cart.size){
        case 1 :{
          sizeCount += 0;
          print('Small Size is selected !');
          break;
        }
        case 2 :{
          sizeCount += 200;
          print('Medium Size is selected !');
          break;
        }
        case 3 :{
          sizeCount += 400;
          print('Large Size is selected !');
          break;
        }
        default :{
          sizeCount += 0;
          print('Default Small Size is selected !');
          break;
        }
      }
    }


    ////////////////////////////////Calc all section
    double totalPrice = double.parse(((carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)) + carts.map<double>((cart) => double.parse(cart.newPrice) * cart.quantity).reduce((value, element) => value + element)* 0.1).toStringAsFixed(2));
    totalPrice += spices + sizeCount;
    print('pdf price total is $totalPrice');


    return totalPrice.toStringAsFixed(2);

  }

  String getSize(int size) {
    switch(size){
      case 1:{
        return 'Small';
      }
      case 2:{
        return 'Medium';
      }
      case 3:{
        return 'Large';
      }
      default:{
        return 'Small';
      }
    }
  }

}