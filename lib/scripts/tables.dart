const String places =
    "CREATE TABLE IF NOT EXISTS places(id INTEGER PRIMARY KEY, name TEXT, description TEXT, logo INTEGER, gallery BLOB, updateDate INTEGER)";

const String tables = 'CREATE TABLE IF NOT EXISTS tables('
    'id INTEGER PRIMARY KEY,'
    'placeId INTEGER NOT NULL,'
    'number INTEGER NOT NULL,'
    'image INTEGER,'
    'guests INTEGER NOT NULL,'
    'FOREIGN KEY (placeId) REFERENCES places (id) ON DELETE CASCADE)';

const String reservations = 'CREATE TABLE IF NOT EXISTS reservations('
    'id INTEGER PRIMARY KEY,'
    'tableId INTEGER NOT NULL,'
    'from INTEGER NOT NULL,'
    'to INTEGER,'
    'FOREIGN KEY (tableId) REFERENCES tables (id) ON DELETE CASCADE)';
