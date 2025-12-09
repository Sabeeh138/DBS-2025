1. Create a database named LibraryDB
```js
use LibraryDB
````

2. Create collection: books

```js
db.createCollection("books")
```

3. Insert sample books

```js
db.books.insertMany([
  {
    _id: 1,
    title: "The Road to Freedom",
    author: "John Lee",
    genre: "History",
    publication_year: 1999,
    rating: 4
  },
  {
    _id: 2,
    title: "The Silent Forest",
    author: "Sarah Woods",
    genre: "Fiction",
    publication_year: 2005,
    rating: 5
  },
  {
    _id: 3,
    title: "Advanced Computing",
    author: "Dr. Mark Lee",
    genre: "Technology",
    publication_year: 2010,
    rating: 3
  },
  {
    _id: 4,
    title: "Learning the Basics",
    author: "Emily Stone",
    genre: "Education",
    publication_year: 1995,
    rating: 2
  },
  {
    _id: 5,
    title: "The Great Adventure",
    author: "Robert Adams",
    genre: "Fiction",
    publication_year: 2020,
    rating: 4
  },
  {
    _id: 6,
    title: "Roadmap to Success",
    author: "Kevin Hart",
    genre: "Self-Help",
    publication_year: 2015,
    rating: 5
  }
])
```

4. Count all books

```js
db.books.countDocuments()
```

5. Count books published after 2000

```js
db.books.countDocuments({ publication_year: { $gt: 2000 } })
```

6. Sort by publication year (ascending)

```js
db.books.find().sort({ publication_year: 1 })
```

7. Sort by publication year (descending) then title (ascending)

```js
db.books.find().sort({
  publication_year: -1,
  title: 1
})
```

8. Return first 5 books

```js
db.books.find().limit(5)
```

9. Skip first 3 books

```js
db.books.find().skip(3)
```

10. Pagination: page 2 (skip 5, limit 5)

```js
db.books.find().skip(5).limit(5)
```

11. Average publication year

```js
db.books.aggregate([
  { $group: { _id: null, avgPublicationYear: { $avg: "$publication_year" } } }
])
```

12. Count books per genre

```js
db.books.aggregate([
  { $group: { _id: "$genre", count: { $sum: 1 } } }
])
```

13. Sort genres by count (descending)

```js
db.books.aggregate([
  { $group: { _id: "$genre", count: { $sum: 1 } } },
  { $sort: { count: -1 } }
])
```

14. Show only title and author

```js
db.books.find({}, { title: 1, author: 1, _id: 0 })
```

15. Exclude ISBN field

```js
db.books.find({}, { ISBN: 0 })
```

16. Create a text index on title and author

```js
db.books.createIndex({ title: "text", author: "text" })
```

17. Search for keyword "Road"

```js
db.books.find({ $text: { $search: "Road" } })
```

18. Titles starting with "The"

```js
db.books.find({ title: { $regex: "^The", $options: "i" } })
```

19. Authors ending with "Lee"

```js
db.books.find({ author: { $regex: "Lee$", $options: "i" } })
```

20. Increase all ratings by 1

```js
db.books.updateMany({}, { $inc: { rating: 1 } })
```

21. Decrease publication year of "Advanced Computing" by 5

```js
db.books.updateOne(
  { title: "Advanced Computing" },
  { $inc: { publication_year: -5 } }
)
```

22. Update genre of “The Great Adventure”

```js
db.books.findOneAndUpdate(
  { title: "The Great Adventure" },
  { $set: { genre: "Classic" } },
  { returnNewDocument: true }
)
```

23. Delete “The Silent Forest”

```js
db.books.findOneAndDelete({ title: "The Silent Forest" })
```
