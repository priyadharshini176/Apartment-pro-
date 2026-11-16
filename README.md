# Apartment Maintenance and Resident Complaint Management System

**Scenario 18** — a Java + MySQL + Python project that manages apartments, residents, monthly maintenance payments and resident complaints, and analyses facility problems with charts.

## Project description
An apartment association needs to keep resident and apartment records, track who has paid maintenance, handle complaints (water, electrical, cleanliness, lift, etc.) and find recurring problems. This system provides:

- **Modern Java Swing desktop application** – dashboard cards, navigation tabs, data tables and forms for apartments, residents, maintenance payments, complaints and reports.
- **Java console application** – a second interface for demonstrating menu-driven Java, input validation, classes, methods and JDBC operations.
- **MySQL database** – 4 normalized tables (3NF) with constraints, sample data and 14 example queries.
- **Python analytics** – retrieves data from MySQL, preprocesses it with pandas and generates 7 charts.

## Technologies used
| Area | Technology |
|---|---|
| Application | Java 17+, JDBC |
| Database | MySQL 8 (MariaDB 10.5+ also works) |
| Analytics | Python 3.9+, pandas, matplotlib, numpy, mysql-connector-python |
| Docs / diagrams | Markdown, Mermaid (renders on GitHub) |
| Version control | Git, GitHub |

## Folder structure
```
.
├── README.md
├── db.properties.example        database settings template (copy to db.properties)
├── docs/
│   ├── SRS.md                   software requirements specification
│   ├── Design.md                use case, class, architecture, sequence diagrams
│   ├── Database_Design.md       ER diagram, relational model, normalization, query list
│   └── Testing.md               test strategy, test cases with expected & actual results
├── src/com/apartment/           Java source (model, dao, service, db, util, Main)
├── lib/                         put the MySQL JDBC driver jar here
├── run-desktop.bat / .sh        launch the Swing desktop app
├── run-console.bat / .sh        launch the console app
├── database/
│   ├── schema.sql               creates database and tables
│   ├── sample_data.sql          sample data (40 apartments, 37 residents, 222 payments, 90 complaints)
│   ├── generate_sample_data.py  regenerates sample_data.sql
│   └── queries.sql              14 SQL queries
├── python/
│   ├── analysis.py              retrieve → preprocess → visualize
│   └── requirements.txt
├── sample_inputs/               input files for the Java app
├── sample_outputs/              console output produced from those inputs
└── outputs/                     charts (PNG) and analysis_summary.txt
```

## Database setup
1. Install MySQL and make sure the server is running.
2. From the project folder run:
   ```bash
   mysql -u root -p < database/schema.sql
   mysql -u root -p < database/sample_data.sql
   ```
   (This creates the database `apartment_db`. Running `schema.sql` again resets it.)
3. Optional: try the queries with `mysql -u root -p < database/queries.sql`.

## Running the Java application
1. Download **MySQL Connector/J** (https://dev.mysql.com/downloads/connector/j/ → "Platform Independent" → unzip) and copy `mysql-connector-j-x.y.z.jar` into the `lib/` folder.
2. Copy `db.properties.example` to `db.properties` and put your MySQL username and password in it.
3. Compile and run (Linux / macOS):
   ```bash
   mkdir -p out
   javac -cp "lib/*" -d out $(find src -name "*.java")
   java -cp "out:lib/*" com.apartment.Main
   ```
   Windows (Command Prompt):
   ```bat
   mkdir out
   dir /s /b src\*.java > sources.txt
   javac -cp "lib/*" -d out @sources.txt
   java -cp "out;lib/*" com.apartment.Main
   ```
4. Use the menu: Apartments, Residents, Payments, Complaints, Reports, Exit.

### Run the modern desktop interface (recommended)

The project also includes a Java Swing interface with an overview dashboard, apartment and resident directories, maintenance payment controls, complaint tracking, and database-backed reports.

- **Windows:** double-click `run-desktop.bat`.
- **Linux / macOS:** run `chmod +x run-desktop.sh` once, then `./run-desktop.sh`.

The desktop launcher compiles the Java source before opening the app. Keep the MySQL server running and configure `db.properties` first. The interface uses the same DAO classes and MySQL schema as the console application.

To launch the original console version, use `run-console.bat` on Windows or `./run-console.sh` on Linux / macOS.

### Run with the ready-made sample input
```bash
java -cp "out:lib/*" com.apartment.Main --echo < sample_inputs/input_demo.txt
```
`--echo` prints each answer so the output reads like a normal session. The result is saved in `sample_outputs/output_demo.txt`. (`input_validation_tests.txt` runs the boundary tests.) Reload the database with the two SQL files before re-running, because the demo adds records.

### Menu overview
| Menu | Functions |
|---|---|
| 1 Apartments | add, view, change occupancy |
| 2 Residents | add (one per apartment), view |
| 3 Payments | generate monthly charges, record payment, view pending / by month / all |
| 4 Complaints | register, update status (forward only), view all / by status |
| 5 Reports | pending payments · complaint resolution · category-wise complaints |

## Running the Python analysis
```bash
pip install -r python/requirements.txt
# Linux / macOS
export DB_USER=root DB_PASSWORD=your_password
# Windows (Command Prompt):  set DB_USER=root & set DB_PASSWORD=your_password
python python/analysis.py
```
Optional variables: `DB_HOST` (default `localhost`), `DB_PORT` (`3306`), `DB_NAME` (`apartment_db`).

The script reads the data from MySQL, removes duplicates, fixes data types, checks missing/inconsistent values, derives resolution time and month, and saves to `outputs/`:

| File | Chart |
|---|---|
| `01_complaints_by_category.png` | Complaints per category |
| `02_status_by_category.png` | Open / In Progress / Resolved by category |
| `03_monthly_complaint_trend.png` | Complaints raised per month |
| `04_avg_resolution_days.png` | Average days to resolve by category |
| `05_collection_by_month.png` | Paid vs pending maintenance per month |
| `06_top_pending_dues.png` | Top 10 apartments with pending dues |
| `07_block_category_heatmap.png` | Recurring problems by block and category |
| `analysis_summary.txt` | Preprocessing log and key findings |

### Key findings on the sample data
- Water supply is the biggest problem: 32 of 90 complaints (36%), and it recurs in all four blocks.
- 68% of complaints are resolved, average resolution time 2.2 days; lift and "other" complaints take longest.
- 27% of billed maintenance (Rs 131,700 of Rs 480,000) is pending; 28 apartments have at least one unpaid month.

## Documents
- [SRS](docs/SRS.md) · [Design diagrams](docs/Design.md) · [Database design & normalization](docs/Database_Design.md) · [Testing](docs/Testing.md)

## Push to GitHub

1. Create a **new empty repository** on GitHub (for example, `apartment-maintenance-complaint-system`). Do not initialize it with a README because this project already has one.
2. Open a terminal in this project folder and run:

   ```bash
   git init
   git add .
   git commit -m "Apartment Maintenance and Complaint Management System"
   git branch -M main
   git remote add origin https://github.com/<your-username>/apartment-maintenance-complaint-system.git
   git push -u origin main
   ```
3. Replace `<your-username>` with your GitHub username. GitHub may ask you to sign in through a browser or use a Personal Access Token.
4. Share the resulting repository address: `https://github.com/<your-username>/apartment-maintenance-complaint-system`.

**Important:** GitHub hosts the source code and documents; it does not run this desktop Java + MySQL application as a website. Your teacher can open the repository, download the ZIP or clone it, follow the setup steps, and run the desktop app on a computer with Java and MySQL installed. Never commit `db.properties` or real database passwords; the file is ignored by `.gitignore`.

**Database reset warning:** `database/schema.sql` starts by dropping and recreating `apartment_db`. Back up any existing data before running it. Load `database/sample_data.sql` after creating the schema.
