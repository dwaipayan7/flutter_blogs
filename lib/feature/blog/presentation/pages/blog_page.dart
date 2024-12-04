import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blogs/core/common/widgets/loader.dart';
import 'package:flutter_blogs/core/utils/show_snackbar.dart';
import 'package:flutter_blogs/feature/blog/presentation/pages/add_new_blog_page.dart';

import '../bloc/blog_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: Icon(CupertinoIcons.add_circled)
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if(state is BlogFailure){
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {

          if(state is BlogLoading){
            return const Loader();
          }

          if(state is BlogDisplaySuccess){
            return ListView.builder(
              itemCount: state.blogs.length,
                itemBuilder: (context, index){
                final blog = state.blogs[index];
                return Text(blog.title);
                }
            );
          }

       return SizedBox.fromSize();
        },
      ),
    );
  }
}
