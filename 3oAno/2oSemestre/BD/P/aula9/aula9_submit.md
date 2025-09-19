# BD: Guião 9


## ​9.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  	| Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- 	| :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 |   0.080 	| 552        | 322       | ...        | Clustered Index Scan |            |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  | 5     |  0.00015	| 26         | 34        | ...        | Clustered Index Seek |            |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               | 15    |  0.00017	| 26         | 32        | ...        | Clustered Index Seek |            |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   | 72595 |   0.080	| 554        | 322       | ...        | Clustered Index Seek |            |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2007-06-25'                                          | 60    |   0.080	| 554        | 54        | ...        | Clustered Index Scan |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   | 15    |0.00016	| 44         | 51        | ...        | Key Lookup           |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              | 11    | 0.00017	| 26         | 45        | ProductID(startDate)  |NonClustered Index Seek|          |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              | 1107  |0.0013		| 30         | 36        | ProductID(startDate)  |NonClustered Index Seek|           |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04'            | 3     |0.0014 	| 32         | 35        | ProductID(startDate)  |NonClustered Index Seek|           |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' | 5     |0.00029  	| 33         | 33        | ProductID and startDate|NonClustered Index Seek|          |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' | 3	    |0.0002868  | 28         | 21        | ProductID and startDate|NonClustered Index Seek|			 |

## ​9.2.

### a)

ALTER TABLE mytemp
ADD CONSTRAINT PK_mytemp_rid
PRIMARY KEY CLUSTERED (rid);


### b)

Fragmentação: 98.8%
Ocupação: 69.9%

### c)


Fillfactor: 65%
61122 ms
Fillfactor: 80%
61554 ms
Fillfactor: 90%
65622 ms

### d)

Fillfactor: 65%
54100 ms
Fillfactor: 80%
54822 ms
Fillfactor: 90%
53971 ms


### e)

7591+ ms
COm mais indices, a performance piora.

## ​9.3.
i) 
CREATE UNIQUE CLUSTERED INDEX idx_ssn ON EMPLOYEE(Ssn);

ii) 
CREATE NONCLUSTERED INDEX idx_f_lname ON EMPLOYEE(Fname, Lname);

iii) 
CREATE NONCLUSTERED INDEX idx_dno ON EMPLOYEE(Dno);
CREATE UNIQUE CLUSTERED INDEX idx_dnumber ON DEPARTMENT(Dnumber);

iv)
CREATE UNIQUE CLUSTERED INDEX idx_essn_pno ON WORKS_ON(Essn, Pno);
CREATE NONCLUSTERED INDEX idx_pnum ON PROJECT(Pnumber);
CREATE NONCLUSTERED INDEX idx_pno ON WORKS_ON(Pno);
v)
CREATE UNIQUE CLUSTERED INDEX idx_essn_dname ON DEPENDENT(Essn, Dependent_name); 
CREATE NONCLUSTERED INDEX idx_dependent_essn ON DEPENDENT(Essn);                 

vi)
CREATE NONCLUSTERED INDEX idx_project_dnum ON PROJECT(Dnum);