import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_blog/constants/api_key.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherBlocLoding());
      try {
        WeatherFactory weatherFactory =
            WeatherFactory(apiKey, language: Language.ENGLISH);
        // Position position = await Geolocator.getCurrentPosition(
        //     desiredAccuracy: LocationAccuracy.high);
        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event. position.longitude);
        print(weather);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
