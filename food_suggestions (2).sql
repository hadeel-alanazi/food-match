-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 21 يونيو 2025 الساعة 07:19
-- إصدار الخادم: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `food_suggestions`
--
CREATE DATABASE IF NOT EXISTS `food_suggestions` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `food_suggestions`;

-- --------------------------------------------------------

--
-- بنية الجدول `allergies_list`
--

CREATE TABLE `allergies_list` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `allergies_list`
--

INSERT INTO `allergies_list` (`id`, `name`) VALUES
(1, 'الجلوتين'),
(2, 'اللاكتوز'),
(3, 'بيض'),
(4, 'فول سوداني'),
(6, 'الأسماك'),
(8, 'الصويا'),
(10, 'السمسم'),
(15, 'الشوكولاتة');

-- --------------------------------------------------------

--
-- بنية الجدول `foods`
--

CREATE TABLE `foods` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `calories` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `ingredients` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `foods`
--

INSERT INTO `foods` (`id`, `name`, `category_id`, `calories`, `description`, `ingredients`, `image`, `details`) VALUES
(1, 'شوفان مع فواكه', 1, 350, 'فطور صحي يحتوي على ألياف وسكر طبيعي من الفواكه', 'شوفان، حليب، موز، توت، يحتوي على اللاكتوز', 'img/9a73d984e743ba255cc293d090ae5083.jpg', 'في قدر صغير، اغلي الحليب ثم أضف الشوفان. اطبخه حتى يتماسك، ثم أضف شرائح الموز والتوت. يُقدم دافئًا للإفطار.'),
(2, 'صدر دجاج مشوي', 2, 400, 'غداء غني بالبروتين ومنخفض الدهون', 'صدر دجاج، بهارات، زيت زيتون', 'img/90443a1ea66c5b16841be1db4ace6f2f.jpg', 'تُتبل صدور الدجاج بالبهارات وزيت الزيتون، ثم تُشوى على الجريل أو في الفرن لمدة 20 دقيقة حتى تنضج تمامًا. تُقدم مع خضار مشوية أو سلطة.'),
(3, 'سلطة التونة', 2, 300, 'وجبة خفيفة مليئة بالألياف والبروتين', 'تونة، خس، طماطم، زيت زيتون ، يحتوي على الأسماك', 'img/efd2ad3755fee749279b035727698486.jpg', 'اخلط التونة مع الخس والطماطم، وأضف زيت الزيتون. يُقدم الطبق باردًا كسلطة خفيفة مليئة بالبروتين.'),
(4, 'زبادي يوناني مع عسل', 4, 180, 'سناك خفيف غني بالبروتين', 'زبادي يوناني، عسل، يحتوي على اللاكتوز', 'img/49732dbd44b6f9cdc866f7e24896d5b6.jpg', 'في وعاء، ضع الزبادي اليوناني ثم أضف العسل فوقه. يمكن تزيينه بالمكسرات أو الفواكه حسب الرغبة. يُقدم كوجبة خفيفة أو بعد التمرين.'),
(5, 'كاري الخضار النباتي', 3, 450, 'عشاء نباتي متكامل غني بالتوابل والخضار', 'بطاطس، جزر، بازلاء، كاري، حليب جوز الهند', 'img/559873b2fde9b67d5f6f6754ffebd688.jpg', 'يُقلى البصل في القليل من الزيت ثم تضاف الخضروات وتُطهى مع بهارات الكاري. يُضاف حليب جوز الهند ويُترك حتى تتمازج النكهات. يُقدم مع الأرز البني أو بمفرده.'),
(6, 'بيض مسلوق', 1, 150, 'فطور بسيط غني بالبروتين', 'بيض،ملح', 'img/598cc53d837897d217758800a89f713f.jpg', 'اسلق البيض في ماء مغلي لمدة 8-10 دقائق، ثم قشّره وقدّمه مع رشة ملح أو خضار طازجة.'),
(7, 'سلطة كيتو', 6, 250, 'سلطة منخفضة الكربوهيدرات تحتوي على خضروات طازجة وزيت زيتون.', 'خس، طماطم، زيت زيتون، خيار', 'img/81a3840be5caf5679c0772b4abd8087e.jpg', 'اخلط الخضار المقطعة مع زيت الزيتون وقدّمها كسلطة كيتو باردة ومنعشة.'),
(8, 'بانكيك الشوفان', 7, 300, 'فطور غني بالكربوهيدرات البطيئة لإمداد الجسم بالطاقة قبل التمرين', 'شوفان، موز، بيض، عسل', 'img/de5c52d8eb45874d8f6a010a3e5be80a.jpg', 'اخلط الشوفان والموز المهروس والبيض والعسل. اطهها على مقلاة غير لاصقة حتى تصبح ذهبية من الجانبين. يُقدّم مع فواكه أو زبدة الفول السوداني.'),
(9, 'عصير الطاقة', 7, 250, 'عصير غني بالكربوهيدرات والفيتامينات لزيادة الطاقة', 'موز، تمر، حليب لوز، سبيرولينا', 'img/e384f6eb73ed11a56ab0b1fdd04b6775.jpg', 'اخلط الموز والتمر وحليب اللوز والسبيرولينا في الخلاط حتى تحصل على عصير ناعم ومغذي.'),
(10, 'سلطة البروتين', 8, 350, 'سلطة غنية بالبروتين والمغذيات لتعزيز التعافي بعد التمرين', 'صدر دجاج مشوي، أفوكادو، خضروات متنوعة، زيت زيتون', 'img/8903135757558378b5766084899c7d52.jpg', 'اخلط الأفوكادو المقطع مع صدر الدجاج المشوي والخضروات، وأضف زيت الزيتون. تُقدَّم السلطة باردة بعد التمرين.'),
(11, 'سمك السلمون المشوي', 8, 400, 'وجبة غنية بالبروتين والأحماض الدهنية الأساسية', 'سمك سلمون، ليمون، زيت زيتون ، يحتوي على الأسماك', 'img/48f7f2d5c32c78d5bac93d574d070e56.jpg', 'تبّل السلمون بالليمون وزيت الزيتون، واشوهه في الفرن أو المقلاة حتى ينضج. يُقدَّم مع خضروات مشوية أو أرز.'),
(12, 'كرات اللحم بالكيتو', 9, 450, 'كرات لحم لذيذة منخفضة الكربوهيدرات ومناسبة للكيتو', 'لحم مفروم، جبن موزاريلا، زيت زيتون، توابل', 'img/de68362f2f593833f8504939f5c2134f.jpg', 'اخلط اللحم المفروم مع الجبن والتوابل، شكّله كرات واطبخه في الفرن أو على النار حتى ينضج تمامًا. يُقدّم مع سلطة.'),
(13, 'سلطة الأفوكادو والبيض', 9, 300, 'سلطة مغذية وخفيفة مناسبة لحمية الكيتو', 'أفوكادو، بيض مسلوق، زيت زيتون', 'img/ed03c6fb9a9d6dbf672cfeb9b9f1d395.jpg', 'اخلط البيض المسلوق مع الأفوكادو والزيت في وعاء، وتُقدّم كسلطة مغذية مناسبة للكيتو.'),
(14, 'كيكة الأرز البني', 10, 200, 'كيكة لذيذة خالية من الجلوتين مثالية للفطور أو السناك', 'أرز بني، بيض، عسل، زيت جوز الهند', 'img/3ab226ed3c1175b640d25ff7e11218a3.jpg', 'اخلط الأرز البني المطحون مع البيض والعسل وزيت جوز الهند. صبّ الخليط في قوالب واخبزه حتى ينضج. تُقدّم مع كوب شاي.'),
(15, 'باستا خالية من الجلوتين', 10, 350, 'مكرونة خالية من الجلوتين مع صلصة الطماطم', 'مكرونة خالية من الجلوتين، صلصة طماطم، زيت زيتون، أعشاب', 'img/c61f726fa826a8cf0686ed3332e372c3.jpg', 'اسلق المكرونة ثم أضف إليها صلصة الطماطم والزيت والأعشاب. اطبخ الخليط لعدة دقائق ثم قدّمه ساخنًا.'),
(16, 'براونيز الشوكولاتة الداكنة', 11, 180, 'براونيز صحي خالي من السكر ومليء بالكاكاو الطبيعي', 'كاكاو داكن، دقيق اللوز، سكر جوز الهند ، يحتوي على الشوكولاتة', 'img/9f5baa2c9989dcdee5f12ffe9539c797.jpg', 'اخلط المكونات في وعاء، صبّها في قالب، واخبز البراونيز في فرن متوسط الحرارة حتى تنضج. تُقدّم كتحلية صحية.'),
(17, 'كرات الطاقة بالشوفان', 11, 250, 'كرات طاقة خفيفة ولذيذة وصحية', 'شوفان، زبدة لوز، عسل، كاكاو', 'img/494f361b990d466bc1740309f0203602.jpg', 'اخلط الشوفان مع زبدة اللوز والعسل والكاكاو، شكلها كرات صغيرة واحفظها في الثلاجة. تُقدّم كوجبة طاقة سريعة.'),
(18, 'فطائر التفاح', 12, 200, 'فطائر صحية ولذيذة تحتوي على تفاح طبيعي', 'دقيق القمح الكامل، تفاح، قرفة، يحتوي على جلوتين', 'img/bdd99366ec4aeb8753979d4e85a8d5c4.jpg', 'اخلط دقيق القمح مع التفاح المبشور والقرفة. صبّ المزيج في قوالب واخبزه حتى يحمر. تُقدّم دافئة.'),
(19, 'سلطة الفواكه', 12, 150, 'سلطة فواكه طبيعية وخفيفة للأطفال', 'تفاح، برتقال، موز، توت', 'img/b157607911f6bac5dfced8883216002b.jpg', 'قطّع الفواكه واخلطها بلطف في وعاء. تُقدَّم باردة كتحلية صحية للأطفال.'),
(20, 'توست الأفوكادو', 1, 280, 'توست من خبز القمح الكامل مع أفوكادو طازج', 'خبز قمح كامل، أفوكادو، زيت زيتون، يحتوي على جلوتين', 'img/8d42afe0862ca6a282b5344c459bad4a.jpg', 'حمّص خبز القمح الكامل، ثم افرد عليه طبقة من الأفوكادو المهروس، وقدّمه مع رشة زيت زيتون.'),
(21, 'عصير الفواكه الخضراء', 1, 220, 'عصير مغذي من الفواكه والخضروات', 'سبانخ، تفاح، ليمون، ماء جوز الهند', 'img/0aeb8a1977b69abb00d004660045780f.jpg', 'اخلط السبانخ والتفاح والليمون وماء جوز الهند في الخلاط. يُقدّم العصير طازجًا ومنعشًا.'),
(22, 'لحم بقري مشوي', 2, 500, 'لحم بقري مشوي غني بالبروتين', 'لحم بقري، زيت زيتون، بهارات', 'img/eaa5e1d0612935f110254af26a4e0caf.jpg', 'تبّل اللحم بالبهارات واشوهه حتى ينضج، ثم قطّعه شرائح وقدّمه مع طبق جانبي أو سلطة.'),
(23, 'سلطة الكينوا والدجاج', 2, 350, 'سلطة خفيفة مع دجاج مشوي وكينوا', 'دجاج مشوي، كينوا، طماطم، خيار', 'img/682bddfa23f57ec23b8aec2bfa9da75d.jpg', 'اخلط الكينوا المطبوخة مع الدجاج المشوي والخضروات، وقدّمها كسلطة متوازنة.'),
(24, 'شوربة العدس', 3, 250, 'شوربة عدس مغذية ولذيذة', 'عدس، طماطم، بصل، ثوم', 'img/6f572145269f4dc070aa849110ae18ff.jpg', 'في قدر، اقلي البصل ثم أضف العدس والطماطم والثوم. أضف الماء واتركه حتى ينضج. تُقدَّم الشوربة ساخنة.'),
(25, 'سوتيه الخضروات', 3, 300, 'خضار مشوية مع زيت الزيتون', 'بروكلي، جزر، كوسا، زيت زيتون', 'img/94054ce3b8689208bd928fb6e5dc6d18.jpg', 'قطّع الخضار واقلها مع زيت الزيتون حتى تذبل. يُقدّم الطبق ساخنًا كطبق جانبي.'),
(26, 'برغر نباتي', 3, 400, 'برغر نباتي مع خبز القمح الكامل', 'فاصوليا سوداء، توابل، خبز قمح كامل', 'img/771d59f5ffaf698b312a2ba2817a0625.jpg', 'اخلط الفاصوليا المهروسة مع التوابل وشكّلها على شكل أقراص، اقليها أو اشوها، ثم ضعها داخل خبز القمح الكامل.'),
(27, 'مكسرات مشوية', 4, 250, 'مزيج من المكسرات المشوية', 'لوز، جوز، فستق، ملح', 'img/48c21b01ae0d6b547dfb75da06a4140a.jpg', 'حمّص المكسرات في الفرن مع رشة ملح حتى تتحمّر. تُقدّم كوجبة خفيفة مغذية.'),
(28, 'ترايفل الفواكه', 4, 220, 'ترايفل فواكه مع زبادي', 'زبادي، توت، موز، عسل، يحتوي على اللاكتوز', 'img/b570436c97b25eabe19c94ac38581d8c.jpg', 'ضع الزبادي في كأس، أضف طبقات من التوت والموز والعسل، ثم زيّنها بالفواكه حسب الرغبة.'),
(29, 'شرائح التفاح مع زبدة الفول السوداني', 4, 200, 'وجبة خفيفة مليئة بالبروتين', 'تفاح، زبدة فول سوداني', 'img/1a00dd7d26b1f0f2308de19d6a5f2dfb.jpg', 'قطّع التفاح إلى شرائح وقدّمه مع زبدة الفول السوداني كوجبة خفيفة مغذية.'),
(30, 'توست الأفوكادو مع بيض', 7, 280, 'وجبة خفيفة مليئة بالبروتين والكربوهيدرات', 'أفوكادو، بيض، توست', 'img/379f37af3c7deea26b544d7658bafeb1.jpg', 'حمّص التوست، افرد عليه الأفوكادو، وأضف البيض المسلوق أو المقلي فوقه. يُقدّم ساخنًا.'),
(31, 'زبدة الفول السوداني مع موز', 7, 250, 'وجبة سريعة تمد الجسم بالطاقة', 'موز، زبدة فول سوداني', 'img/63089aa1aa6911aa92b1f1a5b4517ac1.jpg', 'قطّع الموز وقدّمه مع زبدة الفول السوداني. يمكن لفه في خبز التورتيلا أو تناوله مباشرة كسناك.'),
(32, 'شرائح لحم البقر مع خضار', 8, 450, 'لحم بقري مشوي مع خضار سوتيه', 'لحم بقري، بروكلي، زيت زيتون', 'img/3a66e815fad906493a1dcb189fb32ee0.jpg', 'اشوِ شرائح اللحم مع القليل من الزيت والبهارات، ثم قدّمها مع خضار سوتيه مطهوة بخفة.'),
(33, 'شوربة الدجاج الصحية', 8, 350, 'شوربة دجاج مغذية وسهلة التحضير', 'دجاج، جزر، بصل، كرفس', 'img/7e41f68af944c377e4d3ff57938a6664.jpg', 'في قدر، اسلق الدجاج ثم أضف الخضار والتوابل واتركه يغلي حتى تنضج المكونات. تُقدّم الشوربة ساخنة ومغذية.');

-- --------------------------------------------------------

--
-- بنية الجدول `food_allergies`
--

CREATE TABLE `food_allergies` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `allergy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `food_allergies`
--

INSERT INTO `food_allergies` (`id`, `user_id`, `allergy_id`) VALUES
(8, 7, 6),
(9, 8, 8);

-- --------------------------------------------------------

--
-- بنية الجدول `food_categories`
--

CREATE TABLE `food_categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `food_categories`
--

INSERT INTO `food_categories` (`id`, `category_name`) VALUES
(1, 'فطور'),
(2, 'غداء'),
(3, 'عشاء'),
(4, 'سناك'),
(5, 'نباتي'),
(6, 'منخفض الكربوهيدرات'),
(7, 'وجبة قبل التمرين'),
(8, 'وجبة بعد التمرين'),
(9, 'دايت الكيتو'),
(10, 'خالية من الجلوتين'),
(11, 'حلى صحي'),
(12, 'وجبة للأطفال');

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `height` float DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `weight`, `height`, `age`, `gender`) VALUES
(1, 'أحمد السلمي', 'ahmed@example.com', '123456', 75, 178, 28, 'male'),
(2, 'سارة المالكي', 'sara@example.com', 'password', 60, 165, 24, 'female'),
(4, 'ليلى العتيبي', 'layla@example.com', 'layla123', 55, 160, 22, 'female'),
(6, 'dee', 'dee@gmail.com', '$2y$10$L2/iC7is8vUqMuXW6rhRsOtrkNEN11gpAls7fORA.kZ/pFS1V6GZO', 60, 160, 24, 'female'),
(7, 'ريمان', 'reman@gmail.com', '$2y$10$4SfAUfy3uf8Yh71DLP63/eKyPZbLqBq06LuNDUSjK7LjKDyodwXS.', 50, 160, 21, 'female'),
(8, 'ريمان', 'remaan@gmail.com', '$2y$10$18W4C7L5mplOI.hp9pM6dOWHRsKBYOv5r/Xz5qcyuHDyXa.KuUGru', 55, 158, 20, 'female');

-- --------------------------------------------------------

--
-- بنية الجدول `user_preferences`
--

CREATE TABLE `user_preferences` (
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `user_preferences`
--

INSERT INTO `user_preferences` (`user_id`, `category_id`) VALUES
(6, 3),
(7, 2),
(8, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `allergies_list`
--
ALTER TABLE `allergies_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `food_allergies`
--
ALTER TABLE `food_allergies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `allergy_id` (`allergy_id`);

--
-- Indexes for table `food_categories`
--
ALTER TABLE `food_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD PRIMARY KEY (`user_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `allergies_list`
--
ALTER TABLE `allergies_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `foods`
--
ALTER TABLE `foods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `food_allergies`
--
ALTER TABLE `food_allergies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `food_categories`
--
ALTER TABLE `food_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- قيود الجداول المُلقاة.
--

--
-- قيود الجداول `foods`
--
ALTER TABLE `foods`
  ADD CONSTRAINT `foods_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `food_categories` (`id`);

--
-- قيود الجداول `food_allergies`
--
ALTER TABLE `food_allergies`
  ADD CONSTRAINT `food_allergies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `food_allergies_ibfk_2` FOREIGN KEY (`allergy_id`) REFERENCES `allergies_list` (`id`);

--
-- قيود الجداول `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD CONSTRAINT `user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_preferences_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `food_categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
