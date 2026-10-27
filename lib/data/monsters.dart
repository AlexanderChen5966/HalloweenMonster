class Monster {
  const Monster({
    required this.id,
    required this.name,
    required this.english,
    required this.origin,
    required this.tagline,
    required this.description,
    required this.traits,
    required this.weakness,
    required this.scare,
    required this.imageCredit,
  });

  final String id;
  final String name;
  final String english;
  final String origin;
  final String tagline;
  final String description;
  final List<String> traits;
  final String weakness;
  final int scare; // 1-5
  final String imageCredit;

  String get image => 'assets/images/$id.jpg';
}

const monsters = <Monster>[
  Monster(
    id: 'vampire',
    name: '吸血鬼',
    english: 'Vampire',
    origin: '東歐民間傳說',
    tagline: '夜晚的貴族，以鮮血為食',
    description:
        '吸血鬼是東歐傳說中靠吸食人血維生的不死生物。1897 年布蘭·史托克的小說《德古拉》讓他成為優雅又危險的黑夜貴族，也是最受歡迎的萬聖節造型之一。',
    traits: ['長生不死', '怕陽光', '能變成蝙蝠', '鏡中無影'],
    weakness: '陽光、大蒜、木樁、十字架',
    scare: 4,
    imageCredit: 'Max Schreck 飾演 Count Orlok，《Nosferatu》(1922)',
  ),
  Monster(
    id: 'werewolf',
    name: '狼人',
    english: 'Werewolf',
    origin: '歐洲中世紀傳說',
    tagline: '滿月之夜，人性消失',
    description:
        '狼人白天是普通人，滿月時會變身為凶猛的狼。這幅 1512 年的木刻版畫出自盧卡斯·克拉納赫之手，描繪了中世紀人們心中最恐怖的狼人形象。',
    traits: ['月圓變身', '力大無窮', '嗅覺敏銳', '失去理智'],
    weakness: '銀製武器、烏頭草',
    scare: 5,
    imageCredit: '盧卡斯·克拉納赫《狼人》木刻版畫 (1512)',
  ),
  Monster(
    id: 'frankenstein',
    name: '科學怪人',
    english: "Frankenstein's Monster",
    origin: '瑪麗·雪萊 1818 年小說',
    tagline: '由人類創造的孤獨生命',
    description:
        '科學家弗蘭肯斯坦用屍塊拼湊並賦予生命的生物。其實「Frankenstein」是創造者的姓氏，而不是怪物的名字。他外表可怕，內心卻渴望被接納。',
    traits: ['縫合軀體', '怪力', '怕火', '孤獨善感'],
    weakness: '火焰、電力耗盡',
    scare: 3,
    imageCredit: 'Frankenstein 1831 年修訂版插圖',
  ),
  Monster(
    id: 'witch',
    name: '女巫',
    english: 'Witch',
    origin: '歐洲民間傳說',
    tagline: '騎著掃帚，煮著大鍋湯',
    description:
        '女巫會調製魔藥、施展咒語，常與黑貓和掃帚為伴。萬聖節的尖帽、長袍和大鍋，就是從她們的形象延伸而來。',
    traits: ['魔藥', '飛行掃帚', '黑貓使魔', '咒語'],
    weakness: '流水、鐵器、鹽',
    scare: 3,
    imageCredit: '童謠插畫 Witch winks',
  ),
  Monster(
    id: 'jack',
    name: '南瓜燈傑克',
    english: "Jack-o'-lantern",
    origin: '愛爾蘭傳說《吝嗇的傑克》',
    tagline: '提著鬼火的流浪靈魂',
    description:
        '傳說吝嗇的傑克騙過惡魔，死後天堂不收、地獄不要，只能提著一塊炭火四處流浪。愛爾蘭人最初用蕪菁雕刻燈籠，移民美國後換成了南瓜。',
    traits: ['雕刻笑臉', '燭光閃爍', '驅趕惡靈', '萬聖節象徵'],
    weakness: '被風吹熄的燭火',
    scare: 2,
    imageCredit: 'Book of Halloween 插畫',
  ),
  Monster(
    id: 'skeleton',
    name: '骷髏',
    english: 'Skeleton',
    origin: '中世紀「死亡之舞」',
    tagline: '跳著舞的亡者樂團',
    description:
        '「死亡之舞（Danse Macabre）」是中世紀的藝術主題：骷髏拉著各階層的人一起跳舞，提醒大家人人終將一死。如今骷髏已成萬聖節最常見的裝飾。',
    traits: ['喀啦作響', '愛跳舞', '樂器演奏', '不怕痛'],
    weakness: '被拆散的骨頭',
    scare: 2,
    imageCredit: 'Guyot Marchand《死亡之舞》骷髏樂手',
  ),
  Monster(
    id: 'mummy',
    name: '木乃伊',
    english: 'Mummy',
    origin: '古埃及',
    tagline: '被繃帶包裹的千年法老',
    description:
        '古埃及人以防腐技術保存遺體，希望死者在來世重生。電影讓木乃伊成為被詛咒復活、全身繃帶的怪物。',
    traits: ['滿身繃帶', '法老詛咒', '動作緩慢', '沙塵暴召喚'],
    weakness: '火焰、解咒儀式',
    scare: 3,
    imageCredit: 'Ginger (mummy)，大英博物館藏',
  ),
  Monster(
    id: 'death',
    name: '死神',
    english: 'Grim Reaper',
    origin: '歐洲中世紀',
    tagline: '手持鐮刀的終極使者',
    description:
        '死神負責帶領靈魂前往彼岸。古斯塔夫·多雷的《蒼白馬上的死神》描繪了《啟示錄》中騎著蒼白馬、帶來終結的第四騎士。',
    traits: ['黑色斗篷', '巨大鐮刀', '沙漏', '無聲出現'],
    weakness: '無（只能和他下棋拖延）',
    scare: 5,
    imageCredit: '古斯塔夫·多雷《蒼白馬上的死神》',
  ),
];
