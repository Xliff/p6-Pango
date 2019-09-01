# p6-Pango

## Installation

Make a directory to contain the p6-Gtk-based projects. Once made, then set the P6_GTK_HOME environment variable to that directory:

```
$ export P6_GTK_HOME=/path/to/projects
```

Switch to that directory and clone p6-Pango

```
$ git clone https://github.com/Xliff/p6-Pango.git
$ cd p6-Pango
$ zef install --deps-only .
```

[Optional] To build all of Pango and the required GTK modules, you can change to the p6-Pango directory and do:

```
./build.sh
```

If you just want to run the examples, you can do:

```
./p6gtkexec t/<name of example>
```
