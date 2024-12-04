import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_blogs/core/usecase/usecase.dart';
import 'package:flutter_blogs/feature/blog/domain/entities/blog.dart';
import 'package:flutter_blogs/feature/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_blogs/feature/blog/domain/usecases/upload_blog.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  // Handler for BlogUpload
  Future<void> _onBlogUpload(BlogUpload event,
      Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    result.fold(
      (failure) => emit(BlogFailure(error: failure.message)),
      (_) => emit(BlogUploadSuccess()),
    );
  }

  FutureOr<void> _onFetchAllBlogs(
      BlogFetchAllBlogs event,
      Emitter<BlogState> emit) async{

    final res = await _getAllBlogs(NoParams());

    res.fold((l) => emit(BlogFailure(error: l.message)),
            (r) => BlogDisplaySuccess(blogs: r));
    
  }
}
