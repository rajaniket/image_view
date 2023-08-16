import 'package:cached_network_image/cached_network_image.dart';
import 'package:curie/view_model/bloc/image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ImageBloc imageBloc;
  @override
  void initState() {
    imageBloc = BlocProvider.of<ImageBloc>(context);
    imageBloc.add(OnFetchDefaultData(query: "nature"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      hintText: 'Search Images here',
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      imageBloc.add(OnImageSearch(value, 1, 20));
                    },
                  ),
                )),
            const Divider(
              height: 0,
              thickness: 2,
            ),
            Expanded(
              child: BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) {
                  if (state is ImageIntial) {
                    return const Center(child: Text("Search Something"));
                  } else if (state is ImageError) {
                    return const Center(child: Text("Something went wrong"));
                  } else if (state is ImageLoading) {
                    return const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: state.imagesData!.photos!.length,
                      itemBuilder: (BuildContext context, int index) {
                        String imageUrl = state.imagesData!.photos![index].src!.small!;
                        return Card(
                          // color: Colors.amber,
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
