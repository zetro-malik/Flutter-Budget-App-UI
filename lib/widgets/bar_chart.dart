import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BarChart extends StatelessWidget {
  final List<double> expense;

  BarChart({required this.expense});


  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expense.forEach((element) {
      if (element > mostExpensive){
        mostExpensive = element;
      }
    },);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text(
            'Weekly Spending',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back),iconSize: 30,),
              const Text('Nov 10, 2019 - Nov 16, 2019',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,letterSpacing: 0.6),),
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward),iconSize: 30,),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(lable:'Su',amountSpent:expense[0], mostExpensive:mostExpensive),
              Bar(lable:'Mo',amountSpent:expense[1], mostExpensive:mostExpensive),
              Bar(lable:'Tu',amountSpent:expense[2], mostExpensive:mostExpensive),
              Bar(lable:'We',amountSpent:expense[3], mostExpensive:mostExpensive),
              Bar(lable:'Th',amountSpent:expense[4], mostExpensive:mostExpensive),
              Bar(lable:'Fr',amountSpent:expense[5], mostExpensive:mostExpensive),
              Bar(lable:'Sa',amountSpent:expense[6], mostExpensive:mostExpensive),
            
            ],
          )
        ],
      ),
    );
  }
}


class Bar extends StatelessWidget {
  
  final String lable;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight=150.0;
  

  const Bar({super.key, required this.lable, required this.amountSpent, required this.mostExpensive});@override
  Widget build(BuildContext context) {
    final barHeight = amountSpent/mostExpensive * _maxBarHeight;
    return  Column(
      children: [
        Text('\$${amountSpent.toStringAsFixed(2)}',style:const TextStyle(fontWeight: FontWeight.w600),),
        const SizedBox(height: 6.0),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6.0)
          ),
         
        ),
        const SizedBox(height: 9.0),
        Text(lable,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),

      ],
    );
  }
}