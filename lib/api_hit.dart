
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
// import 'package:url_launcher/url_launcher.dart';


const String apiUrl = "https://catfact.ninja/fact";

Future getData() async {
    Response res = await get(Uri.parse(apiUrl));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }



class DataRepository {
  DataRepository() {
    getData();
  }

  DataApi dataApi = DataApi();
  List<Map<String, dynamic>> formattedData = [];
  final _controller = StreamController<List<Map<String, dynamic>>>();

  Future<void> getData() async {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      Map<String, dynamic> el =  dataApi.getNew();
      formattedData.add({'id': el['id'], 'name': el['name']});
      _controller.add(formattedData);
    });
  }

  Stream<List<Map<String, dynamic>>> data() async* {
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}

class DataApi {
  var rng = Random();
  getNew() {
    var rnd = rng.nextInt(100);
    return {
      "id": rnd,
      "name": "Person " + rnd.toString()
    };
  }
}

class DataListState   {
  const DataListState(this.data);

  final List<Map<String, dynamic>> data;

  DataListState copyWith({
    List<Map<String, dynamic>>? data,
  }) {
    return DataListState(
      data ?? this.data,
    );
  }
}

class DataListCubit extends Cubit<DataListState> {
  DataListCubit(this.dataRepository) : super(DataListState([])) {
    loadList();
  }
  final DataRepository dataRepository;

  loadList() {
    dataRepository.data().listen((event) {
      if (event.isNotEmpty) {
        emit(state.copyWith(data: dataRepository.formattedData));
      }
    });
  }
}



