import 'package:notes/widgets/my_app.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';


Future<List> all_weather_types() async {
  
  List types = [];
  Weather weather = await wf.currentWeatherByCityName(Cityname);

  types.add(weather.humidity);
  types.add(weather.windSpeed);
  types.add(weather.weatherDescription);
  types.add(weather.temperature);


  return types;

}

Future<Widget> image_weather() async {

  List types = [];
  Weather weather = await wf.currentWeatherByCityName(Cityname);
  types.add(weather.weatherDescription);
  String weather_ = types[0].toString();
  print(weather_);
  if (weather_ == 'Ясно'){
    return Image.network('https://github.com/JerkingFan/weather/blob/main/clear.png');
  }
  if (weather_ == 'Облачно с прояснениями'){
    return Image.network('https://github.com/JerkingFan/weather/blob/main/cloud.png');
  }
  if (weather_ == 'Дождь'){
    return Image.network('https://github.com/JerkingFan/weather/blob/main/mist.png');
  }

  else{
    return Image.network('https://github.com/JerkingFan/weather/blob/main/404.png');
  }


}

class Weather_Widget extends StatelessWidget {
  const Weather_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    var text_style = const TextStyle(color: Color.fromRGBO(14, 39, 61, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold);
    var text_style_const = const TextStyle(color: Color.fromRGBO(14, 39, 61, 1),
                              fontSize: 8,
                              fontWeight: FontWeight.bold);
    return FutureBuilder<List>(
      future: all_weather_types(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        } else {
          String tempStr = snapshot.data![3].toString();
          String firstTwoChars = tempStr.substring(0, 4);
          String wind = snapshot.data![2].toString();
          wind =  wind[0].toUpperCase() + wind.substring(1);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Widget>(
                future: image_weather(),
                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  } else {
                    return snapshot.data!;
                  }
                },
              ),
              SizedBox(height: 200,),
              
              Text('${firstTwoChars} C', style: const TextStyle(color: Color.fromRGBO(14, 39, 61, 1), 
                                                                fontSize: 45,
                                                                fontWeight: FontWeight.bold),),
              Text('${wind}', style: text_style),
              SizedBox(height: 50,), 
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.water, color: Color.fromRGBO(14, 39, 61, 1),),
                      const SizedBox(width: 5,),
                      Column(
                        children: [
                          Text('${snapshot.data![0]} %',style: text_style),
                          Text("Влажность", style: text_style_const),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(width: 150,),
                  Row(
                    children: [
                      const Icon(Icons.wind_power, color: Color.fromRGBO(14, 39, 61, 1),),
                      const SizedBox(width: 5,),
                      Column(
                        children: [
                          Text('${snapshot.data![1]} км/ч',style: text_style),
                          Text("Скорость ветра", style: text_style_const),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              
            ],
          );
        }
      },
    );
  }
}


