import 'package:flutter/material.dart';
import 'package:notes/widgets/weather_widgets.dart';
import 'package:weather/weather.dart';



String text_ = '';
String Cityname = '';


WeatherFactory wf = new WeatherFactory("4437f66f2bfb5c2ab81145c3d26fac35", language: Language.RUSSIAN);

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

void weather() async{

  Weather weather = await wf.currentWeatherByCityName(Cityname);

  
}



class _MyAppState extends State<MyApp> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(7, 40, 61, 1),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: AnimatedContainer(
              height: _isExpanded ? 500 : 150,
              width: _isExpanded ? 500 : 500,
              duration: const Duration(seconds: 1),
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  disabledForegroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white,
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
                child: _isExpanded
                  ? const Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 30,),
                          Icon(Icons.map, color: Color.fromRGBO(14, 42, 61, 1),),
                          SizedBox(width: 25,),
                          Text('City', style: TextStyle(color: Color.fromRGBO(14, 42, 61, 1)), ),
                          SizedBox(width: 200,),
                          Icon(Icons.search, color: Color.fromRGBO(44, 91, 124, 1),)
                        ],
                      ),
                      Weather_Widget()
                    ],
                  )
                  : Row(
                      children: [
                        const SizedBox(width: 30,),
                        const Icon(Icons.map, color: Color.fromRGBO(14, 42, 61, 1),),
                        const SizedBox(width: 25,),
                        const SizedBox(
                          width: 200,
                          child: Text_Field_updating(),
                        ),
                        const SizedBox(width: 20,),
                        IconButton(
                          onPressed: () {                            
                              setState(() {
                              _isExpanded = !_isExpanded;
                              weather();
                            });
                          },
                          icon: const Icon(Icons.search, color: Color.fromRGBO(44, 91, 124, 1),))
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class Text_Field_updating extends StatefulWidget {
  const Text_Field_updating({super.key});

  @override
  _Text_Field_updatingState createState() => _Text_Field_updatingState();
}

class _Text_Field_updatingState extends State<Text_Field_updating> {
  final TextEditingController _controller = TextEditingController();


  @override
  void dispose() {
    _controller.dispose(); // Очистка ресурсов при удалении виджета
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
      ),
      onChanged: (text) {
        text_ = text;
        Cityname = text;
      },
    );
  }
}
