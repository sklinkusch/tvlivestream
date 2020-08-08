# tvlivestream

This Perl script is meant to play the live streams of many public German ans
Austrian TV stations on the internet.

**Note**: Due to copyright issues, parts of the TV programme are not shown in
every country of the earth. This happens due to geoblocking.

## Files

- **`livestream.pl`**: das ausführbare Perl-Skript
- **`livestream.list`**: die Liste der Stream-URLs

## Gebrauch

### Abspielen eines Senders

`livestream.pl sendername`

### Abspielen eines Senders (stummgeschaltet)

`livestream.pl -mute sendername`  
`livestream.pl sendername -mute`

### Anzeigen aller Sendernamen

`livestream.pl list` (getrennt durch einfache Leerzeichen)  
`livestream.pl query` (ein Sendername pro Zeile)  
`livestream.pl fulllist` (ein Sendername pro Zeile, verknüpft mit der
Stream-URL)

### Anzeigen der Zahl der Sender

`livestream.pl number`
