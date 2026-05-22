# IFRS 9 + GRAP 104 Enterprise Big Data Actuarial Engine

This is a fully containerized R/Plumber API for IFRS 9 and GRAP 104 expected credit loss calculations.

## Key Features

- IFRS 9 ECL calculation
- GRAP 104 impairment support
- Stage 1, Stage 2 and Stage 3 logic
- Scenario-weighted ECL
- Discounted lifetime ECL
- GRAP 104 journal movement output
- Render-ready Docker deployment
- No Render Native R or Ruby dependency issues

## Render Deployment

Create a new Render Web Service and choose:

```text
Environment: Docker
Root Directory: leave blank
Health Check Path: /health
```

Do not use Build Command or Start Command. Docker handles everything.

## GitHub Push

```cmd
cd /d "C:\Users\trode\Desktop\A_AAI\IFRS9_GRAP104_Enterprise_Engine"

git init
git add .
git commit -m "Deploy IFRS9 GRAP104 enterprise engine"
git branch -M main
git remote add origin https://github.com/Trodm/IFRS9_GRAP104_BigData_Engine.git
git push -u origin main
```

## Test Endpoints

```text
/health
/example
/calculate_ecl
/grap104_journal
```
