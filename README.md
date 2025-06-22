# TinyTro
The Twitch Elite Tiny Cracktro

## Building

For now build it with vasm from the command line. To get a regular Amiga executable:


```
vasmm68k_mot main.asm -o tinytro.exe -m68000 -Fhunkexe -kick1hunks -nosym
```

If you want an absolute binary file assembled to $4000


```
vasmm68k_mot main.asm -o tinytro.exe -m68000 -Fbin -nosym -DABSORIGIN=$4000
```


Also see "Options" at the top of main.asm !


