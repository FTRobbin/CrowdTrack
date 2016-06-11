/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RobbinNi
 * Created: Jun 9, 2016
 */
DROP DATABASE IF EXISTS acmdb05;
CREATE DATABASE IF NOT EXISTS acmdb05;
USE acmdb05;
CREATE TABLE Pois (pid INTEGER AUTO_INCREMENT, name VARCHAR(50), category CHAR(30), istate CHAR(30), city CHAR(30), street CHAR(30), price NUMERIC(15,2),
	PRIMARY KEY(pid));
CREATE TABLE Users (login CHAR(30), password CHAR(30), name VARCHAR(40), userType INTEGER,
	PRIMARY KEY(login));
CREATE TABLE VisEvent (vid INTEGER AUTO_INCREMENT, cost INTEGER, numofheads INTEGER,
	PRIMARY KEY(vid));
CREATE TABLE Visits (login CHAR(30) NOT NULL, pid INTEGER NOT NULL, vid INTEGER NOT NULL, visdate DATE,
	PRIMARY KEY(login, pid, vid),
    FOREIGN KEY(login) REFERENCES Users(login),
    FOREIGN KEY(pid) REFERENCES Pois(pid),
    FOREIGN KEY(vid) REFERENCES VisEvent(vid));
CREATE TABLE Trusts (login1 CHAR(30), login2 CHAR(30),
	PRIMARY KEY(login1, login2),
    FOREIGN KEY(login1) REFERENCES Users(login),
    FOREIGN KEY(login2) REFERENCES Users(login));
CREATE TABLE Feedbacks (fid INTEGER AUTO_INCREMENT, login CHAR(30) NOT NULL, pid INTEGER NOT NULL, text VARCHAR(200), score INTEGER, fdate DATE,
	PRIMARY KEY(fid),
    FOREIGN KEY(login) REFERENCES Users(login),
    FOREIGN KEY(pid) REFERENCES Pois(pid));
CREATE TABLE Favorites (pid INTEGER NOT NULL, login CHAR(30) NOT NULL, fdate DATE,
	PRIMARY KEY(pid, login),
    FOREIGN KEY(pid) REFERENCES Pois(pid),
    FOREIGN KEY(login) REFERENCES Users(login));
CREATE TABLE Rates (login CHAR(30), fid INTEGER, rating INTEGER,
	PRIMARY KEY(login, fid),
    FOREIGN KEY(login) REFERENCES Users(login),
    FOREIGN KEY(fid) REFERENCES Feedbacks(fid));
CREATE TABLE Keywords (wid INTEGER AUTO_INCREMENT, word CHAR(50),
	PRIMARY KEY(wid));
CREATE TABLE Haskeywords(pid INTEGER NOT NULL, wid INTEGER NOT NULL,
	PRIMARY KEY(pid, wid),
    FOREIGN KEY(pid) REFERENCES Pois(pid),
    FOREIGN KEY(wid) REFERENCES Keywords(wid));