import 'dart:math';

class ReviewData {
  final String reviewersName;
  final double reviewersRating;
  final String reviewersReviews;

  ReviewData(this.reviewersName, this.reviewersRating, this.reviewersReviews);

  // Method to generate random review data
  static ReviewData generateRandomReview() {
    final random = Random();
    const List<String> names = [
      'Aiden Foster', 'Liam Harper', 'Emma Lewis', 'Olivia Carter', 'Noah Adams',
      'Sophia Mitchell', 'Jackson Clark', 'Ava Thompson', 'Ethan Rodriguez', 'Isabella White',
      'Mason Davis', 'Mia Brown', 'Lucas Johnson', 'Charlotte King', 'Logan Walker',
      'Amelia Scott', 'James Harris', 'Ella Nelson', 'Benjamin Young', 'Grace King',
    ];
    const List<double> ratings = [
      4.0, 5.0, 3.0, 4.5, 2.5, 5.0, 4.0, 3.5, 4.5, 4.0,
      2.0, 5.0, 3.0, 4.0, 4.5, 3.5, 5.0, 4.0, 2.5, 4.0,
    ];
    const List<String> reviews = [
      'The product is great and meets expectations.',
      'Excellent quality, will definitely buy again!',
      'It’s okay, but I expected better.',
      'Absolutely fantastic! Exceeded my expectations.',
      'Not what I was hoping for. Could be improved.',
      'Great value for the price. Highly recommend!',
      'Good product, but delivery was delayed.',
      'Satisfied with the purchase. Would buy again.',
      'The product is fine, but the customer service was lacking.',
      'Loved it! Exactly as described and works well.',
      'Average product. Nothing special about it.',
      'Outstanding! Great product and fast delivery.',
      'I am very happy with this purchase. Highly recommended.',
      'Decent product but overpriced.',
      'I was not impressed with the quality.',
      'Excellent product. Would buy again without hesitation.',
      'It’s okay, does the job but expected better quality.',
      'Very satisfied with my purchase. Great quality!',
      'Good product but arrived a bit late.',
      'Fantastic! Exceeded all my expectations.',
    ];

    final name = names[random.nextInt(names.length)];
    final rating = ratings[random.nextInt(ratings.length)];
    final review = reviews[random.nextInt(reviews.length)];
    return ReviewData(name, rating, review);
  }
}
