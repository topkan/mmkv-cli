# mmkv-cli

A command line utility to access Tencent's [MMKV](https://github.com/Tencent/MMKV) key-value stores.

## Purpose

This tool can be used to inspect keys, get, set and delete keys in MMKV store files. It can also clear the entire store or dump all keys and their values.

## Commands

mmkv-cli supports the following commands

- [`keys`](#keys) - enumerate keys in the store
- [`get`](#get) - get key value
- [`set`](#set) - set key value
- [`delete`](#delete) - delete key and its value
- [`dump`](#dump) - dump store contents
- [`reset`](#reset) - clear the entire contents of the store

All commands support the following arguments:

#### `--path [path]`

Path to the MMKV store file. The default is `./`.

#### `--id [string]`

MMKV instance id. If not specified, `default` is used.

### `keys`

Enumerate all keys in the store.

```
$ mmkv-cli keys <arguments>
```

### `get`

Get key value.

```
$ mmkv-cli get <key> --prettify-json <arguments>
```

#### `--prettify-json | -p`

Prettify JSON key value. Default is no prettification.

### `set`

Set key value.

```
$ mmkv-cli set <key> <value> <arguments>
```

### `delete`

Delete key and its value.

```
$ mmkv-cli delete key <arguments>
```

### `reset`

Reset the store, remove all keys and values.

```
$ mmkv-cli reset <arguments>
```

### `dump`

Dump all keys and values in the store. By default, the output is limited to first 100 characters of the value.

```
$ mmkv-cli dump <key> --prettify-json --truncate 80 <arguments>
```

#### `--prettify-json | -p`

Prettify JSON key value. Default is no prettification.

#### `--truncate [number]`

Truncate values to specified width. Default is `100`. Specifying `0` will surpress any truncation.

## License

mmkv-cli is made available under the terms of the Apache 2.0 license.  See the
LICENSE file that accompanies this distribution for the full text of the
license.

MMKV is separately licensed under Tencent [License](https://github.com/Tencent/MMKV/blob/master/LICENSE.TXT).
