CREATE OR REPLACE FUNCTION cekJdwlNonSidang()
RETURNS trigger AS
$$
BEGIN
UPDATE TIMELINE SET isClear = TRUE
WHERE JADWAL_NON_SIDANG.izinMaju == TRUE AND NEW.NIPdosen == JADWAL_NON_SIDANG.NIPdosen AND NEW.IdBerkas == BERKAS.IdBerkas;
RETURN NEW;
END;
$$
Language plpgsql;