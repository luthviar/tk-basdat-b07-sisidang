--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: si_sidang; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA si_sidang;


ALTER SCHEMA si_sidang OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

--
-- Name: update_invoice(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_invoice() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        frekuensi INTEGER;
    BEGIN  	    
	    SELECT COUNT(*),IdTamu 
	    FROM INVOICE 
	    GROUP BY IdTamu 
	    HAVING COUNT(*) > 9;
    	UPDATE 	INVOICE SET Discount = 10
		WHERE 	IdTamu = 10;        
		UPDATE	INVOICE SET TOTAL = Discount*Total;
     END;
$$;


ALTER FUNCTION public.update_invoice() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE book (
    book_id character(14) NOT NULL,
    tittle character varying(100) NOT NULL
);


ALTER TABLE book OWNER TO postgres;

--
-- Name: book_copies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE book_copies (
    book_id character(14) NOT NULL,
    branch_id character(2) NOT NULL,
    no_of_copies integer NOT NULL
);


ALTER TABLE book_copies OWNER TO postgres;

--
-- Name: book_loans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE book_loans (
    book_id character(14) NOT NULL,
    branch_id character(2) NOT NULL,
    card_no character(6) NOT NULL,
    date_out date NOT NULL,
    due_date date NOT NULL
);


ALTER TABLE book_loans OWNER TO postgres;

--
-- Name: borrower; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE borrower (
    card_no character(6) NOT NULL,
    name character varying(30) NOT NULL,
    address character varying(100) NOT NULL,
    phone character(12) NOT NULL
);


ALTER TABLE borrower OWNER TO postgres;

--
-- Name: library_branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE library_branch (
    branch_id character(2) NOT NULL,
    branch_name character varying(50) NOT NULL,
    address character varying(100) NOT NULL
);


ALTER TABLE library_branch OWNER TO postgres;

SET search_path = si_sidang, pg_catalog;

--
-- Name: berkas; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE berkas (
    idberkas integer,
    idmks integer,
    nama character varying(50),
    alamat character varying(50)
);


ALTER TABLE berkas OWNER TO postgres;

--
-- Name: dosen; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE dosen (
    nip character varying(20) NOT NULL,
    nama character varying(100) NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    institusi character varying(100) NOT NULL
);


ALTER TABLE dosen OWNER TO postgres;

--
-- Name: dosen_pembimbing; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE dosen_pembimbing (
    idmks integer NOT NULL,
    nipdosenpembimbing character varying(20) NOT NULL
);


ALTER TABLE dosen_pembimbing OWNER TO postgres;

--
-- Name: dosen_penguji; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE dosen_penguji (
    idmks integer NOT NULL,
    nipdosenpenguji character varying(20) NOT NULL
);


ALTER TABLE dosen_penguji OWNER TO postgres;

--
-- Name: jadwal_non_sidang; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE jadwal_non_sidang (
    idjadwal integer,
    tanggalmulai date,
    tanggalselesai date,
    alasan character varying(50),
    repetisi character varying(8),
    nipdosen integer
);


ALTER TABLE jadwal_non_sidang OWNER TO postgres;

--
-- Name: jadwal_sidang; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE jadwal_sidang (
    idjadwal integer,
    idmks integer,
    tanggal date,
    jammulai character varying(50),
    jamselesai character varying(50),
    idruangan integer
);


ALTER TABLE jadwal_sidang OWNER TO postgres;

--
-- Name: jenis_mks; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE jenis_mks (
    id integer NOT NULL,
    namamks character varying(50) NOT NULL
);


ALTER TABLE jenis_mks OWNER TO postgres;

--
-- Name: mahasiswa; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE mahasiswa (
    npm character(10) NOT NULL,
    nama character varying(100) NOT NULL,
    username character varying(30) NOT NULL,
    password character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    email_alternatif character varying(100),
    telepon character varying(100),
    notelp character varying(100)
);


ALTER TABLE mahasiswa OWNER TO postgres;

--
-- Name: mata_kuliah_spesial; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE mata_kuliah_spesial (
    idmks integer NOT NULL,
    npm character(10) NOT NULL,
    tahun integer NOT NULL,
    semester integer NOT NULL,
    judul character varying(250) NOT NULL,
    issiapsidang boolean DEFAULT false,
    pengumpulanhardcopy boolean DEFAULT false,
    ijinmajusidang boolean DEFAULT false,
    idjenismks integer NOT NULL
);


ALTER TABLE mata_kuliah_spesial OWNER TO postgres;

--
-- Name: prodi; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE prodi (
    id integer NOT NULL,
    namaprodi character varying(50) NOT NULL
);


ALTER TABLE prodi OWNER TO postgres;

--
-- Name: ruangan; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE ruangan (
    idruangan integer,
    nama character varying(50)
);


ALTER TABLE ruangan OWNER TO postgres;

--
-- Name: saran_dosen_penguji; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE saran_dosen_penguji (
    idmks integer NOT NULL,
    nipsaranpenguji character varying(20) NOT NULL
);


ALTER TABLE saran_dosen_penguji OWNER TO postgres;

--
-- Name: term; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE term (
    tahun integer NOT NULL,
    semester integer NOT NULL
);


ALTER TABLE term OWNER TO postgres;

--
-- Name: timeline; Type: TABLE; Schema: si_sidang; Owner: postgres
--

CREATE TABLE timeline (
    idtimeline integer NOT NULL,
    namaevent character varying(100) NOT NULL,
    tanggal date NOT NULL,
    tahun integer NOT NULL,
    semester integer NOT NULL
);


ALTER TABLE timeline OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY book (book_id, tittle) FROM stdin;
01-15-00988136	Telecommunicatins Crash Course
01-10-04010867	Psychology: The Science of Mind and Behaviour
01-10-09014359	Engineering Mathematics
01-15-00813001	Nasionalisme, Laut, dan Sejarah
01-10-07087832	Analisa Penyakit Gigi dan Mulut
01-15-00974331	Introduction to Logistics Systems Management
01-15-00341663	Essentials of Accounting for Governmental and Not-for-Profit Organizations
01-14-29260443	Legal and Ethical Issues for Health Professionals
01-15-01412122	Mathematical Methods in the Physical Sciences
01-14-30896881	Pengantar Akuntansi : Konsep dan Teknik Penyusunan Laporan Keuangan
\.


--
-- Data for Name: book_copies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY book_copies (book_id, branch_id, no_of_copies) FROM stdin;
01-15-00988136	03	5
01-10-04010867	08	3
01-10-09014359	10	4
01-10-09014359	02	2
01-15-00813001	01	2
01-15-00813001	04	3
01-15-00813001	09	2
01-10-07087832	03	3
01-10-07087832	08	3
01-15-00974331	06	4
01-15-00974331	07	2
01-15-00974331	03	1
01-15-00341663	06	4
01-15-00341663	04	1
01-14-29260443	05	3
01-14-29260443	07	2
01-15-01412122	10	3
01-15-01412122	05	3
01-14-30896881	07	5
01-14-30896881	02	2
\.


--
-- Data for Name: book_loans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY book_loans (book_id, branch_id, card_no, date_out, due_date) FROM stdin;
01-15-00988136	03	444555	2013-02-20	2013-02-27
01-10-04010867	08	333444	2013-01-15	2013-02-17
01-10-09014359	10	222333	2012-07-14	2012-07-16
01-10-09014359	02	111222	2012-05-26	2012-06-05
01-15-00813001	04	444555	2014-12-01	2014-12-06
01-10-07087832	03	555666	2013-04-16	2013-07-12
01-10-07087832	08	333444	2014-03-18	2014-03-20
01-15-00341663	06	666777	2015-02-10	2015-02-13
01-14-29260443	05	234234	2014-11-16	2014-11-20
01-15-01412122	10	234234	2014-11-15	2014-11-20
\.


--
-- Data for Name: borrower; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY borrower (card_no, name, address, phone) FROM stdin;
111222	Kirana Rahmawati	Jln Lumut Hijau 311/L, Mega Cinere, Depok 1651	0218313501  
222333	Ana Septiana	Jl. Bango III no.4, Pondok Labu, Cilandak, Jakarta 12450	0217661201  
333444	Erwin	Jl. Lembur Tengah no.14A, Desa Sariwangi, Kec.Parongpong, Bandung	0217450422  
444555	Ibrahim Ahmad	Jl. Gelatik 3 / V2 no.4-5, Bintaro Jaya Sektor 2, Jakarta 12320	0217589635  
555666	Laras Tsurayya	Jl. Raya Gandul no.19, Gandul, Sawangan, Depok	0218479477  
666777	Hendriawan	Jl. Pondasi no.62, Rawamangun, Jakarta 13210	0222017932  
888999	Dedi Purwanto	Arinda Permai 1 Blok G no. 16, Pondok Aren, Tangerang 15224	021846390   
123123	Chandra Gunawan J	Jl Belibis Blok A1 no. 2A, Pinang Griya, Ciledug, Jakarta 15145	0218844686  
234234	Nita Karina 	Jln Tebet Timur Dalam 3M no. 16, Jakarta 12820	0218844686  
456456	Budi Mulyanto	Jln. Gondangdia Blok FA1/10, Bintaro Jaya Sektor 7, Jakarta 15224	0217365114  
\.


--
-- Data for Name: library_branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY library_branch (branch_id, branch_name, address) FROM stdin;
01	Fakultas Kedokteran	UI Depok, Jawa Barat Fakultas 01
02	Fakultas Kedokteran Gigi	UI Depok, Jawa Barat Fakultas 02
03	Fakultas Matematika dan Ilmu Pengetahuan Alam	UI Depok, Jawa Barat Fakultas 03
04	Fakultas Hukum	UI Depok, Jawa Barat Fakultas 04
05	Fakultas Ilmu Pengetahuan dan Budaya	UI Depok, Jawa Barat Fakultas 05
06	Fakultas Ekonomi	UI Depok, Jawa Barat Fakultas 06
07	Fakultas Psikologi	UI Depok, Jawa Barat Fakultas 07
08	Fakultas Teknik	UI Depok, Jawa Barat Fakultas 08
09	Fakultas Kesehatan Masyarakat	UI Depok, Jawa Barat Fakultas 09
10	Fakultas Ilmu Sosial dan Ilmu Politik	UI Depok, Jawa Barat Fakultas 10
\.


SET search_path = si_sidang, pg_catalog;

--
-- Data for Name: berkas; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY berkas (idberkas, idmks, nama, alamat) FROM stdin;
300001	19181	Rahasia Kutu	Jl. Mawar
300002	19182	Kisah kasih di UI	Jl. Teratai
300003	19183	Ayam dan Itik	Jl. Bangau
300004	19184	Rahasia Alam	Jl. Gurame
300005	19185	Bismillah	Jl. Patin
300006	19186	Jessica Sianida	Jl. Hiu
300007	19187	Hoverboard 2016	Jl. Kopi
300008	19188	Sepatu Ajaib	Jl. TehKopi
300009	19189	Tikar Ajaib	Jl. Kipas
300010	19190	Aladdin dan Abu	Jl. Angsa
300011	19191	Tas Mahal Dari Korea	Jl. Onta
300012	19192	Roti Kukusan	Jl. Air
300013	19193	Roti Buaya	Jl. Lampu
300014	19194	Nasi Goreng Indonesia	Jl. Kabel
300015	19195	Ensiklopedi UI	Jl. Internet
300016	19196	Mamalia I	Jl. Sudirman
300017	19197	Kreativitas	Jl. Nasional
300018	19198	Kinerja	Jl. Suara
300019	19199	Produktivitas	Jl. Medan
300020	19200	Ensiklopedi Kesehatan	Jl. Surabaya
300021	19201	Accounting Principles	Jl. Kertas
300022	19202	Advertising	Jl. Tisu
300023	19203	Budgetary Control	Jl. Kapas
300024	19204	Business Organization	Jl. Kantin
300025	19205	Cost Control	Jl. Pulpen
300026	19206	Kepemimpinan	Jl. Paus
300027	19207	Memotivasi Pegawai	Jl. LumbaLumba
300028	19208	Memimpin Manusia	Jl. Tas
300029	19209	The American Heritage	Jl. Handphone
300030	19210	Business and The Man	Jl. Charger
300031	19211	PLATO	Jl. Buku
300032	19212	The Core Package	Jl. Notes
300033	19213	JAVA	Jl. Botol
300034	19214	Software Engineering	Jl. Laptop
300035	19215	Database and Relation	Jl. Headset
300036	19216	Mamalia II	Jl. Pensil
300037	19217	Mamalia III	Jl. Kuas
300038	19218	Corporation Finance	Jl. Penghapus
300039	19219	Mengelola Wisata	Jl. Penggaris
300040	19220	Ensiklopedi Bahasa	Jl. Busur
300041	19221	Ensiklopedi Amerika	Jl. Jangkar
300042	19222	Ensiklopedi Anak	Jl. Kapal
300043	19223	Directory of Computer	Jl. Gembok
300044	19224	Teletechniques	Jl. Kunci
300045	19225	Teams-Games-Tournament	Jl. Marimas
300046	19226	SPARK	Jl. Sirup
300047	19227	DreamSpark	Jl. Marimaju
300048	19228	Lompat Tinggi	Jl. Nutrisi
300049	19229	Kuliah Pagi dan Ngantuk	Jl. Selai
300050	19230	Dosen dan Mahasiswa	Jl. Aloe
300051	19241	Konklab	09 Doe Crossing Crossing
300052	19232	Tres-Zap	6448 Golden Leaf Place
300053	19206	Voltsillam	2 Shopko Trail
300054	19223	Voyatouch	99356 Dovetail Hill
300055	19190	Y-Solowarm	9 Declaration Lane
300056	19230	It	6 Oxford Lane
300057	19186	Tin	07 Bowman Drive
300058	19246	Greenlam	657 Anzinger Center
300059	19184	Cardguard	64 Fremont Pass
300060	19196	Pannier	13279 Sage Circle
300061	19202	Bytecard	3 Menomonie Alley
300062	19207	Flowdesk	3 Fulton Parkway
300063	19245	Zamit	17673 Jana Drive
300064	19210	Home Ing	3 Brown Road
300065	19255	Treeflex	369 Glacier Hill Circle
300066	19253	Redhold	2 Evergreen Way
300067	19233	Tin	563 Mendota Point
300068	19199	Cardguard	30 Thierer Trail
300069	19198	Voltsillam	624 Chinook Avenue
300070	19222	Voltsillam	466 Anderson Place
300071	19206	Voltsillam	1 Emmet Road
300072	19232	Otcom	0 Dexter Road
300073	19213	Home Ing	680 Fallview Street
300074	19223	Fix San	219 Village Green Way
300075	19184	Fintone	37 Beilfuss Terrace
300076	19188	Veribet	0 Springview Parkway
300077	19227	Bigtax	27186 Fair Oaks Park
300078	19207	Zontrax	61793 Bartelt Center
300079	19243	Zamit	54 Heath Crossing
300080	19231	Fix San	16 David Park
300081	19245	Solarbreeze	1661 Jenifer Plaza
300082	19194	Tempsoft	719 Namekagon Hill
300083	19247	Opela	3 Barby Terrace
300084	19244	Opela	0986 Kipling Plaza
300085	19205	It	5496 Ridgeview Pass
300086	19258	Fix San	874 Randy Hill
300087	19198	Rank	3 3rd Crossing
300088	19212	Andalax	186 Buhler Road
300089	19208	Fintone	5 Sunbrook Drive
300090	19191	Pannier	8 Acker Circle
300091	19236	Toughjoyfax	43389 Kropf Street
300092	19234	Alpha	61 Laurel Court
300093	19210	Zaam-Dox	2 Loomis Alley
300094	19186	Stim	36 Mariners Cove Parkway
300095	19233	Biodex	99803 Oak Center
300096	19235	Bigtax	861 Hudson Junction
300097	19253	Zathin	0 Reindahl Pass
300098	19222	Hatity	83 Canary Place
300099	19188	Stronghold	7 Monterey Road
300100	19186	Veribet	56 Forest Run Terrace
300101	19204	Redhold	275 Forest Drive
300102	19218	Flowdesk	3 Oneill Pass
300103	19194	Bytecard	7068 Service Plaza
300104	19236	Tin	909 Homewood Avenue
300105	19197	Quo Lux	99344 Grayhawk Junction
300106	19211	Lotstring	264 Morning Drive
300107	19254	Opela	950 Delaware Place
300108	19255	Trippledex	527 Moose Pass
300109	19192	Toughjoyfax	6913 Scott Avenue
300110	19255	Namfix	83739 Tennessee Lane
300111	19256	Stim	81818 Grayhawk Plaza
300112	19251	Duobam	0978 Knutson Alley
300113	19212	Voltsillam	897 Bonner Drive
300114	19181	Y-find	1149 Dennis Alley
300115	19257	Stringtough	3644 Dapin Hill
300116	19219	Ronstring	81 Schurz Crossing
300117	19216	Zontrax	347 Thackeray Pass
300118	19240	Namfix	4623 Eastlawn Circle
300119	19205	Fixflex	10600 Bultman Hill
300120	19224	Alphazap	65126 Ohio Plaza
300121	19185	Aerified	63128 Colorado Hill
300122	19199	Wrapsafe	74 Sunbrook Parkway
300123	19256	Cookley	0066 Nelson Park
300124	19206	Zaam-Dox	515 Old Gate Drive
300125	19203	Konklux	75 Lunder Court
300126	19248	It	09 Debs Plaza
300127	19212	Temp	71 Summerview Junction
300128	19245	Zamit	6 Rieder Avenue
300129	19237	Alpha	25697 Stone Corner Junction
300130	19225	Bamity	6115 Ruskin Drive
300131	19195	Zathin	085 Mcbride Drive
300132	19220	Tampflex	837 Arrowood Avenue
300133	19232	Voltsillam	08663 Lunder Drive
300134	19235	Biodex	33852 Ryan Plaza
300135	19224	Treeflex	2 Kenwood Center
300136	19205	Hatity	595 Sugar Park
300137	19226	Zontrax	484 Fairfield Street
300138	19197	Zamit	1 Anzinger Pass
300139	19252	Matsoft	0 Erie Terrace
300140	19253	Y-Solowarm	746 Starling Way
300141	19250	Redhold	40245 Old Gate Center
300142	19239	Tempsoft	001 Graedel Center
300143	19209	Tres-Zap	3747 Milwaukee Parkway
300144	19199	Flexidy	448 Mesta Lane
300145	19208	Holdlamis	3 Blackbird Alley
300146	19228	Gembucket	6 Main Pass
300147	19195	Cookley	1237 Farragut Alley
300148	19186	Redhold	9811 Dwight Crossing
300149	19201	Bamity	32496 High Crossing Street
300150	19202	Vagram	61 Hooker Drive
\.


--
-- Data for Name: dosen; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY dosen (nip, nama, username, password, email, institusi) FROM stdin;
1000000000	Dosen1	dosen1	pwddsn1	dosen1@institusi.com	UI
1000000001	Dosen2	dosen2	pwddsn2	dosen2@institusi.com	ITB
1000000002	Dosen3	dosen3	pwddsn3	dosen3@institusi.com	ITS
1000000003	Dosen4	dosen4	pwddsn4	dosen4@institusi.com	UI
1000000004	Dosen5	dosen5	pwddsn5	dosen5@institusi.com	ITB
1000000005	Dosen6	dosen6	pwddsn6	dosen6@institusi.com	ITS
1000000006	Dosen7	dosen7	pwddsn7	dosen7@institusi.com	UMN
1000000007	Dosen8	dosen8	pwddsn8	dosen8@institusi.com	LSPR
1000000008	Dosen9	dosen9	pwddsn9	dosen9@institusi.com	UMN
1000000009	Dosen10	dosen10	pwddsn10	dosen10@institusi.com	ITB
1000000010	Dosen11	dosen11	pwddsn11	dosen11@institusi.com	UI
1000000011	Dosen12	dosen12	pwddsn12	dosen12@institusi.com	UI
1000000012	Dosen13	dosen13	pwddsn13	dosen13@institusi.com	UI
1000000013	Dosen14	dosen14	pwddsn14	dosen14@institusi.com	UT
1000000014	Dosen15	dosen15	pwddsn15	dosen15@institusi.com	UKI
1000000015	Dosen16	dosen16	pwddsn16	dosen16@institusi.com	UPI
1000000016	Dosen17	dosen17	pwddsn17	dosen17@institusi.com	ITB
1000000017	Dosen18	dosen18	pwddsn18	dosen18@institusi.com	UPI
1000000018	Dosen19	dosen19	pwddsn19	dosen19@institusi.com	UNS
1000000019	Dosen20	dosen20	pwddsn20	dosen20@institusi.com	UNS
1000000020	Dosen21	dosen21	pwddsn21	dosen21@institusi.com	ITB
7942803747	Brian Hansen	rmbnaidgys	fce9a553aaeeada01282d6bf44589e50	brian hansen@institusi.com	ISS
1284824200	Edward Morales	mfgvjckaon	4bb870187d8db3669421da97e277ec46	edward morales@institusi.com	USS
4702364532	Louis Burton	gczbhojdke	5e5854fbfc75975b5719996e886ebf5d	louis burton@institusi.com	IST
2069875058	Tina Roberts	ckryqpmgfz	0f7b796f2d6f8228d3d0509b81948ebc	tina roberts@institusi.com	ISN
2693451744	Carl Henderson	ohdfspvbuk	0b35476c3ecb75b5e2e72c077a2a1bad	carl henderson@institusi.com	ISN
8718107628	Anne Hunter	kyuecjsbag	bf9f28cf41a16da59d2d16c934c30103	anne hunter@institusi.com	IMB
9193211527	Chris Ray	yhocbnsgru	38b42c50d803dd20e0db0ca06b00babd	chris ray@institusi.com	USS
9939807645	Scott Freeman	lcrebdihok	615ebfa35dada34c524ae7075929ed5c	scott freeman@institusi.com	UBB
4351838817	Juan Morrison	tlscqjopek	c0be5c8709fd940681bbcc0a6347bc13	juan morrison@institusi.com	UMN
7182714876	Phillip Williams	zrujbpaewg	3205ce0dc6f467a0a9adea33015fd78e	phillip williams@institusi.com	UBS
7139210127	Lawrence Kelley	kcdovpxwem	fc3bd3911c0bdad8071e5fdc41daedad	lawrence kelley@institusi.com	ISB
7513670864	Karen Murray	myklvrdctp	ea8451059d9bad4ac085f466c006d874	karen murray@institusi.com	UST
7338612729	Jennifer Willis	cmkiqxvyjz	5c319fcd0178349c0f4c1a60add713ff	jennifer willis@institusi.com	ISS
1101336174	Denise Kim	iwejbnlkfx	53144de90ce5686d12842fb9cb6eb617	denise kim@institusi.com	ISS
1542082751	Melissa Gardner	zwgmynutbr	85507df896de4aaeb1c0511a4b0fa13a	melissa gardner@institusi.com	ITS
1003460248	Bobby Medina	kmrqjhszid	51108650e0ce929bff6c62a9d57474e2	bobby medina@institusi.com	INS
6077450977	Ann Hicks	sxqgeayvrc	8c1be9f27a611ea4ed33ca022a7100ac	ann hicks@institusi.com	UBS
3562175951	Harold Black	ortpbqwinx	ad624ce95c90306a09e79e178549a122	harold black@institusi.com	IST
9324024215	Billy Robertson	biusrvmdew	34c8b3d80f7717a148bc378d91fa5ff6	billy robertson@institusi.com	USS
8899898690	Ruth Butler	tgqoeripxz	e93bedcf1e79614c6f7ac47f6a6d5a6b	ruth butler@institusi.com	INT
2217882138	Nancy Hudson	dnitrujeqv	5ba0d6be027c885ecfc59aca89858ea8	nancy hudson@institusi.com	IBS
9597677891	Rebecca Willis	hxjcnakbuw	5cdf9f5432cdf0b5479ddb74afbd885d	rebecca willis@institusi.com	UNT
8292941288	Ruby Williams	zdgcniqbve	13cd4dd6bab0e73435ef53a3a263c747	ruby williams@institusi.com	ITN
8387929683	Martha Brooks	jgpovkfwbc	11a9d87ab9ac3fb1049616962aef3205	martha brooks@institusi.com	UBS
4736547180	Chris King	qfdiucjslk	4fa002c8d49b5c2042d0e9b397da34eb	chris king@institusi.com	ITS
2010341207	Harry Hawkins	nzosvrbklw	80b295ad7fc991ad584e6d72a6b85abf	harry hawkins@institusi.com	USB
7695185004	Christina Stevens	kybrlictnz	8e27de82e848dd32d38acad20bb17163	christina stevens@institusi.com	USS
3538176582	Matthew Jones	bhcpvdmwgi	5b55c71223c2df77abed00d2688470da	matthew jones@institusi.com	UBS
8544431437	Anne Bell	gbsqrkixut	9de665eae96c8b880eabe201ca0e5249	anne bell@institusi.com	USN
5407737578	Bruce Washington	ovdxcgbjnt	48b8da5ed7b8379a912f3ec096f1c14d	bruce washington@institusi.com	USS
\.


--
-- Data for Name: dosen_pembimbing; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY dosen_pembimbing (idmks, nipdosenpembimbing) FROM stdin;
19181	7942803747
19183	4702364532
19184	2069875058
19185	2693451744
19186	8718107628
19187	9193211527
19188	9939807645
19189	4351838817
19191	7139210127
19192	7513670864
19193	7338612729
19194	1101336174
19195	1542082751
19196	1003460248
19197	6077450977
19198	3562175951
19199	9324024215
19200	8899898690
19201	2217882138
19202	9597677891
19203	8292941288
19204	8387929683
19205	4736547180
19206	2010341207
19207	7695185004
19208	3538176582
19209	8544431437
19210	5407737578
19211	8292941288
19212	8387929683
19213	4736547180
19214	2010341207
19215	7695185004
19216	3538176582
19217	8544431437
19218	5407737578
19219	5407737578
19220	8292941288
19221	8387929683
19222	4736547180
19223	7942803747
19225	4702364532
19226	2069875058
19227	2693451744
19228	8718107628
19229	9193211527
19230	9939807645
19231	4351838817
19233	7139210127
19234	7513670864
19235	7338612729
19250	3538176582
19251	8544431437
19252	5407737578
19253	8292941288
19254	8387929683
19255	4736547180
19256	2010341207
19257	7695185004
19259	8544431437
19260	5407737578
19181	5407737578
19182	8292941288
19183	8387929683
19184	4736547180
19185	7942803747
19187	4702364532
19188	2069875058
19189	2693451744
19190	8718107628
19191	9193211527
19192	9939807645
19193	4351838817
19195	7139210127
19196	7513670864
19197	7338612729
19198	1101336174
19199	1542082751
19184	4702364532
19185	2069875058
\.


--
-- Data for Name: dosen_penguji; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY dosen_penguji (idmks, nipdosenpenguji) FROM stdin;
19181	1000000000
19182	1000000001
19183	1000000002
19184	1000000003
19185	1000000004
19186	1000000005
19187	1000000006
19188	1000000007
19189	1000000008
19190	1000000009
19191	1000000010
19192	1000000011
19193	1000000012
19194	1000000013
19195	1000000014
19196	1000000015
19197	1000000016
19198	1000000017
19199	1000000018
19200	1000000019
19201	1000000020
19202	1000000000
19203	1000000001
19204	1000000002
19205	1000000003
19206	1000000004
19207	1000000005
19208	1000000006
19209	1000000007
19210	1000000008
19211	1000000009
19212	1000000010
19213	1000000011
19214	1000000012
19215	1000000013
19216	1000000014
19217	1000000015
19218	1000000016
19219	1000000017
19220	1000000018
19221	7942803747
19222	1284824200
19223	4702364532
19224	2069875058
19225	2693451744
19226	8718107628
19227	9193211527
19228	9939807645
19229	4351838817
19230	7182714876
19209	7139210127
19210	7513670864
19211	7338612729
19212	1101336174
19213	1542082751
19214	1003460248
19215	6077450977
19216	3562175951
19217	9324024215
19218	8899898690
19219	2217882138
19220	9597677891
19221	8292941288
19222	8387929683
19223	4736547180
19224	2010341207
19225	7695185004
19226	3538176582
19227	8544431437
19228	5407737578
19229	7942803747
19230	1284824200
19231	4702364532
19232	2069875058
19233	2693451744
19234	8718107628
19235	9193211527
19250	7338612729
19251	1101336174
19252	1542082751
19253	1003460248
19254	6077450977
19255	3562175951
19256	9324024215
19257	8899898690
19181	1000000016
19182	1000000017
19183	1000000018
19184	1000000019
19185	1000000020
19186	1000000000
19187	1000000001
19188	1000000002
19189	1000000003
19190	1000000004
19191	1000000005
19192	1000000006
19193	1000000007
19194	1000000008
19195	1000000009
19196	1000000010
\.


--
-- Data for Name: jadwal_non_sidang; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY jadwal_non_sidang (idjadwal, tanggalmulai, tanggalselesai, alasan, repetisi, nipdosen) FROM stdin;
100001	2016-10-11	2016-10-11	Sakit	Harian	1000000000
100002	2016-10-12	2016-10-12	Pingsan	Harian	1000000001
100003	2016-10-13	2016-10-13	Pergi	Mingguan	1000000002
100004	2016-10-14	2016-10-14	Acara keluarga	NULL	1000000003
100005	2016-10-15	2016-10-15	Masak	Bulanan	1000000004
100006	2016-10-16	2016-10-16	Makan	NULL	1000000005
100007	2016-10-17	2016-10-17	Acara keluarga	Bulanan	1000000006
100008	2016-10-18	2016-10-18	Sakit	Mingguan	1000000007
100009	2016-10-19	2016-10-19	Sakit	Harian	1000000008
100010	2016-10-20	2016-10-20	Anak sakit	Bulanan	1000000009
100011	2016-10-21	2016-10-21	Pergi	Harian	1000000010
100012	2016-10-22	2016-10-22	Dinas	NULL	1000000011
100013	2016-10-23	2016-10-23	Dinas	NULL	1000000012
100014	2016-10-24	2016-10-24	Pingsan	NULL	1000000013
100015	2016-10-25	2016-10-25	Masak	Mingguan	1000000014
100016	2016-10-26	2016-10-26	Sakit	Harian	1000000015
100017	2016-10-27	2016-10-27	Sakit	Harian	1000000016
100018	2016-10-28	2016-10-28	Pergi	Mingguan	1000000017
100019	2016-10-29	2016-10-29	Dinas	Bulanan	1000000018
100020	2016-10-30	2016-10-30	Izin	Bulanan	1000000019
100021	2016-10-31	2016-10-31	Acara keluarga	Harian	1000000020
100023	2016-11-02	2016-11-02	Pingsan	NULL	1284824200
100025	2016-11-04	2016-11-04	Sakit	Harian	2069875058
100037	2017-03-07	2017-04-19	coherent	NULL	1509170350
100041	2017-08-04	2017-03-25	reciprocal	Bulanan	1444088319
100052	2017-11-08	2017-06-17	composite	Mingguan	1575349055
100054	2017-04-18	2017-05-29	neutral	Bulanan	1886382981
100059	2017-05-26	2016-12-12	Multi-tiered	Bulanan	1403681378
100062	2017-02-09	2017-01-07	non-volatile	Harian	1605946251
100071	2017-01-22	2017-05-26	attitude	Mingguan	1818553667
100001	2016-11-10	2016-11-10	Sakit	Harian	1000000000
100002	2016-12-10	2016-12-10	Pingsan	Harian	1000000001
100023	2016-02-11	2016-02-11	Pingsan		1284824200
100025	2016-04-11	2016-04-11	Sakit	Harian	2069875058
100031	2016-11-10	2016-11-10	Sakit	Harian	1000000000
100032	2016-12-10	2016-12-10	Pingsan	Harian	1000000001
100052	2016-01-11	2016-01-11	Dinas	Harian	1000000000
100053	2016-02-11	2016-02-11	Pingsan		1000000001
100054	2016-03-11	2016-03-11	Pingsan		1000000002
100055	2016-04-11	2016-04-11	Sakit	Harian	1000000003
100056	2016-05-11	2016-05-11	Sakit	Bulanan	1000000004
100057	2016-06-11	2016-06-11	Dinas	Bulanan	1000000005
100058	2016-07-11	2016-07-11	Dinas		1000000006
100059	2016-08-11	2016-08-11	Pingsan		1000000007
100060	2016-09-11	2016-09-11	Acara keluarga	Harian	1000000008
100061	2016-11-10	2016-11-10	Sakit	Harian	1000000009
100062	2016-12-10	2016-12-10	Pingsan	Harian	1000000010
100001	2016-10-11	2016-10-11	Sakit	Harian	1000000000
100002	2016-10-12	2016-10-12	Pingsan	Harian	1000000001
100003	2016-10-13	2016-10-13	Pergi	Mingguan	1000000002
100004	2016-10-14	2016-10-14	Acara keluarga	NULL	1000000003
100005	2016-10-15	2016-10-15	Masak	Bulanan	1000000004
100006	2016-10-16	2016-10-16	Makan	NULL	1000000005
100007	2016-10-17	2016-10-17	Acara keluarga	Bulanan	1000000006
100008	2016-10-18	2016-10-18	Sakit	Mingguan	1000000007
100009	2016-10-19	2016-10-19	Sakit	Harian	1000000008
100010	2016-10-20	2016-10-20	Anak sakit	Bulanan	1000000009
100011	2016-10-21	2016-10-21	Pergi	Harian	1000000010
100012	2016-10-22	2016-10-22	Dinas	NULL	1000000011
100013	2016-10-23	2016-10-23	Dinas	NULL	1000000012
100014	2016-10-24	2016-10-24	Pingsan	NULL	1000000013
100015	2016-10-25	2016-10-25	Masak	Mingguan	1000000014
100016	2016-10-26	2016-10-26	Sakit	Harian	1000000015
100017	2016-10-27	2016-10-27	Sakit	Harian	1000000016
100018	2016-10-28	2016-10-28	Pergi	Mingguan	1000000017
100019	2016-10-29	2016-10-29	Dinas	Bulanan	1000000018
100020	2016-10-30	2016-10-30	Izin	Bulanan	1000000019
100021	2016-10-31	2016-10-31	Acara keluarga	Harian	1000000020
100022	2016-11-01	2016-11-01	Dinas	Harian	1000000021
100023	2016-11-02	2016-11-02	Pingsan	NULL	1000000022
100024	2016-11-03	2016-11-03	Pingsan	NULL	1000000023
100025	2016-11-04	2016-11-04	Sakit	Harian	1000000024
100026	2016-11-05	2016-11-05	Sakit	Bulanan	1000000025
100027	2016-11-06	2016-11-06	Dinas	Bulanan	1000000026
100028	2016-11-07	2016-11-07	Dinas	NULL	1000000027
100029	2016-11-08	2016-11-08	Pingsan	NULL	1000000028
100030	2016-11-09	2016-11-09	Acara keluarga	Harian	1000000029
100031	2017-12-03	2017-07-11	actuating	Bulanan	1000000030
100032	2017-06-07	2017-02-13	focus group	NULL	1000000031
100033	2017-12-17	2016-11-30	cohesive	Bulanan	1000000032
100034	2017-11-15	2017-05-02	initiative	Bulanan	1000000033
100035	2017-07-29	2016-12-10	migration	Mingguan	1000000034
100036	2017-03-08	2017-03-14	Intuitive	Bulanan	1000000035
100037	2017-03-07	2017-04-19	coherent	NULL	1000000036
100038	2016-12-31	2017-06-06	composite	Harian	1000000037
100039	2017-09-23	2017-12-15	structure	Harian	1000000038
100040	2017-07-10	2017-10-05	transitional	Bulanan	1000000039
100041	2017-08-04	2017-03-25	reciprocal	Bulanan	1000000040
100042	2017-11-24	2017-04-30	Robust	Mingguan	1000000041
100043	2017-07-23	2017-12-12	User-centric	Harian	1000000042
100044	2017-03-19	2017-06-23	Multi-lateral	Mingguan	1000000043
100045	2017-03-29	2017-02-24	24 hour	Bulanan	1000000044
100046	2017-08-02	2017-04-09	discrete	Harian	1000000045
100047	2017-08-29	2017-05-07	task-force	Mingguan	1000000046
100048	2017-12-17	2016-12-10	Operative	Bulanan	1000000047
100049	2017-03-10	2017-09-11	multi-state	Bulanan	1000000048
100050	2017-03-20	2017-02-26	secondary	Mingguan	1000000049
100051	2016-11-21	2017-07-09	even-keeled	NULL	1000000050
100052	2017-11-08	2017-06-17	composite	Mingguan	1000000051
100053	2017-04-09	2017-09-18	project	NULL	1000000052
100054	2017-04-18	2017-05-29	neutral	Bulanan	1000000053
100055	2017-05-26	2017-10-25	local	Bulanan	1000000054
100056	2017-10-21	2017-07-18	Business-focused	Harian	1000000055
100057	2017-07-28	2017-05-17	capability	NULL	1000000056
100058	2017-01-06	2017-08-14	system-worthy	Harian	1000000057
100059	2017-05-26	2016-12-12	Multi-tiered	Bulanan	1000000058
100060	2017-10-20	2017-07-26	function	Bulanan	1000000059
100061	2017-02-12	2017-01-02	Re-engineered	NULL	1000000060
100062	2017-02-09	2017-01-07	non-volatile	Harian	1000000061
100063	2017-04-27	2017-09-25	secured line	Harian	1000000062
100064	2017-03-21	2017-06-28	full-range	Mingguan	1000000063
100065	2017-10-24	2016-12-09	algorithm	Harian	1000000064
100066	2017-10-16	2017-12-04	collaboration	Harian	1000000065
100067	2017-02-24	2017-09-21	Seamless	Bulanan	1000000066
100068	2017-07-04	2017-10-18	Cloned	Bulanan	1000000067
100069	2017-07-17	2017-01-18	Sharable	Bulanan	1000000068
100070	2017-06-01	2017-06-25	systemic	Bulanan	1000000069
100071	2017-01-22	2017-05-26	attitude	Mingguan	1000000070
100072	2016-11-21	2016-11-18	Optimized	Harian	1000000071
100073	2017-06-21	2017-05-27	analyzer	Bulanan	1000000072
100074	2017-05-27	2017-08-22	secondary	Mingguan	1000000073
100075	2017-08-25	2017-02-24	intangible	Bulanan	1000000074
100076	2017-03-23	2016-11-20	systemic	Bulanan	1000000075
100077	2017-05-05	2016-12-12	strategy	NULL	1000000076
100078	2017-11-17	2017-09-14	matrix	NULL	1000000077
100079	2017-07-23	2016-12-25	explicit	Mingguan	1000000078
100080	2016-12-14	2017-06-10	Versatile	Bulanan	1000000079
\.


--
-- Data for Name: jadwal_sidang; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY jadwal_sidang (idjadwal, idmks, tanggal, jammulai, jamselesai, idruangan) FROM stdin;
900001	19181	2017-01-01	10.00 AM	12.00 PM	200001
900002	19182	2017-01-01	10.00 AM	12.00 PM	200002
900003	19183	2017-01-01	10.00 AM	12.00 PM	200003
900004	19184	2017-01-01	10.00 AM	12.00 PM	200004
900005	19230	2017-01-01	01.00 PM	03.00 PM	200005
900006	19229	2017-01-01	01.00 PM	03.00 PM	200006
900007	19228	2017-01-01	01.00 PM	03.00 PM	200007
900008	19227	2017-01-01	01.00 PM	03.00 PM	200008
900009	19185	2017-01-02	10.00 AM	12.00 PM	200009
900010	19186	2017-01-02	10.00 AM	12.00 PM	200010
900011	19187	2017-01-02	10.00 AM	12.00 PM	200011
900012	19188	2017-01-02	10.00 AM	12.00 PM	200012
900013	19226	2017-01-02	01.00 PM	03.00 PM	200013
900014	19225	2017-01-02	01.00 PM	03.00 PM	200014
900015	19224	2017-01-02	01.00 PM	03.00 PM	200015
900016	19223	2017-01-02	01.00 PM	03.00 PM	200001
900017	19189	2017-01-03	10.00 AM	12.00 PM	200002
900018	19190	2017-01-03	10.00 AM	12.00 PM	200003
900019	19191	2017-01-03	10.00 AM	12.00 PM	200004
900020	19192	2017-01-03	10.00 AM	12.00 PM	200005
900021	19222	2017-01-03	01.00 PM	03.00 PM	200006
900022	19221	2017-01-03	01.00 PM	03.00 PM	200007
900023	19220	2017-01-03	01.00 PM	03.00 PM	200008
900024	19219	2017-01-03	01.00 PM	03.00 PM	200009
900025	19193	2017-01-04	10.00 AM	12.00 PM	200010
900026	19194	2017-01-04	10.00 AM	12.00 PM	200011
900027	19195	2017-01-04	10.00 AM	12.00 PM	200012
900028	19196	2017-01-04	10.00 AM	12.00 PM	200013
900029	19218	2017-01-04	01.00 PM	03.00 PM	200014
900030	19217	2017-01-04	01.00 PM	03.00 PM	200015
900031	19181	2017-01-19	1:06 PM	1:57 PM	200001
900032	19182	2017-01-21	12:31 PM	6:54 PM	200002
900033	19183	2017-01-15	10:42 PM	8:27 PM	200003
900034	19184	2017-01-06	8:05 PM	3:15 AM	200004
900035	19185	2017-01-17	6:05 AM	12:57 PM	200005
900036	19186	2017-01-08	12:37 AM	8:25 PM	200006
900037	19187	2017-01-15	1:37 AM	3:57 PM	200007
900038	19188	2017-01-24	7:17 AM	11:42 AM	200008
900039	19189	2017-01-10	4:08 PM	6:23 PM	200009
900040	19190	2017-01-15	9:16 AM	2:38 AM	200010
900041	19191	2017-01-15	8:18 AM	10:17 PM	200011
900042	19192	2017-01-11	8:08 AM	6:35 PM	200012
900043	19193	2017-01-23	2:40 PM	6:49 AM	200013
900044	19194	2017-01-10	7:15 PM	12:09 PM	200014
900045	19195	2017-01-26	5:47 PM	11:27 AM	200015
900046	19196	2017-01-06	4:58 PM	11:11 AM	200016
900047	19197	2017-01-24	12:52 AM	10:50 PM	200017
900048	19198	2017-01-05	10:35 PM	5:05 AM	200018
900049	19199	2017-01-19	8:50 AM	5:23 PM	200019
900050	19200	2017-01-29	4:42 PM	8:00 PM	200020
900051	19201	2017-01-25	10:03 PM	7:42 PM	200021
900052	19202	2017-01-07	1:01 PM	7:10 PM	200022
900053	19203	2017-01-15	11:17 AM	4:11 AM	200023
900054	19204	2017-01-21	8:05 PM	5:27 PM	200024
900055	19205	2017-01-10	5:08 AM	5:00 PM	200025
900056	19206	2017-01-16	2:42 PM	2:36 AM	200026
900057	19207	2017-01-29	7:01 AM	8:23 AM	200027
900058	19208	2017-01-13	2:24 AM	9:02 PM	200028
900059	19209	2017-01-28	12:34 PM	8:10 AM	200029
900060	19210	2017-01-15	6:45 PM	12:23 PM	200030
900061	19211	2017-01-17	2:42 AM	8:08 AM	200031
900062	19212	2017-01-09	11:11 AM	5:46 PM	200032
900063	19213	2017-01-21	1:36 AM	10:12 AM	200033
900064	19214	2017-01-26	8:42 PM	3:57 PM	200034
900065	19215	2017-01-25	8:15 PM	4:05 PM	200035
900066	19216	2017-01-12	6:31 AM	11:14 AM	200001
900067	19217	2017-01-20	10:49 AM	12:44 PM	200001
900068	19218	2017-01-23	6:17 AM	4:37 PM	200001
900069	19219	2017-01-09	12:14 AM	8:16 PM	200001
900070	19220	2017-01-24	11:40 PM	12:47 AM	200001
900071	19221	2017-01-12	12:01 AM	5:44 AM	200001
900072	19222	2017-01-15	9:01 PM	7:04 PM	200001
900073	19223	2017-01-12	9:24 AM	10:28 AM	200001
900074	19224	2017-01-09	7:18 AM	9:33 PM	200001
900075	19225	2017-01-05	11:41 PM	12:24 PM	200001
900076	19226	2017-01-13	12:24 PM	9:57 PM	200001
900077	19227	2017-01-08	9:30 AM	9:04 AM	200001
900078	19228	2017-01-13	10:53 AM	1:33 PM	200001
900079	19229	2017-01-16	4:46 AM	4:37 AM	200001
900080	19230	2017-01-07	5:25 AM	5:57 AM	200001
\.


--
-- Data for Name: jenis_mks; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY jenis_mks (id, namamks) FROM stdin;
1	Skripsi
2	Karya Akhir
3	Proposal Tesis
4	Usulan Penelitian
5	Seminar Hasil Penelitian S3
6	Pra Promosi
7	Promosi
8	Tesis
9	Lain-lain
\.


--
-- Data for Name: mahasiswa; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY mahasiswa (npm, nama, username, password, email, email_alternatif, telepon, notelp) FROM stdin;
1000000000	Mahasiswa1	mahasiswa1	pwdmhs1	mahasiswa1@kampus.com	mhs1@gmail.com	6281300000000	6281500000000
1000000001	Mahasiswa2	mahasiswa2	pwdmhs2	mahasiswa2@kampus.com	mhs2@gmail.com	6281300000001	6281500000001
1000000002	Mahasiswa3	mahasiswa3	pwdmhs3	mahasiswa3@kampus.com	mhs3@gmail.com	6281300000002	6281500000002
1000000003	Mahasiswa4	mahasiswa4	pwdmhs4	mahasiswa4@kampus.com	mhs4@gmail.com	6281300000003	6281500000003
1000000004	Mahasiswa5	mahasiswa5	pwdmhs5	mahasiswa5@kampus.com	mhs5@gmail.com	6281300000004	6281500000004
1000000005	Mahasiswa6	mahasiswa6	pwdmhs6	mahasiswa6@kampus.com	mhs6@gmail.com	6281300000005	6281500000005
1000000006	Mahasiswa7	mahasiswa7	pwdmhs7	mahasiswa7@kampus.com	mhs7@gmail.com	6281300000006	6281500000006
1000000007	Mahasiswa8	mahasiswa8	pwdmhs8	mahasiswa8@kampus.com	mhs8@gmail.com	6281300000007	6281500000007
1000000008	Mahasiswa9	mahasiswa9	pwdmhs9	mahasiswa9@kampus.com	mhs9@gmail.com	6281300000008	6281500000008
1000000009	Mahasiswa10	mahasiswa10	pwdmhs10	mahasiswa10@kampus.com	mhs10@gmail.com	6281300000009	6281500000009
1000000010	Mahasiswa11	mahasiswa11	pwdmhs11	mahasiswa11@kampus.com	mhs11@gmail.com	6281300000010	6281500000010
1000000011	Mahasiswa12	mahasiswa12	pwdmhs12	mahasiswa12@kampus.com	mhs12@gmail.com	6281300000011	6281500000011
1000000012	Mahasiswa13	mahasiswa13	pwdmhs13	mahasiswa13@kampus.com	mhs13@gmail.com	6281300000012	6281500000012
1000000013	Mahasiswa14	mahasiswa14	pwdmhs14	mahasiswa14@kampus.com	mhs14@gmail.com	6281300000013	6281500000013
1000000014	Mahasiswa15	mahasiswa15	pwdmhs15	mahasiswa15@kampus.com	mhs15@gmail.com	6281300000014	6281500000014
1000000015	Mahasiswa16	mahasiswa16	pwdmhs16	mahasiswa16@kampus.com	mhs16@gmail.com	6281300000015	6281500000015
1000000016	Mahasiswa17	mahasiswa17	pwdmhs17	mahasiswa17@kampus.com	mhs17@gmail.com	6281300000016	6281500000016
1000000017	Mahasiswa18	mahasiswa18	pwdmhs18	mahasiswa18@kampus.com	mhs18@gmail.com	6281300000017	6281500000017
1000000018	Mahasiswa19	mahasiswa19	pwdmhs19	mahasiswa19@kampus.com	mhs19@gmail.com	6281300000018	6281500000018
1000000019	Mahasiswa20	mahasiswa20	pwdmhs20	mahasiswa20@kampus.com	mhs20@gmail.com	6281300000019	6281500000019
1000000020	Mahasiswa21	mahasiswa21	pwdmhs21	mahasiswa21@kampus.com	mhs21@gmail.com	6281300000020	6281500000020
1000000021	Mahasiswa22	mahasiswa22	pwdmhs22	mahasiswa22@kampus.com	mhs22@gmail.com	6281300000021	6281500000021
1000000022	Mahasiswa23	mahasiswa23	pwdmhs23	mahasiswa23@kampus.com	mhs23@gmail.com	6281300000022	6281500000022
1000000023	Mahasiswa24	mahasiswa24	pwdmhs24	mahasiswa24@kampus.com	mhs24@gmail.com	6281300000023	6281500000023
1000000024	Mahasiswa25	mahasiswa25	pwdmhs25	mahasiswa25@kampus.com	mhs25@gmail.com	6281300000024	6281500000024
1000000025	Mahasiswa26	mahasiswa26	pwdmhs26	mahasiswa26@kampus.com	mhs26@gmail.com	6281300000025	6281500000025
1000000026	Mahasiswa27	mahasiswa27	pwdmhs27	mahasiswa27@kampus.com	mhs27@gmail.com	6281300000026	6281500000026
1000000027	Mahasiswa28	mahasiswa28	pwdmhs28	mahasiswa28@kampus.com	mhs28@gmail.com	6281300000027	6281500000027
1000000028	Mahasiswa29	mahasiswa29	pwdmhs29	mahasiswa29@kampus.com	mhs29@gmail.com	6281300000028	6281500000028
1000000029	Mahasiswa30	mahasiswa30	pwdmhs30	mahasiswa30@kampus.com	mhs30@gmail.com	6281300000029	6281500000029
1000000030	Mahasiswa31	mahasiswa31	pwdmhs31	mahasiswa31@kampus.com	mhs31@gmail.com	6281300000030	6281500000030
1000000031	Mahasiswa32	mahasiswa32	pwdmhs32	mahasiswa32@kampus.com	mhs32@gmail.com	6281300000031	6281500000031
1000000032	Mahasiswa33	mahasiswa33	pwdmhs33	mahasiswa33@kampus.com	mhs33@gmail.com	6281300000032	6281500000032
1000000033	Mahasiswa34	mahasiswa34	pwdmhs34	mahasiswa34@kampus.com	mhs34@gmail.com	6281300000033	6281500000033
1000000034	Mahasiswa35	mahasiswa35	pwdmhs35	mahasiswa35@kampus.com	mhs35@gmail.com	6281300000034	6281500000034
1000000035	Mahasiswa36	mahasiswa36	pwdmhs36	mahasiswa36@kampus.com	mhs36@gmail.com	6281300000035	6281500000035
1000000036	Mahasiswa37	mahasiswa37	pwdmhs37	mahasiswa37@kampus.com	mhs37@gmail.com	6281300000036	6281500000036
1000000037	Mahasiswa38	mahasiswa38	pwdmhs38	mahasiswa38@kampus.com	mhs38@gmail.com	6281300000037	6281500000037
1000000038	Mahasiswa39	mahasiswa39	pwdmhs39	mahasiswa39@kampus.com	mhs39@gmail.com	6281300000038	6281500000038
1000000039	Mahasiswa40	mahasiswa40	pwdmhs40	mahasiswa40@kampus.com	mhs40@gmail.com	6281300000039	6281500000039
1000000040	Mahasiswa41	mahasiswa41	pwdmhs41	mahasiswa41@kampus.com	mhs41@gmail.com	6281300000040	6281500000040
3526312933	Carlos Lynch	ksalhrojex	12062411741206200000	hicobjsxak@ISM.com			
9930701371	Russell Patterson	ozchmxegyj	12062072301206200000	hiwumercby@USS.com	wenfmvbgcs@yahoo.com	6281499202241	6281960888759
9178889512	Norma Burke	nfldveysow	12062393141206200000	hvusyzotcr@ISS.com			
8721812777	Jesse Wallace	uyervfhbxd	12062551601206200000	nmupbjtxlv@UNM.com	pszjacoyux@gmail.com	6283410183265	6283318505264
1408792204	Joan Peters	jpuftoglqb	12062562261206200000	sdprbxikyv@UMT.com	xskulbjmgi@hotmail.com	6286340363327	6281889858852
6114327136	Juan Lopez	wexcmtkosn	12062071931206200000	tderaogjhu@ISS.com	ayrmopuzcd@yahoo.com	6284080833009	6287143626705
3674137816	Jeremy Mills	hlptzndxvf	12062562451206200000	digtpoyknw@USS.com	yeofgqkhbi@hotmail.com	6286907730490	6288753718657
2887082756	Martin Johnston	fnzyjktmgo	12062494161206200000	radyzjxsvo@INM.com	fdwaglkcto@yahoo.com	6281083082659	6289952234999
3235810486	Ruby Lee	vunacgyrbm	12062071421206200000	koapntilgs@USM.com	nvsmwkxhlz@gmail.com	6286725591291	6287502902735
6430728325	Sarah Burke	hsjpmuqako	12062074641206200000	bnxzrahvqo@UTM.com	cadhzwfygm@hotmail.com	6289816051665	6287807919473
9167876485	Virginia Sanchez	imxlvpwozc	12062070921206200000	tbiwusypgr@UNM.com	klzgbjedpy@yahoo.com	6289301617313	6281638189228
5823507444	Matthew Mitchell	gtanmipxbc	12062070861206200000	hpdxcmjrwv@USS.com	zevrbxiwja@yahoo.com	6286648817551	6287189228586
3039537946	Ann Williamson	ajeyzprxhk	12062447301206200000	zmlqfcjodb@IMM.com			
9449009799	Jeffrey Gomez	xhcwqjdpie	12062070031206200000	jhybadwqko@IMT.com	alrhgixntb@hotmail.com	6281511078229	6280978987997
8193455242	Denise Smith	lhgatneufs	12062075201206200000	iebljushfr@IBS.com	cpdwxuytea@hotmail.com	6282825115182	6288293221512
5269733540	Jose Jackson	mazecoqyjt	12062560241206200000	yqwrjbgdtf@USB.com	vuxtpjczfr@hotmail.com	6283027248404	6280196997670
7150023197	Louise Ford	srglodbney	12062561441206200000	akgfecmtbn@UTM.com	dsptmxlhua@yahoo.com	6288535181222	6289465393683
1039154280	Kathy Meyer	kdmzpsviwf	12062438221206200000	vaqsfrliwu@UNS.com			
8999213707	Marilyn Jenkins	ijnfyvsqou	12062449511206200000	alwprxsnkb@ISS.com			
802828390 	Samuel Jackson	ifwaqgntpc	12062561251206200000	cvpquietxz@UMS.com	fsunzgkwvr@hotmail.com	6286406138361	6280199054827
3939799847	Sarah Fuller	niykejxvfp	12062072561206200000	jqezxvmusr@ISM.com	osxdwjtuln@hotmail.com	6285008174316	6286099444846
882109671 	Barbara Simmons	rtqgxchkew	12062561311206200000	fqohrazcbu@UNT.com	sngyoklrhu@hotmail.com	6288764440878	6282501118066
468755930 	Julia Allen	ymurdajcpl	12062436201206200000	uvpqwdeyix@ISN.com	qozksmhgxe@gmail.com	6288338678918	6283454928930
8167909717	Kelly Green	yxuptbgawo	12062071801206200000	wegfiyclbm@ISS.com	yspkbgwczn@yahoo.com	6282156817858	6286658694381
1146437306	Paula Elliott	ilzswadger	12062069661206200000	wukomqyehg@ISM.com	bwjlvdezht@gmail.com	6283303517971	6288686442797
4696505428	Gregory Allen	jgsfunprmz	12062416211206200000	bvmorislge@USM.com	rlzopkhxai@hotmail.com	6282032977661	6288345259507
9143004599	Martin Murphy	nelaxkqbdr	12062075711206200000	gnwmayebrj@IMS.com			
7372144020	Phyllis Sullivan	tbwceqnykd	12062446931206200000	rbojltmwny@UMS.com			
9894802031	Patricia Holmes	ovpzaudrmn	12062069211206200000	hlkzdignpf@IST.com			
2404433719	Phyllis Alexander	kjgbewpclx	12062073761206200000	zobwjhalqk@ISS.com	yicmsdonxw@hotmail.com	6288790907760	6287057348766
8225334666	Joan Ferguson	jidvrtpygh	12062411741206200000	abvokqrzxm@UMN.com			
4913898072	Albert Coleman	bjifdoxkvn	12062072301206200000	ygbzxwavdj@ISS.com	uniklqvrof@hotmail.com	6281574586936	6282158766928
9685317121	Eric Ferguson	yfjdeqhcur	12062393141206200000	ecjpbfgsot@UMT.com	eljdgirnmy@yahoo.com	6287763280097	6286234859852
8210858128	Stephen Mcdonald	acgopeqwzu	12062551601206200000	mdlvrznwqj@USS.com	mkgcxrpsth@hotmail.com	6289087681540	6282771845446
3521427476	Sarah George	bgvwxyfeau	12062562261206200000	ymksjxbteo@USM.com	hpilznwtyk@gmail.com	6288001662912	6288951721886
651482897 	Randy Henry	cjquransdh	12062071931206200000	dulxfionmk@UNS.com	qhrktpazgx@gmail.com	6285530820879	6287866930619
3878851042	Evelyn Hansen	kfdrqtunce	12062494161206200000	ihodpgmuxq@USM.com	hxaytwsuoe@gmail.com	6282111538844	6283246169074
4895588162	Lillian Watson	xobvqaldfw	12062071421206200000	endzrabgcl@UBS.com	mvfhdoyjeb@gmail.com	6282906844947	6283922407258
374511048 	Melissa Moreno	slomuwhzcf	12062074641206200000	arvhfcunwp@UMT.com			
6305330606	Deborah Bryant	larcytxfod	12062070921206200000	badyptqhju@IMS.com	afdnemuyhs@gmail.com	6280576653131	6282849280664
2357441060	Adam West	xevsblgcha	12062070861206200000	volwxahdpt@ISN.com			
5118347082	Betty Kim	bhygvwxdjl	12062447301206200000	dzkicsqxfj@ITS.com	zsxcefydjq@yahoo.com	6284249579745	6282140879541
571297251 	Richard Adams	qsmtrxcfzo	12062070031206200000	sdoniqybjm@ISS.com			
4939667286	Cynthia Burke	iyxhtkecmz	12062075201206200000	kwzsvfnixg@INM.com	aewgvbhryt@gmail.com	6284797530751	6288731201823
2149008843	Ryan Bennett	ogjcuwxftz	12062560241206200000	qphucetolx@UMM.com	uisepdomzx@hotmail.com	6281358348458	6283491364036
5172702456	Diane Simpson	ntpdkwysav	12062561441206200000	ebogapflzs@ITM.com	gyuxparfmj@gmail.com	6286776352629	6285165247790
9946731974	Donald Frazier	snaokxzjgc	12062438221206200000	awzvuhrxkd@INS.com	nlrcfmizbv@hotmail.com	6286039184754	6282053151448
8420527038	Ronald Perry	asrqxcnwju	12062449511206200000	svazgkxowy@USN.com			
861351013 	Dennis Garza	yvhmwtlfnu	12062561251206200000	rdjkhvxyam@UNM.com	hteflnjdso@hotmail.com	6280944245511	6283205176356
7972215796	Douglas Boyd	efywuolbdp	12062072561206200000	gdsakmjqlr@UBM.com			
2697937428	Janice Richardson	rfcohjyang	12062561311206200000	repqyjsuga@ISS.com	nsevpdqytw@gmail.com	6287429787564	6289017638199
3318532480	Teresa Perez	myaxeholwu	12062436201206200000	fivlpwgtcx@ISS.com			
990879257 	Beverly Lee	hscfzvirwu	12062071801206200000	towalzispu@ISB.com	dfplueqjar@hotmail.com	6286392445570	6280005586238
1104897261	Scott Gomez	pbdakjgylz	12062069661206200000	bjoswyunel@USB.com	azfxyruknb@yahoo.com	6287026601560	6288428668725
8670060971	Jean Wells	sjdvohtcxl	12062416211206200000	qarmpdybie@UMS.com	knsmfteuoi@gmail.com	6287661836359	6282000167490
4887221576	Shirley Oliver	grcsztfvdk	12062075711206200000	gwdsjhlorn@ISS.com	awxutdcibl@hotmail.com	6281950580219	6281622623779
3628670869	Anna Bradley	imsrxtnoev	12062446931206200000	inkvedbgto@UMT.com			
7919258134	Martin Mills	hwtnakscgj	12062069211206200000	ukefogtdml@ISS.com			
1194613888	Jason Cook	nobltjgpqx	12062073761206200000	iwrkbtgxfp@INS.com			
318710352 	John Marshall	syuhnalgzi	12062411741206200000	sbzhivuglo@UBM.com	eoctrgiphu@hotmail.com	6289455606211	6280358887181
2055774053	Anthony Ray	nhbkmrioyg	12062072301206200000	vfmixecawb@UNS.com			
1869593646	Richard Ferguson	iplgqsyfwk	12062393141206200000	wjghsokpbu@USN.com	elbkxfquvh@hotmail.com	6280823295979	6281762535683
168523298 	Lawrence Frazier	owscatfmlb	12062551601206200000	apxuebtodh@IBS.com			
4439359020	Shawn Cole	hqjtgpyvdn	12062562261206200000	syvjapcflg@ISS.com	gyqxieldps@yahoo.com	6284578369867	6286282489997
957556480 	Walter Castillo	rmytexhawo	12062071931206200000	owrabjcvng@USS.com	zcaumsdoqy@yahoo.com	6280539734454	6285338781070
5003533958	Shawn Ferguson	ewvjpdqmsy	12062562451206200000	pgqsadibec@IBS.com	idjspxozlt@yahoo.com	6284282694307	6284154450503
9511433367	Christine Morris	jkixtmoqps	12062494161206200000	hqtzapokgc@ISN.com	vzaqrucmfd@hotmail.com	6282271407490	6287748659451
7347006647	Jack Grant	wkmugjbysr	12062071421206200000	tgwosncraz@ISN.com			
7964146209	Pamela Cole	canwzyxqgi	12062074641206200000	elziagqnmc@INT.com			
\.


--
-- Data for Name: mata_kuliah_spesial; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY mata_kuliah_spesial (idmks, npm, tahun, semester, judul, issiapsidang, pengumpulanhardcopy, ijinmajusidang, idjenismks) FROM stdin;
19181	1000000000	2014	2	Gastric freezing	t	f	t	8
19182	1000000001	2014	1	Rev hip repl-acetab comp	f	t	t	6
19183	1000000002	2014	2	Thor rep-diaph hern NOS	t	f	f	6
19184	1000000003	2014	1	Conjunctivorhinos w tube	f	t	t	8
19185	1000000004	2014	1	Videoradio eeg monitor	f	f	f	2
19186	1000000005	2014	2	Blepharoptos repair NEC	f	f	t	5
19187	1000000006	2014	1	Resect ext seg sm bowel	t	t	t	7
19188	1000000007	2014	3	Wrist structure division	f	f	t	2
19189	1000000008	2014	1	Tiss adj to valv ops NEC	f	t	f	4
19190	1000000009	2014	2	Skin defect tattooing	t	f	f	5
19191	1000000010	2014	1	Coronary arteriogram NEC	f	f	t	8
19192	1000000011	2014	3	Open rep umbil hern NEC	t	f	f	4
19193	1000000012	2014	1	Local perfusion liver	f	f	f	8
19194	1000000013	2014	3	Tube & uterus x-ray NEC	t	f	f	6
19195	1000000014	2014	3	Bilat tubal destruct NEC	t	f	f	6
19196	1000000015	2014	3	Other incision of thymus	f	f	t	3
19197	1000000016	2014	2	Pedicle attach to mouth	t	f	t	2
19198	1000000017	2014	3	Cell blkpap-upper urin	f	t	t	8
19199	1000000018	2014	3	Endosc inser nasopan tub	f	t	f	5
19200	1000000019	2014	3	Punctum repair NEC	f	f	f	6
19201	1000000020	2014	3	Rt & lt heart angiocard	f	f	f	1
19202	1000000021	2014	1	Prolapsed iris excision	f	f	f	7
19203	1000000022	2014	1	Thorac lobectomy lung	t	f	f	7
19204	1000000023	2014	2	Behavior therapy	f	f	t	5
19205	1000000024	2014	1	Lap incid appendectomy	t	f	f	2
19206	1000000025	2014	2	Injection into prostate	f	f	t	9
19207	1000000026	2014	3	Revis bile tract anastom	f	t	t	8
19208	1000000027	2014	3	Debrid opn fx-femur	f	t	f	5
19209	1000000028	2014	2	Symphysiotomy	t	f	f	2
19210	1000000029	2014	1	Psychoanalysis	t	f	t	1
19211	1000000030	2014	2	Referral for psychother	f	t	f	5
19212	1000000031	2014	3	Pros rep atrial def-opn	f	f	t	8
19213	1000000032	2014	3	Vaginal douche	t	t	t	2
19214	1000000033	2014	1	Replace lower limb cast	t	t	f	4
19215	1000000034	2014	1	C & s-spleenmarrow	t	t	t	5
19216	1000000035	2014	1	Repair heart assist sys	t	f	t	6
19217	1000000036	2014	2	Dental restoration NEC	f	f	f	1
19218	1000000037	2014	2	Ethmoidectomy	t	f	t	4
19219	1000000038	2014	1	Thermography NEC	f	f	t	4
19220	1000000039	2014	2	C & s-blood	f	t	f	8
19221	1000000040	2014	3	Perc ather intracran vsl	t	f	f	5
19222	3526312933	2014	2	Drsldslmb fus postpost	t	t	f	5
19223	9930701371	2014	2	Hand joint struct divis	f	t	f	1
19224	9178889512	2014	1	Prt lg intes exc NECNOS	t	t	t	3
19225	8721812777	2014	3	Gynecologic examination	t	f	f	7
19226	1408792204	2014	1	Explor tend sheath-hand	f	f	f	5
19227	6114327136	2014	2	Rev knee repl-femur comp	f	t	t	8
19228	3674137816	2014	2	Breast full-thick graft	t	t	f	9
19229	2887082756	2014	2	Vag suspfix w grftpros	f	t	t	2
19230	3235810486	2014	1	Close sm bowel fist NEC	f	f	t	4
19231	6430728325	2014	2	Implementasi media Giving Card untuk meningkatkan keterampilan berbicara siswa kelas V D pada pelajaran Bahasa Inggris di MIN Darul Ulum Rejoso Peterongan Jombang.	t	f	t	2
19232	9167876485	2014	1	Implementasi Pendidikan Matematika Realistik PMR untuk Meningkatkan Hasil Belajar Siswa Kelas V di MI Fathul Huda Grobogan Mojowarno Jombang Tahun Pelajaran 20132014	f	t	t	2
19233	5823507444	2014	2	Penerapan Metode CIRC Pada Bidang Studi Bahasa Indonesia untuk Meningkatkan Keterampilan Membaca Cerpen Kelas V MI Tarbiyatul Aulad Gebang Malang Bandung Tahun Pelajaran 20132014	t	f	f	2
19234	3039537946	2014	1	Penggunaan Metode Mind Mapping Concept Untuk Meningkatkan Keterampilan Berfikir Kritis Pada Mata Pelajaran IPS Siswa Kelas IV di MI Hasyim AsyOari Jogoroto Jombang Tahun Pelajaran 20132014	f	t	t	2
19235	9449009799	2014	1	Efektivitas penerapan metode eksperimen untuk meningkatkan hasil belajar IPA kelas IV di SD Islam Al-Fattah Kepuhkembeng Peterongan Jombang tahun pelajaran 20132014	f	f	f	2
19250	9685317121	2014	3	Studi Komparatif Prestasi Belajar Siswa antara Anak Petani dan Anak Buruh Pabrik di MI Bustanul Ulum Brudu Sumobito Jombang Tahun Pelajaran 20142015	f	f	f	1
19251	8210858128	2014	3	Hubungan antara Gaya Belajar dengan Hasil Belajar Siswa Mata Pelajaran Aqidah Akhlak Kelas V di MI Darul Ulum 1 Sumber Penganten Jogoroto Jombang	f	f	f	8
19252	3521427476	2014	1	Pengaruh Penggunaan Media Sosial Game Online terhadap Kemampuan Bersosialisasi Anak di MI Unggulan Assalam Mojowarno Jombang	f	f	f	8
19253	4939667286	2014	1	Pengaruh Penggunaan Metode Student Facilitator and Explaining terhadap Pencapaian Hasil Belajar Siswa pada Mata Pelajaran Bahasa Indonesia Kelas IV di MI Hidayatus Shibyan Cendoro Palang Tuban Tahun Ajaran 20142015	t	f	f	8
19254	2149008843	2014	2	Pengembangan Cara Mendidik Anak MI Srudi Analisis Film Taare Zameen Par Every Child Is Special Produced dan Decorated Aamir Khan	f	f	t	8
19255	5172702456	2014	1	Pengaruh Penggunaan Multimedia terhadap Hasil Belajar Siswa pada Mata Pelajaran IPS Kelas V MI Ulumuddin Godong Gudo Jombang Tahun Ajaran 20142015	t	f	f	8
19256	9946731974	2014	2	Perbandingan Hasil Belajar antara Siswa Mendapat dan Tanpa Mendapat Evaluasi Formatif pada Mata Pelajaran Matematika Kelas II MI Bustanul Ulum Badas Sumobito Jombang	f	f	t	8
19257	8420527038	2014	3	Hubungan Perhatian Orang Tua dan Sarana Belajar Siswa Kelas V SDIT Al-Khalifa Selorejo Mojowarno Jombang Tahun Ajaran 20142015	f	t	t	8
19259	2697937428	2014	1	Hubungan Kinerja Mengajar Guru Dengan Hasil Belajar Siswa Kelas IV di SDI AT-Aufiq Bogem Grogol Diwek Jombang	t	f	t	8
19260	1869593646	2014	2	Korelasi antara Keterampilan Mengajar Guru dan Gaya Belajar Visual dengan Kecerdasan Emosional Siswa pada Pelajaran Fiqih Kelas VA MI Miftahul Ulum Jarak Kulon Jogoroto Jombang Tahun Pelajaran 20142015	f	t	t	8
19238	7150023197	2014	3	Penerapan Metode Crossword Puzzle Untuk Meningkatkan Hasil Belajar Siswa Pada Mata Pelajaran SKI di MI Fathul Huda Grobogan Mojowarno Jombang Tahun Pelajaran 20132014	f	f	t	2
19239	1039154280	2014	1	Implementasi Outdoor Learning Sebagai Upaya Peningkatan Motivasi Belajar Siswa Pada Mata Pelajaran IPA Kelas V-B di MIN Rejoso Peterongan Jombang Tahun Ajaran 20132014	f	t	f	1
19240	8999213707	2014	2	Upaya Peningkatan Hasil Belajar Aqidah Akhlak melalui Model Pembelajaran Quantum Teaching di Kelas III B MI Al-Hikmah Janti Jogoroto Jombang Tahun Pelajaran 20132014	t	f	f	1
19241	8167909717	2014	1	Penggunaan media bola tempel pada mata pelajaran Ilmu Pengetahuan Alam IPA untuk meningkatkan motivasi belajar siswa di SDN Kemaduh 1 Baron Nganjuk tahun pelajaran 20132014	f	f	t	1
19242	1146437306	2014	3	Penerapan Metode demonstrasi dalam pembelajaran PAI untuk meningkatkan hasil belajar siswa di SDN Tunggorono II Jombang Tahun 2013-2014	t	f	f	1
19243	4696505428	2014	1	Penerapan metode Jarimatika untuk meningkatkan keterampilan berhitung penjumlahan dan pengurangan di MIN Rejoso Peterongan Jombang Tahun Ajaran 20132014	f	f	f	1
19245	7372144020	2014	3	Pengaruh Metode Sosiodrama terhadap Motivasi Siswa Belajar pada Mata Pelajaran SKI di kelas V MI Al-Azhar Sambong Dukuh Jombang	t	f	f	1
19246	9894802031	2014	3	Hubungan Tingkat Keotoriteran Pola Asuh Orang Tua dengan Pembentukan Kepribadian Siswa Kelas 5 MI Mubtadiul Ulum Carangrejo Kesamben Jombang	f	f	t	1
19247	2404433719	2014	2	Perbandingan Buku Teks Penertbitan Erlangga dengan Penerbit Buku Sekolah Elektronik Mata Pelajaran IPS Kelas IV Studi Kasus di Madrasah Ibtidaiyah Bustanul Ulum Brudu Sumobito	t	f	t	1
19248	8225334666	2014	3	Perbandingan Hasil Belajar Bidang Studi Agama Islam antara Siswa Kelas 4D dengan 4E dalam Implementasi Kurikulum 2013 di MIN Kauman Utara Jombang Tahun Pelajaran 20142015	f	t	t	1
19249	4913898072	2014	3	Pengembangan Pendidikan Peran Komite Madrasah terhadap Pengembangan Pendidikan di MI Salafiyah Syafiiyah Bandung Krajan Diwek Jombang	f	t	f	1
19261	3526312933	2014	2	Studi Komparatif Prestasi Belajar Siswa antara Anak Petani dan Anak Buruh Pabrik di MI Bustanul Ulum Brudu Sumobito Jombang Tahun Pelajaran 20142015	t	t	f	2
19262	9930701371	2014	3	Hubungan antara Gaya Belajar dengan Hasil Belajar Siswa Mata Pelajaran Aqidah Akhlak Kelas V di MI Darul Ulum 1 Sumber Penganten Jogoroto Jombang	f	f	f	2
19263	9178889512	2014	3	Pengaruh Penggunaan Media Sosial Game Online terhadap Kemampuan Bersosialisasi Anak di MI Unggulan Assalam Mojowarno Jombang	f	t	t	2
19264	8721812777	2014	3	Pengaruh Penggunaan Metode Student Facilitator and Explaining terhadap Pencapaian Hasil Belajar Siswa pada Mata Pelajaran Bahasa Indonesia Kelas IV di MI Hidayatus Shibyan Cendoro Palang Tuban Tahun Ajaran 20142015	f	f	f	2
19265	1408792204	2014	3	Pengembangan Cara Mendidik Anak MI Srudi Analisis Film Taare Zameen Par Every Child Is Special Produced dan Decorated Aamir Khan	t	f	f	2
19266	6114327136	2014	1	Pengaruh Penggunaan Multimedia terhadap Hasil Belajar Siswa pada Mata Pelajaran IPS Kelas V MI Ulumuddin Godong Gudo Jombang Tahun Ajaran 20142015	f	f	f	2
19267	3674137816	2014	1	Perbandingan Hasil Belajar antara Siswa Mendapat dan Tanpa Mendapat Evaluasi Formatif pada Mata Pelajaran Matematika Kelas II MI Bustanul Ulum Badas Sumobito Jombang	f	t	t	2
19268	2887082756	2014	2	Hubungan Perhatian Orang Tua dan Sarana Belajar Siswa Kelas V SDIT Al-Khalifa Selorejo Mojowarno Jombang Tahun Ajaran 20142015	t	f	f	2
19270	6430728325	2014	2	Hubungan Kinerja Mengajar Guru Dengan Hasil Belajar Siswa Kelas IV di SDI AT-Aufiq Bogem Grogol Diwek Jombang	t	f	f	1
19271	9167876485	2014	3	Korelasi antara Keterampilan Mengajar Guru dan Gaya Belajar Visual dengan Kecerdasan Emosional Siswa pada Pelajaran Fiqih Kelas VA MI Miftahul Ulum Jarak Kulon Jogoroto Jombang Tahun Pelajaran 20142015	f	t	t	1
19272	5823507444	2014	3	Studi Komparatif Prestasi Belajar Siswa antara Anak Petani dan Anak Buruh Pabrik di MI Bustanul Ulum Brudu Sumobito Jombang Tahun Pelajaran 20142015	t	f	f	1
19273	3039537946	2014	1	Hubungan antara Gaya Belajar dengan Hasil Belajar Siswa Mata Pelajaran Aqidah Akhlak Kelas V di MI Darul Ulum 1 Sumber Penganten Jogoroto Jombang	t	f	f	1
19274	9449009799	2014	2	Pengaruh Penggunaan Media Sosial Game Online terhadap Kemampuan Bersosialisasi Anak di MI Unggulan Assalam Mojowarno Jombang	f	f	f	1
19275	8193455242	2014	2	Pengaruh Penggunaan Metode Student Facilitator and Explaining terhadap Pencapaian Hasil Belajar Siswa pada Mata Pelajaran Bahasa Indonesia Kelas IV di MI Hidayatus Shibyan Cendoro Palang Tuban Tahun Ajaran 20142015	t	t	t	1
19276	5269733540	2014	3	Pengembangan Cara Mendidik Anak MI Srudi Analisis Film Taare Zameen Par Every Child Is Special Produced dan Decorated Aamir Khan	f	f	f	1
19277	7150023197	2014	3	Pengaruh Penggunaan Multimedia terhadap Hasil Belajar Siswa pada Mata Pelajaran IPS Kelas V MI Ulumuddin Godong Gudo Jombang Tahun Ajaran 20142015	f	f	f	1
19278	1039154280	2014	1	Perbandingan Hasil Belajar antara Siswa Mendapat dan Tanpa Mendapat Evaluasi Formatif pada Mata Pelajaran Matematika Kelas II MI Bustanul Ulum Badas Sumobito Jombang	f	f	f	1
19279	8999213707	2014	2	Hubungan Perhatian Orang Tua dan Sarana Belajar Siswa Kelas V SDIT Al-Khalifa Selorejo Mojowarno Jombang Tahun Ajaran 20142015	f	f	f	1
\.


--
-- Data for Name: prodi; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY prodi (id, namaprodi) FROM stdin;
1	Ilmu Komputer
2	Sistem Informasi
3	Aktuaris
4	E-sports
5	Teologi
6	Kesekretariatan
\.


--
-- Data for Name: ruangan; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY ruangan (idruangan, nama) FROM stdin;
200016	Horizontal
200017	User-centric
200018	well-modulated
200019	budgetary management
200020	intranet
200021	zero tolerance
200022	Managed
200023	model
200024	conglomeration
200025	4th generation
200026	knowledge base
200027	Cross-platform
200028	homogeneous
200029	multimedia
200030	user-facing
200031	throughput
200032	asynchronous
200033	support
200034	extranet
200035	impactful
200001	Kucing
200002	Anjing
200003	Kuda
200004	Ayam
200005	Burung
200006	Cicak
200007	Tokek
200008	Ikan
200009	Buaya
200010	Dodo
200011	Lemur
200012	Gajah
200013	Paus
200014	Hiu
200015	Macan
\.


--
-- Data for Name: saran_dosen_penguji; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY saran_dosen_penguji (idmks, nipsaranpenguji) FROM stdin;
19181	1000000000
19182	1000000001
19183	1000000002
19184	1000000003
19185	1000000004
19186	1000000005
19187	1000000006
19188	1000000007
19189	1000000008
19190	1000000009
19191	1000000010
19192	1000000011
19193	1000000012
19194	1000000013
19195	1000000014
19196	1000000015
19197	1000000016
19198	1000000017
19199	1000000018
19200	1000000019
19201	1000000020
19202	1000000000
19203	1000000001
19204	1000000002
19205	1000000003
19206	1000000004
19207	1000000005
19208	1000000006
19209	1000000007
19210	1000000008
19211	1000000009
19212	1000000010
19213	1000000011
19214	1000000012
19215	1000000013
19216	1000000014
19217	1000000015
19218	1000000016
19219	1000000017
19220	1000000018
19221	1000000019
19222	1000000020
19223	1000000000
19224	1000000001
19225	1000000002
19226	1000000003
19227	1000000004
19228	1000000005
19229	1000000006
19230	1000000007
19209	7942803747
19210	1284824200
19211	4702364532
19212	2069875058
19213	2693451744
19214	8718107628
19215	9193211527
19216	9939807645
19217	4351838817
19218	7182714876
19219	7139210127
19220	7513670864
19221	7338612729
19222	1101336174
19223	1542082751
19224	1003460248
19225	6077450977
19226	3562175951
19227	9324024215
19228	8899898690
19229	2217882138
19230	9597677891
19231	8292941288
19232	8387929683
19233	4736547180
19234	2010341207
19235	7695185004
19216	6077450977
19250	7513670864
19251	7338612729
19252	1101336174
19253	1542082751
19254	1003460248
19255	6077450977
19256	3562175951
19257	9324024215
19181	3562175951
19182	9324024215
19183	8899898690
19184	2217882138
19185	9597677891
19186	8292941288
19187	8387929683
19188	4736547180
19189	2010341207
19190	7695185004
19191	3538176582
19192	8544431437
19193	5407737578
19194	7942803747
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY term (tahun, semester) FROM stdin;
2014	1
2014	2
2014	3
\.


--
-- Data for Name: timeline; Type: TABLE DATA; Schema: si_sidang; Owner: postgres
--

COPY timeline (idtimeline, namaevent, tanggal, tahun, semester) FROM stdin;
1	Kegiatan 1	2016-10-11	2014	1
2	Kegiatan 2	2016-10-12	2014	2
3	Kegiatan 3	2016-10-13	2014	3
4	Kegiatan 4	2016-10-14	2014	1
15	arcu sed augue	2016-12-12	2014	1
28	ullamcorper purus	2016-12-23	2014	2
14	posuere nonummy	2016-12-02	2014	2
29	eu massa	2016-11-22	2014	2
22	ligula in lacus	2016-12-07	2014	2
18	maecenas	2016-11-18	2014	3
13	ac	2016-11-30	2014	3
26	leo rhoncus	2016-12-20	2014	2
24	in tempor	2016-12-10	2014	3
23	nulla	2016-12-05	2014	1
19	tempus	2016-11-17	2014	2
25	eget eros	2016-12-19	2014	1
11	ligula in lacus	2016-12-07	2014	2
12	maecenas	2016-11-18	2014	3
16	leo rhoncus	2016-12-20	2014	2
17	in tempor	2016-12-10	2014	3
20	tempus	2016-11-17	2014	2
21	sit amet lobortis	2016-11-20	2014	1
27	vel	2016-11-19	2014	3
30	nascetur	2016-12-10	2014	1
31	ligula in lacus	2016-11-17	2014	1
32	maecenas	2016-11-20	2014	2
33	ac	2016-12-14	2014	1
34	arcu sed augue	2016-11-22	2014	3
35	ullamcorper purus	2016-12-19	2014	2
36	leo rhoncus	2016-12-23	2014	1
37	in tempor	2016-12-20	2014	3
38	posuere nonummy	2016-11-19	2014	3
39	nulla	2016-11-20	2014	3
40	tempus	2016-11-17	2014	1
41	sit amet lobortis	2016-11-20	2014	1
42	sed	2016-12-14	2014	1
43	eu massa	2016-11-22	2014	3
44	eget eros	2016-12-19	2014	3
45	lacus at turpis	2016-12-23	2014	3
\.


SET search_path = public, pg_catalog;

--
-- Name: book_copies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book_copies
    ADD CONSTRAINT book_copies_pkey PRIMARY KEY (book_id, branch_id);


--
-- Name: book_loans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book_loans
    ADD CONSTRAINT book_loans_pkey PRIMARY KEY (book_id, branch_id, card_no);


--
-- Name: book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- Name: borrower_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY borrower
    ADD CONSTRAINT borrower_pkey PRIMARY KEY (card_no);


--
-- Name: library_branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY library_branch
    ADD CONSTRAINT library_branch_pkey PRIMARY KEY (branch_id);


SET search_path = si_sidang, pg_catalog;

--
-- Name: dosen_pembimbing_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY dosen_pembimbing
    ADD CONSTRAINT dosen_pembimbing_pkey PRIMARY KEY (idmks, nipdosenpembimbing);


--
-- Name: dosen_penguji_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY dosen_penguji
    ADD CONSTRAINT dosen_penguji_pkey PRIMARY KEY (idmks, nipdosenpenguji);


--
-- Name: dosen_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY dosen
    ADD CONSTRAINT dosen_pkey PRIMARY KEY (nip);


--
-- Name: jenis_mks_namamks_key; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY jenis_mks
    ADD CONSTRAINT jenis_mks_namamks_key UNIQUE (namamks);


--
-- Name: jenis_mks_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY jenis_mks
    ADD CONSTRAINT jenis_mks_pkey PRIMARY KEY (id);


--
-- Name: mahasiswa_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY mahasiswa
    ADD CONSTRAINT mahasiswa_pkey PRIMARY KEY (npm);


--
-- Name: mata_kuliah_spesial_idmks_key; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY mata_kuliah_spesial
    ADD CONSTRAINT mata_kuliah_spesial_idmks_key UNIQUE (idmks);


--
-- Name: mata_kuliah_spesial_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY mata_kuliah_spesial
    ADD CONSTRAINT mata_kuliah_spesial_pkey PRIMARY KEY (idmks, npm, tahun, semester);


--
-- Name: prodi_namaprodi_key; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY prodi
    ADD CONSTRAINT prodi_namaprodi_key UNIQUE (namaprodi);


--
-- Name: saran_dosen_penguji_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY saran_dosen_penguji
    ADD CONSTRAINT saran_dosen_penguji_pkey PRIMARY KEY (idmks, nipsaranpenguji);


--
-- Name: term_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_pkey PRIMARY KEY (tahun, semester);


--
-- Name: timeline_pkey; Type: CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY timeline
    ADD CONSTRAINT timeline_pkey PRIMARY KEY (idtimeline);


SET search_path = public, pg_catalog;

--
-- Name: book_copies_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book_copies
    ADD CONSTRAINT book_copies_book_id_fkey FOREIGN KEY (book_id) REFERENCES book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: book_copies_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book_copies
    ADD CONSTRAINT book_copies_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES library_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: book_loans_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book_loans
    ADD CONSTRAINT book_loans_book_id_fkey FOREIGN KEY (book_id) REFERENCES book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: book_loans_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book_loans
    ADD CONSTRAINT book_loans_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES library_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: book_loans_card_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book_loans
    ADD CONSTRAINT book_loans_card_no_fkey FOREIGN KEY (card_no) REFERENCES borrower(card_no) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = si_sidang, pg_catalog;

--
-- Name: dosen_pembimbing_idmks_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY dosen_pembimbing
    ADD CONSTRAINT dosen_pembimbing_idmks_fkey FOREIGN KEY (idmks) REFERENCES mata_kuliah_spesial(idmks) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dosen_pembimbing_nipdosenpembimbing_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY dosen_pembimbing
    ADD CONSTRAINT dosen_pembimbing_nipdosenpembimbing_fkey FOREIGN KEY (nipdosenpembimbing) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dosen_penguji_idmks_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY dosen_penguji
    ADD CONSTRAINT dosen_penguji_idmks_fkey FOREIGN KEY (idmks) REFERENCES mata_kuliah_spesial(idmks) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dosen_penguji_nipdosenpenguji_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY dosen_penguji
    ADD CONSTRAINT dosen_penguji_nipdosenpenguji_fkey FOREIGN KEY (nipdosenpenguji) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mata_kuliah_spesial_idjenismks_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY mata_kuliah_spesial
    ADD CONSTRAINT mata_kuliah_spesial_idjenismks_fkey FOREIGN KEY (idjenismks) REFERENCES jenis_mks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mata_kuliah_spesial_npm_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY mata_kuliah_spesial
    ADD CONSTRAINT mata_kuliah_spesial_npm_fkey FOREIGN KEY (npm) REFERENCES mahasiswa(npm) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mata_kuliah_spesial_tahun_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY mata_kuliah_spesial
    ADD CONSTRAINT mata_kuliah_spesial_tahun_fkey FOREIGN KEY (tahun, semester) REFERENCES term(tahun, semester) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: saran_dosen_penguji_idmks_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY saran_dosen_penguji
    ADD CONSTRAINT saran_dosen_penguji_idmks_fkey FOREIGN KEY (idmks) REFERENCES mata_kuliah_spesial(idmks) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: saran_dosen_penguji_nipsaranpenguji_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY saran_dosen_penguji
    ADD CONSTRAINT saran_dosen_penguji_nipsaranpenguji_fkey FOREIGN KEY (nipsaranpenguji) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: timeline_tahun_fkey; Type: FK CONSTRAINT; Schema: si_sidang; Owner: postgres
--

ALTER TABLE ONLY timeline
    ADD CONSTRAINT timeline_tahun_fkey FOREIGN KEY (tahun, semester) REFERENCES term(tahun, semester) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

