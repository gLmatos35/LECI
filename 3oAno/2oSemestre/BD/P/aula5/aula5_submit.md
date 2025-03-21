# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
π Fname,Minit,Lname,Ssn (
	employee
	⨝ Ssn = Essn works_on
	⨝ Pno = Pnumber project
)
```


### *b)* 

```
π Fname,Minit,Lname (
	employee
	⨝ Super_ssn = Boss.Ssn (
		ρ Boss (π Ssn σ Fname = 'Carlos' ∧ Minit = 'D' ∧ Lname = 'Gomes' employee)
	)
)
```


### *c)* 

```
γ Pname; totalHousr <- Sum(Hours) (
	project
	⨝ Pnumber = Pno works_on
	)
```


### *d)* 

```
π Fname,Minit,Lname,Ssn,Hours,Dno
	σ Dno = 3 ∧ Hours > 20 ∧ Pname = 'Aveiro Digital' (
	employee
	⨝ Ssn = Essn works_on
	⨝ Pno = Pnumber project
)
```


### *e)* 

```
π Fname,Lname 
	σ Essn = null (
	employee
	⟗ Ssn = Essn works_on
)
```


### *f)* 

```
... Write here your answer ...
```


### *g)* 

```
... Write here your answer ...
```


### *h)* 

```
... Write here your answer ...
```


### *i)* 

```
... Write here your answer ...
```


## ​Problema 5.2

### *a)*

```
... Write here your answer ...
```

### *b)* 

```
... Write here your answer ...
```


### *c)* 

```
... Write here your answer ...
```


### *d)* 

```
... Write here your answer ...
```


## ​Problema 5.3

### *a)*

```
... Write here your answer ...
```

### *b)* 

```
... Write here your answer ...
```


### *c)* 

```
... Write here your answer ...
```


### *d)* 

```
... Write here your answer ...
```

### *e)* 

```
... Write here your answer ...
```

### *f)* 

```
... Write here your answer ...
```
