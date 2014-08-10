#Doctor's Office Program

###Written by Ellen Lehman

###First week of databases and SQL

##Set Up
To set up this program, clone the repository from Github and open the program in your terminal.  You will also need to create a database with multiple tables as outlined below using SQL.


CREATE DATABASE doctor_office;
CREATE TABLE doctor (id serial PRIMARY KEY, name varchar, specialty_id int, insurance_id int);
CREATE TABLE patient (id serial PRIMARY KEY, name varchar, birthdate date, doctor_id int, insurance_id int);
CREATE TABLE specialty (id serial PRIMARY KEY, name varchar);
CREATE TABLE insurance (id serial PRIMARY KEY, name varchar);
CREATE TABLE doctor_patient (id serial PRIMARY KEY, doctor_id int, patient_id int);

##What it does
This program creates a filing system for a doctor's office where the practice can keep track of the doctors, their specialities, their patients and insurance companies.

MIT License. Copyright Ellen Lehman 2014
