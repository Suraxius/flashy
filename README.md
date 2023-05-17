# Flashy - Just another simple vocabulary trainer

This is a single-file php application for training writing using flash cards sorted into boxes.
The UI is optimized for mobile viewing. Added cards are automatically sorted into different boxes based on successfully typing in the correct answer or not.

The provided database contains cards for learning German for english speakers but it can be adapted to learn anything. Editing is also possible throug the UI (except for word classes) so adding an empty database is also an option. Please tweak db.sql before creating the sqlite3 database.

## Why built it?
I wrote this small application to help my wife learn german but then thought of publishing it in case someone else is looking for a simple solution. I know there are plenty of language learning programs out there but i wanted something offline and with boxes the cards are sorted into the traditional way. Contributions and improvements are most welcome.

## Screenshots
![Top view of App showing testing area and vocabulary boxes below](doc/top.png)
![View of lower part of App showing the editor area](doc/bottom.png)

### Test
![Test Area](doc/test.png)

### Vocabulary Boxes
![Test Area](doc/boxes.png)

### Editor
![Test Area](doc/editor.png)


## Requirements

- php 7.4 or higher
- php-sqlite3 extension

## Installation
Create a database from the provided db.sql file:
```
sqlite db.db < db.sql
```

## Edit index.php
Find following user/password lines and edit as needed.
```
class Auth {
    private $user = 'username';
    private $pass = 'password';
```

You can also comment out the line

```
new Auth();
```
at the bottom to disable basic authentication completely.
