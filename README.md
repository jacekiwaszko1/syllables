##### Overview

**syllables** is a perl script that devides words into syllables and adds hyphenation.
It is not based on TeX or any other algorithm, it does not use any dictionary.

 **syllables** is based on simple set of rules which works surprisingly well.

---

##### Languages supported

- Latin
- Polish

---

##### Instalation

- clone repository
- type `make install`

---

##### Usage

`syllables -[lp] text-file`

###### Options

- `-l, --latin ` - rules adjusted to latin texts
- `-p, --polish` - rules adjusted to polish texts (default)

###### Demo:

input:

```
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
```

output:

```
Lo-rem ip-sum do-lor sit a-met, con-sec-te-tur a-di-pi-si-cing e-lit, sed do e-i-us-mod tem-por in-ci-di-dunt ut la-bo-re et do-lo-re mag-na a-li-qua. Ut e-nim ad mi-nim ve-ni-am, quis nost-rud e-xer-ci-ta-ti-on ul-lam-co la-bo-ris ni-si ut a-li-quip ex e-a com-mo-do con-se-quat. Du-is au-te i-ru-re do-lor in rep-re-hen-de-rit in vo-lup-ta-te ve-lit es-se cil-lum do-lo-re e-u fu-gi-at nul-la pa-ri-a-tur. Ex-cep-te-ur sint oc-cae-cat cu-pi-da-tat non pro-i-dent, sunt in cul-pa qui of-fi-ci-a de-se-runt mol-lit a-nim id est la-bo-rum.
```
