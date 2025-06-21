<?php
include('db_connect.php');

session_start();

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];

$sql = "SELECT * FROM users WHERE id = $user_id";
$result = mysqli_query($conn, $sql);
$user = mysqli_fetch_assoc($result);

if (!$user) {
    echo "<p style='color:red; text-align:center;'>لا يوجد بيانات لهذا المستخدم</p>";
    exit();
}

// استعلام لاسترجاع التفضيلات الغذائية
$preferences_query = "SELECT fc.category_name
                      FROM user_preferences up
                      JOIN food_categories fc ON up.category_id = fc.id
                      WHERE up.user_id = $user_id";
$preferences_result = mysqli_query($conn, $preferences_query);

$preferences = [];
while ($pref = mysqli_fetch_assoc($preferences_result)) {
    $preferences[] = $pref['category_name'];
}

$preferences_list = !empty($preferences) ? implode(", ", $preferences) : 'لا يوجد';

// استعلام لاسترجاع الحساسية الغذائية للمستخدم من allergies_list
$allergies_query = "SELECT al.name AS allergy_name
                    FROM food_allergies fa
                    JOIN allergies_list al ON fa.allergy_id = al.id
                    WHERE fa.user_id = $user_id";
$allergies_result = mysqli_query($conn, $allergies_query);

$allergies = [];
while ($allergy = mysqli_fetch_assoc($allergies_result)) {
    $allergies[] = $allergy['allergy_name'];
}

$allergies_list = !empty($allergies) ? implode(", ", $allergies) : 'لا توجد حساسية مسجلة';
?>

<!DOCTYPE html>
<html lang="ar">
<head>
  <meta charset="UTF-8">
  <title>الملف الشخصي</title>
  <link href="https://fonts.googleapis.com/css2?family=Tajawal&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="style.css">
</head>
<body>
 <div class="main-box">
  <div class="container">
<header class="main-header">
    <h1 class="logo">foodmatch</h1>
    <nav class="main-nav">
      <a href="suggestions.php">تغذيتي</a>
      <a href="profile.php">ملفي الشخصي</a>
      <a href="logout.php">تسجيل الخروج</a>
    </nav>
</header>

<main class="centered-wrapper">
<div class="profile-box">
  <h2>الملف الشخصي</h2>
  <div class="profile-info">
    <!-- عرض بيانات المستخدم  -->
    <p><strong>الاسم:</strong> <?php echo $user['name']; ?></p>
    <p><strong>البريد الإلكتروني:</strong> <?php echo $user['email']; ?></p>
    <p><strong>الوزن:</strong> <?php echo $user['weight']; ?> كجم</p>
    <p><strong>الطول:</strong> <?php echo $user['height']; ?> سم</p>
    <p><strong>العمر:</strong> <?php echo $user['age']; ?> سنة</p>
    <p><strong>الجنس:</strong> <?php echo ($user['gender'] == 'male') ? 'ذكر' : 'أنثى'; ?></p>
    <p><strong>الحساسيات الغذائية:</strong> <?php echo $allergies_list; ?></p>
    <p><strong>التفضيلات الغذائية:</strong> <?php echo $preferences_list; ?></p>
  </div>
  
  <a href="edit_profile.php" class="edit-btn">تعديل البيانات</a>
  <a href="logout.php" class="logout-btn">تسجيل الخروج</a>

</div>
</div>
</div>
</body>
</html>
