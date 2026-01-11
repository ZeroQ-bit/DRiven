# DRiven Setup Guide

This repository contains a complete, working DRiven setup with Riven, Zurg, and Plex.

## Working Configuration

This setup includes:
- **Riven**: v0.23.6 with Plex integration
- **Zurg**: Real-Debrid integration
- **Plex**: Native media server
- **PostgreSQL**: 16.3-alpine3.20 for database
- **Torrentio**: 26 streams configured for anime/movies
- **mdblist**: 20k+ items support with duplicate key error fix
- **Path Structure**: Optimized for symlink mounting

## Quick Start

### 1. Clone and Navigate
```bash
git clone https://github.com/ZeroQ-bit/DRiven.git
cd DRiven
```

### 2. Configure Environment Variables

#### Riven Configuration (`riven/.env`)
```bash
PUID=1000
PGID=1000
TZ=Etc/UTC
```

#### Zurg Configuration (`zurg/.env`)
```bash
REAL_DEBRID_API_KEY=YOUR_API_KEY_HERE
```

### 3. Configure Riven Settings

Copy the template and add your credentials:
```bash
cp riven/riven/riven/settings.json.template riven/riven/riven/settings.json
```

Edit `riven/riven/riven/settings.json` and fill in:
- `api_key`: Generate a random 32-character key
- `updaters.plex.token`: Your Plex server token
- `updaters.plex.url`: Your Plex server URL (http://192.168.1.63:32400)
- `downloaders.real_debrid.api_key`: Your Real-Debrid API key
- `content.mdblist.api_key`: Your mdblist.com API key

### 4. Directory Structure

Ensure these directories exist and are writable:
```bash
mkdir -p riven/riven/rivenfrontend
mkdir -p riven/postgres
mkdir -p zurg/config
mkdir -p /mnt/zurg/__all__
mkdir -p /mnt/library
```

### 5. Start Services

```bash
# Create directories
./create_directories.sh

# Start Docker Compose
cd riven
docker-compose up -d

# Check logs
docker-compose logs -f riven
```

## Key Features of This Setup

### ✅ Working Configuration
- All paths verified and tested on NUC (192.168.1.63)
- Database: PostgreSQL 16.3-alpine3.20
- 31,624+ items successfully processed
- Duplicate key error fix applied (commit 539f886)

### ✅ Torrentio Integration
- 26 streams configured
- Quality filter: 480p, scr, cam excluded
- Real-Debrid debrid provider enabled

### ✅ mdblist Support
- 10 mdblist sources configured
- 20k+ combined items support
- Fixed: Duplicate key errors no longer block processing

### ✅ Symlink Mounting
- Zurg: `/mnt/zurg/__all__`
- Library: `/mnt/library`
- Automatic symlink creation and repair

### ✅ Plex Integration
- Native Plex server support
- Watchlist auto-add enabled
- Media updates every 120 seconds

## API Keys Required

Obtain these from:
- **Real-Debrid**: https://real-debrid.com/account/credentials
- **Plex Token**: Right-click Plex server → Copy server address (token in URL)
- **mdblist API Key**: https://mdblist.com/preferences/api
- **Riven API Key**: Generate any 32-character random string

## Troubleshooting

### Docker Container won't start
```bash
cd riven
docker-compose down
docker-compose up -d
docker-compose logs --tail 50 riven
```

### Database connection issues
```bash
# Verify PostgreSQL is running
docker exec riven-db pg_isready -U postgres

# Check database
docker exec riven-db psql -U postgres -d riven -c "SELECT COUNT(*) FROM media_item;"
```

### mdblist indexing stuck
The fix in commit 539f886 prevents events from getting stuck. If issues persist:
```bash
docker restart riven
```

## File Locations

- **Riven Config**: `riven/riven/riven/settings.json`
- **Docker Compose**: `riven/docker-compose.yml`
- **Environment**: `riven/.env`, `zurg/.env`
- **Data**: `riven/riven/` (persisted volume)
- **Database**: `riven/postgres/` (persisted volume)

## Support

For issues:
1. Check logs: `docker-compose logs -f`
2. Verify API keys are set correctly
3. Ensure paths exist: `/mnt/zurg/__all__` and `/mnt/library`
4. Check Riven UI: http://192.168.1.63:3000

## Version Info

- Riven: v0.23.6
- PostgreSQL: 16.3-alpine3.20
- spoked/riven-frontend: latest
- spoked/riven: latest
