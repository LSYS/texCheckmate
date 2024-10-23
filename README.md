# texCheckmate
Shell utilities to inspect a LaTeX manuscript. 

Most are taken from Jonathan Dingel's [https://github.com/jdingel/projecttemplate/blob/master/paper/reviewing/Makefile](https://github.com/jdingel/projecttemplate/blob/master/paper/reviewing/Makefile).

## Use with `Make`
Comes with a `Makefile`, with quick CLI access to the utilities, some of which calling scripts from [https://github.com/LSYS/texCheckmate/tree/main/inspecting](https://github.com/LSYS/texCheckmate/tree/main/inspecting). 

```text
acronyms         Find and tally acronyms
aynumeric        Change author-year to numeric citation
cleantex         Clean aux output files in LaTex compilation
dueto            Find "due to"s; Did you mean "because of", "owing to", or "from"?
duplicated_labels Check for duplicated labels
hardcodednumbers Find hardcoded numbers
help             Show this help message and exit
inspect          Do all inspections of manuscript
linkchecker      Check URLs
numericay        Change author-year to numeric citation
repeated_strings Check for repeated words
textidote        Check with textidote
unreferenced_labels Check for label referencing
wordcount        Wordcount via texcount
```


## Porting
To download the utilities without cloning:

1. Download the zipped repo

```bash
wget -v https://github.com/LSYS/texCheckmate/archive/refs/heads/main.zip
```

2. Unzip

```bash
unzip -j main.zip -d _contents
```

3. Remove the `README.md`
```bash
rm _contents/README.md
```

4. Move to ./
```bash
mv _contents/* .
```

5. Clean up

```bash
rm -r _contents
rm main.zip
```


