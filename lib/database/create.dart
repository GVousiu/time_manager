/// create table sql statement

const CREATE_TODO_TABLE = '''CREATE TABLE todo (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  detail TEXT,
  status TEXT
)''';