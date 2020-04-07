use pet-theory;

CREATE TABLE appointments (
  id INT NOT NULL AUTO_INCREMENT,
  clinic_id INT NOT NULL,
  user_id INT NOT NULL,
  start_ts INT NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO appointments (clinic_id, user_id, start_ts) VALUES (1, 234, 1564668000);
INSERT INTO appointments (clinic_id, user_id, start_ts) VALUES (1, 982, 1564668000);
INSERT INTO appointments (clinic_id, user_id, start_ts) VALUES (2, 451, 1567328400);
INSERT INTO appointments (clinic_id, user_id, start_ts) VALUES (3, 701, 1569920400);

SELECT * FROM appointments;
