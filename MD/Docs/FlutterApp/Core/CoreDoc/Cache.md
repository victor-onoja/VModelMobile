# Cache

### The Cache module handles local storage and caching of data. It helps to improve the app's developing performance by reducing the need for frequent code repeating and allowing for faster access to frequently used data.

### This file contains the following classes:

#### VModelSharedPrefStorage: This class provides methods for reading and writing data to the shared preferences store.
#### VModelSecureStroage: This class provides methods for reading and writing data to the secure storage store.

### Shared Preferences
#### Shared preferences is a `key`-`value` store that is persisted to disk. It is a good choice for storing small amounts of data, such as user settings, that need to be available even when the app is not running.

## Note that all metheds are in class which need to be inistantiated first

### Methods in VModelSharedPrefStorage

```
getString(`key`)
```

- Parameters:
    - `key`: The `key` of the `value` to be retrieved.
- Returns: The `value` associated with the `key`, or null if the `key` does not exist.

```
getInt(`key`)
```

 - Parameters:
    - `key`: The `key` of the `value` to be retrieved.
 - Returns: The integer `value` associated with the `key`, or null if the `key` does not exist.

```
getBool(`key`)
```

 - Parameters:
    - `key`: The `key` of the `value` to be retrieved.
 - Returns: The boolean `value` associated with the `key`, or null if the `key` does not exist.


```
setString(`key`, `value`)
```

 - Parameters:
     - `key`: The `key` to associate with the `value`.
     - `value`: The `value` to be stored.
 - Returns: `true` if the `value` was successfully stored, or `false` if the `key` already exists.

```
setInt(`key`, `value`)
```

 - Parameters:
     - `key`: The `key` to associate with the `value`.
     - `value`: The integer `value` to be stored.
 - Returns: `true` if the `value` was successfully stored, or `false` if the `key` already exists.


```
setBool(`key`, `value`)
```

 - Parameters:
     - `key`: The `key` to associate with the `value`.
     - `value`: The boolean `value` to be stored.
 - Returns: `true` if the `value` was successfully stored, or `false` if the `key` already exists.

### Secure Storage
#### Secure storage is a key-value store that is encrypted and stored on the device. It is a good choice for storing sensitive data, such as passwords and credit card numbers.

### Methods in VModelSecureStroage
```
read(`key`)
```

 - Parameters:
     - `key`: The `key` of the `value` to be retrieved.
 - Returns:The `value` associated with the `key`, or null if the `key` does not exist.

```
readAll()
```

 - Returns: A map of all `key`-`value` pairs in the secure storage store.

```
delete(`key`)
```

 - Parameters:
     - `key`: The `key` of the `value` to be deleted.
 - Returns: `true` if the `value` was successfully deleted, or `false` if the `key` does not exist.

```
deleteAll()
```

 - Returns: `true` if all `value`s were successfully deleted, or `false` if there were no `value`s to delete.

```
write(`key`, `value`)
```

 - Parameters:
     - `key`: The `key` to associate with the `value`.
     - `value`: The `value` to be stored.
 - Returns: `true` if the `value` was successfully stored, or `false` if the `key` already exists.