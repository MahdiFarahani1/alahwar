import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';



class Search
 extends StatelessWidget {
  static String rn = "/Search";
  const Search({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon.appBar("Search"),
      backgroundColor: Colors.grey.shade900,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
              child: Column(children: [
        
          dropDown(context),
        input(context),
        
        box(context)
        ],),
      )
    );
  }

  Container box(BuildContext context) {
    return Container(height:  EsaySize.height(context) /15,width: double.infinity,margin: const EdgeInsets.all(3),
      alignment: Alignment.center,
      color: Colors.white,
      child: const Text("gfklklhglhlg...",style: TextStyle(color: Colors.redAccent),),);
  }

  Container input(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(3),
        width: double.infinity,height:  EsaySize.height(context) /15,
        color: Colors.white,
        child: Row(children: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
        const Expanded(
                    child: TextField(
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.all(10),
                     
                     border: InputBorder.none,
                   ),
          ),
        )
      ]),
        );
  }

  Padding dropDown(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: [
              EsaySize.safeGap(EsaySize.width(context) / 2),
               Expanded(
                                              child: Container(
                                                height: EsaySize.height(context) /15,
                           color: Colors.white,     child: DropdownButton<String>(
                             
                             value: "item1",
                             items: const [
                               DropdownMenuItem(
                                 value: 'item1',
                                 child: Text('آیتم 1'),
                               ),
                               DropdownMenuItem(
                                 value: 'item2',
                                 child: Text('آیتم 2'),
                               ),
                               DropdownMenuItem(
                                 value: 'item3',
                                 child: Text('آیتم 3'),
                               ),
                               DropdownMenuItem(
                                 value: 'item4',
                                 child: Text('آیتم 4'),
                               ),
                             ],
                             onChanged: (value) {
                               
                             },
                             dropdownColor: Colors.white, 
                             underline: Container(
                               height: 1,
                               color: Colors.white, 
                             ),
                           ),
                         ),
                       ),
                       const Spacer(),
            Container(
                color: Colors.white,
                child:Row(children: [
          checkBox("cads",context),
          EsaySize.gap(3),
              checkBox("sadsa",context),
          
              ],)),
                   
                      
                          
          
            ],
          ),
        ),
      );
  }

  Container checkBox(String txt,BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
       
      ),
      height: EsaySize.height(context) /15,
          
            child: Row(children: [

Checkbox(value: true, onChanged: (value) {

},),
EsaySize.gap(5),
Padding(
  padding: const EdgeInsets.only(right: 5),
  child: Text(txt),
),
            ]),
          );
  }
}