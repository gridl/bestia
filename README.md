# bestia
bestia is a library of functions and classes designed to help you build dynamic command-line applications on Linux / Darwin systems.


## available functions / classes

### output.py

```
* echo
* FString
* Row
* tty_rows
* tty_cols
* clear_screen
* expand_seconds
* remove_path
* obfuscate_random_chars
* ProgressBar
```

### iterate.py

```
* LoopedList
* items_are_equal
* iterable_to_string
* unique_random_items
* pop_random_item
```

### proc.py

```
* Process
```



## dependencies
Installing bestia does not require you to install any external dependencies.


## api reference

The highlight of this library is the output module and more specifically the _echo()_ function along with the *FString()* and _Row()_ classes. Let's have a quick look at how these work:

`from bestia.output import echo, FString, Row `


### echo() function:

This is the simplest of the three, allowing to fast echo a string that reflects a particular color:

```
>>> echo('Hello World!', 'blue', 'underline', mode='retro')
```

<span style="color:blue"> `Hello World!` </span>

Supported fg and bg colors are:  
`black red green yellow blue magenta cyan white`  


Supported fx are: `reset bold faint underline blink reverse conceal cross frame circle overline`  

This is of course as long as your terminal emulator supports these as well. Some of the later ones are rarely supported unfortunately.

As an extra, the echo function has an optional last argument mode that has 3 possible values: 
`"modern", "raw", "retro"`  
These have to do with how the strings are rendered|terminated. Play with them and see what you like!



### FString() class:

The FString class was designed to help constructing strings that need to fit into specific areas of the terminal. This is done by dinamically preppending/appending blank spaces to the actual string so that it will be placed as needed on the horizontal plane. Let's take a look at a couple of examples:

```
>>> fs = FString('123', size=5, align='r')
>>> fs.echo()
  123
```

Notice how the "123" string has moved to the right by setting it's `size=5` and `align='r'`. The default value for align is `'l'`, but we can also use any of: ``('l', 'r', 'c', 'cl', 'cr')`

```
>>> FString(' bla ', size=20, align='cl').echo()
        bla         
```

When dealing with empty spaces it can be hard to understand where our FStrings end and where the rest of the terminal begins. We can use the `pad` argument to help debug this or to create more interesting TUI's:

```
>>> FString(' asd ', size=20, align='cl', pad='|').echo()
||||||| asd ||||||||

>>> FString(' asd ', size=20, align='cr', pad='*').echo()
******** asd *******
```

On top of that, FString supports all the ANSI SGR Codes that echo() does thru the `fg=str, bg=str, fx=[]` arguments


### Row() class:

A Row() object is a string that's width is exactly one entire row of your current terminal size. It accepts any number of str|FString objects as arguments and will automatically resize them so that they occupy exactly 1 row.

```
>>> r = Row('123', FString('ABC', align='r'))
>>> r.echo()
123                                                              ABC
```


