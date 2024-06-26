# USER MANUAL


## Calling the program

``` <!---sh-->
    ./deckmyn "`cat deckmyn.c`" "`cat musicfile`" > output.pbm
```

Then display `output.pbm`.

This minimalistic music notator expects two command line arguments. The first is
the font description embedded in the source code. Notice that you don't pass the
file name, but the actual content as one long character string! If you want to
define your personal music font, you can of course do so. The file layout must
be exactly the same as [deckmyn.c](%%REPO_URL%%/2012/deckmyn/deckmyn.c) though, only the locations of
space (`" "`) may differ.

The second argument is the actual music. Again it is one long string, not a file
name. But it is possible to save your music in a file, of course.

Output should be redirected to a file. Afterwards, this file can be visualised
with various viewers.


## Music input

Every element in the music is given by a string of *exactly* 3 characters. Any
violation of this will result in the rest of the music being interpreted in some
randomly wrong way. Notice that in a file, the newline is also a character!
Therefore, when preparing music in a file, care should be taken that the last
musical element of a line is only 2 characters!

1. Basic notes:
    A single note is input by a letter (in the range `[A-Ga-g]`) followed by a
    duration (1, 2, 4 or 8) and possibly a dot (`.`). The notes cover 2 octaves,
    from `C` (lowest) to `b` (highest). The possible durations are 1 (whole
    note), 2 (half note), 4 (quaver), 8 (semi-quaver). So a dotted quaver `A`
    followed by a semi quaver `G` is input as `"A4.G8 "`.

2. Rests:
    A rest is given by the letter `r` followed by a duration (1, 2, 4 or 8).

3. Bar lines:
    There are three possible bar line types: single (`":  "`), double (`":: "`)
    and final (`":; "`).

4. Accidentals:
    Chromatic changes (sharp, flat, natural) are entered separately from the
    note that follows them! They are a three-character sequence by themselves.
    The first character is the chromatic change [`+-=`]. The second is the pitch
    at which it should be drawn. Thus `"+G G4 "` will draw a G sharp quaver.
    Notice that these signs do not necessarily have to be followed by a note.
    `"+f +c +g B2 "` is perfectly legal.

5. Space (formatting):
    To manually change the spacing of the music, you can add space between
    different musical elements. This is given by an `s` followed by the amount
    of space. `"s3 "` is the space taken by one note.  This length is given in 1
    character. However, to get a value larger than 9, you can just continue
    along the ASCII table. So `"sz "` gives you quite a lot of space on a staff.
    `"s0 "` is not only meaningless, it can cause nasty results.

6. New staff:
    A token `"x  "` signifies to start a new staff of music. A music staff may
    never be empty! Even if you just put some blank space (`"s1 "`), you should
    always have an entry for every staff. `"x  x  "` may give nasty results.

    All staves in the output are extended to the length of the longest staff. To
    have nicely formatted music, though, you will probably have to add spaces
    manually.

7. Time signatures:
    A time signature is given by `[m][234][234]`. For example, `"m24"` will give
    you a two fourth signature. Notice that there are only three available
    numbers.  Especially "6" and "8" are dearly missed.

8. Clef:
    The clef (`G` or `F`) can only be changed at the beginning of the music
    input. If the music starts with `"KF "`, the music will be written in a bass
    clef. `"K"` followed by any other letter will just default to a standard G clef.


## Examples

Blank music paper (with G clef):

``` <!---sh-->
    ./deckmyn "`cat deckmyn.c`" "sz sa x  s1 x  s1 x  s1 x  s1 x  s1 "> blank.pbm
```

With an F clef:

```
    ./deckmyn "`cat deckmyn.c`" "KF sz sa x  s1 x  s1 x  s1 x  s1 x  s1 "> blank.pbm
```

Notice how only the first staff (or any staff) needs to have the full length.

Some files with well-known melodies are included as examples.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
