import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/detail_block/detail_bloc_cubit.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/ui/detail/detail_bloc_screen.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
  final List<Data> data;

  const HomeBlocLoadedScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
        actions: [
          IconButton(
            onPressed: () => handleLogout(context),
            icon: Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return movieItemWidget(data[index], context);
        },
      ),
    );
  }

  Widget movieItemWidget(Data data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => DetailBlocCubit()..fetchingDetailMovie(data),
              child: DetailBlocScreen(),
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.network(data.i.imageUrl),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(data.l, textDirection: TextDirection.ltr),
            )
          ],
        ),
      ),
    );
  }

  void handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => handleLogoutAction(context),
              child: Text('Yes'),
            ),
          ],
        );
      },
      barrierDismissible: false,
    );
  }

  void handleLogoutAction(BuildContext context) {
    AuthBlocCubit authBlocCubit = AuthBlocCubit();
    authBlocCubit.logout(context);
  }
}
