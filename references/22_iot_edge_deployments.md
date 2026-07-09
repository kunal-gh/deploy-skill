# Reference: IoT, Edge Device, and Fleet Deployment Strategies

> Last research update: 2026-07-09
> Always verify pricing and limits at official docs.

IoT deployment is different from normal web deployment. The primary problem is
not just hosting an API; it is safely ingesting device telemetry, managing
identity per device, handling intermittent connectivity, updating fleets, and
storing time-series data cheaply.

## Official Source Targets

| Platform | Docs | Pricing / releases |
|---|---|---|
| AWS IoT Core | https://docs.aws.amazon.com/iot | https://aws.amazon.com/iot-core/pricing |
| Azure IoT Hub | https://learn.microsoft.com/azure/iot-hub | https://azure.microsoft.com/pricing/details/iot-hub |
| Google Cloud IoT Core | https://cloud.google.com/iot-core | https://cloud.google.com/iot-core/docs/resources |
| ThingsBoard | https://thingsboard.io/docs | https://github.com/thingsboard/thingsboard/releases |
| EMQX | https://docs.emqx.com | https://github.com/emqx/emqx/releases |
| HiveMQ | https://docs.hivemq.com | https://www.hivemq.com/pricing |
| Balena | https://docs.balena.io | https://www.balena.io/pricing |

## Core Architecture Layers

| Layer | Options | Notes |
|---|---|---|
| Device identity | X.509 certs, per-device tokens, TPM/secure element | Prefer short-lived or revocable credentials. Never share one token across a fleet. |
| Ingestion protocol | MQTT, HTTPS, WebSocket, CoAP | MQTT is the default for constrained and intermittently connected devices. |
| Broker/ingress | AWS IoT Core, Azure IoT Hub, EMQX, HiveMQ, ThingsBoard | Managed brokers reduce ops but can become expensive at high message volume. |
| Stream processing | AWS Lambda, Kinesis, GCP Pub/Sub/Dataflow, Azure Functions/Event Hubs, Kafka/Redpanda/NATS | Choose based on sustained throughput and ops maturity. |
| Time-series storage | TimescaleDB, InfluxDB, QuestDB, ClickHouse, BigQuery, DynamoDB | High-cardinality metrics need careful retention and downsampling. |
| Command/control | MQTT topics, device shadows/twins, queues | Must handle offline devices and idempotent commands. |
| OTA updates | Balena, Mender, AWS IoT Jobs, Azure Device Update | Roll out gradually with rollback and health checks. |
| Fleet observability | Device heartbeat, firmware version, error logs, connectivity, battery | Device-level telemetry is required for support and incident response. |

## Platform Notes

### AWS IoT Core

Best for AWS-native teams that need mature managed MQTT, device shadows, rules
engine, and integrations with Lambda, Kinesis, S3, DynamoDB, Timestream, and
CloudWatch.

Use when:
- You already use AWS.
- You need device certificates, policies, and fine-grained IAM integration.
- You need a managed rules engine to route messages into AWS services.

Gotchas:
- Pricing depends on messages, rules, shadows, registry operations, and downstream services.
- AWS IAM and IoT policies add complexity.
- Egress and downstream storage can dominate cost.

### Azure IoT Hub

Best for Microsoft/enterprise environments, industrial IoT, and Azure-native
data/analytics pipelines.

Use when:
- Devices feed Azure Functions, Event Hubs, Stream Analytics, Data Explorer, or
  Power BI.
- Enterprise identity and governance already live in Azure.

Gotchas:
- Tiers and message metering require careful sizing.
- Device twin and routing behavior should be verified from docs before quoting limits.

### Google Cloud IoT Core

Google Cloud IoT Core was retired. Do not recommend it for new projects.
For GCP-based IoT, use partner MQTT brokers or run EMQX/HiveMQ/VerneMQ, then
route into Pub/Sub, Dataflow, BigQuery, Cloud Run, or GKE.

### ThingsBoard

Best for dashboards, rule chains, device management, and open-source/self-hosted
IoT platforms.

Use when:
- The project needs a full IoT application layer, not just MQTT.
- Self-hosting or private deployment is important.

Gotchas:
- Operating the platform, database, queues, backups, and upgrades becomes your job.
- Clustered high availability requires real DevOps capacity.

### EMQX

Best for high-throughput MQTT broker workloads and teams that want open-source
or commercial MQTT infrastructure.

Use when:
- MQTT throughput and protocol support matter more than a bundled app dashboard.
- You need self-hosted, Kubernetes, or managed MQTT options.

Gotchas:
- A broker alone does not solve device management, OTA, analytics, or dashboards.

### HiveMQ

Best for enterprise MQTT broker deployments with commercial support.

Use when:
- MQTT reliability, enterprise support, and integration with existing systems
  are more important than lowest cost.

Gotchas:
- Pricing and commercial features must be verified directly with HiveMQ.

### Balena

Best for deploying and updating software on fleets of Linux edge devices.

Use when:
- You need container-based device app deployment, OTA updates, and fleet management.
- Devices run Linux and can use BalenaOS or a compatible setup.

Gotchas:
- Balena is fleet management, not a telemetry database.
- You still need cloud ingestion, storage, monitoring, and dashboards.

## Decision Guide

```text
Is the project mostly web/mobile with a few devices?
  -> Use normal backend stack plus MQTT broker or HTTPS ingestion.

Is the project a serious connected-device fleet?
  -> Pick a managed IoT platform or dedicated MQTT broker first.

Already on AWS?
  -> AWS IoT Core + Lambda/Kinesis + Timestream/Timescale/ClickHouse.

Already on Azure or industrial enterprise?
  -> Azure IoT Hub + Event Hubs/Functions + Data Explorer.

Need self-hosted/control?
  -> EMQX or HiveMQ broker + ThingsBoard dashboard + TimescaleDB/ClickHouse.

Need OTA/fleet software updates?
  -> Add Balena, Mender, AWS IoT Jobs, or Azure Device Update.

Need low-cost hobby/prototype?
  -> EMQX on a VPS + Postgres/Timescale + Grafana, but document ops burden.
```

## Recommendation Requirements

When recommending an IoT stack, always include:

- Device identity and credential rotation plan.
- Ingestion protocol and broker choice.
- Message volume assumptions and pricing risks.
- Offline behavior and retry/backpressure strategy.
- Storage retention and downsampling policy.
- OTA update and rollback strategy.
- Monitoring for heartbeat, firmware version, and error rate.
- Security model for per-device authorization.
