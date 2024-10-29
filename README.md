# Thesis Technical Exercise

You have been asked to develop a relational database design and a basic web application to manage a computer catalog. The contents of the catalog has been provided to you in the following format:

| RAM    | Disk Space | Processor                                     | Ports |
| ------ | ---------- | --------------------------------------------- | ----- |
| 8 GB   | 1 TB SSD	  | Intel® Celeron™ N3050 Processor               | 2 x USB 3.0, 4 x USB 2.0 |
| 16 GB  | 2 TB HDD	  | AMD FX 4300 Processor                         | 3 x USB 3.0, 4 x USB 2.0 |
| 8 GB   | 3 TB HDD	  | AMD Athlon Quad-Core APU Athlon 5150          | 4 x USB 3.0, 4 x USB 2.0  |
| 16 GB  | 4 TB HDD	  | AMD FX 8-Core Black Edition FX-8350           | 5 x USB 2.0, 4 x USB 3.0 |
| 32 GB  | 750 GB SDD | AMD FX 8-Core Black Edition FX-8370           | 2 x USB 3.0, 2 x USB 2.0, 1 x USB C |
| 32 GB  | 2 TB SDD	  | Intel Core i7-6700K 4GHz Processor            | 2 x USB C, 4 x USB 3.0 |
| 8 GB   | 2 TB HDD	  | Intel® Core™ i5-6400 Processor                | 8 x USB 3.0 |
| 16 GB  | 500 GB SDD | Intel® Core™ i5-6400 Processor                | 4 x USB 2.0 |
| 2 GB   | 2 TB HDD	  | Intel Core i7 Extreme Edition 3 GHz Processor | 10 x USB 3.0, 10 x USB 2.0, 10 x USB C |
| 512 MB | 80 GB SSD  | Intel® Core™ i5-6400 Processor                | 19 x USB 3.0, 4 x USB 2.0 |

With this information, spend up to 4 hours building the following features:

DONE
1. Write a database script in `db/RebuildDatabase.sql` which creates tables and inserts the data for the catalog. Design the database as you see fit, using principles of relational database design.

DONE
2. In `Controllers/ComputerController.cs`, implement in the `Get` method to fetch data from the catalog. Design the API as you see fit, applying SOLID design principles.


3. In `ClientApp/src/components/Home.js`, complete the code to call the `Get` method and render the results in the table. Use React state and React best practices.

4. Across the full stack, add functionality to submit a form which adds a new row to the catalog. An endpoint and initial form have been provided which can be filled out with the final solution.

5. Implement any one of the following features:
    - Add the ability to select a row in the catalog table and update any/all of its values.
    - Add comprehensive error handling and type checking when adding a new row to the catalog table.
    - Add the ability to search the catalog. Implement and design the feature as you see fit.
    - Add comprehensive unit and/or integration tests to the solution

As this project is meant to take no longer than 4 hours, it is expected the solution will not be production-ready and that compromises will be made. Use your best judgement and come prepared to the interview to speak about your design decisions and what you would change if this were a production-ready solution. Feel free to add any notes about your solution into this README.

If there are any questions about the exercise, please reach out to your recruiter.

# Running the Project

The solution requires SQL Server Express to be installed to host the database. Install SQL Server Express here and run the script in `db/RebuildDatabase.sql` to create an initial database. A connection string to the database can be found in `appsettings.json`.

The solution uses the .NET Core React/WebAPI template, which means it can be built and run out of the box. To build and run the solution, open a terminal to the root directory of the project and run `dotnet watch`. This should build the app and launch the API and an SPA Proxy server.
						
