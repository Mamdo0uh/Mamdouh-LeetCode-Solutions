SELECT book_id, MAX(title) AS title, MAX(author) AS author, MAX(genre) AS genre, MAX(publication_year) AS publication_year, MAX(total_copies) AS current_borrowers FROM
(
    SELECT book_id ,title ,author, genre,publication_year , total_copies,  total_copies AS total_remain FROM library_books
    UNION ALL
    SELECT book_id, '', '', '', 1000, 0, -1 FROM borrowing_records WHERE return_date IS NULL
)sub
GROUP BY book_id
HAVING SUM(total_remain) = 0
ORDER BY current_borrowers DESC, title;