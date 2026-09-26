# D365 Data Import Engine (`DataImportEngine`)

> A centralized, extensible Power Platform solution for high-performance, governed data ingestion into Dynamics 365 and Dataverse.

---

## 🚀 Overview

The **D365 Data Import Engine** replaces custom, single-purpose batch import applications with a unified, low-code ingestion platform built on Microsoft Power Platform. It leverages native Dataverse Import APIs (`ParseImport`, `TransformImport`, `ImportRecords`) to process CSV and Excel files without requiring custom parsing code.

Planned using **Tim Corey's WOULD Framework** (**W**alkthrough, **O**pen requirements, **U**I design, **L**ogic design, **D**ata design).

---

## ✨ Key Features

- 📊 **Command Center Dashboard:** Canvas App UI providing real-time status tracking (Pending → Processing → Success/Failed) and high-level KPIs.
- 🔍 **Row-Level Error Diagnostics:** Direct drill-down into native `importlog` data displaying exact row numbers, failed columns, and error reasons.
- 📤 **Manual Upload Bypass:** Drag-and-drop file ingestion screen for ad-hoc loads and fast re-uploads.
- ⚙️ **No-Code Data Mapping:** Pre-configured routing linking target entities to native D365 Data Maps (`importmap`).
- 🔌 **Extensible Listener Architecture:** Lightweight "Dumb Listener" Power Automate flows enable adding new file sources (SharePoint, SFTP, Azure Blob, APIs) seamlessly.
- 📦 **ALM Ready:** Managed solution lifecycle configured via Power Platform CLI (`pac solution`) and GitHub Actions pipelines.

---

## 🛠️ Technology Stack

| Layer | Component | Description |
| :--- | :--- | :--- |
| **Frontend** | Canvas Power App | Command Center, Diagnostics, Manual Upload & Config screens |
| **Backend / Orchestration** | Power Automate Cloud Flows | Dumb Ingestion Listeners & Core Engine Flow |
| **Engine / Storage** | Dataverse & D365 Import APIs | Custom tables (`die_importqueue`, `die_importconfiguration`) + native `importmap` |
| **ALM / DevOps** | PAC CLI, Git & GitHub Actions | Unmanaged source control unpacking and managed CI/CD deployment |

---

## 📁 Repository Structure

```
data-import-engine/
├── src/                      # Solution source code unpacked via PAC CLI
│   └── DataImportEngine/
├── tests/                    # Sample test datasets (CSV / Excel)
└── .github/
    └── workflows/            # GitHub Actions CI/CD pipelines
```

---

## 📄 License

MIT License.
