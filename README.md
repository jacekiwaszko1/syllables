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

input:

```
ROZDZIAŁ 1
Przyszedł nowy rok 1655. Styczeń był mroźny, ale suchy; zima tęga przykryła Żmudź świętą grubym na łokieć, białym kożuchem; lasy gięły się i łamały pod obfitą okiścią, śnieg olśniewał oczy w dzień przy słońcu, a nocą przy księżycu migotały jakoby iskry niknące po stężałej od mrozu powierzchni; zwierz zbliżał się do mieszkań ludzkich, a ubogie szare ptactwo stukało dziobami do szyb szedzią i śnieżnymi kwiatami okrytych.

Pewnego wieczora siedziała panna Aleksandra w izbie czeladnej wraz z dziewczętami dworskimi. Dawny to był zwyczaj Billewiczów, że gdy gości nie było, to z czeladzią spędzali wieczory śpiewając pieśni pobożne i przykładem swym prostactwo budując. Tak też czyniła i panna Aleksandra, a to tym łacniej, że między jej dziewkami dworskimi same były prawie szlachcianki, sieroty bardzo ubogie. Te robotę wszelką, choćby najgrubszą, spełniały i przy paniach służebnymi były, a w zamian za to ćwiczyły się w obyczajności, lepszego doznając od prostych dziewek traktowania. Były jednak między nimi i chłopki, mową głównie się różniące, bo wiele z nich po polsku nie umiało.
```

output:

```
ROZ-DZIAŁ 1
Przy-szedł no-wy rok 1655. Sty-czeń był mroź-ny, a-le su-chy; zi-ma tę-ga przy-kry-ła Żmudź świę-tą gru-bym na ło-kieć, bia-łym ko-żu-chem; la-sy gię-ły się i ła-ma-ły pod ob-fi-tą o-kiś-cią, śnieg olś-nie-wał o-czy w_dzień przy słoń-cu, a no-cą przy księ-ży-cu mi-go-ta-ły ja-ko-by iskry nik-ną-ce po stę-ża-łej od mro-zu po-wierzch-ni; zwierz zbli-żał się do miesz-kań ludz-kich, a u-bo-gie sza-re ptact-wo stu-ka-ło dzio-ba-mi do szyb sze-dzią i śnież-ny-mi kwia-ta-mi o-kry-tych.

Pew-ne-go wie-czo-ra sie-dzia-ła pan-na A-lek-sand-ra w_iz-bie cze-lad-nej wraz z_dziew-czę-ta-mi dwor-ski-mi. Daw-ny to był zwy-czaj Bil-le-wi-czów, że gdy goś-ci nie by-ło, to z_cze-la-dzią spę-dza-li wie-czo-ry śpie-wa-jąc pieś-ni po-boż-ne i przyk-ła-dem swym pros-tact-wo bu-du-jąc. Tak też czy-ni-ła i pan-na A-lek-sand-ra, a to tym łac-niej, że mię-dzy jej dziew-ka-mi dwor-ski-mi sa-me by-ły pra-wie szlach-cian-ki, sie-ro-ty bar-dzo u-bo-gie. Te ro-bo-tę wszel-ką, choć-by najg-rub-szą, speł-nia-ły i przy pa-niach słu-żeb-ny-mi by-ły, a w_za-mian za to ćwi-czy-ły się w_o-by-czaj-noś-ci, lep-sze-go doz-na-jąc od pros-tych dzie-wek trak-to-wa-nia. By-ły jed-nak mię-dzy ni-mi i chłop-ki, mo-wą głów-nie się róż-nią-ce, bo wie-le z_nich po pol-sku nie u-mia-ło.
```
