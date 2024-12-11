-- レコード作成
INSERT INTO reports (report_id, person_id, content)
VALUES
(1, 1, '課題完了'),
(2, 2, '課題完了'),
(3, 3, '課題完了'),
(4, 4, '課題完了'),
(5, 5, '課題完了'),
(6, 6, '課題完了'),
(7, 7, '課題完了'),
(8, 8, '課題完了'),
(9, 9, '課題完了'),
(10, 10, '課題完了');

-- 内部結合
SELECT * FROM people INNER JOIN reports ON people.person_id = reports.person_id;

-- カラムの制限
SELECT p.person_id, p.name, r.content
FROM people AS p INNER JOIN reports AS r ON p.person_id = r.person_id;

-- 省略できるものを省く
SELECT p.person_id, p.name, r.content
FROM people p JOIN reports r ON p.person_id = r.person_id;

-- 外部結合
SELECT p.person_id, p.name, r.content FROM people p LEFT OUTER JOIN reports r USING (person_id);

-- レコードを消す
DELETE FROM reports WHERE report_id = 10;

-- レコードの追加
INSERT INTO people (person_id, name, email, age, gender)
VALUES
(11, 'test2', 'test2', 12, 1);

SELECT p.person_id, p.name, r.content FROM people p LEFT OUTER JOIN reports r USING (person_id);

-- COUNt関数
SELECT gender, COUNT(*) AS people_count FROM people GROUP BY gender;

-- Q1
CREATE TABLE departments (
  department_id INT unsigned NOT NULL auto_increment PRIMARY KEY COMMENT "部署ID",
  name VARCHAR(20) NOT NULL COMMENT "部署名",
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "作成日時",
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "更新日時"
);

-- Q2
ALTER TABLE people ADD department_id INT unsigned AFTER email;

-- Q3
INSERT INTO departments (name)
VALUES
('営業'),
('開発'),
('経理'),
('人事'),
('情報システム');

INSERT INTO people (name, email, department_id, age, gender)
VALUES
('営業1', 'aaa@aaa', 1, 30, 1),
('営業2', 'bbb@bbb', 1, 31, 2),
('営業3', 'ccc@ccc', 1, 32, 1),
('開発1', 'ddd@ddd', 2, 33, 1),
('開発2', 'eee@eee', 2, 34, 2),
('開発3', 'fff@fff', 2, 35, 1),
('開発4', 'ggg@ggg', 2, 34, 2),
('経理1', 'hhh@hhh', 3, 30, 1),
('人事1', 'iii@iii', 4, 31, 2),
('情報システム1', 'jjj@jjj', 5, 32, 1);

INSERT INTO reports (person_id, content)
VALUES
(12, '営業1です。レポートの作成完了です。'),
(13, '営業2です。レポートの作成完了です。'),
(14, '営業3です。レポートの作成完了です。'),
(15, '開発1です。レポートの作成完了です。'),
(16, '開発2です。レポートの作成完了です。'),
(17, '開発3です。レポートの作成完了です。'),
(18, '開発4です。レポートの作成完了です。'),
(19, '経理１です。レポートの作成完了です。'),
(20, '人事１です。レポートの作成完了です。'),
(21, '情報システム１です。レポートの作成完了です。');

-- Q4
UPDATE people SET department_id = 1 WHERE department_id IS NULL;

-- Q5 年齢の降順で男性の名前と年齢を取得してください。
SELECT name, age FROM people WHERE gender = 1 ORDER BY age ASC;

-- Q6 テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL文を日本語で説明してください。

SELECT
  `name`, `email`, `age`
FROM
  `people`
WHERE
  `department_id` = 1
ORDER BY
  `created_at`;

`people`テーブルから`department_id = 1`のレコードを検索し、 `name`,`email`,`age`カラムを取得して、
`created_at`の昇順で並べ替える。

-- Q7 20代の女性と40代の男性の名前一覧を取得してください。
SELECT name, age FROM people WHERE (gender = 2 AND age BETWEEN 20 AND 29) or (gender = 1 AND age BETWEEN 40 AND 49);

-- Q8 営業部に所属する人だけを年齢の昇順で取得してください。
SELECT name, department_id, age FROM people WHERE department_id = 1 ORDER BY age;

-- Q9 開発部に所属している女性の平均年齢を取得してください。
SELECT AVG(age) AS average_age FROM people
WHERE gender = 2 AND department_id = 2;

-- Q10 名前と部署名とその人が提出した日報の内容を同時に取得してください。（日報を提出していない人は含めない）
SELECT p.name, d.name, r.content
FROM people AS p
INNER JOIN departments AS d ON p.department_id = d.department_id
INNER JOIN reports AS r ON p.person_id = r.person_id;

-- Q11 日報を一つも提出していない人の名前一覧を取得してください。
SELECT p.name, d.name, r.content
FROM people AS p
LEFT OUTER JOIN departments AS d ON p.department_id = d.department_id
LEFT OUTER JOIN reports AS r ON p.person_id = r.person_id
WHERE r.content IS NULL;
