abstract final class AppConstants {
  static const String brandName = 'Mysterious Coder';
  static const String packageName = "com.mysteriouscoder.budgetflow";


  //All apps titles:
  static const String brainBooster = 'Brain Booster: Sound Therapy';
  static const String classicWingedBird = 'Classic Winged Bird';
  static const String hindiShayariHub = 'Hindi Shayari Hub';
  static const String mazedarHindiJokes = 'Mazedar Hindi Jokes';
  static const String noteMaster = 'Note Master: Offline Organizer';
  static const String budgetFlow = 'BudgetFlow: Expense & Budget';

  /// Android or iOS
  static const String androidAppId = "com.mysteriouscoder.budgetflow";
  static const String iosAppId = "com.mysteriouscoder.budgetflow";

  static String playStoreUrlMaker({String appId = packageName}) =>
      'https://play.google.com/store/apps/details?id=$appId';

  //App apps descriptions:
  static const String brainBoosterDescription =
      "Brain Booster: Sound Therapy is an audio app with binaural beats, soothing music, and guided meditation sessions to improve focus, clarity, and relaxation. Ideal for meditation, studying, or stress relief, it offers customizable playlists and a helpful FAQ section. 🎶🧘‍♂️✨";
  static const String classicWingedBirdDescription =
      "Classic Winged Bird is a fun and addictive game featuring classic Flappy Bird gameplay. Navigate through obstacles while unlocking various bird characters and dynamic backgrounds. Enjoy easy tap controls and a high-score challenge.";
  static const String hindiShayariHubDescription =
      "Explore the best Hindi Shayari with Hindi Shayari Hub! Discover Shayari for love, friendship, sadness, and more. Easily share your favorite Shayari with friends. Enjoy a simple design and growing categories.";
  static const String mazedarHindiJokesDescription =
      "Mazedar Hindi Jokes is a fun app packed with hilarious Hindi jokes to brighten your day. From witty one-liners to laugh-out-loud stories, enjoy endless entertainment. Easily share jokes with friends and family.";
  static const String noteMasterDescription =
      "NoteMaster: Offline Organizer is your go-to app for organizing notes, tasks, and ideas without needing an internet connection. Perfect for managing to-do lists, reminders, and important thoughts. Stay organized anytime, anywhere.";
  static const String budgetFlowDescription =
      "BudgetFlow is a simple and powerful app to track your expenses and manage your budget effortlessly. Stay organized, view your financial trends, and keep control of your money with an easy-to-use interface.";

  //All apps urls:
  static const String brainBoosterUrl =
      'https://play.google.com/store/apps/details?id=com.mysteriouscoder.brainbooster';
  static const String classicWingedBirdUrl =
      'https://play.google.com/store/apps/details?id=com.mysteriouscoder.classicwingedbird';
  static const String hindiShayariHubUrl =
      'https://play.google.com/store/apps/details?id=com.mysteriouscoder.hindishayarihub';
  static const String mazedarHindiJokesUrl =
      'https://play.google.com/store/apps/details?id=com.mysteriouscoder.mazedarhindijokes';
  static const String noteMasterUrl =
      'https://play.google.com/store/apps/details?id=com.mysteriouscoder.notemaster';
  static const String budgetFlowUrl =
      'https://play.google.com/store/apps/details?id=com.mysteriouscoder.budgetflow';

  //Google Forms Feedback URL
  static const String googleFeedbackFormUrl =
      "https://docs.google.com/forms/d/e/1FAIpQLSeEc7kuPDXezxgyOMAllpT8StrCcPAE0NT5yW5fJ0kGPjsb1w/viewform?usp=header";

  //Social Media Links
  static const String youtubeLink =
      "https://youtube.com/@mysterious_coder?si=nmKdCfauVOj0LApZ";
  static const String instagramLink =
      "https://www.instagram.com/mysteriouscoder__?igsh=MTI5eGpxanE5ZGd5Mg==";
  static const String facebookLink =
      "https://www.facebook.com/share/1C6RSPZgnq/";
  static const String whatsAppChannelLink =
      "https://whatsapp.com/channel/0029Vb1Se9gKrWR1TBGlCs1x";

  static const String budgetFlowPrivacyPolicy="https://mysteriouscoder.com/privacypolicy/budgetflow";

  static const List<Map<String, dynamic>> mCat = [
    {
      "catId": 0,
      "catName": "Bills",
      'catImage': "assets/icons/category/bills.png"
    },
    {
      "catId": 1,
      "catName": "Food",
      'catImage': "assets/icons/category/food.png"
    },
    {
      "catId": 2,
      "catName": "Grocery",
      'catImage': "assets/icons/category/grocery.png"
    },
    {
      "catId": 3,
      "catName": "Luxury Items",
      'catImage': "assets/icons/category/luxury_items.png"
    },
    {
      "catId": 4,
      "catName": "Medical",
      'catImage': "assets/icons/category/medical.png"
    },
    {
      "catId": 5,
      "catName": "Shopping",
      'catImage': "assets/icons/category/shopping.png"
    },
    {
      "catId": 6,
      "catName": "Makeup",
      'catImage': "assets/icons/category/makeup.png"
    },
    {
      "catId": 7,
      "catName": "Entertainment",
      'catImage': "assets/icons/category/entertainment.png"
    },
    {
      "catId": 8,
      "catName": "Petrol",
      'catImage': "assets/icons/category/petrol.png"
    },
    {
      "catId": 9,
      "catName": "Recharge",
      'catImage': "assets/icons/category/recharge.png"
    },
    {
      "catId": 10,
      "catName": "Servicing",
      'catImage': "assets/icons/category/servicing.png"
    },
    {
      "catId": 11,
      "catName": "Subscriptions",
      'catImage': "assets/icons/category/subscriptions.png"
    },
    {
      "catId": 12,
      "catName": "Travelling",
      'catImage': "assets/icons/category/travelling.png"
    },
    {
      "catId": 13,
      "catName": "Health",
      'catImage': "assets/icons/category/health.png"
    },
    {
      "catId": 14,
      "catName": "Salary/Bonus",
      'catImage': "assets/icons/category/salary_bonus.png"
    },
    {
      "catId": 15,
      "catName": "Others",
      'catImage': "assets/icons/category/others.png"
    },
  ];
}
