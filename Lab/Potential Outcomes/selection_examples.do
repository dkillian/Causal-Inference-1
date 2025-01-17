* Selection on y0 
clear
set obs 1000000

gen id = _n
gen y0 = 100 + rnormal(0,20)
gen y1 = 150 + rnormal(0,15)
gen delta = y1-y0

* selection based on y0: y1 _||_ D

gen 	d=0
replace d=1 if y0>=100

* Create the aggregate conditional causal effects
egen ate = mean(delta)
egen att = mean(delta) if d==1
egen atu = mean(delta) if d==0
su ate-atu

* Check for independence with respect to y0
summarize y0 if d==0
summarize y0 if d==1 

* check for independence with respect to y1

summarize y1 if d==0
summarize y1 if d==1

* check for independence with respect to treatment effects
summarize delta if d==0
summarize delta if d==1

* switching equation
gen y=d*y1 + (1-d)*y0

egen temp_1 = mean(y) if d==1
egen temp_0 = mean(y) if d==0

egen y_1 = min(temp_1)
egen y_0 = min(temp_0)

gen sdo = y_1-y_0

su sdo ate att atu // when treatment is independent of y1, SDO = ATU


* selection on y1: y0 _||_ d
clear
set obs 1000000

gen id = _n
gen y0 = 100 + rnormal(0,20)
gen y1 = 150 + rnormal(0,15)
gen delta = y1-y0

* selection based on y1: 

gen 	d=0
replace d=1 if y1>=150

* Create the aggregate conditional causal effects
egen ate = mean(delta)
egen att = mean(delta) if d==1
egen atu = mean(delta) if d==0
su ate-atu


* Check for independence with respect to y0
summarize y0 if d==0
summarize y0 if d==1 

* check for independence with respect to y1

summarize y1 if d==0
summarize y1 if d==1

* check for independence with respect to treatment effects
summarize delta if d==0
summarize delta if d==1

* switching equation
gen y=d*y1 + (1-d)*y0

egen temp_1 = mean(y) if d==1
egen temp_0 = mean(y) if d==0

egen y_1 = min(temp_1)
egen y_0 = min(temp_0)

gen sdo = y_1-y_0

su sdo ate att atu




* selection on delta = y1-y0
clear
set obs 1000000

gen id = _n
gen y0 = 100 + rnormal(0,20)
gen y1 = 150 + rnormal(0,15)
gen delta = y1-y0

* selection based on y1

gen 	d=0
replace d=1 if delta>=50

* Check for independence with respect to y0
summarize y0 if d==0
summarize y0 if d==1 

* check for independence with respect to y1

summarize y1 if d==0
summarize y1 if d==1

* check for independence with respect to treatment effects
summarize delta if d==0
summarize delta if d==1

* switching equation
gen y=d*y1 + (1-d)*y0



