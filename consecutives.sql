drop table atable;
CREATE table atable (
    id_set INT,
    number INT,
    status VARCHAR(8)
)
;
	
INSERT INTO atable
	(id_set, number, status)
VALUES
	(1, 000002, 'FREE'),
	(1, 000003, 'ASSIGNED'),
	(1, 000004, 'FREE'),
	(1, 000005, 'FREE'),
	(1, 000006, 'ASSIGNED'),
	(1, 000007, 'ASSIGNED'),
	(1, 000008, 'FREE'),
	(1, 000009, 'FREE'),
	(1, 000010, 'FREE'),
	(1, 000011, 'ASSIGNED'),
	(1, 000012, 'ASSIGNED'),
	(1, 000013, 'ASSIGNED'),
	(1, 000014, 'FREE'),
	(1, 000015, 'ASSIGNED'),
	(1, 000016, 'FREE'),
	(1, 000017, 'FREE'),
	(1, 000018, 'FREE'),
	(1, 000019, 'FREE'),
	(2, 000015, 'ASSIGNED'),
	(2, 000016, 'FREE'),
	(2, 000017, 'FREE'),
	(2, 000018, 'FREE'),
	(2, 000019, 'FREE')
;

 
WITH partitioned AS (
  SELECT
    *,
    number - ROW_NUMBER() OVER (PARTITION BY id_set) AS grp
  FROM atable
  WHERE status = 'FREE'
),
counted AS (
  SELECT
    *,
    COUNT(*) OVER (PARTITION BY id_set, grp) AS cnt
  FROM partitioned
)
SELECT
  id_set,
  number
FROM counted
WHERE cnt >= 3
;

