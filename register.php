<?php
include('db_connect.php');

//  فئات الطعام من جدول food_categories
$categories_query = "SELECT * FROM food_categories";
$categories_result = mysqli_query($conn, $categories_query);
//  حساسيات الطعام من جدول food_allergies
$allergy_query = "SELECT * FROM allergies_list";  
$allergy_result = mysqli_query($conn, $allergy_query);

// التحقق من إرسال الفورم
if (isset($_POST['submit'])) {
    // استقبال القيم من النموذج
    $name        = $_POST['name'];
    $email       = $_POST['email'];
    $password    = $_POST['password'];
    $weight      = $_POST['weight'];
    $height      = $_POST['height'];
    $age         = $_POST['age'];
    $gender      = $_POST['gender'];
    $allergies   = $_POST['allergies'];
    $preferences = $_POST['preferences']; 

    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    $sql = "INSERT INTO users (name, email, password, weight, height, age, gender) 
            VALUES (?, ?, ?, ?, ?, ?, ?)";

    if ($stmt = mysqli_prepare($conn, $sql)) {
        mysqli_stmt_bind_param($stmt, "sssiiss", $name, $email, $hashed_password, $weight, $height, $age, $gender);
        
        if (mysqli_stmt_execute($stmt)) {
           
            $user_id = mysqli_insert_id($conn);

            // إدخال التفضيلات في جدول user_preferences
            if (!empty($preferences)) {
                foreach ($preferences as $pref) {
                    $insert_pref = "INSERT INTO user_preferences (user_id, category_id) VALUES (?, ?)";
                    $stmt_pref = mysqli_prepare($conn, $insert_pref);
                    mysqli_stmt_bind_param($stmt_pref, "ii", $user_id, $pref);
                    mysqli_stmt_execute($stmt_pref);
                    mysqli_stmt_close($stmt_pref);
                }
            } else {
                echo "<p style='color:red; text-align:center;'>يجب تحديد التفضيلات الغذائية.</p>";
                exit();
            }

            // إدخال الحساسية في جدول food_allergies
            if (!empty($allergies)) {
                foreach ($allergies as $allergy) {
                    $insert_allergy = "INSERT INTO food_allergies (user_id, allergy_id) VALUES (?, ?)";
                    $stmt_allergy = mysqli_prepare($conn, $insert_allergy);
                    mysqli_stmt_bind_param($stmt_allergy, "ii", $user_id, $allergy); 
                    mysqli_stmt_execute($stmt_allergy);
                    mysqli_stmt_close($stmt_allergy);
                }
            } else {
                echo "<p style='color:red; text-align:center;'>يجب تحديد الحساسية.</p>";
                exit();
            }

          
            header("Location: login.php");
            exit();
        } else {
            echo "<p style='color:red; text-align:center;'>حدث خطأ أثناء إدخال المستخدم: " . mysqli_error($conn) . "</p>";
        }

        mysqli_stmt_close($stmt);
    } else {
        echo "<p style='color:red; text-align:center;'>خطأ في تحضير الاستعلام.</p>";
    }
}
?>


<!DOCTYPE html>
<html lang="ar">
<head>
  <meta charset="UTF-8">
  <title>إنشاء حساب</title>
  <link href="https://fonts.googleapis.com/css2?family=Tajawal&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
<header class="main-header">
    <h1 class="logo">foodmatch</h1>
    <nav class="main-nav">
      <a href="suggestions.php">تغذيتي</a>
      <a href="profile.php">ملفي الشخصي</a>
      <a href="logout.php">تسجيل الخروج</a>
    </nav>
</header>
<div class="register-box">
  <h2>إنشاء حساب جديد</h2>
  <form action="register.php" method="POST">
    <div class="form-group">
      <label>الاسم الكامل</label>
      <input type="text" name="name" required>
    </div>

    <div class="form-group">
      <label>البريد الإلكتروني</label>
      <input type="email" name="email" required>
    </div>

    <div class="form-group">
      <label>كلمة المرور</label>
      <input type="password" name="password" required>
    </div>

    <div class="form-group">
      <label>الوزن (كجم)</label>
      <input type="number" name="weight" required>
    </div>

    <div class="form-group">
      <label>الطول (سم)</label>
      <input type="number" name="height" required>
    </div>

    <div class="form-group">
      <label>العمر</label>
      <input type="number" name="age" required>
    </div>

    <div class="form-group">
      <label>الجنس</label>
      <select name="gender" required>
        <option value="">اختر</option>
        <option value="male">ذكر</option>
        <option value="female">أنثى</option>
      </select>
    </div>

    <div class="form-group">
  <label>الحساسيات الغذائية </label>
  <!-- يتم جلب الحساسيات من قاعدة البيانات وعرضها كخيارات متعددة -->
  <select name="allergies[]" multiple required>
    <?php while ($allergy = mysqli_fetch_assoc($allergy_result)): ?>
      <option value="<?php echo $allergy['id']; ?>"><?php echo $allergy['name']; ?></option>
    <?php endwhile; ?>
  </select>
</div>



    <div class="form-group">
      <label>التفضيلات الغذائية</label>
      <!-- يتم جلب التصنيفات الغذائية من قاعدة البيانات وعرضها كخيارات متعددة -->
      <select name="preferences[]" multiple required>
        <?php while ($cat = mysqli_fetch_assoc($categories_result)): ?>
          <option value="<?php echo $cat['id']; ?>"><?php echo $cat['category_name']; ?></option>
        <?php endwhile; ?>
      </select>
    </div>

    <button type="submit" name="submit">تسجيل</button>
  </form>
</div>
        </div>
</body>
</html>
