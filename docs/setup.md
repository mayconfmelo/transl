
# Setup

This project uses `just` to automate the development processes. Run `just` or
refer to the [justfile](../justfile) for more information.

Codetags like _TODO_ or _FIXME_ can be easily viewed using todo.


## Release Setup

Setup the package in the default _preview_ namespace.

```
just install preview
just remove preview
```


## Testing Setup

Setup the package in a testing _local_ namespace:

```
just install local
just remove local
```


## Development Setup

Setup a the special _local:0.0.0_ path through a symlink:

```
just symlink
```

This way, every change made into the package will instantly be available to 
Typst.


-------------------------


## Other Useful Commands


### Tests

Run the test suite (tytanic):

```
just test
```


### Debug package

Install the package in `dev/pkg/` for debug purposes:

```
just install pkg
```


### Init debug project

Initialize a template project in `dev/` for the package:

```
just init
```


### Compile example

Compile example file as PDF and PNG in `dev/example/` path:

```
just example
```


### Compile documentation

Compile the manual file as PDF and PNG in `dev/doc/` path:

```
just doc
```

### Clean project

Remove non-essential files from project:

```
just clean
```