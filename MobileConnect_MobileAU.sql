SELECT
	a.Id,
	'Contact' AS ObjectType,
	CASE
		WHEN REPLACE(REPLACE(REPLACE(COALESCE(a.MobilePhone,a.Phone),'+',''),' ',''),'-','') LIKE ('614[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
		THEN REPLACE(REPLACE(REPLACE(COALESCE(a.MobilePhone,a.Phone),'+',''),' ',''),'-','')
		WHEN REPLACE(REPLACE(REPLACE(COALESCE(a.MobilePhone,a.Phone),'+',''),' ',''),'-','') LIKE ('04[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
		THEN '61' + SUBSTRING(REPLACE(REPLACE(REPLACE(COALESCE(a.MobilePhone,a.Phone),'+',''),' ',''),'-',''),2,9)
	END AS MobilePhone,
	CASE
		WHEN 	REPLACE(REPLACE(REPLACE(COALESCE(a.MobilePhone,a.Phone),'+',''),' ',''),'-','') LIKE ('614[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') or
				REPLACE(REPLACE(REPLACE(COALESCE(a.MobilePhone,a.Phone),'+',''),' ',''),'-','') LIKE ('04[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
		THEN 'AU'
	END AS Locale,
	CAST(a.FirstName AS VARCHAR(50)) AS FirstName,
	CAST(a.LastName AS VARCHAR(80)) AS LastName,
	CAST(a.MailingPostalCode AS VARCHAR(50)) AS PostCode,
	CAST(a.MailingState AS VARCHAR(50)) AS State,
	a.Id AS ContactKey
FROM
	ContactsSF a WITH (NOLOCK)
WHERE
	REPLACE(REPLACE(REPLACE(COALESCE(a.MobilePhone,a.Phone),'+',''),' ',''),'-','') LIKE ('614[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') OR
	REPLACE(REPLACE(REPLACE(COALESCE(a.MobilePhone,a.Phone),'+',''),' ',''),'-','') LIKE ('04[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')