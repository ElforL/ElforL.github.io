/// Block in the project screen
///
/// Available blocks:
/// - [HeadProjectBlock]
/// - [FullWidthImageProjectBlock]
/// - [BannerProjectBlock]
/// - [ImageWithPaddingProjectBlock]
/// - [HeadlineProjectBlock]
/// - [ImageOverhangProjectBlock]
///
/// # Configuration:
/// A block is configured in JSON style. Each project's screen has a list/array of blocks.
///
/// Each block contains two attributes: `type` and `content`.
///
/// `type` is one the values of the enum [ProjectBlockType].
///
/// `content` changes based on the block type.
///
/// # Block types and thier content:
///
/// | type             | description                                                                                                                                                                 |
/// |:-----------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
/// | head             | The starting block. Contains the title description and details of the project.                                                                                              |
/// | fullWidthImage   | An image whose width takes the whole screen. height can be adjusted                                                                                                         |
/// | banner           | A headline and a text in a banner that has a different color.                                                                                                               |
/// | imageWithPadding | Just a centered image with padding around it. (preferred to be a long image)                                                                                                |
/// | headline         | Just a simple headline text.                                                                                                                                                |
/// | imageOverhang    | Similar to ProjectBlockType.banner but the text is at the start and next to it is an image that a part of it leaves the banner from the top. The image disappears on mobile |
///
/// A full JSON example:
/// ```json
/// [
/// 	{
/// 		"type": "head",
/// 		"content": {
/// 			"title": {
/// 				"en": "The First Project",
/// 				"ar": "المشروع الأول"
/// 			},
/// 			"small_description": {
/// 				"en": "Small catchy description",
/// 				"ar": "وصف قصير لافت"
/// 			},
/// 			"long_description": {
/// 				"en": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ligula nunc, eleifend ac placerat eget, ultricies id nibh. Etiam nec tellus nec metus eleifend aliquet sed vitae tellus. Ut quis quam lorem. In blandit, diam quis maximus fermentum, massa metus convallis diam, eu tempor odio magna dapibus enim. Sed commodo feugiat neque, elementum pretium enim rhoncus in. Duis semper sed eros id consectetur. Ut hendrerit maximus nisl, tempor auctor lacus mattis id. Quisque fermentum iaculis nulla. Donec et facilisis quam, quis volutpat nisi. Nulla id lacus varius, luctus ex iaculis, porttitor urna. Cras vestibulum pulvinar nisi, nec vulputate lectus accumsan.",
/// 				"ar": "خسائر اللازمة ومطالبة حدة بل. الآخر الحلفاء أن غزو، إجلاء وتنامت عدد مع. لقهر معركة لبلجيكا، بـ انه، ربع الأثنان المقيتة في، اقتصّت المحور حدة و. هذه ما طرفاً عالمية استسلام، الصين وتنامت حين 30, ونتج والحزب المذابح كل جوي. أسر كارثة المشتّتون بل، وبعض وبداية الصفحة غزو قد، أي بحث تعداد الجنوب.                    قصف المسرح واستمر الاتحاد في، ذات أسيا للغزو، الخطّة و، الآخر لألمانيا جهة بل. في سحقت هيروشيما البريطاني يتم، غريمه باحتلال الأيديولوجية، في فصل، دحر وقرى لهيمنة الإيطالية 30. استبدال استسلام القاذفات عل مما. ببعض مئات وبلجيكا، قد أما، قِبل الدنمارك حتى كل، العمليات اليابانية انه أن.                    حتى هاربر موسكو ثم، وتقهقر المنتصرة حدة عل، التي فهرست واشتدّت أن أسر. كانت المتاخمة التغييرات أم وفي. ان وانتهاءً باستحداث قهر. ان ضمنها للأراضي الأوروبية ذات.                    حشد الثقيل المنتصر ثم، أسر قررت تم. وغير تصفح الحزب واستمر، مشروط الساحلية هذا ان. أما معركة لبلجيكا، من، الألوف الثقيلة الإنجليزية أسر 30. 30 دار أمام أحدث، أما بحشد الهادي الدولارات ما، هو الحزب الصفحة محاولات قبل. وبحلول الخنادق الأوروبية، ان غير، وليرتفع برلين، انه، انتباه الوزراء البولندي تم تلك.                    كما أن وقام وبدأت، لم أدوات للمجهود بلا. إذ لها الأول الستار، تحت وصغار مدينة عل. أي بحشد ليرتفع الساحلية أما، ليركز الهادي للأسطول ما هذا، أسابيع الروسية وتم عن. وفي مع شدّت فكان أدوات. سمّي تعداد ونستون هذا ما. به، بـ الخاصّة هيروشيما، وربع جندي الشهير الساحل.                    يكن لعدم الثانية عل، جديداً الخاطفة منشوريا بها تم، إذ جهة الأمم الجنوب. أي أما الحربية المعارك، قد وعلى الحربي، الأولية جعل. بحث إعادة قُدُماً ان، بحث أطراف استولت شموليةً ما. الغزو قبضتهم للسيطرة عدد أم. دون أي بالقصف العالم، للأسطول.                    مدن ثم للسيطرة سنغافورة، أفاق الاعتداء أخر 30, لمّ أسيا غرّة، مع. هو ودول وجهان فقد، في الوراء وبالتحديد، غير. وألمّ وجهان به، ان ربع حصدت وحزبه، أم جعل بشكل سابق الكونجرس. وضم يقوم الأولية شموليةً أن، أي ربع طرفاً الأرضية.                    ذلك بالفشل ونستون ابتدعها قد. لها قد مساعدة الحلفاء، واشتدّت الهزائم إلى كل. تم البلطيق الحيلولة دار، عن به، تُصب البرية والحلفاء. مشارف واشتدّت شبح كل، بتخصيص بل مما. الحرة بقيادة تم وصل.                    لغزو احتار كل أسر، بـ هُزم النمسا الخاسر بعد، من مسرح ألمانيا البشريةً فعل. والجنوب ارتكبها وبالتحديد، فعل. الا مع قِبل أمدها جديداً. بوابة الضغوط أن ولم. قد لمّ مكثّفة دنكيرك. جهة وبعض شعار ان."
/// 			},
/// 			"deliverables": [
/// 				{
/// 					"en": "UI Design",
/// 					"ar": "تصميم واجهة المستخدم"
/// 				},
/// 				{
/// 					"en": "Software Engineering",
/// 					"ar": "هندسة البرمجيات"
/// 				},
/// 				{
/// 					"en": "Front-end Development",
/// 					"ar": "تطوير الواجهة الأمامية"
/// 				},
/// 				{
/// 					"en": "Back-end Development",
/// 					"ar": "تطوير الواجهة الخلفية/البنية التحتية"
/// 				}
/// 			],
/// 			"year": 2020,
/// 			"buttons": [
/// 				{
/// 					"en": "Visit Site",
/// 					"ar": "زر الموقع",
/// 					"url": "google.com"
/// 				},
/// 				{
/// 					"en": "View Code",
/// 					"ar": "اطلع على الكود",
/// 					"url": "google.com"
/// 				}
/// 			],
/// 			"store_badges": [
/// 				{
/// 					"type": "g_play",
/// 					"url": "google.com"
/// 				}
/// 			]
/// 		}
/// 	},
/// 	{
/// 		"type": "fullWidthImage",
/// 		"content": {
/// 			"url": "https://i.imgur.com/ea9PB3H.png",
/// 			"height": null
/// 		}
/// 	},
/// 	{
/// 		"type": "banner",
/// 		"content": {
/// 			"headline": {
/// 				"en": "Bold, fun, and full of character(s)",
/// 				"ar": "Bold, fun, and full of character(s)"
/// 			},
/// 			"text": {
/// 				"en": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ligula nunc, eleifend ac placerat eget, ultricies id nibh. Etiam nec tellus nec metus eleifend aliquet sed vitae tellus. Ut quis quam lorem. In blandit, diam quis maximus fermentum, massa metus convallis diam, eu tempor odio magna dapibus enim. Sed commodo feugiat neque, ",
/// 				"ar": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ligula nunc, eleifend ac placerat eget, ultricies id nibh. Etiam nec tellus nec metus eleifend aliquet sed vitae tellus. Ut quis quam lorem. In blandit, diam quis maximus fermentum, massa metus convallis diam, eu tempor odio magna dapibus enim. Sed commodo feugiat neque, "
/// 			}
/// 		}
/// 	},
/// 	{
/// 		"type": "imageWithPadding",
/// 		"content": {
/// 			"url": "https://i.imgur.com/3JF85oV.png"
/// 		}
/// 	},
/// 	{
/// 		"type": "headline",
/// 		"content": {
/// 			"en": "The Begening",
/// 			"ar": "البداية"
/// 		}
/// 	},
/// 	{
/// 		"type": "imageOverhang",
/// 		"content": {
/// 			"text": {
/// 				"headline": {
/// 					"en": "Jam packed full",
/// 					"ar": ""
/// 				},
/// 				"text": {
/// 					"en": "We tailored the mobile design and created a dynamic, distinctive and fun experience that helped communicate the brand’s unique sense of humour and product.",
/// 					"ar": ""
/// 				}
/// 			},
/// 			"image": {
/// 				"url": "https://toyfight.co/wp-content/uploads/2018/09/toggl-mobile.png",
/// 				"overhang_percentage": 8
/// 			}
/// 		}
/// 	}
/// ]
/// ```
abstract class ProjectBlock {
  final ProjectBlockType type;
  final Map<String, dynamic> content;

  ProjectBlock(this.type, this.content);

  factory ProjectBlock.fromJson(Map<String, dynamic> json) {
    final String typeString = json['type'];
    ProjectBlockType? type;

    type = getBlockType(typeString);

    if (type == null) throw ArgumentError('Invalid type: $typeString');

    switch (type) {
      case ProjectBlockType.head:
        return HeadProjectBlock(json['content']);

      case ProjectBlockType.fullWidthImage:
        return FullWidthImageProjectBlock(json['content']);

      case ProjectBlockType.banner:
        return BannerProjectBlock(json['content']);

      case ProjectBlockType.imageWithPadding:
        return ImageWithPaddingProjectBlock(json['content']);

      case ProjectBlockType.headline:
        return HeadlineProjectBlock(json['content']);

      case ProjectBlockType.imageOverhang:
        return ImageOverhangProjectBlock(json['content']);
    }
  }

  static ProjectBlockType? getBlockType(String typeString) {
    ProjectBlockType? output;
    for (var item in ProjectBlockType.values) {
      if (item.toShortString() == typeString) {
        output = item;
        break;
      }
    }
    return output;
  }
}

class HeadProjectBlock extends ProjectBlock {
  static const _titleMapKey = 'title';
  static const _smallDescriptionMapKey = 'small_description';
  static const _longDescriptionMapKey = 'long_description';
  static const _deliverablesMapKey = 'deliverables';
  static const _yearMapKey = 'year';
  static const _buttonsMapKey = 'buttons';
  static const _storeBadgesMapKey = 'store_badges';

  HeadProjectBlock(Map<String, dynamic> content) : super(ProjectBlockType.head, content);

  int get year => content[_yearMapKey];
  String title(String langCode) => getValueWithLocale(content[_titleMapKey], langCode);
  String smallDescribtion(String langCode) => getValueWithLocale(content[_smallDescriptionMapKey], langCode);
  String longDescribtion(String langCode) => getValueWithLocale(content[_longDescriptionMapKey], langCode);

  List<String> deliverables(String langCode) {
    List<String> output = [];
    final list = content[_deliverablesMapKey];

    for (var item in list) {
      try {
        output.add(getValueWithLocale(item, langCode));
      } catch (e) {
        try {
          output.add((item as Map).values.first);
        } catch (e) {
          continue;
        }
      }
    }

    return output;
  }

  /// Returns a list of button maps.
  /// each map contains to values 'text' and 'url'
  ///
  /// Button map example:
  ///
  /// {
  ///   'text': 'Visit Site',
  ///   'url': 'google.com',
  /// }
  ///
  List<Map<String, String>> buttons(String langCode) {
    List<Map<String, String>> output = [];
    final btnsList = content[_buttonsMapKey];

    for (var button in btnsList) {
      try {
        output.add({
          'text': getValueWithLocale(button, langCode),
          'url': button['url'],
        });
      } catch (e) {
        continue;
      }
    }

    return output;
  }

  List<Map<String, String>> get storeBadges {
    final badgesList = List.from(content[_storeBadgesMapKey]);

    final output = List<Map<String, String>>.generate(
      badgesList.length,
      (index) => Map<String, String>.from(
        badgesList.elementAt(index),
      ),
    );

    return output;
  }
}

class FullWidthImageProjectBlock extends ProjectBlock {
  FullWidthImageProjectBlock(Map<String, dynamic> content) : super(ProjectBlockType.fullWidthImage, content);

  String get url => content['url'];
  double? get height => content['height'];
}

class BannerProjectBlock extends ProjectBlock {
  BannerProjectBlock(Map<String, dynamic> content) : super(ProjectBlockType.banner, content);

  String headline(String langCode) => getValueWithLocale(content['headline'], langCode);
  String text(String langCode) => getValueWithLocale(content['text'], langCode);
}

class ImageWithPaddingProjectBlock extends ProjectBlock {
  ImageWithPaddingProjectBlock(Map<String, dynamic> content) : super(ProjectBlockType.imageWithPadding, content);

  String get url => content['url'];
}

class HeadlineProjectBlock extends ProjectBlock {
  HeadlineProjectBlock(Map<String, dynamic> content) : super(ProjectBlockType.headline, content);

  String text(String langCode) => getValueWithLocale(content, langCode);
}

class ImageOverhangProjectBlock extends ProjectBlock {
  ImageOverhangProjectBlock(Map<String, dynamic> content) : super(ProjectBlockType.imageOverhang, content);

  String headline(String langCode) => getValueWithLocale(content['text']['headline'], langCode);
  String text(String langCode) => getValueWithLocale(content['text']['text'], langCode);

  String get imageUrl => content['image']['url'];
  double get imageOverhandPercentage => content['image']['overhang_percentage'];
}

enum ProjectBlockType {
  /// The starting block
  head,

  /// An image whose width takes the whole screen.
  ///
  /// height can be adjusted
  fullWidthImage,

  banner,
  imageWithPadding,

  /// just a simple headline
  headline,

  /// Similar to ProjectBlockType.banner but the text is at the start and next to it is an image that a part of it leaves the banner from the top
  ///
  /// The image disappears on mobile
  imageOverhang,
}

extension EnumToShortString on Enum {
  /// Returns the string of the **value**.
  ///
  /// For example,
  /// dart
  /// var enum1 = MyEnum.val1;
  /// print(enum1.toString()); /// 'MyEnum.val1'
  /// print(enum1.toShortString()); /// 'val1'
  ///
  String toShortString() {
    return toString().split('.').last;
  }
}

getValueWithLocale(dynamic container, String langCode, [String? defaultLangCode = 'en']) {
  return container[langCode] ?? container[defaultLangCode];
}
