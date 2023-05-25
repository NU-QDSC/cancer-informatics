DECLARE @min_age as INT = 21
DECLARE @proc_codes TABLE (list varchar(10)) 
INSERT into @proc_codes
VALUES 
 ('G0123')
,('G0143')
,('G0144')
,('G0145')
,('G0147')
,('G0148')
,('G0476')
,('P3000')
,('G0124')
,('G0141')
,('Q0091')
,('G0101')

--HIV screening (procedure codes can only be found in [NM_BI].[fact].[vw_procedure_order] and for some reason not in vw_coded_procedure)
SELECT count(distinct p.ir_id) [Screened Eligible Patients]
	   , 
			(
				select count(distinct p1.ir_id) 
				from [NM_BI].[dim].[vw_patient] p1 
				where p1.is_alive = 1 
					  and 
					  p1.age >= @min_age
			) [Eligible Patients] 
FROM [NM_BI].[dim].[vw_patient] p
WHERE 
	p.is_alive = 1 
	and 
	p.age >= @min_age
	and
	EXISTS
			(
				SELECT vcp.patient_key
				FROM [NM_BI].[fact].[vw_coded_procedure] vcp
					join [NM_BI].[dim].[vw_procedure] pro  
						on pro.procedure_key = vcp.procedure_key
							and 
							pro.procedure_code in 
								(
									SELECT *
									FROM @proc_codes
								)
				WHERE vcp.patient_key = p.patient_key --If these procedures could be found in [NM_BI].[fact].[vw_coded_procedure] then we would need a union with a very similar query to look at that view as well
			)

--CRC screening (procedure codes can only be found in [NM_BI].[fact].[vw_procedure_order] and for some reason not in vw_coded_procedure)
SET @min_age = 45
DELETE FROM @proc_codes
INSERT into @proc_codes
VALUES 
('G0105')
,('G0121')
,('G0104')
,('G0121')
,('G0106')
,('G0120')
,('G0122')
,('G0327')
 
 SELECT count(distinct p.ir_id) [Screened Eligible Patients]
	   , 
			(
				select count(distinct p1.ir_id) 
				from [NM_BI].[dim].[vw_patient] p1 
				where p1.is_alive = 1 
					  and 
					  p1.age >= @min_age
			) [Eligible Patients] 
FROM [NM_BI].[dim].[vw_patient] p
WHERE 
	p.is_alive = 1 
	and 
	p.age >= @min_age
	and
	EXISTS
			(
				SELECT vcp.patient_key
				FROM [NM_BI].[fact].[vw_coded_procedure] vcp
					join [NM_BI].[dim].[vw_procedure] pro  
						on pro.procedure_key = vcp.procedure_key
							and 
							pro.procedure_code in 
								(
									SELECT *
									FROM @proc_codes
								)
				WHERE vcp.patient_key = p.patient_key --If these procedures could be found in [NM_BI].[fact].[vw_coded_procedure] then we would need a union with a very similar query to look at that view as well
			)

--Prostate Cancer  (procedure codes can only be found in [NM_BI].[fact].[vw_procedure_order] and for some reason not in vw_coded_procedure)
SET @min_age = 40
DELETE FROM @proc_codes
INSERT into @proc_codes
VALUES 
('G0102')
,('G0103')
 
 SELECT count(distinct p.ir_id) [Screened Eligible Patients]
	   , 
			(
				select count(distinct p1.ir_id) 
				from [NM_BI].[dim].[vw_patient] p1 
				where p1.is_alive = 1 
					  and 
					  p1.age >= @min_age
			) [Eligible Patients] 
FROM [NM_BI].[dim].[vw_patient] p
WHERE 
	p.is_alive = 1 
	and 
	p.age >= @min_age
	and
	EXISTS
			(
				SELECT vcp.patient_key
				FROM [NM_BI].[fact].[vw_coded_procedure] vcp
					join [NM_BI].[dim].[vw_procedure] pro  
						on pro.procedure_key = vcp.procedure_key
							and 
							pro.procedure_code in 
								(
									SELECT *
									FROM @proc_codes
								)
				WHERE vcp.patient_key = p.patient_key --If these procedures could be found in [NM_BI].[fact].[vw_coded_procedure] then we would need a union with a very similar query to look at that view as well
			)

--Breast
SET @min_age = 40
DELETE FROM @proc_codes
INSERT into @proc_codes
VALUES 
 ('19030')
,('76641')
,('76642')
,('77046')
,('77047')
,('77048')
,('77049')
,('77053')
,('77054')
,('77063')
,('77065')
,('77066')
,('77067')
,('C8903')
,('C8905')
,('C8906')
,('C8908')
,('G0279')


 SELECT count(distinct p.ir_id) [Screened Eligible Patients]
	   , 
			(
				select count(distinct p1.ir_id) 
				from [NM_BI].[dim].[vw_patient] p1 
				where p1.is_alive = 1 
					  and 
					  p1.age >= @min_age
			) [Eligible Patients] 
FROM [NM_BI].[dim].[vw_patient] p
WHERE 
	p.is_alive = 1 
	and 
	p.age >= @min_age
	and
	EXISTS
			(
				SELECT vcp.patient_key
				FROM [NM_BI].[fact].[vw_coded_procedure] vcp
					join [NM_BI].[dim].[vw_procedure] pro  
						on pro.procedure_key = vcp.procedure_key
							and 
							pro.procedure_code in 
								(
									SELECT *
									FROM @proc_codes
								)
				WHERE vcp.patient_key = p.patient_key
			)