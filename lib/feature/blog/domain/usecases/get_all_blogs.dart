import 'package:flutter_blogs/core/error/failure.dart';
import 'package:flutter_blogs/core/usecase/usecase.dart';
import 'package:flutter_blogs/feature/blog/domain/entities/blog.dart';
import 'package:flutter_blogs/feature/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';


class GetAllBlogs implements UseCase<List<Blog>, NoParams>{

  final BlogRepository blogRepository;
  GetAllBlogs({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async{

    return await blogRepository.getAllBlogs();

  }

}