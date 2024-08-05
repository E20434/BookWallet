import 'package:book_wallert/controllers/book_recommended_controller.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final BookRecommendController bookRecommendController =
        BookRecommendController(globalUser!.userId);
    // void recommendBook(book) async {
    //   try {
    //     await bookRecommendController.fetchBookId(book);
    //     await bookRecommendController.postRecommendation(
    //         globalUser!.userId, bookRecommendController.bookId!);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //           content: Text('Book recommended to followers successfully.')),
    //     );
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Error recommending book: $e')),
    //     );
    //   }
    // }

    return GestureDetector(
      onTap: () {
        // Navigate to BookProfileScreenBody when the card is tapped
        screenChange(context, BookProfileScreenBody(book: book));
      },
      child: Card(
        color: MyColors.panelColor, // Card background color
        child: ListTile(
            iconColor: MyColors.nonSelectedItemColor,
            leading: SizedBox(
              width: 80,
              child: Image.network(
                  book.imageUrl, // Use imageUrl from the book object
                  scale: 1, errorBuilder: (context, error, stackTrace) {
                return const Icon(
                    Icons.error); // Display error icon if image fails to load
              }),
            ),
            title: Text(
              book.title, // Use title from the book object
              style: const TextStyle(
                color: MyColors.textColor, // Text color
              ),
            ),
            subtitle: Text(
              '${book.author}\nPages: ${(book.pages == 0) ? '-' : book.pages}\nGenre: ${book.genre}\nTotal Rating: ${book.totalRating}/10',
              style: const TextStyle(
                color: MyColors.text2Color, // Text color
              ),
            ),
            trailing: CustomPopupMenuButtons(items: const [
              'Recommond book to followers',
              'Add to wishlist',
            ], onItemTap: [
              () async {
                try {
                  await bookRecommendController.fetchBookId(book);
                  await bookRecommendController.postRecommendation(
                      globalUser!.userId, bookRecommendController.bookId!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Book recommended to followers successfully.')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error recommending book: $e')),
                  );
                }
              },
              () {}, // Praveen meka witharak wenas karapn buuruwaaa
            ], icon: const Icon(Icons.more_vert_rounded))),
      ),
    );
  }
}
