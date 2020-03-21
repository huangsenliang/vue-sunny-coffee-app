SET NAMES UTF8;  # 设置格式
DROP DATABASE IF EXISTS luckin_coffee;  # 如果存在则删除
CREATE DATABASE luckin_coffee CHARSET=UTF8;
USE luckin_coffee;

/** 首页轮播广告商品 **/
CREATE TABLE luckin_coffee_bannar(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  imgUrl VARCHAR(128)
);                                                          

INSERT INTO luckin_coffee_bannar VALUES 
(NULL,"images/bannar/bannar1.png"),
(NULL,"images/bannar/bannar2.png"),
(NULL,"images/bannar/bannar3.png"),
(NULL,"images/bannar/bannar4.png");

/** title :  title:"现在下单" imgUrl:""   tip:"冲2送1" **/ 
CREATE TABLE luckin_coffee_title(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  imgUrl VARCHAR(128),
  title VARCHAR(128),
  tip VARCHAR(32),
  linkUrl VARCHAR(128)
);  

INSERT INTO luckin_coffee_title VALUES
(NULL,"images/img1/kfqb.png","咖啡钱包","","Personal"),
(NULL,"images/img1/kfqb.png","送TA咖啡","","Menu"),
(NULL,"images/img1/yhlm.png","优惠联盟","充2赠1","Index"),
(NULL,"images/img1/rhs.png","瑞划算","充2赠1","Menu"),
(NULL,"images/img1/rxcp.png","瑞幸潮品","NEW","Product"),
(NULL,"images/img1/xzxd.png","","NEW","Product");

/**  为你推荐： title2: url:"" name:"拿铁" English_name:"Latte"  price:13.2  **/
CREATE TABLE luckin_coffee_title2(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  imgUrl VARCHAR(128),
  uname VARCHAR(128),
  English_name VARCHAR(64),
  price DECIMAL(10,2),
  old_price DECIMAL(10,2)
);

INSERT INTO luckin_coffee_title2 VALUES 
(NULL,"images/img2/1.png","香草拿铁","Vanilla Latte",16.00,27.00),
(NULL,"images/img2/2.png","冲绳黑糖拿铁","Brown Sugar Latte",18.00,29.00),
(NULL,"images/img2/3.png","芥末腰果","Wasabi Cashew Nuts",14.00,18.00);


/** 新鲜事：轮播图 **/
CREATE TABLE luckin_coffee_bannar2(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  imgUrl VARCHAR(128)
);                                                          

INSERT INTO luckin_coffee_bannar2 VALUES 
(NULL,"images/bannar2/1.png"),
(NULL,"images/bannar2/2.png"),
(NULL,"images/bannar2/3.png"),
(NULL,"images/bannar2/4.png");

/** 瑞幸潮品 **/
--  url:""  content:"小蓝经典保温杯(2020款)"  selling(售卖):600
CREATE TABLE luckin_coffee_title3(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  imgUrl VARCHAR(128),
  content VARCHAR(64),
  selling INT,                 # selling后期可以改动业务逻辑
  price DECIMAL(10,2)
);

INSERT INTO luckin_coffee_title3 VALUES 
(NULL,"images/luckin_coffee_title3/1.png","幸运随行杯（瑞幸蓝）",600,69),
(NULL,"images/luckin_coffee_title3/2.png","幸运随行杯（浅粉色）",2500,69),
(NULL,"images/luckin_coffee_title3/3.png","幸运随行杯（汤唯签名款小白杯）",600,258),
(NULL,"images/luckin_coffee_title3/4.png","联名陶瓷内壁咖啡（蓝）",500,258),
(NULL,"images/luckin_coffee_title3/5.png","榴莲腰果",4700,12.5),
(NULL,"images/luckin_coffee_title3/6.png","芥末腰果",4400,9.9),
(NULL,"images/luckin_coffee_title3/7.png","小蓝经典保温杯（2020款）",800,108),
(NULL,"images/luckin_coffee_title3/8.png","猫王收音机",500,399),
(NULL,"images/luckin_coffee_title3/9.png","LAMY狩猎系列宝珠笔",1000,260),
(NULL,"images/luckin_coffee_title3/10.png","幸运随行杯（瑞幸蓝）",600,69);


/** 商品系列家族 **/
CREATE TABLE luckin_laptop_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,    # 商品系列的id
  fname VARCHAR(32)                      # 商品系列的名字
);

INSERT INTO luckin_laptop_family VALUES
  (NULL,'人气TOP'),
  (NULL,'大师咖啡'),
  (NULL,'瑞纳冰'),
  (NULL,'经典饮品'),
  (NULL,'瑞幸坚果'),
  (NULL,'瑞幸潮品'),
  (NULL,'鲜榨果蔬汁'),
  (NULL,'小鹿茶精选'),
  /** 潮品 **/
  (NULL,'本周新品'),
  (NULL,'经典保温'),
  (NULL,'luckinCup'),
  (NULL,'luckinCoffeeSTTOKE'),
  (NULL,'冯唐系列'),
  (NULL,'探月50周年'),
  (NULL,'luckin礼品卡'),
  (NULL,'luckinPopFriend'),
  (NULL,'luckinCup小鹿茶'),
  (NULL,'坚果礼盒'),
  (NULL,'luckNuts瑞幸坚果'),
  (NULL,'luck幸运小食'),
  (NULL,'健康轻食');

/** 商品数据 **/
CREATE TABLE luckin_laptop(
  lid INT PRIMARY KEY AUTO_INCREMENT,
  family_id INT,              #所属型号家族编号
  sold_count INT,             #已售出的数量
  lname VARCHAR(32),          #商品名称
  details VARCHAR(1024),      #商品详细说明
  e_name VARCHAR(32),         #英文名字
  price DECIMAL(10,2),        #价格
  old_price DECIMAL(10,2),    #旧价格
  da_ka_shuo VARCHAR(1024),   #标题简介
  heat VARCHAR(32),           #温度
  sugar VARCHAR(32),          #糖度
  cream VARCHAR(32),          #奶油
  tea VARCHAR(32),            #茶底 
  material VARCHAR(1024),     #原料
  storage VARCHAR(64),        #存储条件
  size VARCHAR(64),           #含量  
  imgUrl VARCHAR(64),         #图片路径
  imgUrlDetails VARCHAR(64),  #详情图片路径
  videUrl VARCHAR(64)         #视频路径
);

INSERT INTO luckin_laptop VALUES
  # 瑞幸坚果系列6个 
  (NULL,5,300,"每日坚果","原产地精选优良坚果，蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干6种搭配。原味烘焙，自然清香，每天悄悄来一包。","Daily Nuts 25g",4.55,6.9,"","","","","","蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干、白砂糖、葵花籽油","请置于阴凉干燥处存放。","25kg","goods/images/20200219000033_mrjg.png","","goods/images/vide.mp4"),
  (NULL,5,400,"榴莲捉妖记","榴莲馥郁香气包裹腰果的脆香，浓郁的松脆香甜缠绕舌尖，满足榴莲控的味蕾。","Duriann Cashew Nuts 15g",7.92,12,"","","","","","冻干榴莲果肉，腰果仁。","请置于阴凉干燥处存放。","15kg","goods/images/20200218235440_llyg.png","",""),
  (NULL,5,500,"榴莲腰果","原产地精选优良坚果，蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干6种搭配。原味烘焙，自然清香，每天悄悄来一包。","Daily Nuts 25g",4.55,6.9,"","","","","","蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干、白砂糖、葵花籽油","请置于阴凉干燥处存放。","25kg","goods/images/20200218235440_llyg.png","goods/images/20200218235014_llyg.png","goods/images/vide.mp4"),
  (NULL,5,500,"蜂蜜腰果","原产地精选优良坚果，蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干6种搭配。原味烘焙，自然清香，每天悄悄来一包。","Daily Nuts 25g",4.55,6.9,"","","","","","蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干、白砂糖、葵花籽油","请置于阴凉干燥处存放。","25kg","goods/images/20200218235440_llyg.png","goods/images/20200218235014_llyg.png","goods/images/vide.mp4"),
  (NULL,5,600,"海苔腰果","原产地精选优良坚果，蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干6种搭配。原味烘焙，自然清香，每天悄悄来一包。","Daily Nuts 25g",4.55,6.9,"","","","","","蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干、白砂糖、葵花籽油","请置于阴凉干燥处存放。","25kg","goods/images/20200219000033_mrjg.png","",""),
  (NULL,5,200,"芥末腰果","原产地精选优良坚果，蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干6种搭配。原味烘焙，自然清香，每天悄悄来一包。","Daily Nuts 25g",4.55,6.9,"","","","","","蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干、白砂糖、葵花籽油","请置于阴凉干燥处存放。","25kg","goods/images/20200218235440_llyg.png","",""),
   # 瑞幸潮品系列10个 
  (NULL,6,600,"小白经典保温杯（2020款）","","STTOKE Ceramic",86,0,"","","","","","","","25kg","goods/images/20200219003802xb.png","","goods/images/vide.mp4"),
  (NULL,6,600,"幸运随行杯（瑞幸蓝）","","luckin Reusable Everyday",120,0,"","","","","","","","25kg","goods/images/20200219003702_syj.png","",""),
  (NULL,6,600,"小蓝经典保温杯（2020款）","","Classic Insulation Ceramic Cup （classic Blue）",69,0,"","","","","","","","25kg","goods/images/20200219003050xy.png","",""),
  (NULL,6,600,"小蓝经典保温杯（2020款）","","STTOKE Ceramic",69,0,"","","","","","","","25kg","goods/images/20200219003050xy.png","",""),
  (NULL,6,600,"汤唯签名款小白杯","","Classic Insulation Ceramic Cup （classic Blue）",69,0,"","","","","","","","25kg","goods/images/20200219003702_syj.png","",""),
  (NULL,6,600,"小白经典保温杯（2020款）","","STTOKE Ceramic",69,0,"","","","","","","","25kg","goods/images/20200219003802xb.png","",""),
  (NULL,6,600,"小蓝经典保温杯（2020款）","","luckin Reusable Everyday",69,0,"","","","","","","","25kg","goods/images/20200219003050xy.png","",""),
  (NULL,6,600,"汤唯签名款小白杯","","Classic Insulation Ceramic Cup （classic Blue）",69,null,"","","","","","","","25kg","goods/images/20200219003802xb.png","",""),
  (NULL,6,600,"猫王收音机","","luckin Reusable Everyday",69,0,"","","","","","","","25kg","goods/images/20200219003702_syj.png","",""),
  (NULL,6,600,"小蓝经典保温杯（2020款）","","Classic Insulation Ceramic Cup （classic Blue）",69,null,"","","","","","","","25kg","goods/images/20200219003050xy.png","",""),
  # 瑞纳冰4个
  (NULL,3,300,"乐岛桃桃冰","【网易云音乐主题推荐款】蜜桃和玫瑰的灵感碰撞，清甜桃桃香气隐藏在玫瑰花香下，加上绵密细腻的沙冰topping，桃香、花香和清甜奶油，仿佛音符在你的舌尖上开party！","Peach & Rose Exfreezo",28,0,"","","","奶油","","桃汁饮料浓浆，玫瑰风味糖浆，冰块","","","goods/images/20200219215816_ttb.png","","goods/images/vide.mp4"),
  (NULL,3,200,"巧克力瑞纳冰","醇香巧克力风味搭配牛奶，口感香甜酷爽。（到店饮用口感更佳）","Chocolate Exfreezo",28,null,"","","","奶油","","巧克力酱，牛奶，冰沙粉，冰块，搅打奶油（含香草风味糖浆）。","","","goods/images/20200219221457_mc.png","",""),
  (NULL,3,300,"乐岛桃桃冰","【网易云音乐主题推荐款】蜜桃和玫瑰的灵感碰撞，清甜桃桃香气隐藏在玫瑰花香下，加上绵密细腻的沙冰topping，桃香、花香和清甜奶油，仿佛音符在你的舌尖上开party！","Peach & Rose Exfreezo",28,0,"","","","奶油","","桃汁饮料浓浆，玫瑰风味糖浆，冰块","","","goods/images/20200219215816_ttb.png","",""),
  (NULL,3,600,"抹茶瑞纳冰","【网易云音乐主题推荐款】蜜桃和玫瑰的灵感碰撞，清甜桃桃香气隐藏在玫瑰花香下，加上绵密细腻的沙冰topping，桃香、花香和清甜奶油，仿佛音符在你的舌尖上开party！","Peach & Rose Exfreezo",28,0,"","","","奶油","","桃汁饮料浓浆，玫瑰风味糖浆，冰块","","","goods/images/20200219215816_ttb.png","",""),
  (NULL,3,400,"卡布奇诺瑞纳冰","醇香巧克力风味搭配牛奶，口感香甜酷爽。（到店饮用口感更佳）","Chocolate Exfreezo",28,null,"","","","奶油","","巧克力酱，牛奶，冰沙粉，冰块，搅打奶油（含香草风味糖浆）。","","","goods/images/20200219221457_mc.png","",""),
  (NULL,3,600,"抹茶瑞纳冰","【网易云音乐主题推荐款】蜜桃和玫瑰的灵感碰撞，清甜桃桃香气隐藏在玫瑰花香下，加上绵密细腻的沙冰topping，桃香、花香和清甜奶油，仿佛音符在你的舌尖上开party！","Peach & Rose Exfreezo",28,0,"","","","奶油","","桃汁饮料浓浆，玫瑰风味糖浆，冰块","","","goods/images/20200219215816_ttb.png","",""),
  # 人气TOP
  (NULL,1,600,"抹茶瑞纳冰","【网易云音乐主题推荐款】蜜桃和玫瑰的灵感碰撞，清甜桃桃香气隐藏在玫瑰花香下，加上绵密细腻的沙冰topping，桃香、花香和清甜奶油，仿佛音符在你的舌尖上开party！","Peach & Rose Exfreezo",28,0,"","","","奶油","","桃汁饮料浓浆，玫瑰风味糖浆，冰块","","","goods/images/20200219215816_ttb.png","","goods/images/vide.mp4"),
  (NULL,1,200,"芥末腰果","原产地精选优良坚果，蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干6种搭配。原味烘焙，自然清香，每天悄悄来一包。","Daily Nuts 25g",4.55,6.9,"","","","","","蔓越莓干、扁桃仁、核桃仁、腰果仁、榛子仁、蓝莓干、白砂糖、葵花籽油","请置于阴凉干燥处存放。","25kg","goods/images/20200218235440_llyg.png","",""),
  (NULL,1,400,"榴莲捉妖记","榴莲馥郁香气包裹腰果的脆香，浓郁的松脆香甜缠绕舌尖，满足榴莲控的味蕾。","Duriann Cashew Nuts 15g",7.92,12,"","","","","","冻干榴莲果肉，腰果仁。","请置于阴凉干燥处存放。","15kg","goods/images/20200218235440_llyg.png","",""),
  # 大师咖啡
  (NULL,2,500,"香草拿铁","拿铁中融入清新香草风味，沁人心脾。","Vanilla Latte",15.4,28,"咖啡的好味，生豆八分，研磨烘焙，冲煮，萃取，我愿意就这样，用一生，去打磨一杯咖啡的香醇。","热","全糖","","","","","","goods/images/20200226231617_xcnt.png","","goods/images/vide.mp4"),
  (NULL,2,300,"标准美式","Espresso（意式浓缩）与水的黄金配比，带来浓郁的咖啡芬芳，成为脑海中挥之不去的绝妙体验。","Americano",22,null,"我会一直传承意大利人数百年的做法，用咖啡发源地的醇香，问候世间每一个味蕾。","热","无糖","无奶油","","浓缩咖啡、黑糖味寒天晶球，牛奶","","","goods/images/20200226225830_bzms.png","",""),
  (NULL,2,700,"焦糖拿铁","拿铁中融入清新香草风味，沁人心脾。","Vanilla Latte",12.4,28,"咖啡的好味，生豆八分，研磨烘焙，冲煮，萃取，我愿意就这样，用一生，去打磨一杯咖啡的香醇。","热","全糖","","","","","","goods/images/20200226231617_xcnt.png","",""),
  (NULL,2,200,"陨石拿铁","【探月50年主题推荐款】独特的黑糖风味拿铁，佐以香滑Q嫩的黑糖口味寒天晶球，创造出层次丰富的美妙口感，一起碰撞咖啡宇宙的无限可能。","Brown Suggar BoBo Latte",15.4,28,"","冰","半糖","无奶油","","浓缩咖啡，水","图片仅供参考，请以实物为准，建议送达后尽快饮用","","goods/images/20200226232910_ysnt.png","",""),
  (NULL,2,300,"加浓美式","Espresso（意式浓缩）与水的黄金配比，带来浓郁的咖啡芬芳，成为脑海中挥之不去的绝妙体验。","Americano",22,28,"我会一直传承意大利人数百年的做法，用咖啡发源地的醇香，问候世间每一个味蕾。","热","无糖","无奶油","","浓缩咖啡、黑糖味寒天晶球，牛奶","","","goods/images/20200226225830_bzms.png","",""),
  (NULL,2,100,"榛果拿铁","【探月50年主题推荐款】独特的黑糖风味拿铁，佐以香滑Q嫩的黑糖口味寒天晶球，创造出层次丰富的美妙口感，一起碰撞咖啡宇宙的无限可能。","Hazelnut Latte",15.4,28,"","热","全糖","","","浓缩咖啡，水","图片仅供参考，请以实物为准，建议送达后尽快饮用","","goods/images/20200226232910_ysnt.png","",""),
  # 经典饮品
  (NULL,4,400,"巧克力","牛奶与巧克力风味冲撞交织，满口细腻醇滑。","Chocolate Mike",25,null,"","冰","","","","巧克力酱、牛奶","图片仅供参考，请以实物为准，建议送达后尽快饮用","","goods/images/20200226235812_qkl.png","","goods/images/vide.mp4"),
  (NULL,4,300,"纯牛奶","精选优质牛奶","Mike",25,null,"","热","","","","牛奶","图片仅供参考，请以实物为准，建议送达后尽快饮用","","goods/images/20200226235833_cnn.png","",""),
  (NULL,4,600,"巴黎水330ml","经典气泡矿泉水","Perrier",19,null,"","","","","","含气矿泉水。净含量：330ml","图片仅供参考，请以实物为准，建议送达后尽快饮用","","goods/images/20200227000754._blspng.png","",""),
  (NULL,4,500,"小红莓苏打水","红宝石茶底是以莓果香气为主的德国花果茶拼入中国红茶，包含玫瑰茄、苹果、黑莓果干的风味，馥郁花香和酸甜果香混合酷爽沁凉的苏打水，带来清新饱满的味蕾体验。
（注：仅供冷饮，建议搅拌后饮用）","Ruby Tea & Soda Water",19,null,"","","半糖","","","红宝石茶汤，苏打水，原味调味糖浆","图片仅供参考，请以实物为准，建议送达后尽快饮用","","goods/images/20200227000812_sds.png","","")

;

/* 用户信息 */
CREATE TABLE luckin_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  phone VARCHAR(16),
  user_name VARCHAR(32)      #用户名，如王小明
);

INSERT INTO luckin_user VALUES
(NULL, 'doudou', '123456789', '13501234567', '刘备'),
(NULL, 'zhaoyun', '123456789', '13501234567', '赵云'),
(NULL, 'zhangfei', '123456789', '13501234567', '张飞'),
(NULL, 'guanyu', '123456789', '13501234567', '关羽');

/* 购物车表 */
CREATE TABLE luckin_cart(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(64), #商品名称
  user_id INT,              #用户编号
  product_id INT,           #商品编号
  count INT,                #购买数量
  str_types VARCHAR(64),    #选中的类型
  total DECIMAL(10,2)       #总价格
);

/* 订单表：还没有下单 */
CREATE TABLE luckin_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,              #用户编号
  product_id INT,           #商品编号
  product_name VARCHAR(64),  #商品名字
  count INT,                #购买数量
  str_types VARCHAR(128)   #类型
);

/* 历史订单：下单成功 */
CREATE TABLE luckin_history_order(
  hid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  oids_str VARCHAR(32),       #下单时的购物中的商品字符串
  total DECIMAL(10,2),                  #支付金额
  creat_time timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP  #自动保存当前系统时间
);

