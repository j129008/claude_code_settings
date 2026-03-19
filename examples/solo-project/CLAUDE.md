# CLAUDE.md

Local web app — image generation tool with FastAPI backend and vanilla frontend.

## Tech Stack

- **Backend:** Python FastAPI + Uvicorn
- **Frontend:** Vanilla HTML/CSS/JS (no build tools)
- **Image Processing:** Pillow, NumPy
- **HTTP Client:** httpx

## Project Structure

```
backend/
├── main.py              # FastAPI entry point (serves frontend + API)
├── api/
│   ├── routes.py        # API endpoints (/api/*)
│   └── client.py        # External API client & processing
├── models/schemas.py    # Pydantic request/response models
└── requirements.txt
frontend/
├── index.html           # Single-page app
├── js/app.js            # Frontend logic
└── css/style.css
```

## Running

```bash
pip install -r backend/requirements.txt
python backend/main.py
# Serves at http://0.0.0.0:8000
```

## Rules

- **Never commit `.env`** or any file containing API tokens
- All API calls go through the backend — never expose tokens to frontend
- Keep frontend simple: no frameworks, no build tools
- Use python-dotenv for environment variable management

## Team (Sub-Agents)

| Agent | Personality | Role |
|-------|-------------|------|
| **Steve Jobs** | PM | Product vision, feature specs, UI/UX final call |
| **Guido van Rossum** | Backend | FastAPI, API integrations, Pythonic code |
| **Lea Verou** | Frontend | UI components, CSS mastery, vanilla HTML/CSS/JS |
| **James Whittaker** | QA | Google-level testing rigor, endpoint validation |
| **Donald Knuth** | Tech Writer | Documentation, API references |
| **Linus Torvalds** | Reviewer | Code review, quality enforcement, merge gatekeeper |

### Workflow
1. **Steve Jobs** defines what to build (specs & priorities)
2. **Guido / Lea** implement the changes
3. **James Whittaker** tests functionality and catches bugs
4. **Donald Knuth** writes/updates documentation
5. **Linus Torvalds** reviews code and merges approved changes
6. **Steve Jobs** does final product review before shipping
