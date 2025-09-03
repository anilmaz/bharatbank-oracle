# bharatbank-oracle
Oracle 23ai BFSI schema for BharatBank — modular, persistent, and ready for prototyping.

How to Pull the image:

docker pull dbhitman/bharatbank-oracle:23ai-v1


# 🇮🇳 BharatBank Oracle 23ai Container

A modular, production-grade Oracle 23ai container for Indian Banking & Finance schema prototyping.  
Built for learners, educators, and architects exploring relational design in containerized environments.

---

## 🐳 Container Overview

- **Image**: `gvenzl/oracle-free:slim`
- **Port**: `1547` (mapped to Oracle's default `1521`)
- **Volume**: `oracle-volume` for persistent data
- **Schema**: `bharatbank` user with full BFSI tables and sample data
- **Database**: `FREEPDB1` (Oracle 23ai default pluggable database)

---

## 🏦 What's Inside the Schema?

| Module         | Tables Included                                                                 |
|----------------|----------------------------------------------------------------------------------|
| Core Banking   | `Customers`, `Accounts`, `Transactions`                                         |
| Lending        | `Loans`, `EMI_Schedule`, `LoanTypes`                                            |
| Infrastructure | `Branches`, `Staff`, `Roles`                                                    |
| Compliance     | `KYC_Documents`, `AuditLogs`                                                    |
| Payments       | UPI, NEFT, IMPS-ready transaction modes                                         |

Includes Aadhaar, PAN, IFSC, EMI schedules, and UPI references — ideal for RBI sandbox simulations or fintech prototyping.

---

## 🚀 Quick Start

### 1. Create a volume


docker volume create oracle-volume

2. Run the container
docker run -d `
  -p 1547:1521 `
  --name bharatbank-oracle `
  -e ORACLE_PASSWORD=Welcome123! `
  -v oracle-volume:/opt/oracle/oradata `
  gvenzl/oracle-free:slim


3. Inject the schema

I have attached the Schema in a .SQL file in this Repo.


📦 Commit & Push (Optional) -->  --> Use your Docker Hub Repo, not mine!

docker commit bharatbank-oracle <yourdockerhubusername>/bharatbank-oracle:23ai-v1
docker push <yourdockerhubusername>/bharatbank-oracle:23ai-v1



🧠 Who Is This For?
- 🧑‍🎓 Students learning Oracle SQL and schema design
- 🧑‍💻 Developers prototyping BFSI apps
- 🏛️ Educators teaching relational modeling
- 🏗️ Architects simulating RBI-compliant systems

📚 Learn More
- Oracle 23ai Free Edition - https://www.oracle.com/database/free/
- Docker for Windows - https://docs.docker.com/desktop/setup/install/windows-install/
- Gerald Venzl's GitHub Repo - https://github.com/gvenzl/oci-oracle-free



🛠️ Contribute
Want to add Healthcare, Retail, or Education verticals?
Fork this repo and submit a pull request — let’s build India-first database containers together.

🏁 License
MIT — use it, remix it, teach with it.


