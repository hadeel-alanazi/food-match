<?php
include('db_connect.php');
session_start();

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];

// استعلام SQL لاختيار الحساسيات الخاصة بالمستخدم
$sql_allergies = "SELECT al.name FROM food_allergies fa
                  JOIN allergies_list al ON fa.allergy_id = al.id
                  WHERE fa.user_id = ?";
$stmt_allergies = mysqli_prepare($conn, $sql_allergies);
mysqli_stmt_bind_param($stmt_allergies, "i", $user_id);
mysqli_stmt_execute($stmt_allergies);
$result_allergies = mysqli_stmt_get_result($stmt_allergies);

// تخزين الحساسيات الخاصة بالمستخدم في مصفوفة
$allergies = [];
while ($row = mysqli_fetch_assoc($result_allergies)) {
    $allergies[] = $row['name'];
}

// استعلام SQL لاختيار الأطعمة بناءً على تفضيلات المستخدم
$sql = "SELECT f.* 
        FROM foods f
        JOIN user_preferences up ON f.category_id = up.category_id
        WHERE up.user_id = ? ";
$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_bind_param($stmt, "i", $user_id);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

// تصفية الأطعمة التي تحتوي على مكونات تسبب الحساسية
$suggestions = [];
while ($food = mysqli_fetch_assoc($result)) {
    $ingredients = explode('،', $food['ingredients']); // فصل المكونات

    // فحص ما إذا كانت المكونات تحتوي على أي حساسية
    $contains_allergy = false;
    foreach ($ingredients as $ingredient) {
        foreach ($allergies as $allergy) {
            if (stripos(trim($ingredient), $allergy) !== false) {
                $contains_allergy = true;
                break 2; // إذا وجدنا حساسية، نتوقف عن البحث في هذه الوجبة
            }
        }
    }

    // إذا لم تحتوي الوجبة على حساسية، نضيفها للنتائج
    if (!$contains_allergy) {
        $suggestions[] = $food;
    }
}
?>

<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>اقتراحات الأكل</title>
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

<div class="container">
<h2>مقترحات بناءً على تفضيلاتك</h2>
  <?php if (!empty($suggestions)): ?>
    <div class="food-suggestions">

      <?php foreach ($suggestions as $food): ?>
  <div class="food-item">
    <h3><?php echo $food['name']; ?></h3>
    
    <?php if (!empty($food['image'])): ?>
      <img src="<?php echo $food['image']; ?>" alt="<?php echo $food['name']; ?>" style="width: 200px; height: 250px;; border-radius: 8px;">
    <?php endif; ?>
    
    <p><strong>السعرات:</strong> <?php echo $food['calories']; ?> kcal</p>
    <p><strong>المكونات:</strong> <?php echo $food['ingredients']; ?></p>

    <?php if (!empty($food['details'])): ?>
      <p><strong>الوصفة:</strong> <?php echo nl2br($food['details']); ?></p>
    <?php endif; ?>
  </div>
<?php endforeach; ?>


    </div>
  <?php else: ?>
    <p>لا توجد اقتراحات حالياً لتفضيلاتك.</p>
  <?php endif; ?>
</div>
</div>
  </div>
</body>
</html>
