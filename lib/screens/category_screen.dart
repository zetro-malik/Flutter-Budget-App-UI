import 'package:budget_app/helpers/colar_helper.dart';
import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/widgets/radial_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryScreen extends StatefulWidget {
  Category category;

  CategoryScreen({required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
 

 _buildExpense(){
  List<Widget> expenseList = [];
  widget.category.expenses.forEach((element) {
    expenseList.add(
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow:const [BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 2),
          blurRadius: 6
        )]),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(element.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              Text('-\$${element.cost.toStringAsFixed(2)}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.red),)
           
            ],
          ),
        ),
      )
    );
  });
  return Column(
    children: expenseList,
  );
 }
 
 
  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category.expenses.forEach((element) {
      totalAmountSpent += element.cost;
    });
    final double amountLeft = widget.category.maxAmount - totalAmountSpent;
    final double percent = amountLeft / widget.category.maxAmount;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            iconSize: 30,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6)
                  ]),
              child: CustomPaint(
                foregroundPainter: RadialPainter(bgColor: Colors.grey,lineColor: getColor(percent),percent: percent,width: 15.0),
                child: Center(child: Text('\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount.toStringAsFixed(2)}',style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),))),
            ),
            _buildExpense()
          ],
        ),
      ),
    );
  }
}
