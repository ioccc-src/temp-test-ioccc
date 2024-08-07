## To build:

``` <!---sh-->
    make all
```

There are two alternate versions, one that has an increased buffer size and one
that uses `fgets()`; neither are completely functional.  See below section [Bugs
and &lpar;mis&rpar;features](#bugs-and-misfeatures) for details and the [Alternate
code](#alternate-code) section for how to use.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: uses gets() - change to fgets() if possible**

For more detailed information see [1994/schnitzi in bugs.html](../../bugs.html#1994_schnitzi).


## To use:

``` <!---sh-->
    ./schnitzi < textfile
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

These alternate versions are for those who wish to help with getting the entry
to use `fgets(3)`. See the
FAQ on "[gets and fgets](../../faq.html#gets)"
for why this is desired.

The first version, `schnitzi.alt.c`, uses `fgets(3)` but when fed its own code
it will generate code that still uses `gets(3)`. What's more that code will not
compile. Other functionality of the alt version works fine.

The second version, `schnitzi.alt2.c`, has an increased buffer size but when fed
its own source code it will generate code that, although it can compile but, it
has the original buffer size. This is due to a comment which is explained in
more detail in [1994/schnitzi in bugs.html](../../bugs.html#1994_schnitzi).


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `schnitzi.alt` and `schnitzi.alt2` as you would `schnitzi` above except that
feeding the source code to it will not work right.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

Try:

``` <!---sh-->
    ./schnitzi < schnitzi.c
```

Compare the output of the program with its source.  Sure the output
is different, but there is more than meets the `diff`'s eye.  Can you
find out why?

You might also wish to redirect the output to another file,
compile it and compare how it works to the original code.


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


## Author's remarks:

This is a program which takes any text file as input and 'flips'
the input file along a diagonal running from the top left corner
down to the bottom right.  In other words, the first row in the
file ends up written down the first column of the result, the
second row is written down the second column, etc. The program
is run by redirecting a file into the executable on the command
line; for instance, for the file 'info', the program
would be run as follows:

``` <!---sh-->
    ./schnitzi < info
```

The program generates interesting results when its source file is
used as input:

``` <!---sh-->
    ./schnitzi < schnitzi.c
```

The result of this command is a program which does the exact same
thing -- in other words, both the program and the "flipped"
version of itself work identically (you'll need to redirect the
output of the above command into a separate file and compile it).
You might notice some differences in the flipped version, though.
First off, a secret message becomes visible that was not visible
in the original program.  Also, much of the code shows up in
different places in the flipped program than it appeared in the
first program.  My first version of this program was perfectly
symmetrical along the diagonal, but I later found out there were
interesting ways to break the symmetry.  The best way to see this
is to load both the original and flipped versions of the program
into an editor and switch back and forth between them rapidly.

C tokens longer than a character (such as `main()`) proved difficult
to use in both the original and flipped versions (after flipping,
they show up as a string of single letters on successive lines).
However, I found that it was possible to get around this through
a few well-placed comments.  An earlier version of this program
used nearly every single-character token in the "shared" area;
however, it proved to be too large for contest guidelines (although
the code itself is only about 300 characters, the extra whitespace
needed to pad it put it over the limit -- it nearly filled a 79 by
79 area, adding up to over 4000 total characters).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
