import 'package:budget_app/data/data.dart';
import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../helpers/colar_helper.dart';
import '../widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  _buildCategory(Category category ,totalAmountSpent){
      return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(category:category),)),
        child: Container(
          padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          margin:const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow:const [BoxShadow(
              color: Colors.black12,
              offset: Offset(0,2),
              blurRadius: 6.0
            )]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category.name,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                  Text('\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w600))
                ],
              ),
             const SizedBox(height: 10),
              LayoutBuilder(
                builder:(contxt, constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent)/category.maxAmount;
                  double barWidth = percent * maxBarWidth;
                if (barWidth < 0){
                  barWidth = 0;
                }
                   return  Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                     Container(
                      width: barWidth,
                      height: 20,
                      decoration: BoxDecoration(
                        color: getColor(percent),
                        borderRadius: BorderRadius.circular(15)
                      ),
                    )
                  ],
                );
                },
               
              )
            ],
          ),
        ),
      );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            //pinned: true, for pin the app bar
            expandedHeight: 100.0,
            leading: IconButton(
              icon: const Icon(Icons.settings),
              iconSize: 30,
              onPressed: () {},
            ),
            flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Simple Budget',
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            if (index == 0) {
              return Container(
                padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: BarChart(expense: weeklySpending),
              );
            }
            else{
              final Category category = categories[index - 1];
              double totalAmountSpent = 0 ;
              category.expenses.forEach((element) {
                totalAmountSpent += element.cost;
              });
              return _buildCategory(category, totalAmountSpent);
            }
          }, childCount: 1 + categories.length))
        ],
      ),
    );
  }
}
