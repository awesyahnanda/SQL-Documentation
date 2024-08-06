# Display the entire database that we have
show databases;

# Create new databases
create database academic;

# Enter the new database
use academic;

# Display all tabless
show tables;

# Create a student(mahasiswa) table
drop table mahasiswa;
create table mahasiswa(
		NIM int primary key auto_increment,
        nama_mahasiswa VARCHAR(255) NOT NULL,
    	jenis_kelamin VARCHAR(10),
    	tempat_lahir VARCHAR(50),
    	tanggal_lahir DATE,
    	alamat VARCHAR(255),
    	telepon VARCHAR(15)
    	);
describe mahasiswa;

select * from mahasiswa;

# Insert Values
insert into mahasiswa(NIM,nama_sapapun, jenis_kelamin, tempat_lahir, tanggal_lahir, alamat, telepon)
values 
(120, 'Daffa M', 'pria','dimana', '2000-12-01', 'apapun', 0987122);

insert into mahasiswa(nama_sapapun, jenis_kelamin, tempat_lahir, tanggal_lahir, alamat, telepon)
values 
('Daffa M', 'pria','dimana', '2000-12-01', 'apapun', 0987122);
 
 alter table mahasiswa
 change column nama_mahasiswa nama_sapapun varchar(20);