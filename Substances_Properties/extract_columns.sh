#!/bin/bash

awk 'FS="\t" {print $1 "\t"$32 "\t"$46 "\t"$54 "\t"$59 "\t"$62 "\t"$68 "\t"$72 "\t"$76 "\t"$81 "\t"$88 "\t"$91 "\t"$94 "\t"$101 "\t"$104 "\t"$107 "\t"$112 "\t"$116 "\t"$120 "\t"$123 "\t"$127 "\t"$132 "\t"$138 "\t"$141 "\t"$145 "\t"$147 "\t"$150 "\t"$153 "\t"$157 "\t"$160 "\t"$163 "\t"$166 "\t"$169 "\t"$173 "\t"$176 "\t"$179 "\t"$182 "\t"$185 "\t"$189 "\t"$194 "\t"$199 "\t"$203 "\t"$207 "\t"$211 "\t"$214 "\t"$219 "\t"$224 "\t"$229 "\t"$235 "\t"$238 "\t"$243 "\t"$247 "\t"$250 "\t"$254 "\t"$258 "\t"$262 "\t"$265 "\t"$268 "\t"$278 "\t"$288 "\t"$291 "\t"$294 "\t"$298 "\t"$303 "\t"$307 "\t"$312 "\t"$318 "\t"$321 "\t"$329 "\t"$333 "\t"$341 "\t"$349 "\t"$354 "\t"$357 "\t"$361 "\t"$364 "\t"$367 "\t"$374 "\t"$380 "\t"$388 "\t"$393 "\t"$399 "\t"$405 "\t"$413 "\t"$420 "\t"$428 "\t"$436 "\t"$446 "\t"$454 "\t"$462 "\t"$470 "\t"$478 "\t"$486 "\t"$494 "\t"$502 "\t"$510 "\t"$521 "\t"$528 "\t"$533 "\t"$540 "\t"$546 "\t"$550 "\t"$553 "\t"$557 "\t"$560 "\t"$565 "\t"$570 "\t"$574 "\t"$578 "\t"$586 "\t"$592 "\t"$608 "\t"$620 "\t"$645 "\t"$660 "\t"$668 "\t"$672 "\t"$675}' ../PREP/P_SUB/scr_03_Aug_22/head_unique_all_subds.tsv > L_columns.tsv

# de aqui imprimir $i cada uno de los campos !
