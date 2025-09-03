-- ============================================================
-- 🇮🇳 BharatBank BFSI Schema for Oracle 23ai Free Edition
-- Author: Anil Mahadev
-- Container: bharatbank-oracle
-- PDB: FREEPDB1
-- Image: gvenzl/oracle-free:slim
-- ============================================================

-- 🔐 Create dedicated schema user
CREATE USER bharatbank IDENTIFIED BY Bharat123;

-- 🎓 Grant developer privileges and unlimited tablespace
GRANT DB_DEVELOPER_ROLE TO bharatbank;
GRANT UNLIMITED TABLESPACE TO bharatbank;

-- 🧭 Switch to BharatBank schema
ALTER SESSION SET CURRENT_SCHEMA = bharatbank;

-- ============================================================
-- 1. Customers Table
-- Stores KYC-compliant customer data
-- ============================================================
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    FullName VARCHAR2(100),
    DOB DATE,
    Aadhaar VARCHAR2(12),
    PAN VARCHAR2(10),
    Mobile VARCHAR2(10),
    Email VARCHAR2(100),
    CreatedAt DATE DEFAULT SYSDATE
);

INSERT INTO Customers VALUES
(1, 'Ravi Kumar', TO_DATE('1985-06-15','YYYY-MM-DD'), '123456789012', 'ABCDE1234F', '9876543210', 'ravi.kumar@example.in', SYSDATE),
(2, 'Meena Joshi', TO_DATE('1990-03-22','YYYY-MM-DD'), '234567890123', 'FGHIJ5678K', '9123456789', 'meena.joshi@example.in', SYSDATE);

-- ============================================================
-- 2. Branches Table
-- Geo-tagged branch info with IFSC codes
-- ============================================================
CREATE TABLE Branches (
    BranchID NUMBER PRIMARY KEY,
    BranchName VARCHAR2(100),
    IFSC VARCHAR2(11),
    PINCode VARCHAR2(6)
);

INSERT INTO Branches VALUES
(1, 'MG Road Branch', 'BHRB000001', '560001'),
(2, 'Indiranagar Branch', 'BHRB000002', '560038');

-- ============================================================
-- 3. Accounts Table
-- Links customers to account types and balances
-- ============================================================
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER REFERENCES Customers(CustomerID),
    AccountType VARCHAR2(20),
    Balance NUMBER(18,2),
    OpenDate DATE,
    BranchID NUMBER REFERENCES Branches(BranchID)
);

INSERT INTO Accounts VALUES
(101, 1, 'Savings', 25000.00, TO_DATE('2022-01-15','YYYY-MM-DD'), 1),
(102, 2, 'Fixed Deposit', 100000.00, TO_DATE('2023-03-10','YYYY-MM-DD'), 2);

-- ============================================================
-- 4. Transactions Table
-- Debit/credit logs with UPI/NEFT/IMPS modes
-- ============================================================
CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER REFERENCES Accounts(AccountID),
    TxnType VARCHAR2(10),
    Amount NUMBER(18,2),
    TxnMode VARCHAR2(10),
    TxnDate DATE,
    ReferenceNo VARCHAR2(50)
);

INSERT INTO Transactions VALUES
(1001, 101, 'Credit', 5000.00, 'UPI', SYSDATE, 'UPI123456'),
(1002, 101, 'Debit', 2000.00, 'NEFT', SYSDATE, 'NEFT789012');

-- ============================================================
-- 5. LoanTypes Table
-- Defines loan categories and interest rates
-- ============================================================
CREATE TABLE LoanTypes (
    LoanTypeID NUMBER PRIMARY KEY,
    TypeName VARCHAR2(50),
    InterestRate NUMBER(5,2)
);

INSERT INTO LoanTypes VALUES
(1, 'Home Loan', 7.5),
(2, 'Personal Loan', 11.0);

-- ============================================================
-- 6. Loans Table
-- Tracks loan issuance and tenure
-- ============================================================
CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER REFERENCES Customers(CustomerID),
    LoanTypeID NUMBER REFERENCES LoanTypes(LoanTypeID),
    PrincipalAmount NUMBER(18,2),
    StartDate DATE,
    TenureMonths NUMBER
);

INSERT INTO Loans VALUES
(201, 1, 1, 2500000.00, TO_DATE('2023-01-01','YYYY-MM-DD'), 240);

-- ============================================================
-- 7. EMI_Schedule Table
-- Monthly repayment tracking
-- ============================================================
CREATE TABLE EMI_Schedule (
    EMI_ID NUMBER PRIMARY KEY,
    LoanID NUMBER REFERENCES Loans(LoanID),
    DueDate DATE,
    EMI_Amount NUMBER(18,2),
    Paid NUMBER(1) DEFAULT 0
);

INSERT INTO EMI_Schedule VALUES
(301, 201, TO_DATE('2023-02-01','YYYY-MM-DD'), 22000.00, 1),
(302, 201, TO_DATE('2023-03-01','YYYY-MM-DD'), 22000.00, 0);

-- ============================================================
-- 8. Roles Table
-- Defines staff roles for access control
-- ============================================================
CREATE TABLE Roles (
    RoleID NUMBER PRIMARY KEY,
    RoleName VARCHAR2(50)
);

INSERT INTO Roles VALUES
(1, 'Manager'),
(2, 'Teller');

-- ============================================================
-- 9. Staff Table
-- Employee directory with branch and role mapping
-- ============================================================
CREATE TABLE Staff (
    StaffID NUMBER PRIMARY KEY,
    FullName VARCHAR2(100),
    RoleID NUMBER REFERENCES Roles(RoleID),
    BranchID NUMBER REFERENCES Branches(BranchID),
    Mobile VARCHAR2(10)
);

INSERT INTO Staff VALUES
(501, 'Anita Desai', 1, 1, '9812345678'),
(502, 'Kiran Rao', 2, 2, '9823456789');

-- ============================================================
-- 10. KYC_Documents Table
-- Tracks Aadhaar, PAN, and other document verification
-- ============================================================
CREATE TABLE KYC_Documents (
    DocID NUMBER PRIMARY KEY,
    CustomerID NUMBER REFERENCES Customers(CustomerID),
    DocType VARCHAR2(50),
    DocNumber VARCHAR2(50),
    Verified NUMBER(1) DEFAULT 0
);

INSERT INTO KYC_Documents VALUES
(1, 1, 'Aadhaar', '123456789012', 1),
(2, 2, 'PAN', 'FGHIJ5678K', 1);

-- ============================================================
-- 11. AuditLogs Table
-- Tracks system actions for compliance
-- ============================================================
CREATE TABLE AuditLogs (
    LogID NUMBER PRIMARY KEY,
    Action VARCHAR2(100),
    PerformedBy VARCHAR2(100),
    Timestamp DATE DEFAULT SYSDATE
);

INSERT INTO AuditLogs VALUES
(1, 'Created Account 101', 'System', SYSDATE),
(2, 'Processed Loan 201', 'System', SYSDATE);

-- ============================================================
-- ✅ End of BharatBank Oracle 23ai Schema
-- ============================================================
