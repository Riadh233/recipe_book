import 'package:equatable/equatable.dart';

enum BookmarkStatus { success, failed, initial }

class BookmarkState extends Equatable {
  final bool isBookmarked;
  final BookmarkStatus status;

  const BookmarkState(
      {this.isBookmarked = false, this.status = BookmarkStatus.initial});

  BookmarkState copyWith({bool? isBookmarked, BookmarkStatus? status}) {
    return BookmarkState(
        isBookmarked: isBookmarked ?? this.isBookmarked,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [isBookmarked, status];
}
