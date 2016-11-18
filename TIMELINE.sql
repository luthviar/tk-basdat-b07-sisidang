CREATE TABLE TIMELINE{
	IdTimeline	INT			NOT NULL,
	NamaEvent	VARCHAR(100)		NOT NULL,
	Tanggal		Date			NOT NULL,
	Tahun		VARCHAR(50)		NOT NULL,
	Semester	VARCHAR(100)		NOT NULL,
	PRIMARY KEY (IdTimeline),
FOREIGN KEY (Tahun) REFERENCES TERM (Tahun) ON DELETE CASCADE ON UPDATE      CASCADE,
FOREIGN KEY (Semester) REFERENCES TERM (Semester) ON DELETE CASCADE ON UPDATE      CASCADE,
}

INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('1','Kegiatan 1','10/11/2016','2014','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('2','Kegiatan 2','10/12/2016','2014','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('3','Kegiatan 3','10/13/2016','2014','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('4','Kegiatan 4','10/14/2016','2014','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('5','Kegiatan 5','10/15/2016','2015','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('6','Kegiatan 6','10/16/2016','2015','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('7','Kegiatan 7','10/17/2016','2016','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('8','Kegiatan 8','10/18/2016','2016','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('9','Kegiatan 9','10/19/2016','2016','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('10','Kegiatan 10','10/20/2016','2015','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('22','ligula in lacus','12/7/2016','2016','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('18','maecenas','11/18/2016','2016','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('13','ac','11/30/2016','2016','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('15','arcu sed augue','12/12/2016','2014','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('28','ullamcorper purus','12/23/2016','2014','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('26','leo rhoncus','12/20/2016','2015','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('24','in tempor','12/10/2016','2015','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('14','posuere nonummy','12/2/2016','2014','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('23','nulla','12/5/2016','2016','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('19','tempus','11/17/2016','2015','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('28','sit amet lobortis','11/20/2016','2016','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('15','sed','12/14/2016','2016','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('29','eu massa','11/22/2016','2014','2');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('25','eget eros','12/19/2016','2015','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('18','lacus at turpis','12/23/2016','2015','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('19','suspendisse ornare consequat','12/20/2016','2016','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('22','vel','11/19/2016','2016','3');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('25','ultrices vel','11/20/2016','2016','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('29','morbi','12/10/2016','2016','1');
INSERT INTO TIMELINE (IdTimeline,NamaEvent,Tanggal,Tahun,Semester) VALUES ('15','nascetur','12/10/2016','2014','1');
