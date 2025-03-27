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
γ Dname; Avg(Salary) ->AvgSalary
	(σ Sex = 'F'
		(employee
			⨝Dno= Dnumber department
		)
	)
```


### *g)* 

```
σ dependents > 2
(γ Fname,Minit,Lname, Essn; count(Essn) -> dependents
	(employee
	⨝ Ssn = Essn dependent)
)
```


### *h)* 

```
π Fname,Minit,Lname,Ssn
σ Essn=null 
	(dependent
		⟗Essn = Mgr_ssn 
		(employee
		⨝ Mgr_ssn = Ssn department)
	)
```


### *i)* 

```
π Fname,Minit,Lname, Address,Dlocation,Plocation ( 
	σ Plocation = 'Aveiro' ∧ Dlocation ≠ 'Aveiro' (
		employee
		⨝Dno=Dnumber department
		⨝Dnumber=Dnum project
		⨝department.Dnumber = dept_location.Dnumber dept_location
	)
)
```


## ​Problema 5.2

### *a)*

```
σ numero = null
(fornecedor
⟗ nif = fornecedor encomenda)
```

### *b)* 

```
γ nome; Avg(item.unidades) -> AvgEncom (
	item
	⨝ codProd = codigo produto
)
```


### *c)* 

```
γ; avg(unitsByEnc) -> media_produtos_por_encomenda (γ numero; COUNT(codProd) -> unitsByEnc 
	(
	encomenda
	⨝numero=numEnc item
	)
)
```


### *d)* 

```
γ fornecedor.nome, produto.nome; sum(item.unidades) -> provided_units
(
produto
⨝ codigo=item.codProd

(fornecedor
⨝ fornecedor.nif = encomenda.fornecedor

(encomenda
	⨝ numero = numEnc item)
	)
)
```


## ​Problema 5.3

### *a)*

```
π nome,paciente.numUtente,dataNasc,endereco
σ numPresc = null (
	paciente ⟗ prescricao)
```

### *b)* 

```
γ especialidade; count(numPresc) -> numPrescicoes
	(medico
	⨝ numSNS = numMedico prescricao)
```


### *c)* 

```
γ farmacia.nome; count(numPresc) -> numPrescicoes
	(prescricao
	⨝ farmacia = nome farmacia)
```


### *d)* 

```
π nomeFarmaco,numRegFarm,presc_farmaco.numPresc,dataProc
σ numReg = 906 ∧ dataProc = null (
	farmaceutica
	⟗ numReg = numRegFarm presc_farmaco
	⟗ prescricao)
```

### *e)* 

```
γ farmacia.nome,farmaceutica.nome; count(numPresc) -> numFarmacosV (
	farmacia 
	⨝ nome = farmacia prescricao
	⨝ presc_farmaco
	⨝ numRegFarm = numReg farmaceutica
	)
```

### *f)* 

```
σ numMedicosDif > 1
γ paciente.nome,numUtente; count(numSNS) -> numMedicosDif (
	paciente
	⨝ prescricao
	⨝ numMedico = numSNS medico
	)
```
