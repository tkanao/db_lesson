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
