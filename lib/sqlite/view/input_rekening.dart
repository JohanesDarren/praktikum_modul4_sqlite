import 'package:flutter/material.dart';
import '../transaction/rekening_handler.dart';

class InputRekening extends StatefulWidget {
  const InputRekening({super.key});

  @override
  State<InputRekening> createState() => _InputRekeningState();
}

class _InputRekeningState extends State<InputRekening> {
  double saldo1 = 0;
  double saldo2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input rekening"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(onPressed: () async {
                  await RekeningQueryHandler()
                      .bacaSaldo(4)
                      .then(
                        (saldo){
                          setState(() {
                            saldo1 = saldo;
                          });
                        }
                    );
                }, child: Text("Saldo rek 1")),
                Text("Saldo rek 1 $saldo1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              ],
            ),
            Row(
              children: [
                TextButton(onPressed: () async {
                  await RekeningQueryHandler()
                      .bacaSaldo(5)
                      .then((saldo){
                        setState(() {
                          saldo2 = saldo;
                        });
                      });
                }, child: Text("Saldo Rek 2")),
                Text("Saldo rek 2 $saldo2",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              ],
            ),
            TextButton(
                onPressed: () async{
                  RekeningQueryHandler().safeTransfer(5, 4, 200000);
                  await RekeningQueryHandler()
                      .bacaSaldo(4)
                      .then((saldo){
                    setState(() {
                      saldo1 = saldo;
                    });
                  });
                  await RekeningQueryHandler()
                      .bacaSaldo(5)
                      .then((saldo){
                    setState(() {
                      saldo2 = saldo;
                    });
                  });
                },
                child: Text("Transfer")
            ),
            TextButton(
                onPressed: (){
                  RekeningQueryHandler().isiRekening(1, 1000000);
                },
                child: Text("Isi Rekening 1")
            ),

            TextButton(
                onPressed: (){
                  RekeningQueryHandler().isiRekening(2, 2000000);
                },
                child: Text("Isi Rekening 2")
            ),

          ],
        ),
      ),
    );
  }
}
