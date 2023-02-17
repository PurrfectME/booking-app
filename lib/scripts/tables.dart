const String places =
    'CREATE TABLE IF NOT EXISTS places(id INTEGER PRIMARY KEY, name TEXT, description TEXT, logoId INTEGER, base64Logo TEXT, updateDate INTEGER)';

const String tables = 'CREATE TABLE IF NOT EXISTS tables('
    'id INTEGER PRIMARY KEY, '
    'placeId INTEGER NOT NULL, '
    'number INTEGER NOT NULL, '
    'guests INTEGER NOT NULL, '
    'FOREIGN KEY (placeId) REFERENCES places (id) ON DELETE CASCADE)';

const String tableImages = 'CREATE TABLE IF NOT EXISTS tableImages('
    'id INTEGER PRIMARY KEY, '
    'tableId INTEGER NOT NULL, '
    'images TEXT, '
    'base64Images TEXT, '
    'FOREIGN KEY (tableId) REFERENCES tables (id) ON DELETE CASCADE)';

const String reservations = 'CREATE TABLE IF NOT EXISTS reservations('
    'id INTEGER PRIMARY KEY, '
    'tableId INTEGER NOT NULL, '
    'start INTEGER NOT NULL, '
    'end INTEGER NOT NULL, '
    'FOREIGN KEY (tableId) REFERENCES tables (id) ON DELETE CASCADE)';

const String userReservations = 'CREATE TABLE IF NOT EXISTS user_reservations('
    'id INTEGER PRIMARY KEY, '
    'tableId INTEGER NOT NULL, '
    'placeId INTEGER NOT NULL, '
    'start INTEGER NOT NULL, '
    'end INTEGER NOT NULL, '
    'updateDate INTEGER NOT NULL, '
    'FOREIGN KEY (placeId) REFERENCES places (id) ON DELETE CASCADE, '
    'FOREIGN KEY (tableId) REFERENCES tables (id) ON DELETE CASCADE)';
