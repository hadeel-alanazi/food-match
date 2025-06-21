<?php
include('db_connect.php');

// التحقق من إرسال الفورم
if (isset($_POST['login'])) {
    $email    = $_POST['email'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM users WHERE email = ?";
    if ($stmt = mysqli_prepare($conn, $sql)) {
        mysqli_stmt_bind_param($stmt, "s", $email);
        
        mysqli_stmt_execute($stmt);

        $result = mysqli_stmt_get_result($stmt);

        if (mysqli_num_rows($result) > 0) {
            $user = mysqli_fetch_assoc($result);

            if (password_verify($password, $user['password'])) {
                session_start();
                $_SESSION['user_id'] = $user['id']; 
                $_SESSION['user_name'] = $user['name'];
                header("Location: profile.php");
                exit();
            } else {
                echo "<p style='color:red; text-align:center;'>البريد الإلكتروني أو كلمة المرور غير صحيحة</p>";
            }
        } else {
            echo "<p style='color:red; text-align:center;'>البريد الإلكتروني أو كلمة المرور غير صحيحة</p>";
        }

        mysqli_stmt_close($stmt);
    } else {
        echo "<p style='color:red; text-align:center;'>خطأ في الاتصال بقاعدة البيانات.</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="ar">
<head>
  <meta charset="UTF-8">
  <title>تسجيل الدخول</title>
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
<div class="register-box">
  <h2>تسجيل الدخول</h2>
  <form action="login.php" method="POST">
    <div class="form-group">
      <label>البريد الإلكتروني</label>
      <input type="email" name="email" required>
    </div>

    <div class="form-group">
      <label>كلمة المرور</label>
      <input type="password" name="password" required>
    </div>

    <button type="submit" name="login">تسجيل الدخول</button>
    <div class="login-link">
                <p>ليس لديك حساب؟ <a href="register.php">تسجيل جديد</a></p>
            </div>
  </form>
</div>

</div>
</div>
</body>
</html>
