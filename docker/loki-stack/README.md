# Loki Stack

Full observability stack: Loki · Promtail · Prometheus · Grafana · Alertmanager · cAdvisor · Node Exporter

## Quick start

```bash
# 1. Copy and edit environment
cp .env .env.local          # optional — defaults work out of the box

# 2. Start the stack
docker compose up -d

# 3. Open Grafana
open http://localhost:3000   # admin / changeme
```

## Services

| Service       | URL                        | Purpose                        |
|---------------|----------------------------|--------------------------------|
| Grafana       | http://localhost:3000      | Dashboards & log exploration   |
| Loki          | http://localhost:3100      | Log storage & query API        |
| Prometheus    | http://localhost:9090      | Metrics storage & query        |
| Alertmanager  | http://localhost:9093      | Alert routing                  |
| Node Exporter | http://localhost:9100      | Host metrics                   |
| cAdvisor      | http://localhost:8080      | Container metrics              |

## Configuration files

```
loki-stack/
├── docker-compose.yml
├── .env                                  ← credentials & domain
├── loki/config.yml                       ← Loki storage, retention, limits
├── promtail/config.yml                   ← log scrape targets & pipelines
├── prometheus/
│   ├── prometheus.yml                    ← scrape jobs
│   └── rules/alerts.yml                 ← alerting rules
├── alertmanager/config.yml              ← notification receivers
└── grafana/provisioning/
    ├── datasources/datasources.yml      ← auto-wired Loki + Prometheus
    ├── dashboards/dashboards.yml        ← dashboard loader config
    ├── dashboards/docker-logs.json      ← pre-built Docker logs dashboard
    └── alerting/alerting.yml            ← Grafana managed alerts bootstrap
```

## Common operations

```bash
# Tail Loki logs
docker compose logs -f loki

# Reload Prometheus config without restart
curl -X POST http://localhost:9090/-/reload

# Check Loki ingestion
curl http://localhost:3100/ready
curl http://localhost:3100/metrics | grep loki_distributor

# Stop everything
docker compose down

# Wipe volumes (destructive — removes all data)
docker compose down -v
```

## Enabling notifications

Edit `alertmanager/config.yml` and uncomment the Slack or email receiver block,
then restart Alertmanager:

```bash
docker compose restart alertmanager
```

## Retention

Default: Prometheus keeps **15 days** of metrics. Loki has **no automatic expiry** until
you uncomment the `retention_period` in `loki/config.yml`.

To enable 30-day Loki retention, add under `limits_config`:

```yaml
limits_config:
  retention_period: 720h
```
