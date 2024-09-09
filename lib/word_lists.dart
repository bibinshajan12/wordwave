// word_lists.dart

Map<String, List<String>> wordLists = {
  'Animals': ['cat', 'dog', 'elephant', 'tiger', 'lion'],
  'Fruits': ['apple', 'banana', 'grape', 'orange', 'pineapple'],
  'Countries': ['india', 'canada', 'germany', 'brazil', 'france'],
  'Technology': ['flutter', 'dart', 'widget', 'mobile', 'programming'],
};

List<String> getWordsForCategory(String category) {
  return wordLists[category] ?? [];
}
