# Voting Database System

## Summary

This repository hosts SQL scripts and a Python interface designed for a database system that manages voting operations. From creating new ballots and registering voters to updating ballot information and casting votes, this project aims to facilitate streamlined and secure election processes.

## Table of Contents
- [Summary](#summary)
- [Getting Started](#getting-started)
- [Database Schema](#database-schema)
- [Usage](#usage)
- [Python Interface for MySQL Operations](#python-interface-for-mysql-operations)

## Getting Started

To use these SQL files or Python script, you'll need a MySQL server running. Import the database schema and run the desired SQL files or Python script.

### Prerequisites

- MySQL Server
- A database client (like MySQL Workbench, DBeaver, etc.)
- Python 3.x (for Python script)
- MySQL Python Connector (`pip install mysql-connector-python`, required for Python script)

### Installing

1. Clone this repository.
    ```bash
    git clone https://github.com/yourusername/voting-database-system.git
    ```
   
2. Open your database client and connect to your MySQL server.

3. Import the schema.sql file to set up the database and tables.

4. To run the Python script, execute `python main.py` in your terminal.

## Database Schema

The database contains the following tables:

- `Folks`: Stores information about individuals.
- `Residencies`: Records residency details.
- `Email`: Holds email information.
- `Ballots`: Contains ballot details.
- `Voting_Registry`: Manages voter registrations.
- `Voting_Centers`: Stores information about voting centers.
- `Cast_Votes`: Records cast votes.
- `Election_Staff`: Keeps track of election staff members.

## Usage

- To create a new ballot, run `create_new_ballot.sql`.
- To register a voter for a ballot, run `register_voter.sql`.
- To update ballot information, run `update_ballot.sql`.
- To cast a vote, run `cast_vote.sql`.
- To delete a voter and their associated records, run `delete_voter.sql`.

## Python Interface for MySQL Operations

We've also included a Python script that interfaces directly with the MySQL database to perform various tasks:

- **User Authentication**: Securely validate user credentials.
- **Voter Registration**: Register voters and save their information in the database.
- **Ballot Management**: Perform CRUD (Create, Read, Update, Delete) operations on ballots.
- **Data Analysis**: Includes complex SQL queries for insightful data analysis.

To run the Python script, execute `python main.py` in your terminal. It will prompt you for the database username and password for secure access.
