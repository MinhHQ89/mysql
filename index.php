<?php
$host = "localhost";
$port = 3333;
$username = "root";
$password = "";
$dbname = "demo_mysql";

try {
    // ----------------------------------------------------------
    // DB demo_mysql に接続
    // ----------------------------------------------------------
    $dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // エラー報告モードを設定（エラーが発生した場合は例外を表示）

    // --------------Slide 20 - 21: Connect to Database--------------
    echo "Success connection!";

    // --------------Slide 46 - 49: Create table--------------
    $sql = "
        CREATE TABLE IF NOT EXISTS news (
            id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(255) NOT NULL,
            email VARCHAR(255),
            description VARCHAR(255),
            slug VARCHAR(255),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        );
    ";
    $pdo->exec($sql);
    echo "Table 'news' created successfully!";

    // --------------Slide 64 - 66: Insert Data--------------
    $sql = "
        INSERT INTO news (title, email, description, slug)
        VALUES
        ('Breaking Tech News', 'tech@example.com', 'Latest updates in the technology world', 'breaking-tech-news'),
        ('World Economy Update', 'finance@example.com', 'Insights into the current global economy', 'world-economy-update');
    ";
    $pdo->exec($sql);
    echo "2 records inserted successfully into 'news'!";

    // --------------Slide 72 - 75: Select Data--------------
    // newsテーブルから全データをselectするSQL
    $sql = "SELECT * FROM news;";
    $stmt = $pdo->query($sql);
    // 結合配列形式のデータを取得
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
    // データを表示
    foreach ($results as $row) {
        echo "ID: " . $row['id'] . "<br>";
        echo "Title: " . $row['title'] . "<br>";
        echo "Email: " . $row['email'] . "<br>";
        echo "Description: " . $row['description'] . "<br>";
        echo "Slug: " . $row['slug'] . "<br>";
        echo "Created At: " . $row['created_at'] . "<br>";
        echo "Updated At: " . $row['updated_at'] . "<br>";
        echo "<hr>";
    }

} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
