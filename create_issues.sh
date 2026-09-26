#!/usr/bin/env bash
# ==============================================================================
# Script to automate GitHub Issue creation for D365 Data Import Engine
# Usage: ./create_issues.sh
# ==============================================================================

set -e

REPO="Invoke-STPE/data-import-engine"
GH_EXEC="${HOME}/.local/bin/gh"

if ! command -v "$GH_EXEC" &> /dev/null; then
    GH_EXEC="gh"
fi

echo "🚀 Creating GitHub Issues for ${REPO}..."

# ------------------------------------------------------------------------------
# FEATURES
# ------------------------------------------------------------------------------
"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Feature] Dataverse Custom Tables & Schema (die_importconfiguration, die_importqueue)" \
  --body "### Summary
Define custom Dataverse tables \`die_importconfiguration\` and \`die_importqueue\` with required columns, choices (OptionSets), and native lookup relationships.

### Scope & Requirements
- **die_importconfiguration:** Target entity logical name, lookup to native \`importmap\`, source type choice, active flag.
- **die_importqueue:** Job auto-number (\`IMP-JOB-{YYYY}-{00000}\`), status reason choice (Pending, Processing, Success, Completed with Errors, System Error), record counters, duration timers, file payload attachment column.
- **Relationships:** Config (1) -> Queue (N), Native Data Map (1) -> Config (N).

### Acceptance Criteria
- [ ] Schema deployed in Dev environment under publisher prefix \`die_\`.
- [ ] OptionSets/Choices published and accessible in Power Apps forms." \
  --label "feature,dataverse,backend"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Feature] Power Automate Ingestion Listener Flows (SharePoint & Extensibility)" \
  --body "### Summary
Implement lightweight 'Dumb Listener' Power Automate flows that pick up file payloads from SharePoint folders or external sources and insert records into \`die_importqueue\` with Status = Pending.

### Scope & Requirements
- **SharePoint Listener Flow:** Triggers on file creation in designated SharePoint folder, extracts file content, and writes to \`die_importqueue\`.
- **Extensibility Pattern:** Standardized 2-step listener template for future sources (SFTP, Azure Blob, API).

### Acceptance Criteria
- [ ] File drop in SharePoint automatically generates a Pending record in \`die_importqueue\` with payload attached." \
  --label "feature,power-automate,backend"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Feature] Core Processing Engine Power Automate Flow" \
  --body "### Summary
Build the main queue processor flow triggered on \`die_importqueue\` creation with status = Pending. Orchestrate native Dataverse Bound Actions and update queue status.

### Scope & Requirements
- **State Machine:** Transition status from Pending -> Processing -> Success / Completed with Errors / System Error.
- **Dataverse API Integration:** Execute native Bound Actions: \`ParseImport\`, \`TransformImport\`, \`ImportRecords\`.
- **Diagnostics Extraction:** Query native \`importlog\` table for failed rows and write total/success/error metrics to queue record.

### Acceptance Criteria
- [ ] End-to-end execution of a CSV file populates target D365 records natively.
- [ ] Native error logs correctly update \`die_importqueue\` error counters." \
  --label "feature,power-automate,backend"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Feature] Canvas App Command Center Dashboard (scr_CommandCenter)" \
  --body "### Summary
Develop the primary Canvas App screen providing real-time status tracking, KPI metric summary cards, queue gallery polling, and slide-out details panel.

### Scope & Requirements
- **KPI Summary Cards:** Total Jobs, Success Rate %, Active Queue Count, Failed Jobs count.
- **Queue Gallery (\`gal_ImportQueue\`):** Timer-controlled polling (10s interval) for active jobs with color-coded status badges.
- **Slide-out Drawer (\`pnl_JobDetails\`):** Contextual side drawer displaying job metadata, download options, and diagnostic drill-down links.

### Acceptance Criteria
- [ ] Dashboard dynamically updates active queue job status without manual page refreshes." \
  --label "feature,canvas-app,frontend"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Feature] Canvas App Row-Level Error Diagnostics Viewer (scr_JobDiagnostics)" \
  --body "### Summary
Build the contextual error log screen querying native \`importlog\` data for selected failed jobs.

### Scope & Requirements
- **Error Log Table (\`gal_ErrorLog\`):** Displays line number, target column name, error phase, raw value, and error description.
- **Export & Action Controls:** Export error summary to CSV/Excel, download original file, direct link to Manual Re-upload screen.

### Acceptance Criteria
- [ ] Selecting a failed job loads all corresponding row-level error entries from \`importlog\`." \
  --label "feature,canvas-app,frontend"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Feature] Canvas App Manual File Ingestion Bypass (scr_ManualUpload)" \
  --body "### Summary
Create the manual file upload screen allowing users to select a configuration template, attach a CSV/Excel file (<8MB limit check), and submit directly to \`die_importqueue\`.

### Scope & Requirements
- **Form Controls:** Configuration picker dropdown, file attachment control with size validation (<8MB), reference notes.
- **Submit Logic:** Creates record in \`die_importqueue\` with Source Type = Manual and Status = Pending.

### Acceptance Criteria
- [ ] Submitting a file creates a valid queue item and navigates back to Command Center with a success notification." \
  --label "feature,canvas-app,frontend"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Feature] Canvas App Configuration Manager (scr_Configurations)" \
  --body "### Summary
Build administrative screen to manage \`die_importconfiguration\` records and link target entities to native D365 Data Maps (\`importmap\`).

### Scope & Requirements
- Configuration list gallery, status toggle (Active/Disabled), and mapping selector modal.

### Acceptance Criteria
- [ ] Admins can define new routing rules linking target entities to existing D365 Data Maps." \
  --label "feature,canvas-app,frontend"

# ------------------------------------------------------------------------------
# USER STORIES
# ------------------------------------------------------------------------------
"$GH_EXEC" issue create --repo "$REPO" \
  --title "[User Story] Real-Time Queue Monitoring for Admins" \
  --body "### User Story
As a D365 Administrator,
I want to view live import queue statuses and execution timers in the Command Center,
So that I can monitor data ingestion progress in real-time without refreshing the page.

### Acceptance Criteria
- [ ] Live queue auto-polls status changes (Pending -> Processing -> Success/Failed).
- [ ] KPI cards summarize total jobs and success rate percentage." \
  --label "user-story,canvas-app"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[User Story] Inspect Row-Level Import Errors and Download Log" \
  --body "### User Story
As a Power User,
I want to inspect exact line numbers and failure descriptions for failed imports,
So that I can quickly fix invalid data in Excel off-system.

### Acceptance Criteria
- [ ] Diagnostics screen shows row number, column name, error reason, and raw value.
- [ ] Ability to download original source file and export error log." \
  --label "user-story,canvas-app"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[User Story] Manual File Upload and Re-Run" \
  --body "### User Story
As a User,
I want to attach a corrected CSV/Excel file directly in the app and select an import template,
So that I can immediately re-run a batch import without relying on automated folder polling.

### Acceptance Criteria
- [ ] Drag-and-drop file upload validates file size (<8MB).
- [ ] Submitting immediately triggers background queue processing." \
  --label "user-story,canvas-app"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[User Story] Simple No-Code Ingestion Route Setup" \
  --body "### User Story
As a System Administrator,
I want to link a SharePoint ingestion folder to an existing D365 Data Map without writing code,
So that new data import routes can be configured in minutes.

### Acceptance Criteria
- [ ] UI allows picking target entity and linked \`importmap\` lookup." \
  --label "user-story,dataverse"

# ------------------------------------------------------------------------------
# TASKS
# ------------------------------------------------------------------------------
"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Task] Initialize DataImportEngine Solution and Publisher Prefix" \
  --body "### Description
Create unmanaged solution \`DataImportEngine\` with publisher prefix \`die_\` in the dedicated Dev environment.

### Acceptance Criteria
- [ ] Solution created in Dev environment and unpacked to repository using PAC CLI." \
  --label "task,alm,setup"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Task] Configure Connection References & Environment Variables" \
  --body "### Description
Define solution environment variables for SharePoint site URL and admin notification emails. Configure Dataverse connection references.

### Acceptance Criteria
- [ ] Environment variables packaged in unmanaged solution." \
  --label "task,alm,power-automate"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Task] Setup GitHub Actions Solution ALM Pipeline" \
  --body "### Description
Create \`.github/workflows/alm-pipeline.yml\` for automated solution packing, solution checker validation, and managed deployment to Test/Prod environments.

### Acceptance Criteria
- [ ] GitHub Actions workflow passes solution packing and validation steps." \
  --label "task,alm,devops"

"$GH_EXEC" issue create --repo "$REPO" \
  --title "[Task] Create Sample CSV/Excel Test Data Suite" \
  --body "### Description
Populate \`tests/\` folder with valid and intentionally failing CSV/Excel sample datasets (\`Accounts_Valid.csv\`, \`Contacts_Invalid.csv\`) for verification testing.

### Acceptance Criteria
- [ ] Test files committed to repository." \
  --label "task,testing"

echo "✅ All GitHub Issues created successfully!"
