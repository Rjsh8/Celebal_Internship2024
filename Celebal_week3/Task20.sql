use celebal_week3
CREATE  TABLE source_table (
    id INT PRIMARY KEY,
    data VARCHAR(100)
);

CREATE  TABLE destination_table (
    id INT PRIMARY KEY,
    data VARCHAR(100)
);

INSERT INTO source_table (id, data) VALUES
(1, 'data1'),
(2, 'data2'),
(3, 'data3');

INSERT INTO destination_table (id, data) VALUES
(1, 'data1');

INSERT INTO destination_table (id, data)
SELECT id, data
FROM source_table
WHERE id NOT IN (SELECT id FROM destination_table);
