DROP TABLE IF EXISTS iot_ingest_lines;

CREATE TABLE iot_ingest_lines (
  id serial PRIMARY KEY,
  source_file text NOT NULL,
  line_no int NOT NULL,
  raw_line text NOT NULL,
  received_at timestamptz default now(),
  note text
);

INSERT INTO iot_ingest_lines (source_file, line_no, raw_line, note) VALUES
('gateway_A_2025_11.log', 1, 'DEV_ID: DEV-AB12-3456; fw: v1.2.3; temp: 23.5C; support: ops@example.com', 'telemetry row'),
('gateway_A_2025_11.log', 2, 'device: abcd1234; fw: 1.02; humidity: "45,2"% ; support: help@iot-co.co', 'telemetry row'),
('gateway_B_2025_11.log', 3, 'ID: dev:XY_99-0001; fw: v01.2; size: "1,200" bytes; note: owner@example..com', 'telemetry with bad email'),
('factory_feed.csv', 10, 'serial: SN-0001; version: 2.0.1; storage: "1 024"', 'factory row'),
('factory_feed.csv', 11, 'serial: SN0002; version: v2.0; storage: "512"', 'factory row'),
('device_tags.csv', 1, 'tags: edge, sensor, temperature', 'tags row'),
('device_tags.csv', 2, 'tags: gateway, , backbone', 'tags with empty'),
('installations_dirty.csv', 5, '"Site, North","Rack 12, Unit 4","x:100,y:200"', 'dirty csv'),
('installations_dirty.csv', 6, '"O\Hara, Plant","Area A"," Sector 7","notes: needs inspection"', 'dirty csv with apostrophe'),
('ingest_log.txt', 200, 'INFO: ingest started for gateway_A_2025_11.log', 'log'),
('ingest_log.txt', 201, 'Warning: missing fw version for SN0002', 'log'),
('ingest_log.txt', 202, 'error: failed to parse telemetry line 3', 'log'),
('ingest_log.txt', 203, 'Error: device id malformed', 'log'),
('gateway_A_2025_11.log', 20, 'DEV_ID: bad@-id; support: ops@@example.com; fw: v1..2', 'trap-bad-id-email-fw'),
('device_tags.csv', 3, 'tags: sensor,, ,temperature', 'trap-empty-tags');