# Voting Database System

## Summary

This repository hosts SQL scripts designed for a database system that manages voting operations. From creating new ballots and registering voters to updating ballot information and casting votes, this project aims to facilitate streamlined and secure election processes.

## Table of Contents
- [Summary](#summary)
- [Getting Started](#getting-started)
- [Database Schema](#database-schema)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

To use these SQL files, you'll need a MySQL server running. Import the database schema and run the desired SQL files.

### Prerequisites

- MySQL Server
- A database client (like MySQL Workbench, DBeaver, etc.)

### Installing

1. Clone this repository.
    ```bash
    git clone https://github.com/yourusername/voting-database-system.git
    ```
   
2. Open your database client and connect to your MySQL server.

3. Import the schema.sql file to set up the database and tables.

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

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.
