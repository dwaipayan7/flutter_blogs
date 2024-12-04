import 'dart:io';
import 'package:flutter_blogs/core/error/exceptions.dart';
import 'package:flutter_blogs/core/error/failure.dart';
import 'package:flutter_blogs/feature/blog/data/datasources/blog_remote_data_sources.dart';
import 'package:flutter_blogs/feature/blog/data/models/blog_models.dart';
import 'package:flutter_blogs/feature/blog/domain/entities/blog.dart';
import 'package:uuid/uuid.dart';
import '../../domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class BlogRepositoryImpl implements BlogRepository {

  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async{

    try{
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updatedAt: DateTime.now()
      );
      
     final imageUrl =
     blogRemoteDataSource.uploadBlogImage(
         image: image,
         blog: blogModel
     );

     blogModel = blogModel.copyWith(
       imageUrl: imageUrl.toString(),
     );
     
    final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
    return Either.right(uploadedBlog);

    } on ServerException catch(e){
      return Either.left(Failure(e.message));
    }
    
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async{
    try{

      final blogs = await blogRemoteDataSource.getAllBlogs();

      return Either.right(blogs);

    }on ServerException catch(e){
      return Either.left(Failure(e.message));
    }
  }
}
