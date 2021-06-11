import 'package:http/http.dart' as http;
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HttpManager {
  //  三天预报
  var forecast_url = "https://api-cn.faceplusplus.com/facepp/v3/detect";
  //实况天气
  var new_weather_url = "https://free-api.heweather.com/s6/weather/now?parameters";

  /**
   * 三天预报
   * cityName 城市名称 我们应该使用外部传入
   * net 监听网络请求的结果 因为他不是同步的
   */
  getForecast(NetListener net, String cityName) {
    var client = new http.Client();
    var time = new DateTime.now().millisecondsSinceEpoch;
    client.post(
        forecast_url,
        body: {
          'api_key' : '3tWnsEAOU1dL9PlOh40PV3p2LdVDZEhG',
          'api_secret' : 'VWtztt1p8Alss_PZNIHuH5xUrJWi59b7',
          'image_url' : 'https://www.zyzw.com/sjmhxs/sjmhxst/sjmhxst002.jpg',
          'return_attributes':'gender,age,smiling,headpose,facequality,blur,eyestatus,emotion,beauty,mouthstatus,eyegaze,skinstatus'
        }
    ).then((response){
      print('response');
      net.onForecastResponse(response.body);
    },onError: (error){
      net.onError(error);
    }).whenComplete(
        client.close
    );
  }


  /**
   * 获取实况天气
   */
  getNewWeather(NetListener net,String cityName)  {
    var client = new http.Client();
    client.post(
      new_weather_url,
      body: {
        "location": cityName,
        "key": "eaf572c8304f4eeb8ad209bf05da2872",
      },
    ).then((
        response,
        ) {
      net.onNewWeatherResponse(response.body);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }

}


/**
 * 用来回调成功和失败的结果
 */
abstract class NetListener {
  //实况天气
  void onNewWeatherResponse(String body);
  //三天预报
  void onForecastResponse(String body);

  void onError(error);
}
