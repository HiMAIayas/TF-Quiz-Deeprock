import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //TODO: 6.ปรับปรุง UI ตามชอบ โดยนักเรียนอาจเปลี่ยน icon ให้เป็นรูปอื่นนอกจาก check/close ด้วยก็ได้
        backgroundColor: Colors.grey[200],
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/synthwave.jpg'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  //create an empty list
  List<Icon> scoreKeeper = [];

  //TODO: 4.ปรับปรุงคำถามและคำตอบที่สอดคล้องกัน โดยให้มีคำถาม-คำตอบอย่างน้อย 5 ข้อ (ไม่รวมข้อสุดท้ายที่ให้กดปุ่มใดๆ) อาจเป็นคำถามใหม่ทั้งหมดก็ได้
  List<String> questions = [
    'Earth is flat.',
    'Ocean is deep.',
    'Rock is in the ocean.',
    'But the rock is reef.',
    'Rock is in the depth.',
    'So deep, so you shocked.',
    'Below there, the dwarf is left.',
    'Then we play Deeprock.'
  ];
  List<bool> answers = [false, true, true, false, true, false, false, true];
  int questionNumber = 0;
  double progression = 0;
  int score = 0;
  bool chosen = false;
  bool chosenAnswer = true;
  bool end = false;
  int qN=1;

  void checkQ(bstatus) {
    bool correctAnswer = answers[questionNumber];
    setState(() {
      if (correctAnswer == bstatus) {
        //กรณีที่ตอบถูก
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        score++;
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      if (questionNumber < questions.length - 1) {
        questionNumber++;
        progression = questionNumber / 8;
        qN=questionNumber+1;
      } else {
        end = true;
        progression=1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        LinearProgressIndicator(
          color: Colors.deepPurple,
          minHeight: 10,
          value: progression,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'No. $qN/8',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 150,
            ),
            Text(
              'Score: $score/8',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Text(
            (end==false)?questions[questionNumber]:'Well Done',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          height: 160,
          width: 100,
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          height: 320,
          width: 100,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              if (end == false) ...[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      chosen = true;
                      chosenAnswer = true;
                    });
                  },
                  child: Container(
                    child: Text(
                      'True',
                      style: TextStyle(
                          fontSize: 30,
                          color: (chosen == true && chosenAnswer == true)
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 6),
                        color: (chosen == true && chosenAnswer == true)
                            ? Colors.white
                            : Colors.black.withOpacity(0.2)),
                    width: 350,
                    height: 70,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      chosen = true;
                      chosenAnswer = false;
                    });
                  },
                  child: Container(
                    child: Text(
                      'False',
                      style: TextStyle(
                          fontSize: 30,
                          color: (chosen == true && chosenAnswer == false)
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 6),
                        color: (chosen == true && chosenAnswer == false)
                            ? Colors.white
                            : Colors.black.withOpacity(0.2)),
                    width: 350,
                    height: 70,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                if (chosen == true) ...[
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.indigo.shade300),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          chosen = false;
                        });
                        checkQ(chosenAnswer);
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ]
              else ...[
                SizedBox(
                  height:60,
                ),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.indigo.shade300),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        progression = 0;
                        questionNumber = 0;
                        scoreKeeper.clear();
                        score=0;
                        qN=1;
                        end=false;
                      });
                    },
                    child: Text(
                      'Restart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
        //แสดงผล icon สำหรับ scoreKeeper
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
