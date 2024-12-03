import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_blogs/feature/blog/domain/usecases/upload_blog.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {

    on<BlogUpload>(_onBlogUpload);

  }

  // Handler for BlogUpload
  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await uploadBlog(
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
          (_) => emit(BlogSuccess()),
    );
  }
}