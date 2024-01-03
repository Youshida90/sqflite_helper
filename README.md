<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This Package will make using sqflite much more fun and much easy than making it from zero
## Features

It will help you to create the crude of the sqflite by just calling all the methods like createdatabase, update, delete, insert and get the data from the database 

## Getting started
dependencies:
  sqflite_helper_new: ^1.0.0
  or

  write in the terminal 
  flutter pub add sqflite_helper_new
## Usage
First create a variable  
final sqfliteHelper = SqflitehelperNew();
add the createdatabase inside the initialestate
Example of creating the database:
sqfliteHelper.createDatabase(
        version: 1,
        databasefilename: 'todo.db',
        tablename: 'tasks',
        columns: [
          {
            'name': 'id',
            'type': 'INTEGER PRIMARY KEY AUTOINCREMENT',
          },
          {
            'name': 'title',
            'type': 'TEXT',
          },
          {
            'name': 'description',
            'type': 'TEXT',
          },
          {
            'name': 'status',
            'type': 'TEXT',
          },
        ]);

        Example of the insert:
        sqfliteHelper.insert(
        tablename: 'tasks',
        data: {
        'title': titlecontroller.text,
        'description': descriptioncontroller.text,
        'status': 'new',
    },
);

    Example of the get data from the database with the column name selected by the developer:
    sqfliteHelper.getdatafromdatabase(
    tablename: 'tasks', columnname: 'title');


    without the column name selected by the developer:
    sqfliteHelper.getdatafromdatabase(
    tablename: 'tasks');

    Example of the update the data:

    sqfliteHelper.updateRecord(
    tablename: 'tasks',
    newData: {"title": "ert"},
    whereColumn: "title",
    oldValue: "xx");

    Example of the delete:
    sqfliteHelper.deleteFromDatabase(tablename: 'tasks', whereColumn: 'title', value: 'ert');
    


```dart
const like = 'sample';
```

## Additional information
This package will be opensourse and it will be always up to date with sqflite and the sqflite_comman_ffi packages also this package can be updated to use much more features 
