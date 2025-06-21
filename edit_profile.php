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
}

//  فئات الطعام
$categories_query = "SELECT * FROM food_categories";
$categories_result = mysqli_query($conn, $categories_query);

// التفضيلات الحالية
$current_prefs = [];
$prefs_query = "SELECT category_id FROM user_preferences WHERE user_id = ?";
$prefs_stmt = mysqli_prepare($conn, $prefs_query);
mysqli_stmt_bind_param($prefs_stmt, "i", $user_id);
mysqli_stmt_execute($prefs_stmt);
$prefs_result = mysqli_stmt_get_result($prefs_stmt);
while ($row = mysqli_fetch_assoc($prefs_result)) {
    $current_prefs[] = $row['category_id'];
}
mysqli_stmt_close($prefs_stmt);

//  الحساسيات
$allergy_query = "SELECT * FROM allergies_list";  
$allergy_result = mysqli_query($conn, $allergy_query);

// الحساسيات الحالية للمستخدم
$current_allergies = [];
$allergy_user_query = "SELECT allergy_id FROM food_allergies WHERE user_id = ?";
$allergy_stmt = mysqli_prepare($conn, $allergy_user_query);
mysqli_stmt_bind_param($allergy_stmt, "i", $user_id);
mysqli_stmt_execute($allergy_stmt);
$allergy_result_user = mysqli_stmt_get_result($allergy_stmt);
while ($row = mysqli_fetch_assoc($allergy_result_user)) {
    $current_allergies[] = $row['allergy_id'];
}
mysqli_stmt_close($allergy_stmt);

// التحقق من الفورم
if (isset($_POST['update'])) {
    $name        = $_POST['name'];
    $email       = $_POST['email'];
    $weight      = $_POST['weight'];
    $height      = $_POST['height'];
    $age         = $_POST['age'];
    $gender      = $_POST['gender'];
    $allergies   = $_POST['allergies'];
    $preferences = $_POST['preferences'];

    // تحديث بيانات المستخدم
    $update_sql = "UPDATE users SET name = ?, email = ?, weight = ?, height = ?, age = ?, gender = ? WHERE id = ?";
    $stmt = mysqli_prepare($conn, $update_sql);
    mysqli_stmt_bind_param($stmt, "ssiiisi", $name, $email, $weight, $height, $age, $gender, $user_id);

    if (mysqli_stmt_execute($stmt)) {
        mysqli_stmt_close($stmt);

        // حذف التفضيلات القديمة
        $delete_prefs = "DELETE FROM user_preferences WHERE user_id = ?";
        $del_stmt = mysqli_prepare($conn, $delete_prefs);
        mysqli_stmt_bind_param($del_stmt, "i", $user_id);
        mysqli_stmt_execute($del_stmt);
        mysqli_stmt_close($del_stmt);

        // إدخال التفضيلات الجديدة
        if (!empty($preferences)) {
            foreach ($preferences as $pref) {
                $insert_pref = "INSERT INTO user_preferences (user_id, category_id) VALUES (?, ?)";
                $stmt_pref = mysqli_prepare($conn, $insert_pref);
                mysqli_stmt_bind_param($stmt_pref, "ii", $user_id, $pref);
                mysqli_stmt_execute($stmt_pref);
                mysqli_stmt_close($stmt_pref);
            }
        }

        // حذف الحساسيات القديمة
        $delete_allergies = "DELETE FROM food_allergies WHERE user_id = ?";
        $del_stmt_allergy = mysqli_prepare($conn, $delete_allergies);
        mysqli_stmt_bind_param($del_stmt_allergy, "i", $user_id);
        mysqli_stmt_execute($del_stmt_allergy);
        mysqli_stmt_close($del_stmt_allergy);

        // إدخال الحساسيات الجديدة
        if (!empty($allergies)) {
            foreach ($allergies as $alg) {
                $insert_alg = "INSERT INTO food_allergies (user_id, allergy_id) VALUES (?, ?)";
                $stmt_alg = mysqli_prepare($conn, $insert_alg);
                mysqli_stmt_bind_param($stmt_alg, "ii", $user_id, $alg);
                mysqli_stmt_execute($stmt_alg);
                mysqli_stmt_close($stmt_alg);
            }
        }

        echo "<p style='color:green; text-align:center;'>تم تحديث البيانات بنجاح!</p>";
    } else {
        echo "<p style='color:red; text-align:center;'>حدث خطأ أثناء التحديث: " . mysqli_stmt_error($stmt) . "</p>";
        mysqli_stmt_close($stmt);
    }
}
?>


<!DOCTYPE html>
<html lang="ar">
<head>
  <meta charset="UTF-8">
  <title>تعديل الملف الشخصي</title>
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

<div class="profile-box">
  <h2>تعديل الملف الشخصي</h2>
  <form action="edit_profile.php" method="POST">
    <div class="form-group">
      <label>الاسم الكامل</label>
      <input type="text" name="name" value="<?php echo $user['name']; ?>" required>
    </div>

    <div class="form-group">
      <label>البريد الإلكتروني</label>
      <input type="email" name="email" value="<?php echo $user['email']; ?>" required>
    </div>

    <div class="form-group">
      <label>الوزن (كجم)</label>
      <input type="number" name="weight" value="<?php echo $user['weight']; ?>" required>
    </div>

    <div class="form-group">
      <label>الطول (سم)</label>
      <input type="number" name="height" value="<?php echo $user['height']; ?>" required>
    </div>

    <div class="form-group">
      <label>العمر</label>
      <input type="number" name="age" value="<?php echo $user['age']; ?>" required>
    </div>

    <div class="form-group">
      <label>الجنس</label>
      <select name="gender" required>
        <option value="male" <?php echo ($user['gender'] == 'male') ? 'selected' : ''; ?>>ذكر</option>
        <option value="female" <?php echo ($user['gender'] == 'female') ? 'selected' : ''; ?>>أنثى</option>
      </select>
    </div>

    <div class="form-group">
  <label>الحساسيات الغذائية</label>
  <select name="allergies[]" multiple required>
    <?php 
    $allergy_query = "SELECT * FROM allergies_list";
    $allergy_result = mysqli_query($conn, $allergy_query);
    while ($allergy = mysqli_fetch_assoc($allergy_result)): ?>
      <option value="<?php echo $allergy['id']; ?>" 
        <?php echo in_array($allergy['id'], $current_allergies) ? 'selected' : ''; ?>>
        <?php echo $allergy['name']; ?>
      </option>
    <?php endwhile; ?>
  </select>
</div>


    <div class="form-group">
      <label>التفضيلات الغذائية</label>
      <select name="preferences[]" multiple required>
    <?php while ($cat = mysqli_fetch_assoc($categories_result)): ?>
        <option value="<?php echo $cat['id']; ?>" 
            <?php echo in_array($cat['id'], $current_prefs) ? 'selected' : ''; ?>>
            <?php echo $cat['category_name']; ?>
        </option>
    <?php endwhile; ?>
</select>
    </div>

    <button type="submit" name="update">تحديث البيانات</button>
  </form>
  
  <a href="profile.php" class="back-btn">العودة إلى الملف الشخصي</a>
</div>
</div>
</div>
</body>
</html>
