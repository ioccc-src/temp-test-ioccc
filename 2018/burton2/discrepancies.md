The values below are the field-by-field difference `iocccsize - ioc`.
(`>0` means `iocccsize` counted more than `ioc`, `<0` `ioc` counted more)

```
    cl: lines, cw: words, cc: chars, ci: rule2, ts: saved, kw: keywords, ks: kw_saved

    cl 0   cw -4  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/1986/pawka.c
    cl -45 cw -55 cc -617 ci -463 ts -85 kw -26 ks -69 src/obc/1990/theorem/theorem.c
```

`ioc` is correct; cl is correct even in compat (91) due to comments eating newlines
`iocccsize` fails at `z;/*/`, eating everything until the following `/**/main(`
looks to be due to mis-identification of a comment closing block as opening block

```
    cl 0   cw -2  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/1991/westley/westley.c
    cl 0   cw -3  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/1992/gmariano/gmariano.c
    cl 0   cw -3  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/1992/gmariano/gmariano.orig.c
    cl 0   cw -1  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/1994/shapiro/shapiro.c
    cl 0   cw -2  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/1996/gandalf/gandalf.c
    cl 0   cw -1  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/1996/schweikh1/schweikh1.c
    cl 0   cw -2  cc 0    ci -2   ts 0   kw 1   ks 2   src/obc/1998/df/df.c
```

`iocccsize` counts as keyword `__##int##__`, and saving two characters but int
is not a plausible keyword

```
    cl 0   cw -1  cc 3    ci 2    ts 1   kw 0   ks 0   src/obc/2001/herrmann1/herrmann1.c
```

the text:

```
    d M Y(O)/* state to */
    d
```

counts as cw 3 in iocccsize, but this is clearly 4
and the cc,ci,ts is due entirely to:

```
       /*/*/*/*/*/ /*/*/
    E E /*/*/*/*/*/,/) F
```

which reduces to:

```
    * E E * ,/) F
```

but iocccsize counts this as `* E E *,/) F`, whereas ANSI C says comments are
replaced with a single space equivalent (non-portable token-paste with comments)

```
    cl 0   cw -2  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2004/arachnid/arachnid.c
    cl 0   cw -2  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2004/arachnid/arachnid.orig.c
    cl 0   cw 0   cc 0    ci -4   ts 0   kw 2   ks 4   src/obc/2004/hoyle/hoyle.c
    cl 0   cw 0   cc 0    ci -4   ts 0   kw 2   ks 4   src/obc/2004/hoyle/hoyle.orig.c
```

`iocccsize` counts as two keywords the token-pasted `int##if `(e.g int1)
thus the `kw 2`, and another bug in `iocccsize` counts `#if` as a keyword to 1
thus saving 2 bytes on int, and 2 more on `#if`, when neither is a plausible keyword

```
    cl 0   cw -1  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2004/omoikane/omoikane.c
    cl 0   cw -1  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2005/chia/chia.c
    cl 0   cw -1  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2005/mikeash/mikeash.c
    cl 0   cw 0   cc 0    ci 1    ts 1   kw 0   ks 0   src/obc/2005/toledo/toledo.c
    cl 0   cw 0   cc 0    ci 1    ts 1   kw 0   ks 0   src/obc/2005/toledo/toledo2.c
    cl 0   cw 0   cc 0    ci 1    ts 1   kw 0   ks 0   src/obc/2005/toledo/toledo3.c
```

these three discrepancies are due to backslash-newline of `longjm\p` --
at exactly the 521 byte line length boundary (which is arbitrary)
`ioc` is correct, because it has no line length limit

```
    cl 0   cw -4  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2011/akari/akari.c
    cl 0   cw -7  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2011/hamaji/hamaji.c
    cl 0   cw -4  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2012/endoh1/endoh1.c
    cl 0   cw -3  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2012/endoh1/endoh1_color.c
    cl 0   cw -1  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2012/endoh1/endoh1_deobfuscate.c
    cl 0   cw -2  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2012/omoikane/nyaruko.c
    cl 0   cw 0   cc 0    ci -3   ts 0   kw 1   ks 3   src/obc/2013/cable2/cable2.c
```

this is due to token-pasting of `_##char`; `iocccsize` counts this as a keyword
but it is a pre-processor token-pasted string of the arg to `Y()` and char
rendering this not a keyword, even in disguise

```
    cl 0   cw -2  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2013/endoh4/endoh4.c
    cl 0   cw -2  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2013/misaka/misaka.c
    cl 0   cw -1  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2014/endoh2/prog.c
    cl 0   cw -4  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2014/maffiodo1/prog.c
    cl 0   cw -4  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2014/maffiodo1/prog.orig.c
    cl 0   cw -1  cc 0    ci 0    ts 0   kw 0   ks 0   src/obc/2014/sinon/prog.c
```


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
