import 'package:flutter/material.dart';
import 'package:majootestcase/models/movie_response.dart';

class DetailBlocLoadedScreen extends StatelessWidget {
  const DetailBlocLoadedScreen({Key? key, required this.data})
      : super(key: key);
  final Data data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Movie'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24.0),
        children: [
          Image.network(
            data.i.imageUrl,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.l,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  data.year.toString(),
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0),
                if (data.series != null)
                  Text(
                    'Series',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                SizedBox(height: 8.0),
                if (data.series != null) _seriesMovieItem()
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _seriesMovieItem() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.series!.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 16.0);
      },
      itemBuilder: (context, index) {
        Series series = data.series![index];
        return Card(
          elevation: 4.0,
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(8.0)),
                  image: DecorationImage(
                    image: NetworkImage(series.i.imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  series.l,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
